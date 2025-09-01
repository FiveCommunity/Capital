cacheUsers = {}
cacheUsers.users = {}
cacheUsers.user_source = {}
cacheUsers.user_tables = {}
cacheUsers.userSpawned = {}

local db_drivers = {}
local db_driver
local cached_prepares = {}
local cached_queries = {}
local prepared_queries = {}
local db_initialized = false

vRP.registerDBDriver = function(name, on_init, on_prepare, on_query)
	if not db_drivers[name] then
		db_drivers[name] = { on_init, on_prepare, on_query }
		if name == 'oxmysql' then
			db_driver = db_drivers[name]
			local ok = on_init('oxmysql')
			if ok then
				db_initialized = true
				for _,prepare in pairs(cached_prepares) do
					on_prepare(table.unpack(prepare,1,table.maxn(prepare)))
				end
				for _,query in pairs(cached_queries) do
					query[2](on_query(table.unpack(query[1],1,table.maxn(query[1]))))
				end
				cached_prepares = nil
				cached_queries = nil
			end
		end
	end
end

vRP.prepare = function(name, query)
	prepared_queries[name] = true
	if db_initialized then
		db_driver[2](name,query)
	else
		table.insert(cached_prepares,{ name,query })
	end
end

vRP.query = function(name, params, mode)
	if not mode then mode = "query" end
	if db_initialized then
		return db_driver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cached_queries,{{ name,params or {},mode },r })
		return r:wait()
	end
end

vRP.execute = function(name, params)
	return vRP.query(name, params, "execute")
end

vRP.insert = function(name, params)
	return vRP.query(name, params, "insert")
end

vRP.scalar = function(name, params)
	return vRP.query(name, params, "scalar")
end

vRP.format = function(n)
	local left, num, right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

vRP.isBanned = function(id)
	return exports.system:isBanned(id)
end

vRP.setBanned = function(id, banned, reason, days, staff_id)
	return exports.system:setUserBanned(id, banned, reason, days, staff_id)
end

vRP.getIdentifiers = function(source)
    local identifiers = {}
    for i = 0, GetNumPlayerIdentifiers(source)-1 do
        local id = GetPlayerIdentifier(source, i)
        
		local prefix = splitString(id,":")[1]
		identifiers[prefix] = id
    end
    return identifiers
end

vRP.getUData = function(user_id, key)
	local rows = vRP.query("vRP/get_userdata", { user_id = user_id, key = key })
	if #rows > 0 then
		return rows[1].dvalue
	end
	return ""
end

vRP.setUData = function(user_id, key, value)
	if (value == '') then
		vRP.execute("vRP/rem_userdata", { user_id = user_id, key = key })
	else
		vRP.execute("vRP/set_userdata", { user_id = user_id, key = key, value = value })
	end
end

vRP.getSData = function(key)
	local rows = vRP.query("vRP/get_srvdata", { key = key })
	if #rows > 0 then
		return rows[1].dvalue
	end
	return ""
end

vRP.setSData = function(key, value)
	vRP.execute("vRP/set_srvdata",{ key = key, value = value })
end

vRP.remSData = function(dkey)
	vRP.execute("vRP/rem_srv_data",{ dkey = dkey })
end

vRP.getUsers = function()
	local users = {}
	for k, v in pairs(cacheUsers.user_source) do
		users[k] = v
	end
	return users
end

vRP.getUserDataTable = function(user_id)
	return cacheUsers.user_tables[user_id]
end

vRP.setKeyDataTable = function(user_id, key, value)
	if (cacheUsers.user_tables[user_id]) then
		cacheUsers.user_tables[user_id][key] = value
	end
end

vRP.getUserId = function(source)
	if (source) then return cacheUsers.users[source]; end;
	return nil
end

vRP.getUserSource = function(user_id)
	return cacheUsers.user_source[user_id]
end

concatInv = function(TableInv)
	local txt = ''
	if TableInv and type(TableInv) == 'table' then
		for k, v in pairs(TableInv) do
			if k ~= nil and v ~= nil then
				txt = '\n   ' .. vRP.format(v.amount or 0) .. 'x ' .. (vRP.itemNameList(v.item) or v.item) .. txt
			end
		end
		if txt == '' then
			return 'MOCHILA VAZIA'
		else 
			return txt
		end
	end
	return 'ERRO AO ENCONTRAR INVENTARIO'
end

concatArmas = function(TableInv)
	local txt = ''
	if TableInv and type(TableInv) == 'table' then
		for k, v in pairs(TableInv) do
			txt = '\n   ' .. (vRP.itemNameList(k) or k) .. ' [' .. tostring(v.ammo) .. ']' .. txt
		end
		if txt == '' then
			return 'DESARMADO'
		else
			return txt
		end
	end
	return 'ERRO AO ENCONTRAR ARMAS'
end

vRP.kick = function(source, reason)
	DropPlayer(source, reason)
end

vRP.getUserIdByIdentifiers = function(ids)
	if (#ids > 0) then
		for i = 1, #ids do
			local _ids = ids[i]
			if (string.find(_ids, 'ip:') == nil) then
				local rows = vRP.query('gb_framework/getIdentifier', { identifier = _ids })
				if (#rows > 0) then return rows[1].user_id; end;
			end
		end

		local newUserId = vRP.insert('gb_framework/createUser')
		if (newUserId > 0) then
			for i = 1, #ids do
				local _ids = ids[i]
				if (string.find(_ids, 'ip:') == nil) then
					vRP.execute('gb_framework/addIdentifier', { user_id = newUserId, identifier = _ids })
				end
			end
			return newUserId
		end
	end
	return false
end

formatIdentifiers = function(source)
	local _identifiers = vRP.getIdentifiers(source)
	
	local steamURL, steamID = '', ''
	steamID = '\n**[STEAM HEX]** - '..(_identifiers.steam or 'OFFLINE')
	if (_identifiers.steam) then
		steamURL = '\n**[STEAM URL]** - https://steamcommunity.com/profiles/'..tonumber(_identifiers.steam:gsub('steam:', ''), 16)
	end

	local discord;
	discord = '\n**[DISCORD]** - NÃO ENCONTRADO'
	if (_identifiers.discord) then
		discord = '\n**[DISCORD]** - <@'.._identifiers.discord:gsub('discord:', '')..'>'
	end
	return steamURL, steamID, discord
end

vRP.getAccount = function(identifiers)
	local Steam = '';

	-- Verificar se já existe uma conta criada
	for _, data in pairs(identifiers) do
		if (string.find(data, 'steam')) then
			Steam = data:sub(7)

			local query = vRP.query('vRP/get_account_with_steam', { id = Steam })[1]
			if (query) then return { id = query.id, steam = query.steam, whitelist = query.whitelist, chars = query.chars }; end;
		end
	end

	-- Criar uma nova conta
	if (Steam ~= '') then
		local newAccount = vRP.insert('vRP/create_account', { steam = Steam })
		return { id = newAccount, steam = Steam, whitelist = 0 }
	end
end

vRP.characterChosen = function(source, user_id, creation)
	if (source and user_id) then
		cacheUsers.users[source] = user_id -- Registrar um user_id
		cacheUsers.user_source[user_id] = source -- Registrar uma source
		cacheUsers.user_tables[user_id] = {} -- Registrar uma table do user_id

		vRP.PlayerInventory(user_id) -- Registrar Inventario
		vRP.PlayerGroups(user_id) -- Registrar Grupos
		vRP.PlayerIdentity(user_id) -- Registrar Identity
		vRP.PlayerMoney(user_id) -- Registrar Money

		vRP.execute('vRP/update_last_login', { id = user_id })

		local userTable = vRP.getUData(user_id, 'gb:userTable')
		local data = (json.decode(userTable) or {})
		if (type(data) == 'table') then cacheUsers.user_tables[user_id] = data end
		
		local userSpawned = cacheUsers.userSpawned[user_id]
		TriggerEvent('playerSpawn', user_id, source, (not userSpawned), creation)
		
		local steamURL, steamID, discord = formatIdentifiers(source)
		vRP.webhook('join', {
			title = 'join',
			descriptions = {
				{ 'action', '(join)' },
				{ 'user', user_id },
				{ 'ip', (GetPlayerEndpoint(source) or '0.0.0.0') },
				{ 'identifiers', json.encode(GetPlayerIdentifiers(source), { indent = true }) },
				{ 'steam url', steamURL },
				{ 'steam id', steamID },
				{ 'discord', discord }
			}
		})
		
		cacheUsers.userSpawned[user_id] = true
	end 
end


AddEventHandler('queue:playerConnecting', function(source, ids, name, setKickReason, deferrals)
--AddEventHandler('playerConnecting',function(name, setKickReason, deferrals)
	--local source = source --playerConnecting
	--local ids = GetPlayerIdentifiers(source) --playerConnecting

	if not (name) then name = 'user'; end;

	deferrals.defer()
	deferrals.update('Olá '..name..', estamos carregando as identidades do servidor...')

	if (#ids == 0) then ids = GetPlayerIdentifiers(source); end;

	-- local banServer, banId = exports.system:checkRemoteBanned(ids)
	-- if banServer then
	-- 	deferrals.done('\n\nVocê está banido em um servidor parceiro. ('..banServer..')')
	-- 	TriggerEvent('queue:playerConnectingRemoveQueues', ids)
	-- 	return
	-- end

	local account = vRP.getAccount(ids)
	if (not account) or (not account.id) then
		deferrals.done('Olá '..name..', não foi possível identificar sua Steam.')
		TriggerEvent('queue:playerConnectingRemoveQueues', ids)
		return
	end
	vRP.execute('vRP/update_account_login', { ip = (GetPlayerEndpoint(source) or '0.0.0.0'), id = account.id })

	if (config.maintenanceMode) and not config.maintenanceBypass[account.steam] then
		deferrals.done('\n\nO servidor se encontra em manutenção no momento.\nVerifique o status da cidade em nosso discord: discord.gg/capitalgg')
		TriggerEvent('queue:playerConnectingRemoveQueues', ids)
		return
	end

	if (account.whitelist == 0) then
		deferrals.done('\n\nVocê não possui whitelist em nossa cidade!\nSua whitelist: '..account.id..'\nFaça a sua whitelist em nosso discord: discord.gg/capitalgg.')
		TriggerEvent('queue:playerConnectingRemoveQueues', ids)
		return
	end

	if (vRP.isBanned(account.id)) then
		local info = exports.system:getUserBanInfo(account.id)
		local staffIdentity = vRP.getUserIdentity(info.staff)

		local banTimestamp;
		if (info.days > 0) and (info.ban_date > 0) then
			banTimestamp = ((info.ban_date / 1000) + (info.days * 24 * 60 * 60))
			if (os.time() >= banTimestamp) then
				exports.system:setUserBanned(account.id, false)

				vRP.webhook('ban', {
                    title = 'unban automático',
                    descriptions = {
                        { 'staff', 'sistema' },
                        { 'desbaniu a whitelist', account.id },
                        { 'motivo', 'acabou o tempo do ban' }
                    }
                })  

				deferrals.done()
			end
		end

		deferrals.done('\n\nVocê foi banido '..(info.days > 0 and 'temporariamente' or 'por tempo indeterminado')..' de nossa cidade.\n\n[AUTOR]: Capital'..'\n[MOTIVO]: '..info.reason..'\n[TEMPO]: '..(info.days > 0 and info.days..' DIAS' or 'INDETERMINADO')..'\n[DATA DO BANIMENTO]: '..(info.ban_date > 0 and exports.system:formatDate(info.ban_date) or '??/??/????')..(info.days > 0 and '\n[DATA DO DESBANIMENTO]: '..exports.system:formatDate(banTimestamp * 1000) or '')..'\n[SUA ALLOWLIST]: #'..account.id)
		TriggerEvent('queue:playerConnectingRemoveQueues', ids)
		return
	end

	deferrals.done()	
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	vRP.dropPlayer(source, reason)
end)

vRP.dropPlayer = function(source, reason)
	local source = source
	if (source) then
		local user_id = vRP.getUserId(source)
		if (user_id) then
			local userTable = vRP.getUserDataTable(user_id)
			local ped = GetPlayerPed(source)
			local pCoord = GetEntityCoords(ped)
			local items = vRP.getInventory(user_id)

			TriggerEvent('vRP:playerLeave', user_id, source)
			TriggerClientEvent('gb:playerExit', -1, user_id, reason, pCoord)

			userTable.health = GetEntityHealth(ped)
			userTable.armour = GetPedArmour(ped)
			userTable.Handcuff = Player(source).state.Handcuff
			userTable.Capuz = Player(source).state.Capuz
			userTable.GPS = Player(source).state.GPS
			userTable.deathTimer = Player(source).state.deathTimer

			local steamURL, steamID, discord = formatIdentifiers(source)

			local dataIfLeave = Player(source).state.dataIfLeave
			if dataIfLeave then
				pCoord = dataIfLeave.cds
				userTable.health = dataIfLeave.health
				userTable.armour = dataIfLeave.armour
			end

			local temporaryInfos = Player(source).state.temporaryDataTraining or Player(source).state.temporaryDataMurder
			if temporaryInfos then 
				pCoord = temporaryInfos.coords
				userTable.health = temporaryInfos.health
				userTable.armour = temporaryInfos.armour
			end 

			local health = userTable.health
			
			vRP.webhook('exit', {
				title = 'exit',
				descriptions = {
					{ 'action', '(leave)' },
					{ 'reason', reason },
					{ 'user', user_id },
					{ 'ip', (GetPlayerEndpoint(source) or '0.0.0.0') },
					{ 'identifiers', json.encode(GetPlayerIdentifiers(source), { indent = true }) },
					{ 'health', ((health > 100) and health or 'DIED') },
					{ 'coords', tostring(pCoord) },
					{ 'inventory', concatInv(items) },
					{ 'steam url', steamURL },
					{ 'steam id', steamID },
					{ 'discord', discord }
				}
			})

			vRP.setUData(user_id, 'gb:userTable', json.encode(userTable))

			vRP.releaseGroups(user_id)
			vRP.releaseIdentity(user_id)
			vRP.releaseMoney(user_id)
			
			cacheUsers.users[source] = nil
			cacheUsers.user_source[user_id] = nil
			cacheUsers.user_tables[user_id] = nil
		end
	end
end

vRP.prompt = function(source, questions)
	return exports.hud:prompt(source, questions)
end

vRP.request = function(source, title, message, time)
	return exports.hud:request(source, title, message, time)
end

vRP.getDayHours = function(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)
    if (days > 0) then
        return string.format('<b>%d Dias</b> e <b>%d Horas</b>', days, hours)
    else
        return string.format('<b>%d Horas</b>', hours)
    end
end

vRP.getMinSecs = function(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds/60)
    seconds = seconds - minutes * 60

    if (minutes > 0) then
        return string.format('<b>%d Minutos</b> e <b>%d Segundos</b>', minutes, seconds)
    else
        return string.format('<b>%d Segundos</b>', seconds)
    end
end

local delayflood = {}
local flood = {}

vRP.antiflood = function(source, key, limite)
	if(flood[key]==nil or delayflood[key] == nil)then 
		flood[key]={}
		delayflood[key]={}
	end
    if(flood[key][source]==nil)then
        flood[key][source] = 1
        delayflood[key][source] = os.time()
    else
        if(os.time()-delayflood[key][source]<1)then
            flood[key][source]= flood[key][source] + 1
            if(flood[key][source]==limite)then
                local user_id = vRP.getUserId(source)

				local whitelist_id = exports.system:getUserWhitelist(user_id)
				if (whitelist_id) then
					exports.system:setUserBanned(whitelist_id, true, 'Anti Flood', 0, 0)
				end

                DropPlayer(source, "Hoje não! Hoje não! Hoje sim!")

				vRP.webhook('antiflood', {
					title = 'antiflood',
					descriptions = {
						{ 'id', user_id },
						{ 'anti-flood', key }
					}
				})   
            end
        else
            flood[key][source]=nil
            delayflood[key][source] = nil
        end
        delayflood[key][source] = os.time()
    end
end

task_save_datatables = function()
	Citizen.SetTimeout(10000, task_save_datatables); 
	for k, v in pairs(cacheUsers.user_tables) do
		vRP.setUData(k, 'gb:userTable', json.encode(v))
	end
end
Citizen.CreateThread(task_save_datatables)


-- local Crash = 'https://discord.com/api/s/1073755441592533002/73gJnK61b7W6sPht4uKDjNnDs--BtZw_5dIfVeYwxeR1Hga1SbsBkZRMr6jj0-Hj2Er5'
-- AddEventHandler('playerDropped', function(reason)
--     local _source = source
-- 	if (_source) then
-- 		vRP.dropPlayer(_source, reason)

-- 		local user_id = vRP.getUserId(_source)
-- 		if user_id then
-- 			if (reason == "Game crashed: gta-core-five.dll!CrashCommand (0x0)") then
-- 				vRP.setBanned(user_id, true)
-- 				exports["core"]:insertBanRecord(user_id,true,-1,"FORÇOU CRASH")
-- 				vRP.(Crash, "```prolog\n[USER_ID]: "..user_id.."\n[UTILIZOU COMANDO _CRASH]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```" )
-- 			end
-- 		end
-- 	end
-- end)
local Config = {}

vRP.prepare('vRP/get_user_priority', 'select priority from users where steam = @steam')

Config.RequireSteam = true
Config.PriorityOnly = false

Config.IsBanned = function(src,callback)
	callback(false)
end

Config.prioritySteam = {
	['11000010d0fbf53'] = 500, -- HEX (an4log)
	['110000142959ab4'] = 500, -- HEX (bagual)
	['11000013c57048e'] = 500, -- HEX (paulinho)
	['110000117183b4d'] = 500, -- HEX (petrus)
	['11000010e2a8705'] = 500, -- HEX (Tote)
	['11000010a76a6d6'] = 500, -- HEX (Freitas)
	['11000013606a52f'] = 500, -- HEX (Angel)
	['11000013c4c9b3e'] = 500, -- HEX (Moon)
	['11000010e3a8136'] = 500, -- HEX (Gabe)
	['11000015025499e'] = 500, -- HEX (Formoso)
	['110000168200277'] = 500, -- HEX (Talia)
	['110000136110f18'] = 500, -- HEX (Luqueta)
	['11000013be2ebc1'] = 500, -- HEX (Hanako)
	['110000111e69793'] = 500, -- HEX (Theo)
	['11000010c3e4a52'] = 500, -- HEX (Bauer)
	['1100001172cf8d4'] = 500, -- HEX (Finn)
	['110000115be2c2c'] = 500, -- HEX (Tai)
	['11000016b8d3c32'] = 500, -- HEX (Matheus Ferreira)
	['110000136f72d22'] = 500, -- HEX (White)
	['11000010cc5baf5'] = 500, -- HEX (Maionese)
	
	['110000156b419e4'] = 100,
	['11000015025499E'] = 100,
	['1100001031b963e'] = 100,
	['11000013b1c4b7f'] = 100,
	['11000013256c5c9'] = 100,
	['110000105a53850'] = 100,
	['11000013be2ebc0'] = 100,
	['11000014b5646ca'] = 100,
	['110000144803c08'] = 100,
	['110000114e27400'] = 100
}

Config.Language = {
	joining = '[ Capital City ] \n\nEntrando...',
	connecting = '[ Capital City ] \n\nConectando...',
	err = '[ Capital City ] \n\nNão foi possível identificar sua Steam ou Social Club.',
	_err = '[ Capital City ] \n\nVocê foi desconectado por demorar demais na fila.',
	pos = '[ Capital City ] \n\nVocê é o %d/%d da fila, aguarde sua conexão...\n\nAdquira Prioridade na fila para logar mais rápido: https://capitalcity.tebex.io/',
	connectingerr = '[ Capital City ] \n\nNão foi possível adiciona-lo na fila.\n\ndiscord.gg/capitalgg',
	wlonly = '[ Capital City ] \n\nVocê não está aprovado na whitelist.\n\ndiscord.gg/capitalgg',
	banned = '[ Capital City ] \n\nSeu passaporte foi revogado na cidade.\n\ndiscord.gg/capitalgg',
	steam = '[ Capital City] \n\nVocê precisa estar com a Steam aberta para conectar.',
}

local Queue = {}
Queue.QueueList = {}
Queue.PlayerList = {}
Queue.PlayerCount = 0
Queue.Priority = {}
Queue.Connecting = {}
Queue.ThreadCount = 0

local debug = false
local displayQueue = false
local initHostName = false
local maxPlayers = GetConvarInt('sv_maxclients', 700)

local tostring = tostring
local tonumber = tonumber
local ipairs = ipairs
local pairs = pairs
local string_sub = string.sub
local string_format = string.format
local string_lower = string.lower
local math_abs = math.abs
local math_floor = math.floor
local os_time = os.time
local table_insert = table.insert
local table_remove = table.remove

function Queue:HexIdToSteamId(hexId)
	local cid = math_floor(tonumber(string_sub(hexId, 7), 16))
	local steam64 = math_floor(tonumber(string_sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math_floor(math_abs(6561197960265728 - steam64 - a) / 2)
	local sid = "steam_0:"..a..":"..(a == 1 and b -1 or b)
	return sid
end

function Queue:IsSteamRunning(src)
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v,1,5) == "steam" then
			return true
		end
	end
	return false
end

function Queue:IsInQueue(ids,rtnTbl,bySource,connecting)
	for genericKey1,genericValue1 in ipairs(connecting and self.Connecting or self.QueueList) do
		local inQueue = false

		if not bySource then
			for genericKey2,genericValue2 in ipairs(genericValue1.ids) do
				if inQueue then break end

				for genericKey3,genericValue3 in ipairs(ids) do
					if genericValue3 == genericValue2 then inQueue = true break end
				end
			end
		else
			inQueue = ids == genericValue1.source
		end

		if inQueue then
			if rtnTbl then
				return genericKey1, connecting and self.Connecting[genericKey1] or self.QueueList[genericKey1]
			end

			return true
		end
	end
	return false
end

function Queue:IsPriority(ids)
	local resultPriority, Steam = 10, ''
	for _, data in pairs(ids) do
		if (string.find(data, 'steam')) then
			Steam = data:sub(7)
			if (Config.prioritySteam[Steam]) then
				resultPriority = Config.prioritySteam[Steam]
				break
			else
				local pSQL = vRP.query("vRP/get_user_priority", { steam = Steam })[1]
				if (pSQL) and (pSQL.priority > resultPriority) then
					resultPriority = pSQL.priority
					break
				end
			end
			
		end
	end
	return resultPriority
end

function Queue:AddToQueue(ids,connectTime,name,src,deferrals)
	if self:IsInQueue(ids) then
		return
	end

	local tmp = {
		source = src,
		ids = ids,
		name = name,
		firstconnect = connectTime,
		priority = self:IsPriority(ids) or (src == "debug" and math.random(0,15)),
		timeout = 0,
		deferrals = deferrals
	}

	local _pos = false
	local queueCount = self:GetSize() + 1

	for k,v in ipairs(self.QueueList) do
		if tmp.priority then
			if not v.priority then
				_pos = k
			else
				if tmp.priority > v.priority then
					_pos = k
				end
			end
			if _pos then
				break
			end
		end
	end

	if not _pos then
		_pos = self:GetSize() + 1
	end

	table_insert(self.QueueList,_pos,tmp)
end

function Queue:RemoveFromQueue(ids,bySource)
	if self:IsInQueue(ids,false,bySource) then
		local pos, data = self:IsInQueue(ids,true,bySource)
		table_remove(self.QueueList,pos)
	end
end

function Queue:GetSize()
	return #self.QueueList
end

function Queue:ConnectingSize()
	return #self.Connecting
end

function Queue:IsInConnecting(ids,bySource,refresh)
	local inConnecting,tbl = self:IsInQueue(ids,refresh and true or false,bySource and true or false,true)

	if not inConnecting then
		return false
	end

	if refresh and inConnecting and tbl then
		self.Connecting[inConnecting].timeout = 0
	end
	return true
end

function Queue:RemoveFromConnecting(ids,bySource)
	for k,v in ipairs(self.Connecting) do
		local inConnecting = false

		if not bySource then
			for i,j in ipairs(v.ids) do
				if inConnecting then
					break
				end

				for q,e in ipairs(ids) do
					if e == j then inConnecting = true break end
				end
			end
		else
			inConnecting = ids == v.source
		end

		if inConnecting then
			table_remove(self.Connecting,k)
			return true
		end
	end
	return false
end

function Queue:AddToConnecting(ids,ignorePos,autoRemove,done)
	local function removeFromQueue()
		if not autoRemove then
			return
		end

		done(Config.Language.connectingerr)
		self:RemoveFromConnecting(ids)
		self:RemoveFromQueue(ids)
	end

	if self:ConnectingSize() >= 50 then
		removeFromQueue()
		return false
	end

	if ids[1] == "debug" then
		table_insert(self.Connecting,{ source = ids[1], ids = ids, name = ids[1], firstconnect = ids[1], priority = ids[1], timeout = 0 })
		return true
	end

	if self:IsInConnecting(ids) then
		self:RemoveFromConnecting(ids)
	end

	local pos,data = self:IsInQueue(ids,true)
	if not ignorePos and (not pos or pos > 1) then
		removeFromQueue()
		return false
	end

	table_insert(self.Connecting,data)
	self:RemoveFromQueue(ids)
	return true
end

function Queue:GetIds(src)
	local ids = GetPlayerIdentifiers(src)
	local ip = GetPlayerEndpoint(src)

	ids = (ids and ids[1]) and ids or (ip and {"ip:" .. ip} or false)
	ids = ids ~= nil and ids or false

	if ids and #ids > 1 then
		for k,v in ipairs(ids) do
			if string.sub(v, 1, 3) == "ip:" then table_remove(ids, k) end
		end
	end

	return ids
end

function Queue:AddPriority(id,power)
	if not id then return false end
	
	DBPriority = getDBPriorities()

	if type(id) == "table" then
		for k, v in pairs(id) do
			if k and type(k) == "string" and v and type(v) == "number" then
				DBPriority[k] = v
			else
				return false
			end
		end

		return true
	end

	power = (power and type(power) == "number") and power or 10
	DBPriority[string_lower(id)] = power

	return true
end

function Queue:RemovePriority(id)
	DBPriority = getDBPriorities()

	if not id then
		return false
	end
	DBPriority[id] = nil
	return true
end

function Queue:UpdatePosData(src,ids,deferrals)
	local pos,data = self:IsInQueue(ids,true)
	self.QueueList[pos].source = src
	self.QueueList[pos].ids = ids
	self.QueueList[pos].timeout = 0
	self.QueueList[pos].deferrals = deferrals
end

function Queue:NotFull(firstJoin)
	local canJoin = self.PlayerCount + self:ConnectingSize() < maxPlayers and self:ConnectingSize() < 50
	if firstJoin and canJoin then
		canJoin = self:GetSize() <= 1
	end
	return canJoin
end

function Queue:SetPos(ids,newPos)
	local pos,data = self:IsInQueue(ids,true)
	table_remove(self.QueueList,pos)
	table_insert(self.QueueList,newPos,data)
end

Citizen.CreateThread(function()
	local function playerConnect(name,setKickReason,deferrals)
		debug = GetConvar("sv_debugqueue", "true") == "true" and true or false
		displayQueue = GetConvar("sv_displayqueue", "true") == "true" and true or false
		initHostName = not initHostName and GetConvar("sv_hostname") or initHostName

		local src = source
		local ids = Queue:GetIds(src)
		local connectTime = os_time()
		local connecting = true

		deferrals.defer()

		Citizen.CreateThread(function()
			while connecting do
				Citizen.Wait(500)
				if not connecting then
					return
				end
				deferrals.update(Config.Language.connecting)
			end
		end)

		Citizen.Wait(1000)

		local function done(msg)
			connecting = false
			Citizen.CreateThread(function()
				if msg then
					deferrals.update(tostring(msg) and tostring(msg) or "")
				end

				Citizen.Wait(1000)

				if msg then
					deferrals.done(tostring(msg) and tostring(msg) or "")
					CancelEvent()
				end
			end)
		end

		local function update(msg)
			connecting = false
			deferrals.update(tostring(msg) and tostring(msg) or "")
		end

		if not ids then
			done(Config.Language.err)
			CancelEvent()
			return
		end

		if Config.RequireSteam and not Queue:IsSteamRunning(src) then
			done(Config.Language.steam)
			CancelEvent()
			return
		end

		local banned

		Config.IsBanned(src,function(_banned,_reason)
			banned = _banned
			_reason = _reason and tostring(_reason) or ""

			if _banned then
				done(string.format(Config.Language.banned, _reason and _reason or "Unknown"))
				Queue:RemoveFromQueue(ids)
				Queue:RemoveFromConnecting(ids)
			end
		end)

		while banned == nil do Citizen.Wait(1) end
		if banned then
			CancelEvent()
			return
		end

		local reason = "You were kicked from joining the queue"

		local function setReason(msg)
			reason = tostring(msg)
		end

		TriggerEvent("queue:playerJoinQueue", src, setReason)

		if WasEventCanceled() then
			done(reason)

			Queue:RemoveFromQueue(ids)
			Queue:RemoveFromConnecting(ids)

			CancelEvent()
			return
		end

		if Config.PriorityOnly and not Queue:IsPriority(ids) then
			done(Config.Language.wlonly)
			return
		end

		local rejoined = false

		if Queue:IsInQueue(ids) then
			rejoined = true
			Queue:UpdatePosData(src,ids,deferrals)
		else
			Queue:AddToQueue(ids,connectTime,name,src,deferrals)
		end

		if Queue:IsInConnecting(ids,false,true) then
			Queue:RemoveFromConnecting(ids)

			if Queue:NotFull() then
				local added = Queue:AddToConnecting(ids,true,true,done)
				if not added then
					CancelEvent()
					return
				end

				done()
				TriggerEvent("queue:playerConnecting",src,ids,name,setKickReason,deferrals)

				return
			else
				Queue:AddToQueue(ids,connectTime,name,src,deferrals)
				Queue:SetPos(ids,1)
			end
		end

		local pos,data = Queue:IsInQueue(ids,true)

		if not pos or not data then
			done(Config.Language._err)
			RemoveFromQueue(ids)
			RemoveFromConnecting(ids)
			CancelEvent()
			return
		end

		if Queue:NotFull(true) then
			local added = Queue:AddToConnecting(ids,true,true,done)
			if not added then
				CancelEvent()
				return
			end

			done()

			TriggerEvent("queue:playerConnecting",src,ids,name,setKickReason,deferrals)

			return
		end

		update(string_format(Config.Language.pos,pos,Queue:GetSize()))

		Citizen.CreateThread(function()
			if rejoined then
				return
			end

			Queue.ThreadCount = Queue.ThreadCount + 1
			local dotCount = 0

			while true do
				Citizen.Wait(1000)
				local dots = ""

				dotCount = dotCount + 1
				if dotCount > 3 then
					dotCount = 0
				end

				for i = 1,dotCount do dots = dots .. "." end

				local pos,data = Queue:IsInQueue(ids,true)

				if not pos or not data then
					if data and data.deferrals then
						data.deferrals.done(Config.Language._err)
					end
					CancelEvent()
					Queue:RemoveFromQueue(ids)
					Queue:RemoveFromConnecting(ids)
					Queue.ThreadCount = Queue.ThreadCount - 1
					return
				end

				if pos <= 1 and Queue:NotFull() then
					local added = Queue:AddToConnecting(ids)
					data.deferrals.update(Config.Language.joining)
					Citizen.Wait(500)

					if not added then
						data.deferrals.done(Config.Language.connectingerr)
						CancelEvent()
						Queue.ThreadCount = Queue.ThreadCount - 1
						return
					end

					data.deferrals.update("Loading into server")

					Queue:RemoveFromQueue(ids)
					Queue.ThreadCount = Queue.ThreadCount - 1

					TriggerEvent("queue:playerConnecting",data.source,data.ids,name,setKickReason,data.deferrals)
					
					return
				end

				local msg = string_format(Config.Language.pos.."%s\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe sua sugestão em nosso discord.",pos,Queue:GetSize(),dots)
				data.deferrals.update(msg)
			end
		end)
	end

	AddEventHandler("playerConnecting",playerConnect)

	local function checkTimeOuts()
		local i = 1
		while i <= Queue:GetSize() do
			local data = Queue.QueueList[i]
			local lastMsg = GetPlayerLastMsg(data.source)

			if lastMsg == 0 or lastMsg >= 30000 then
				data.timeout = data.timeout + 1
			else
				data.timeout = 0
			end

			if not data.ids or not data.name or not data.firstconnect or data.priority == nil or not data.source then
				data.deferrals.done(Config.Language._err)
				table_remove(Queue.QueueList, i)
			elseif (data.timeout >= 120) and data.source ~= "debug" and os_time() - data.firstconnect > 5 then
				data.deferrals.done(Config.Language._err)
				Queue:RemoveFromQueue(data.source,true)
				Queue:RemoveFromConnecting(data.source,true)
			else
				i = i + 1
			end
		end

		i = 1

		while i <= Queue:ConnectingSize() do
			local data = Queue.Connecting[i]
			local lastMsg = GetPlayerLastMsg(data.source)
			data.timeout = data.timeout + 1

			if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and data.source ~= "debug" and os_time() - data.firstconnect > 5 then
				Queue:RemoveFromQueue(data.source, true)
				Queue:RemoveFromConnecting(data.source, true)
			else
				i = i + 1
			end
		end

		local qCount = Queue:GetSize()

		if displayQueue and initHostName then
			SetConvar("sv_hostname",(qCount > 0 and "[" .. tostring(qCount) .. "] " or "") .. initHostName)
		end

		SetTimeout(1000,checkTimeOuts)
	end
	checkTimeOuts()
end)

local function playerActivated()
	local src = source
	local ids = Queue:GetIds(src)

	if not Queue.PlayerList[src] then
		Queue.PlayerCount = Queue.PlayerCount + 1
		Queue.PlayerList[src] = true
		Queue:RemoveFromQueue(ids)
		Queue:RemoveFromConnecting(ids)
	end
end

RegisterServerEvent("Queue:playerActivated")
AddEventHandler("Queue:playerActivated",playerActivated)

local function playerDropped()
	local src = source
	local ids = Queue:GetIds(src)

	if Queue.PlayerList[src] then
		Queue.PlayerCount = Queue.PlayerCount - 1
		Queue.PlayerList[src] = nil
		Queue:RemoveFromQueue(ids)
		Queue:RemoveFromConnecting(ids)
	end
end

AddEventHandler("playerDropped",playerDropped)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if exports and exports.connectqueue then
			TriggerEvent("queue:onReady")
			return
		end
	end
end)

AddEventHandler("queue:playerConnectingRemoveQueues",function(ids)
	Queue:RemoveFromQueue(ids)
	Queue:RemoveFromConnecting(ids)
end)

AddEventHandler("onResourceStop", function(resource)
	if displayQueue and resource == GetCurrentResourceName() then
		SetConvar("sv_hostname", initHostName)
	end
end)
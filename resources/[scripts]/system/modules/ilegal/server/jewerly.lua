local srv = {}
Tunnel.bindInterface('Jewerly',srv)
local vCLIENT = Tunnel.getInterface('Jewerly')

local blockTables = {}
local cooldownJewerly = nil

srv.checkJewerly = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then
		if (cooldownJewerly) and (cooldownJewerly > os.time()) then
			TriggerClientEvent('notify', source, 'importante', 'Joalheria', 'Aguarde <b>'..(cooldownJewerly - os.time())..' segundos</b> para roubar a <b>Joalheria</b> novamente.')
			return false
		end

		if (JewerlyRobbery.minPolice) then
			local police = vRP.getUsersByPermission('policia.permissao')
			if (#police < JewerlyRobbery.minPolice) then
				TriggerClientEvent('notify', source, 'negado', 'Joalheria', 'Não possui <b>contingente</b> o suficiente para fazer essa ação. <br><br> É necessário <b>'..JewerlyRobbery.minPolice..' policias</b> para realizar esta ação.')
				return false
			end
		end

		if (vRP.tryGetInventoryItem(user_id, 'flipper-mk3', 1)) then
			vRP.webhook('roubos', {
				title = 'roubos',
				descriptions = {
					{ 'user', user_id },
					{ 'local', 'Joalheria' },
					{ 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
				}
			})   

			vCLIENT.startJewerly(source)
			return true
		end
		TriggerClientEvent('notify', source, 'negado', 'Joalheria', 'Você precisa <b>1x</b> de <b>'..vRP.itemNameList('flipper-mk3')..'</b> para hackear as câmeras de segurança.')
		return false
	end
end

srv.setCooldownJewerly = function()
	cooldownJewerly = (os.time() + JewerlyRobbery.cooldown)
end

srv.callPolice = function(coords)
	local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local pedCoords = GetEntityCoords(GetPlayerPed(source))
        
		TriggerClientEvent('vrp_sound:fixed', -1, source, pedCoords.x, pedCoords.y, pedCoords.z, 100, 'alarm', 0.1)
        exports.vrp:reportUser(user_id, {
            notify = { 
                type = 'default', 
                title = 'Roubo a Joalheria', 
                message = 'Denúncia anônima.',
                coords = pedCoords,
                time = 8000
            },
            blip = {
                id = user_id, 
                text = 'Roubo a Joalheria', 
                coords = pedCoords, 
                timeout = 30000 
            }
        })
    end
end

local timersTable = {}
local tables = 0

srv.checkJewels = function(id, coords, coords_2, heading, prop_1, prop_2)
	local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then
		local ped = GetPlayerPed(source)

		if (not blockTables[id]) then
			blockTables[id] = true

			local toExpire = (cooldownJewerly - os.time())
			Citizen.SetTimeout(toExpire*1000,function()
				blockTables[id] = nil
			end)
			
			tables = (tables + 1)

			SetEntityHeading(ped, heading)
			SetEntityCoords(ped, coords_2.xyz)
			vCLIENT.jewelryRoubbery(source, prop_1, prop_2, id)

			local indexRandom = math.random(#JewerlyRobbery.items)
			local quantityRandom = math.random(JewerlyRobbery.items[indexRandom].quantity.min, JewerlyRobbery.items[indexRandom].quantity.max)
		
			Citizen.SetTimeout(3100, function()
				vRP.giveInventoryItem(user_id, JewerlyRobbery.items[indexRandom].item, quantityRandom, nil, true)
			end)

			if (tables >= 20) then
				vCLIENT.finishRobbery(source)
				tables = 0
			end
		else
			TriggerClientEvent('notify', source, 'aviso', 'Joalheria', 'Esse balcão já foi <b>roubado</b>!')
		end
	end
end

RegisterNetEvent('jewerly:setModels', function(x,y,z,prop_1, prop_2)
	local source = source

	local nearestPlayers = vRPclient.getNearestPlayers(source,35.0)
	TriggerClientEvent('jewerly:setModels',source,x,y,z,prop_1,prop_2)
	for ply_source,_ in pairs(nearestPlayers) do
		TriggerClientEvent('jewerly:setModels',ply_source,x,y,z,prop_1,prop_2)
	end
end)
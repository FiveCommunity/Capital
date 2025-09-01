--======================================================================================================================
-- EXTERNAL FUNCIONS
--======================================================================================================================
function sGARAGE.getPlateOwner(plate)
	if plate and (plate ~= '') then
		local car = vRP.query('garage/getWithPlate', { plate = plate })[1]
		if (car) then return car.user_id, car.vehicle; end;
	end
end

function sGARAGE.generatePlate()
	local user_id = nil
	local nplate = ''
	repeat
		nplate = stringGenerator(config.plateFormat)
		user_id = sGARAGE.getPlateOwner(nplate)
	until not user_id
	return nplate
end

function sGARAGE.addVehicle(user_id,model,days)
    local expires = 0
    if days and (days > 0) then
        expires = math.floor(os.time()+days*24*3600)
    end
	vRP.execute('garage/addVehicle',{ user_id = user_id, vehicle = model, plate = sGARAGE.generatePlate(), service = 0, ipva = os.time(), rented = expires })
end

function sGARAGE.remVehicle(user_id,model)
    if user_id and model then
        local veh = vRP.query('garage/findLatestVehicle',{ user_id = user_id, vehicle = model })[1]
        if veh then
            vRP.execute('garage/delVehicle',{ id = veh.id })
            vRP.deleteInventory('vehicleTrunk:'..veh.id) 
            vRP.deleteInventory('vehicleGloves:'..veh.id)
        end
    else
        vRP.execute('garage/delVehicle',{ id = user_id })
        vRP.deleteInventory('vehicleTrunk:'..user_id) 
        vRP.deleteInventory('vehicleGloves:'..user_id)
    end
end

function sGARAGE.resetUserVehicles(user_id)
    local userVehicles = vRP.query('garage/getVehicles', { user_id = user_id })
	if (#userVehicles > 0) then
		for _, v in pairs(userVehicles) do
            if (v.user_id == user_id) then
                vRP.execute('garage/delVehicle', { id = v.id })
                vRP.deleteInventory( ('vehicleTrunk:'..v.id) )
                vRP.deleteInventory( ('vehicleGloves:'..v.id) )
            end
		end
	end
end

function sGARAGE.findVehicle(id)
    for k,v in pairs(GetAllVehicles()) do
        if DoesEntityExist(v) then
            local netId = NetworkGetNetworkIdFromEntity(v)
            if netId then
                local eid = Entity(v).state['id']
                if eid and (eid == id) then
                    return v, netId
                end
            end
        end
    end
end

function sGARAGE.carDoor(source, dist, door)
    return cGARAGE.carDoor(source, dist, door)
end

function sGARAGE.vehicleAlarm(source)
    return cGARAGE.vehicleAlarm(source)
end

function sGARAGE.deleteNearest(coords,radius,save)
    for k,v in pairs(GetAllVehicles()) do
        if (#(GetEntityCoords(v) - coords) <= radius) then
            if save then
                sGARAGE.safeDelete(NetworkGetNetworkIdFromEntity(v))
            else
                DeleteEntity(v)
            end
        end
    end
end

function sGARAGE.updatePlate(source, command)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local cveh, netId, plate, vname = vRPclient.vehList(source, 5.0)
        if (netId) and (vname) then
            local inVehicle = vRPclient.isInVehicle(source)
            if (not inVehicle) then
                TriggerClientEvent('notify', source, 'negado', 'Garagem', 'Essa ação só funciona quando você está dentro do <b>veículo</b>.')
                return false
            end

            local vehState = sGARAGE.vehicleData(netId)
            if (user_id == vehState.user_id) or (command) then
                local prompt = exports.hud:prompt(source, { 'Digite uma nova placa (Obrigatório 8 caracteres):' })[1]
                if (prompt) then
                    local newPlate = string.upper(prompt)

                    local len = prompt:len()
                    if (len < 8) or (len > 8) then
                        TriggerClientEvent('notify', source, 'negado', 'Garagem', 'O número de caracteres é <b>'..(len < 8 and 'menor' or 'maior')..'</b> do que 8.')
                        return false
                    end

                    local result = exports.oxmysql:query_async('select plate from user_vehicles where plate = ?', { newPlate })[1]
                    if (result) then
                        TriggerClientEvent('notify', source, 'negado', 'Garagem', 'Já existe uma <b>placa</b> cadastrada em nosso sistema com essa <b>identificação</b>.')
                        return false
                    end

                    local userInventory = vRP.PlayerInventory(user_id)
                    if (not userInventory) and (not command) then
                        TriggerClientEvent('notify', source, 'negado', 'Erro no Sistema', 'Não foi possível encontrar o seu <b>inventário</b>.')
                        return false
                    end

                    local allow = false;
                    if (not allow) and (not command) then
                        allow = userInventory:tryGetItem('placa-vip', 1)
                    else
                        allow = true
                    end
                   
                    if (allow) then
                        local request = exports.hud:request(source, 'Trocar Placa', 'Você tem certeza de que deseja alterar sua placa para <b>'..newPlate..'</b>?', 30000)
                        if (request) then
                            Entity(vehState.entity).state:set('plate', newPlate, true)
                            SetVehicleNumberPlateText(vehState.entity, newPlate)
                            exports.oxmysql:insert_async('update user_vehicles set plate = ? where plate = ?', { newPlate, vehState.plate })

                            TriggerClientEvent('notify', source, 'sucesso', 'Garagem', 'A placa foi alterada para <b>'..newPlate..'</b> com sucesso.')
                            return newPlate, plate
                        else
                            userInventory:generateItem('placa-vip', 1)
                        end
                    end
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Garagem', 'Você não deve trocar a placa de um <b>veículo</b> do qual você não é o proprietário.')
            end
        end
    end
    return false
end


function sGARAGE.cloneVehicle(vehnet)
	local vehicle = NetworkGetEntityFromNetworkId(vehnet)
	if vehicle then
		local vehState = sGARAGE.vehicleData(vehnet)
		if vehState.user_id and (not vehState.clone) then
			local cloneId = math.random(1,#config.clonePlates)
            local clonePlate = config.clonePlates[cloneId].plate
			Entity(vehicle).state['clone'] = clonePlate
			SetVehicleNumberPlateText(vehicle,clonePlate)
		end
	end
end

--======================================================================================================================
-- INTERNAL
--======================================================================================================================

function getCarTrunkWeight(id, weight)
    if (id > 0) then
        local invId = ('vehicleTrunk:'..id)
        local VehicleTrunk = vRP.Inventory(invId)
        if VehicleTrunk then
            local weight = VehicleTrunk:getWeight()
            local maxWeight = VehicleTrunk:getMaxWeight()
            vRP.releaseInventory(invId)
            if (weight > 0) then return (parseInt((weight / maxWeight) * 100)); end;
        end
    end
    return 0
end

function getMods(mods, mod)
    if (mods) and mods[mod] then
        return countMods(mods[mod].mod, mod)
    end
    return 0
end

function countMods(value, mod)
    if (value == -1) then value = 0; end;
    local mods = {
        ['12'] = function(value)
            return parseInt(value * 50)
        end,
        ['13'] = function(value)
            return parseInt(value * 50)
        end,
        ['15'] = function(value)
            return parseInt(value * 33.3333333333)
        end
    }
    return mods[mod](value)
end

function stringGenerator(format)
	local num = {'0','1','2','3','4','5','6','7','8','9'}
	local alg = {'A','B','C','D','E','F','G','H','J','K','L','M','N','P','R','S','T','U','V','W','X','Y','Z'}
	local all = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','R','S','T','U','V','W','X','Y','Z'}
	local number = ''
	for i=1,#format do
		local char = string.sub(format,i,i)
    	if char == 'D' then number = number..num[math.random(#num)]
		elseif char == 'L' then number = number..alg[math.random(#alg)]
		elseif char == 'A' then number = number..all[math.random(#all)]
		else number = number..char end
	end
	return number
end


function checkPermissionAlternative(source)
    local source = source
    local user_id = vRP.getUserId(source)

    return vRP.hasPermission(user_id,"staff.permissao")
end

exports("checkPermissionAlternative",checkPermissionAlternative)
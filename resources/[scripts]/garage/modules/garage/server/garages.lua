vRP._prepare('garage/getVehicle', 'SELECT * FROM user_vehicles WHERE id = @id')
vRP._prepare('garage/getWithPlate', 'SELECT * FROM user_vehicles where plate = @plate')
vRP._prepare('garage/getVehicles', 'SELECT * FROM user_vehicles WHERE user_id = @user_id OR share_user = @user_id')
vRP._prepare('garage/getOwnVehicles', 'SELECT * FROM user_vehicles WHERE user_id = @user_id AND service = @service')
vRP._prepare('garage/getServiceVehicle', 'SELECT * FROM user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND service = @service')
vRP._prepare('garage/updateVehicleState', 'UPDATE user_vehicles SET state = @state WHERE id = @id')
vRP._prepare('garage/setShared','UPDATE user_vehicles SET share_user = @user, share_expires = @expires WHERE id = @id')
vRP._prepare('garage/updateShared','UPDATE user_vehicles SET share_user = @user WHERE id = @id')
vRP._prepare('garage/addVehicle', 'INSERT INTO user_vehicles (user_id, vehicle, plate, service, ipva, rented) values (@user_id, @vehicle, @plate, @service, @ipva, @rented)')
vRP._prepare('garage/setDetained', 'UPDATE user_vehicles SET detained = @detained WHERE id = @id')
vRP._prepare('garage/getDetained', 'SELECT detained FROM user_vehicles WHERE id = @id')
vRP._prepare('garage/setIPVA', 'UPDATE user_vehicles SET ipva = @ipva WHERE id = @id')
vRP._prepare('garage/transferVehicle', 'UPDATE user_vehicles SET user_id = @user_id WHERE id = @id')
vRP._prepare('garage/findLatestVehicle', 'SELECT * FROM user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle ORDER BY id DESC LIMIT 1')
vRP._prepare('garage/delVehicle', 'DELETE FROM user_vehicles WHERE id = @id')
vRP._prepare('garage/getTebexCommand', 'select * from tebex where user_id = @userId and executed = 0 and product = @vehicle and method = "-car"')

vRP._prepare('garage/getVehiclePlate', 'SELECT plate FROM user_vehicles WHERE id = @id')
vRP._prepare('garage/getOwnedVehicles', 'SELECT * FROM user_vehicles WHERE user_id = @user_id and service = 0')
vRP._prepare('garage/getMaxGarages', 'SELECT garages FROM user_characters WHERE id = @id')
vRP._prepare('garage/getRented', 'SELECT * FROM user_vehicles WHERE rented > 0')
vRP._prepare('garage/updatePlate', 'UPDATE user_vehicles SET plate = @plate WHERE id = @id')
vRP._prepare('garage/setRented', 'UPDATE user_vehicles set rented = @rented WHERE id = @id')

vRP._prepare('garage/getUserVehicles', 'SELECT * FROM user_vehicles WHERE user_id = @user_id AND service = 0')

vRP._prepare("garage/getRandomVeh","SELECT * FROM user_vehicles WHERE plate != @plate ORDER BY RAND() LIMIT 1")
vRP._prepare("garage/getRandomByModel","SELECT * FROM user_vehicles WHERE vehicle = @vehicle AND plate != @plate ORDER BY RAND() LIMIT 1")

vRP._prepare("garage/setTracker",'UPDATE user_vehicles SET tracker = @tracker WHERE id = @id')
vRP._prepare("garage/hasTracker",'SELECT tracker FROM user_vehicles WHERE id = @id')

-- Expirar carro alugado pela base
AddEventHandler('playerSpawn', function(user_id, source)
    local userVehicles = vRP.query('garage/getUserVehicles', { user_id = user_id })
    local currTime = os.time()

    for i, v in pairs(userVehicles) do
        local tebexCommand = vRP.query('garage/getTebexCommand', {
            userId = user_id,
            vehicle = v.vehicle
        })

        if #tebexCommand == 0 then
            if v.rented > 0 then
                if (currTime > v.rented) then
                    local gloves, trunk = {}, {}
                    
                    local VehGloves = vRP.Inventory( 'vehicleGloves:'..v.id )
                    if VehGloves then gloves = VehGloves:getItems(); end;

                    local VehTrunk = vRP.Inventory( 'vehicleTrunk:'..v.id )
                    if VehTrunk then trunk = VehTrunk:getItems(); end;

                    print('Vehicle #'..tostring(v.id)..' ('..tostring(v.plate)..') expired.')
                    sGARAGE.remVehicle(v.id)

                    vRP.webhook('rental', {
                        title = 'rental-expires',
                        descriptions = {
                            { 'user_id', v.user_id },
                            { 'vehid', v.id },
                            { 'vehicle', v.vehicle },
                            { 'plate', v.plate },
                            { 'expires', (v.rented)..' ('..os.date('%d/%m/%Y - %H:%M', v.rented) },
                            { 'gloves', json.encode(gloves) },
                            { 'trunk', json.encode(trunk) },
                        }
                    })
                end
            end
        end
    end
end)
--======================================================================================================================
-- OPEN GARAGE
--======================================================================================================================
function tGARAGE.checkPermissions(idx)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local garData = config.garages[idx]
        if garData then
            -- if (exports['bank']:verifyMultas(user_id) > 0) then -- exports.bank removido
            --     TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você não pode acessar a garagem tendo multas em sua conta.')
            --     return false
            -- end

            local homePerm = garData.home
            if (homePerm) then
                if (not exports.homes:checkHomePermission(user_id, homePerm)) then
                    TriggerClientEvent('Notify',source,'negado','Garagem','Não possui <b>permissões</b> para acessar esta Garagem!')
                    return false
                end
            else
                local perm = garData.permission
                if (perm) then
                    if (not vRP.hasPermission(user_id, perm)) then
                        TriggerClientEvent('Notify',source,'negado','Garagem','Não possui <b>permissões</b> para acessar esta Garagem!')
                        return false
                    end
                end
            end
            return true 
        end
    end
    return false
end

local vehicleListBuilder = {
    ['normal'] = function(source,user_id,myVehicles,garData,complete,tracker)
        local cb = {}
        local vehicles = vRP.query('garage/getVehicles',{ user_id = user_id })
        local currTime = os.time()
        for k,v in ipairs(vehicles) do
            if v.service == 0 then
                if (v.share_user > -1) then
                    if (currTime > v.share_expires) then
                        vRP.execute('garage/setShared',{ id = v.id, user = -1, expires = -1 })
                        v.share_user = -1
                        v.shared_expires = -1
                    end
                end

                if ((v.user_id == user_id) and (v.share_user == -1)) or (tracker and (v.tracker == 1)) or (v.share_user == user_id) then

                    local add = true
                    if (garData.rule and config.rules[garData.rule]) then
                        local gRule = config.rules[garData.rule]
                        local vclass = vehicleClass(v.vehicle)
                        if (gRule.show_classes) then
                            add = false
                            if (gRule.show_classes[vclass]) then add = true; end;
                        end
                        if (add and gRule.hide_classes) then
                            if (gRule.hide_classes[vclass]) then add = false; end;
                        end
                    end

                    if (add) then

                        if v.rented > 0 then 
                            local tebexCommand = vRP.query('garage/getTebexCommand', {
                                userId = user_id,
                                vehicle = v.vehicle
                            })

                            if #tebexCommand > 0 then
                                local executionAt = tonumber(tebexCommand[1].execution_at)
                                v.rented = executionAt / 1000
                            end
                        end

                        local vehicle = { 
                            id = v.id,
                            name = vehicleName(v.vehicle),
                            maker = vehicleMaker(v.vehicle),
                            type = vehicleType(v.vehicle),
                            class = vehicleClass(v.vehicle),
                            user_id = v.user_id,
                            spawn = v.vehicle,
                            plate = v.plate,
                            service = v.service,
                            detained = v.detained,
                            ipva = v.ipva,
                            rented = v.rented,
                            share_user = v.share_user,
                            trunk = getCarTrunkWeight(v.id, vehicleTrunk(v.vehicle) ),
                        }

                        local state = json.decode(v.state)
                        local custom = json.decode(v.custom)

                        vehicle.body = (state.body or 100)
                        vehicle.engine = (state.engine or 100)
                        vehicle.breaker = getMods(custom, '12')
                        vehicle.transmission = getMods(custom, '13')
                        vehicle.suspension = getMods(custom, '15')
                        vehicle.fuel = (state.fuel or 80)
                        
                        if complete then
                            vehicle.state = state
                            vehicle.custom = custom
                        end

                        cb[#cb+1] = vehicle
                    end
                end
            end
        end
        return cb
    end,

    ['service'] = function(source,user_id,myVehicles,garData,complete)
        local cb = {}
        for k,v in pairs(garData.vehicles) do
            local vehId = -1
            local veh = vRP.query('garage/getServiceVehicle',{ user_id = user_id, vehicle = v, service = 1 })[1]
            if veh then
                vehId = veh.id
            else
                vehId = vRP.insert('garage/addVehicle',{ user_id = user_id, vehicle = v, plate = sGARAGE.generatePlate(), service = 1, ipva = os.time(), rented = 0 })
                veh = vRP.query('garage/getVehicle',{ id = vehId })[1]
            end

            if veh then
                local vehicle = { 
                    id = vehId,
                    name = vehicleName(veh.vehicle),
                    maker = vehicleMaker(veh.vehicle),
                    type = vehicleType(veh.vehicle),
                    class = vehicleClass(veh.vehicle),
                    user_id = veh.user_id,
                    spawn = veh.vehicle,
                    plate = veh.plate,
                    service = veh.service,
                    detained = 0,
                    ipva = 0,
                    share_user = -1,
                    trunk = getCarTrunkWeight(vehId, vehicleTrunk(veh.vehicle) )
                }

                local state = json.decode(veh.state) or {}
                local custom = json.decode(veh.custom)

                vehicle.body = (state.body or 100)
                vehicle.engine = (state.engine or 100)
                vehicle.breaker = getMods(custom, '12')
                vehicle.transmission = getMods(custom, '13')
                vehicle.suspension = getMods(custom, '15')
                vehicle.fuel = (state.fuel or 80.0)

                if complete then
                    vehicle.state = state
                    vehicle.custom = custom
                end

                cb[#cb+1] = vehicle
            end
        end
        return cb
    end,
}

function tGARAGE.requestVehicles(idx,complete)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return sGARAGE.getVehicles(source,user_id,idx,complete,true)
    end
    return {}
end

function sGARAGE.getVehicles(source,user_id,idx,complete,tracker)
    local garData = config.garages[idx]
    if garData then
        local garType = 'normal'
        if garData.vehicles then garType = 'service'; end;
        return vehicleListBuilder[garType](source, user_id, myVehicles, garData, complete, tracker)          
    end
    return {}
end
--======================================================================================================================
-- MAIN FUNCTIONS
--======================================================================================================================
function sGARAGE.vehicleData(netId,entity)
    local vehicle = entity
    if (netId and NetworkGetEntityFromNetworkId(netId)) then
        vehicle = NetworkGetEntityFromNetworkId(netId)
	end
    if vehicle and (DoesEntityExist(vehicle)) then
        local stateBag = Entity(vehicle).state
        return { 
            entity = vehicle,
            id = stateBag['id'],
            user_id = stateBag['user_id'],
            model = stateBag['model'],
            plate = stateBag['plate'],
            service = stateBag['service'],
            state = stateBag['state'],
            custom = stateBag['custom'],
            share_user = stateBag['share_user'],
            locked = stateBag['locked'],
            clone = stateBag['clone'],
        }
    end
	return {}
end
--======================================================================================================================
-- INTERIORS
--======================================================================================================================
local bucketIDS = Tools.newIDGenerator()
local buckets = {}
local seasons = {}

function canInteriorSpawn(veh)
    if (veh.detained > 0) or (os.time() >= parseInt( veh.ipva + (config.ipvaDays * 24 * 60 * 60))) and (veh.service == 0) then
        return false
    else
        return true
    end
end

function tGARAGE.initSeason(idx)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        local garData = config.garages[idx]
        if garData then

            local bucket = buckets[user_id]
            if (not bucket) then
                bucket = parseInt(bucketIDS:gen()+15000)
                buckets[user_id] = bucket
            end
            
            SetPlayerRoutingBucket(source,bucket)
            seasons[user_id] = { garageId = idx, vehicles = {} }
            Wait(1000)

            local intData = config.interiors[garData.interior.id]
            local userVehicles = sGARAGE.getVehicles(source,user_id,idx,true,false)
            
            local maxBoxes = #intData.boxes
            local currBox = 1

            for _,veh in ipairs(userVehicles) do
                if (currBox <= maxBoxes) then
                    if canInteriorSpawn(veh) and ((not intData.block) or (not intData.block[veh.spawn])) then
                        Wait(50)
                        local coords = intData.boxes[currBox] 
                        CreateThread(function()
                            if (not sGARAGE.findVehicle(veh.id)) then
                              
                                local vehHandle = CreateServerVehicle(veh.spawn, vec3(coords.x, coords.y, coords.z-100.001), coords.w or 0.0)
                                if DoesEntityExist(vehHandle) then
                                   
                                    FreezeEntityPosition(vehHandle, true)
                                    SetEntityRoutingBucket(vehHandle, bucket)
                                    Wait(100)
                                    
                                    if DoesEntityExist(vehHandle) then
                                        local stateBag = Entity(vehHandle).state
                                        stateBag['id'] = veh.id
                                        stateBag['user_id'] = veh.user_id
                                        stateBag['model'] = veh.spawn
                                        stateBag['plate'] = veh.plate
                                        stateBag['service'] = veh.service
                                        stateBag['state'] = veh.state
                                        stateBag['custom'] = veh.custom
                                        stateBag['fuel'] = veh.fuel
                                        stateBag['share_user'] = (veh.share_user or -1)
                                        stateBag['locked'] = 2
                                        stateBag['sourceGarage'] = source
                                        
                                        SetVehicleDoorsLocked(vehHandle, 2)
                                        SetVehicleNumberPlateText(vehHandle, veh.plate)
           
                                        local netId = NetworkGetNetworkIdFromEntity(vehHandle)
                                        cGARAGE.settingVehicle(source, netId, veh.plate, veh.custom, coords, veh.fuel, true)
                                       
                                        if (seasons[user_id]) then table.insert(seasons[user_id].vehicles,vehHandle); end;
                                    end
                                end
                            end
                        end)
                        currBox = currBox + 1
                    end
                else
                    break
                end
            end
        end        
    end
    return false
end

function exitSeason(user_id, source, withVehicle, onStop)
    if seasons[user_id] then
        
        local garData = config.garages[seasons[user_id].garageId]
 
        vRP.setKeyDataTable(user_id, 'position',{ x = garData.coords.x, y = garData.coords.y, z = garData.coords.z })
        if onStop then vRPclient._teleport(source,garData.coords.x,garData.coords.y,garData.coords.z); end;

        local veh = -1
        if withVehicle then
            local ped = GetPlayerPed(source)
            if ped > 0 then
                veh = GetVehiclePedIsIn(ped)       
                if (garData.tax) and (not checkRemoveTax(source, user_id, garData.tax, Entity(veh).state['model'] )) then
                    return
                end
                SetEntityRoutingBucket(veh,0)
                Entity(veh).state['sourceGarage'] = nil
            end
        end

        SetPlayerRoutingBucket(source,0)
        for k,v in pairs(seasons[user_id].vehicles) do
            if (veh ~= v) and DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end
        seasons[user_id] = nil

        return true
    end
end

function checkRemoveTax(source,user_id,mode,model)
    if (not vRP.hasPermission(user_id, 'taxgarage.permissao')) then
        local value = config.garageTax
        if (mode == 'percent') then value = math.floor( vehiclePrice(model)*0.10 ); end;

        if exports.hud:request(source, 'Garagem', 'Você realmente deseja pagar <b>R$'..value..'</b> pelo estacionamento?', 30000) then
            if (not vRP.tryFullPayment(user_id, value)) then
                TriggerClientEvent('notify', source, 'negado', 'Garagem', 'Você não possui <b>R$'..value..'</b> para pagar o estacionamento.')
                return;
            end
            exports['phone-bank']:createStatement(user_id, { title = 'Taxas', content = 'Pagou estacionamento', value = value, type = 'spent' })
            TriggerClientEvent('notify', source, 'sucesso', 'Garagem', 'Você pagou <b>R$'..value..'</b> para o estacionamento.')
        else
            return;
        end
    end
    return true
end

function tGARAGE.exitSeason(withVehicle)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        return exitSeason(user_id, source, withVehicle, false)
    end
end

AddEventHandler('vRP:playerLeave',exitSeason)

AddEventHandler('onResourceStop', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
		for k, v in pairs(seasons) do
            local source = vRP.getUserSource(k)
            if source then exitSeason(k, source, false, true); end;
        end
	end
end)
--======================================================================================================================
-- SPAWN
--======================================================================================================================
local trackerBlips = {}
local trackerWait = {}
local trackerIds = Tools.newIDGenerator()
local spawnTasks = {}

local vehicleDetained = {
    [0] = function()
        return true
    end,
    [1] = function(source, user_id, vehId, model)
        local value = parseInt(vehiclePrice(model) * config.taxDetained)
        local request = vRP.request(source, 'Garagem', 'Veículo roubado, deseja acionar o seguro pagando R$'..vRP.format(value)..'?', 60000)
        if (request) then
            if (vRP.tryFullPayment(user_id, value)) then
                exports['phone-bank']:createStatement(user_id, { title = 'Taxas', content = 'Seguro do veículo', value = value, type = 'spent' })
                vRP.execute('garage/setDetained',{ id = vehId, detained = 0 })
                TriggerClientEvent('Notify', source, 'sucesso', 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                return true
            else
                TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
                return false
            end
        end
        return false
    end,
    [2] = function(source, user_id, vehId, model)
        local value = parseInt(vehiclePrice(model) * config.taxSafe)
        local request = vRP.request(source, 'Garagem', 'Veículo detido, deseja pagar a multa de R$'..vRP.format(value)..'?', 60000)
        if (request) then
            if (vRP.tryFullPayment(user_id, value)) then
                exports['phone-bank']:createStatement(user_id, { title = 'Taxas', content = 'Seguro do veículo', value = value, type = 'spent' })
                vRP.execute('garage/setDetained',{ id = vehId, detained = 0 })
                TriggerClientEvent('Notify', source, 'sucesso', 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                return true
            else
                TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
                return false
            end
        end
        return false
    end
}

function tGARAGE.spawnVehicle(currentGarage, vehId, spawn)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        local garData = config.garages[currentGarage]
        if garData then
            if vehId and (not spawnTasks[source]) then
                spawnTasks[source] = true

                local vehEntity, netId = sGARAGE.findVehicle(vehId)
                if (not vehEntity) then
                                       
                    if (vehId <= 0) then
                        if garData.vehicles then
                            for _,model in pairs(garData.vehicles) do
                                if (model == spawn) then
                                    vehId = vRP.insert('garage/addVehicle',{ user_id = user_id, vehicle = model, plate = sGARAGE.generatePlate(), service = 1, ipva = os.time(), rented = 0 })
                                    break
                                end
                            end
                        end
                    end
                    local veh = vRP.query('garage/getVehicle',{ id = vehId })[1]

                    if (veh.share_user > 0) and (veh.share_user ~= user_id) then
                        TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Este <b>veículo</b> não pode ser localizado.')
                        spawnTasks[source] = nil
                        return;
                    end

                    if (veh.user_id ~= user_id) and (veh.share_user ~= user_id) then
                        spawnTasks[source] = nil
                        return;
                    end

                    if garData.interior then
                        local intData = config.interiors[garData.interior.id]
                        if intData and (intData.block) and (intData.block[veh.vehicle]) then
                            TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você não pode retirar este veículo nesta garagem.')
                            spawnTasks[source] = nil
                            return;
                        end
                    else
                        if (garData.tax) and (not checkRemoveTax(source,user_id,garData.tax,veh.vehicle)) then
                            spawnTasks[source] = nil
                            return;
                        end                            
                    end

                    if (veh.service == 0) then
                        
                        -- if (exports['bank']:verifyMultas(user_id) > 0) then -- exports.bank removido
                        --     TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você não pode retirar um veículo da garagem tendo multas em sua conta.')
                        --     spawnTasks[source] = nil
                        --     return
                        -- end

                        local detained = vehicleDetained[(veh.detained)](source, user_id, vehId, veh.vehicle)
                        if (not detained) then 
                            spawnTasks[source] = nil
                            return
                        end

                        if (os.time() >= parseInt(veh.ipva + (config.ipvaDays * 24 * 60 * 60))) then
                            local priceTax = parseInt(vehiclePrice(veh.vehicle) * config.ipvaTax)

                            local request = vRP.request(source, 'Garagem', 'Deseja pagar o <b>Vehicle Tax</b> do veículo <b>'..vehicleName(veh.vehicle)..'</b> por <b>R$'..vRP.format(priceTax)..'</b>?', 60000)
                            if (request) then
                                if (vRP.tryFullPayment(user_id, priceTax)) then
                                    exports['phone-bank']:createStatement(user_id, { title = 'Taxas', content = 'IPVA do veículo', value = priceTax, type = 'spent' })
                                    vRP.execute('garage/setIPVA', { id = vehId, ipva = os.time() })
                                    TriggerClientEvent('Notify', source, 'sucesso', 'Garagem', 'O <b>pagamento</b> foi efetuado com sucesso.')
                                    vRP.webhook('https://discord.com/api/webhooks/1319459289194041415/nyFyvEBBIbAJKe3QT-wI_HqLEzbIbxeifbX7bYrbvjbis_1CreocPnDFyi2k6-FZphQq', {
                                        title = 'Pagou IPVA',
                                        descriptions = {
                                            { 'user id', user_id },
                                            { 'vehicle', veh.vehicle },
                                        }
                                    })
                                else
                                    TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você não possui <b>dinheiro</b> suficiente para este pagamento.')
                                end
                            end
                            spawnTasks[source] = nil
                            return
                        end
                    end
                    local loadModel = cGARAGE.loadModel(source, veh.vehicle, 30000, 60000)
                    if (loadModel) then
                        local slot, coords = cGARAGE.getFreeSlot(source, currentGarage)
                        if (slot) then
                            
                            local bucket = GetPlayerRoutingBucket(source)
                            CreateThread(function()
                                local zSpawn = ((garData.interior and coords.z-100.001) or coords.z)
                                local vehHandle = CreateServerVehicle(veh.vehicle, vec3(coords.x, coords.y, coords.z), coords.w or 0.0)
                                if DoesEntityExist(vehHandle) then
                                    FreezeEntityPosition(vehHandle, true)
                                    SetEntityRoutingBucket(vehHandle, bucket)

                                    Wait(100)
                                    
                                    if DoesEntityExist(vehHandle) then
                                        local state = json.decode(veh.state)
                                        local fuel = ((state and state.fuel) or 80.0)

                                        local stateBag = Entity(vehHandle).state
                                        stateBag['id'] = veh.id
                                        stateBag['user_id'] = veh.user_id
                                        stateBag['model'] = veh.vehicle
                                        stateBag['plate'] = veh.plate
                                        stateBag['service'] = veh.service
                                        stateBag['state'] = state
                                        stateBag['custom'] = json.decode(veh.custom)
                                        stateBag['fuel'] = fuel
                                        stateBag['share_user'] = (veh.share_user or -1)
                                        stateBag['locked'] = 2
                                        stateBag['directionLoss'] = state.directionLoss
                                        stateBag['constantHonk'] = state.constantHonk
                                        stateBag['BackFire'] = state.BackFire
                                        stateBag['drift'] = state.drift
                                        stateBag['fluctuate_engine'] = state.fluctuate_engine
                                        if garData.interior then
                                            stateBag['sourceGarage'] = source
                                        end

                                        SetVehicleDoorsLocked(vehHandle, 2)
                                        SetVehicleNumberPlateText(vehHandle, veh.plate)
                                                                            
                                        local netId = NetworkGetNetworkIdFromEntity(vehHandle)
                                        cGARAGE.settingVehicle(source, netId, veh.plate, json.decode(veh.custom), coords, fuel, garData.interior)
                                        
                                        if garData.interior and seasons[user_id] then
                                            table.insert(seasons[user_id].vehicles,vehHandle)
                                        end

                                        TriggerClientEvent('Notify', source, 'sucesso', 'Garagem', 'O <b>veículo</b> foi liberado com sucesso.')
                                    end
                                end
                                spawnTasks[source] = nil
                            end)
                            return                      
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Todas as <b>vagas</b> se encontram ocupadas no momento.')
                        end
                    else
                        TriggerClientEvent('Notify', source, 'importante', 'Garagem', 'O <b>veículo</b> se encontra indisponível no momento.')
                    end
                else
                    local vehState = sGARAGE.vehicleData(netId)
                    local tracker = vRP.scalar('garage/hasTracker',{ id = vehId })

                    if (vehState.user_id == user_id) and (tracker == 1) then
                        if (not trackerWait[vehId]) then
                            trackerWait[vehId] = true
                           
                            local id = trackerIds:gen()
                            local coords = GetEntityCoords(vehEntity)

                            trackerBlips[id] = vRPclient.addBlip(source, coords.x, coords.y, coords.z, 161, 5, 'Rastreio: ~b~'..(vehicleName(vehState.model) or model)..'~w~', 0.6, false)
                            
                            Citizen.SetTimeout(30000, function() vRPclient.removeBlip(source, trackerBlips[id]); trackerIds:free(id); end)
                            Citizen.SetTimeout(60000, function() trackerWait[vehId] = nil; end)

                            TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você acionou o rastreador deste <b>veículo</b>. Verifique o seu <b>GPS</b>.')
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você rastreou este <b>veículo</b> recentemente. Aguarde.')
                        end
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'Você já possui um <b>veículo</b> deste modelo fora da garagem.')
                    end                    
                end
                spawnTasks[source] = nil
            end
        end
    end
end
--======================================================================================================================
-- DELETE
--======================================================================================================================
function sGARAGE.safeDelete(netId, ignoreState)
    local vehState = sGARAGE.vehicleData(netId)			
    if DoesEntityExist(vehState.entity) then
        if (not ignoreState) then
            if vehState['id'] and vehState['state'] then
                -- vRP._execute('garage/updateVehicleState',{ id = vehState['id'], state = json.encode(vehState['state']) })
                -- Exports removidos: tunings, troll-engine, cortagiro
            end
        end    
        DeleteEntity(vehState.entity)
        return true
    end
    return false
end

function tGARAGE.tryStoreVehicle(idx,vehId,byMenu,withVeh)
    local source = source
	local user_id = vRP.getUserId(source)
    local garData = config.garages[idx]
    if garData then
        local checkDist = garData.coords
       
        if garData.interior and withVeh then
            checkDist = garData.interior.parking
        elseif garData.interior and byMenu then
            checkDist = config.interiors[garData.interior.id].menu
        end
    
        local entity, netId = sGARAGE.findVehicle(vehId)
        if entity and DoesEntityExist(entity) then
            if #(checkDist.xyz - GetEntityCoords(entity)) < 20 then
                local vehState = sGARAGE.vehicleData(false,entity)
                if (vehState.service == 0) and (vehicleType(vehState.model) ~= 'vip') then

                    local identity = vRP.getUserIdentity(user_id)
                    local nIdentity = vRP.getUserIdentity(vehState.user_id)
                   
                    local isMechanic = vRP.checkPermissions(user_id,{ 'mecanico.permissao', 'policia.permissao' })
                    if (vehState.share_user > 0) then
                        if (user_id == vehState.user_id) then
                            vRP.execute('garage/setShared',{ id = vehState.id, user = -1, expires = -1 })
                        else
                            if (user_id ~= vehState.share_user) and (not vehState.clone) and (not isMechanic) then
                                vRP.execute('garage/updateShared',{ id = vehState.id, user = user_id })

                                vRP.webhook('robcar', {
                                    title = 'roubo veiculo',
                                    descriptions = {
                                        { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                                        { 'jogador', '#'..vehState.user_id..' '..nIdentity.firstname..' '..nIdentity.lastname },
                                        { 'vehid', vehState.id },
                                        { 'vehicle', vehState.model },
                                        { 'coords', tostring(GetEntityCoords(GetPlayerPed(source))) },
                                        { 'garagem', tostring(garData.coords) },
                                    }
                                })
                            end
                        end
                    else
                        if (user_id ~= vehState.user_id) and (not vehState.clone) and (not isMechanic) then
                            local expires = os.time()+1*24*3600
                            vRP.execute('garage/setShared',{ id = vehState.id, user = user_id, expires = expires })

                            vRP.webhook('robcar', {
                                title = 'roubo veiculo',
                                descriptions = {
                                    { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                                    { 'jogador', '#'..vehState.user_id..' '..nIdentity.firstname..' '..nIdentity.lastname },
                                    { 'vehid', vehState.id },
                                    { 'vehicle', vehState.model },
                                    { 'coords', tostring(GetEntityCoords(GetPlayerPed(source))) },
                                    { 'garagem', tostring(garData.coords) },
                                    { 'expira', os.date('%d/%m/%Y - %H:%M', expires) },
                                }
                            })
                        end                        
                    end
                end
                return sGARAGE.safeDelete(netId)
            else
                TriggerClientEvent('Notify',source,'importante','Garagem','Veículo muito distante!')
            end
        else
            TriggerClientEvent('Notify',source,'importante','Garagem','Veículo já está na Garagem!')
        end
    end
end

local ghostVehicles = {}
function tGARAGE.syncVehicleAlpha(netid, alpha, timeout)
    local veh = NetworkGetEntityFromNetworkId(netid)
    if veh and DoesEntityExist(veh) then
        ghostVehicles[netid] = alpha
        GlobalState.ghostVehicles = ghostVehicles
        Entity(veh).state.ghostVehicle = alpha
        cGARAGE.syncVehicleAlpha(-1, netid, alpha)
        if timeout then
            SetTimeout(timeout*1000,function()
                tGARAGE.syncVehicleAlpha(netid, nil)
            end)
        end
    end
end
--======================================================================================================================
-- LOCK
--======================================================================================================================
sharedKeys = {}

function tGARAGE.vehicleLock()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cveh,netId,placa,vname,lock,banned = vRPclient.vehList(source,7.5)
		if netId and vname then
			local vehState = sGARAGE.vehicleData(netId)
			if (user_id == vehState.user_id) or (user_id == sharedKeys[netId]) or (user_id == vehState.share_user) then
                
                local stateBag = Entity(vehState.entity).state

				if (not vRPclient.isInVehicle(source)) then vRPclient._playAnim(source,true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false); end;
				TriggerClientEvent('vrp_sounds:vehicle', source, netId, 15.0, 'lock', 0.01)
                if (stateBag['locked'] == 1) then
                    stateBag:set('locked',2,true)
					TriggerClientEvent("Notify",source,"importante","Garagem","Veículo <b>trancado</b> com sucesso.",8000)
				else
                    stateBag:set('locked',1,true)
					TriggerClientEvent("Notify",source,"importante","Garagem","Veículo <b>destrancado</b> com sucesso.",8000)
				end
			end
		end
	end
end
--======================================================================================================================
-- TRUNK
--======================================================================================================================
local trunksOpened = {}

function tGARAGE.tryOpenTrunk()
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        local _,netId,placa,vname,lock,banned,trunk = vRPclient.vehList(source,3)
        if netId then
            if (lock ~= 1) then return; end;

            local vehState = sGARAGE.vehicleData(netId)
            if vehState.entity and vehState.id and (vehState.id > 0) and (not vehState.clone) then
                
                local restrictions = (config.trunks.restrict[vehState.model] or config.trunks.restrict['default'])
                local invId = ('vehicleTrunk:'..vehState.id)
                local maxChest = vehicleTrunk(vehState.model)
                local maxSlot = config.trunks.mainSlots
                
                local trunk = true
                if (GetVehiclePedIsIn(GetPlayerPed(source)) == vehState.entity) then
                    trunk = false
                    invId = ('vehicleGloves:'..vehState.id)
                    maxChest = vehicleGlove(vehState.model)
                    maxSlot = config.trunks.gloveSlots
                end

                if (maxChest <= 0) then return; end;

                if (not trunksOpened[invId]) then
                    
                    trunksOpened[invId] = true

                    if (trunk) then 
                        cGARAGE.vehicleClientTrunk(-1,netId,false)
                    end

                    exports['inventory']:openVault(user_id, invId, vehicleName(vehState.model), {  weight = maxChest, slots = maxSlot }, config.trunks.webhooks, restrictions, function() 
                        --onclose
                        trunksOpened[invId] = nil
                        if (trunk) then 
                            cGARAGE.vehicleClientTrunk(-1,netId,true)
                        end
                    end)
                else
                    TriggerClientEvent('Notify', source, 'aviso', 'Garagem', 'Compartimento ocupado no momento!')
                end
            end
        end
    end
end
--======================================================================================================================
-- ADMIN /CAR
--======================================================================================================================
RegisterCommand('car', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and (vRP.hasPermission(user_id, '+Staff.Administrador') or vRP.hasPermission(user_id, 'gravacao.permissao')) then
        if (args[1]) then
            local vehicleModel = string.lower(args[1])
           
            local loadModel = cGARAGE.loadModel(source, vehicleModel, 30000, 60000)
            if loadModel then
                local playerBucket = GetPlayerRoutingBucket(source)
                local playerPed = GetPlayerPed(source)

                local playerCoord = GetEntityCoords(playerPed)
                local playerHeading = GetEntityHeading(playerPed)
               
                local userVehicle = vRP.query('garage/getServiceVehicle',{ user_id = user_id, vehicle = vehicleModel, service = 0 })[1]
                if (not userVehicle) then
                    userVehicle = { id = -1, plate = identity.registration, state = '{}', custom = 'null' }
                end
       
                CreateThread(function()
                    local vehHandle = CreateServerVehicle(vehicleModel, vec3(playerCoord.x, playerCoord.y, playerCoord.z), playerHeading)
                    if DoesEntityExist(vehHandle) then
                        FreezeEntityPosition(vehHandle, true)
                        SetEntityRoutingBucket(vehHandle, playerBucket)
                        Wait(100)
                        if DoesEntityExist(vehHandle) then
                            local stateBag = Entity(vehHandle).state
                            stateBag['id'] = userVehicle.id
                            stateBag['user_id'] = user_id
                            stateBag['model'] = vehicleModel
                            stateBag['plate'] = userVehicle.plate
                            stateBag['service'] = 0
                            stateBag['state'] = json.decode(userVehicle.state)
                            stateBag['custom'] = json.decode(userVehicle.custom)
                            stateBag['fuel'] = 100.0
                            stateBag['share_user'] = -1
                            stateBag['locked'] = 1
                        
                            SetVehicleDoorsLocked(vehHandle, 1)
                            SetVehicleNumberPlateText(vehHandle, userVehicle.plate)

                            local netId = NetworkGetNetworkIdFromEntity(vehHandle)
                            cGARAGE.settingVehicle(source, netId, userVehicle.plate, json.decode(userVehicle.custom), playerCoord, 100.0, false)

                            SetPedIntoVehicle(playerPed, vehHandle, -1)

                            vRP.webhook('car', {
                                title = 'car',
                                descriptions = {
                                    { 'staff', user_id },
                                    { 'spawnou', vehicleModel },
                                    { 'COORDS', playerCoord }
                                }
                            })    
                            TriggerClientEvent('Notify', source, 'Garagem', 'O <b>veículo</b> foi spawnado com sucesso.')
                        end
                    end
                end)

            end
        end
    end
end)
--======================================================================================================================
-- DV
--======================================================================================================================
RegisterCommand('dv', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "dv.permissao") then
		local vehicle,netId = vRPclient.vehList(source,7)
		if netId then
            local identity = vRP.getUserIdentity(user_id)
			local vehState = sGARAGE.vehicleData(netId)
            if DoesEntityExist(vehState.entity) then		
                local coord = GetEntityCoords(vehState.entity)
                local model = GetEntityModel(vehState.entity)
                if sGARAGE.safeDelete(netId) then
                    vRP.webhook('dv', {
                        title = 'dv',
                        descriptions = {
                            { 'user', user_id.." | "..identity.firstname.." "..identity.lastname },
                            { 'vehicle', (getHashModel(model) or '?') },
                            { 'owner', (vehState.user_id or 'NPC?') },
                            { 'coord', tostring(coord) }
                        }
                    })  
                end
            end
        end
	end
end)

RegisterCommand('dvall', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('announcement', -1, 'Prefeitura', 'Todos os <b>veículos</b> que não possuem alguém dentro, serão deletados em <b>60 segundos</b>.', 'Prefeitura', true, 10000)
        Citizen.Wait(30000)
        TriggerClientEvent('announcement', -1, 'Prefeitura', 'Todos os <b>veículos</b> que não possuem alguém dentro, serão deletados em <b>30 segundos</b>.', 'Prefeitura', true, 10000)
        Citizen.Wait(30000)
        local deleteCount = 0
        for _, veh in ipairs(GetAllVehicles()) do
            local ped = GetPedInVehicleSeat(veh, -1)
            if (not ped or ped <= 0) then 
                DeleteEntity(veh)     
                deleteCount = deleteCount + 1
            end
        end
        TriggerClientEvent('announcement', -1, 'Prefeitura', 'Foram deletados <b>'..deleteCount..'</b> veículos.', 'Prefeitura', true, 10000)

        vRP.webhook('dvall', {
            title = 'dvall',
            descriptions = {
                { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                { 'deletou', deleteCount..' veículos' },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
    end
end)
--======================================================================================================================
-- FIX
--======================================================================================================================
RegisterCommand('fix', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local vehicle,netId = vRPclient.vehList(source,12.0)
		if netId then
            local identity = vRP.getUserIdentity(user_id)
			local vehState = sGARAGE.vehicleData(netId)
            if DoesEntityExist(vehState.entity) then		
                local coord = GetEntityCoords(vehState.entity)
                local model = GetEntityModel(vehState.entity)
                TriggerClientEvent('syncreparar', -1, netId)

                vRP.webhook('fix', {
                    title = 'fix',
                    descriptions = {
                        { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                        { 'fix', (getHashModel(model) or '?') },
                        { 'owner', (vehState.user_id or 'NPC?') },
                        { 'coord', tostring(coord) }
                    }
                })  
            end
        end      
    end
end)
--======1================================================================================================================
-- ADD COMMANDS
--======================================================================================================================
RegisterCommand('addcar', function(source)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.COO') then
        local prompt = vRP.prompt(source, { 'Passaporte', 'Veículo', 'Expira em quantos dias?:' })
        if (prompt) then
            if (prompt[1] and prompt[2]) then
                local nUser = parseInt(prompt[1])
                local vehicle = prompt[2]
                local days = parseInt(prompt[3])
                if (config.vehicles[vehicle]) then

                    sGARAGE.addVehicle(nUser, vehicle, days)

                    TriggerClientEvent('notify', source, 'sucesso', 'Garagem', 'Carro adicionado com sucesso!')

                    local nIdentity = vRP.getUserIdentity(nUser)

                    vRP.webhook('addcar', {
                        title = 'addcar',
                        descriptions = {
                            { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                            { 'jogador', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                            { 'adicionou o veículo', vehicle },
                            { 'dias', days }
                        }
                    })  
                else
                    TriggerClientEvent('Notify', source, 'aviso', 'Garagem', 'Não foi possível encontrar o <b>'..capitalizeString(vehicle)..'</b> em nossa cidade.')
                end
            end
        end
    end
end)

RegisterCommand('remcar', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.COO') then
        local prompt = vRP.prompt(source, { 'Passaporte', 'Veículo' })
        if (prompt) then
            if (prompt[1] and prompt[2]) then
                local nUser = parseInt(prompt[1])
                local vehicle = prompt[2]
                if (config.vehicles[vehicle]) then
                    sGARAGE.remVehicle(nUser, vehicle)
                    TriggerClientEvent('notify', source, 'Garagem', 'Você removeu o veículo <b>'..vehicle..'</b> do id <b>'..nUser..'</b>.')
                    local nIdentity = vRP.getUserIdentity(nUser)

                    vRP.webhook('remcar', {
                        title = 'remcar',
                        descriptions = {
                            { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                            { 'jogador', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                            { 'removeu o veículo', vehicle },
                        }
                    })  
                else
                    TriggerClientEvent('notify', source, 'Garagem', 'Não foi possível encontrar o <b>'..capitalizeString(vehicle)..'</b> em nossa cidade.')
                end
            end
        end
    end
end)
--======================================================================================================================
-- ADD GARAGE
--======================================================================================================================
AddEventHandler('playerSpawn', function(user_id, source, first_spawn)
    local count, userHomes = exports.homes:getAllUserHomes(user_id, true)
    if (count > 0) then
        for home in pairs(userHomes) do
            local hasGarage = exports.homes:hasGarage(home)
            if (hasGarage) then
                addGarage(source, home, hasGarage.blip, hasGarage.spawn)
            end
        end
    end
end)

RegisterNetEvent('homes:addGarage', function(source, home, blip, spawn)
    if (source) then
        addGarage(source, home, blip, spawn)
    else
        local cacheHomes = exports.homes:cacheHomes()
        if (cacheHomes) and cacheHomes[home] then
            for id, _ in pairs(cacheHomes[home].residents) do
                local src = vRP.getUserSource( tonumber(id) )
                if (src) then addGarage(src, home, blip, spawn); end;
            end

            local src = vRP.getUserSource( cacheHomes[home].owner )
            if (src) then addGarage(src, home, blip, spawn); end;
        end
    end
end)

function addGarage(src, name, blip, spawn)
    config.garages[name] = {
        coords = vector3(blip.x, blip.y, blip.z),
        rule = 'carOnly',
        interior = {         
            id = 'homes',
            parking = vector4(spawn.x, spawn.y, spawn.z, spawn.w),
        },
        points = {}
    }
    cGARAGE._addGarage(src, name, config.garages[name])
end
--======================================================================================================================
-- ALLOWLIST VEHICLES
--======================================================================================================================
local knownVehicles = {}

function CreateServerVehicle(model,coords,heading)  
    local veh = CreateVehicle(GetHashKey(model), coords.x, coords.y, coords.z, heading or 0.0, true, true)   
    --local veh = Citizen.InvokeNative(`CREATE_AUTOMOBILE`, GetHashKey(model), coords.x, coords.y, coords.z, (heading or 0.0) )
    local timeout = GetGameTimer()+5000
    while (not DoesEntityExist(veh)) do
        if (timeout < GetGameTimer()) then
            break
        end
        Citizen.Wait(10)
    end
    if DoesEntityExist(veh) then
        knownVehicles[veh] = true
        return veh
    else
        return CreateServerVehicle(model,coords,heading)
    end
end
sGARAGE.CreateServerVehicle = CreateServerVehicle

AddEventHandler("entityCreating",function(entity)
    Citizen.Wait(1000)
	if (not DoesEntityExist(entity)) then return; end;
    if (GetEntityType(entity) == 2) then
        local popType = GetEntityPopulationType(entity)
        if knownVehicles[entity] or (popType == 5) then
            return
        end
        DeleteEntity(entity)
        CancelEvent()
    end
end)

AddEventHandler("entityRemoved",function(entity)
    if knownVehicles[entity] then knownVehicles[entity] = nil; end;
end)
--======================================================================================================================
-- CHECK HASH
--======================================================================================================================
RegisterCommand("gethash",function(source,args)
	if (source == 0) then
		local hash = parseInt(args[1])
		local vname, data = vehHashData(hash)
		if vname then
			print("Model: "..vname.." | "..json.encode(data))
		end
	end
end,true)
--======================================================================================================================
-- DELETE AND SAVE ON SHOUTDOWN
--======================================================================================================================
function deleteAllVehicles()
    for k,v in pairs(GetAllVehicles()) do
        if DoesEntityExist(v) then
            local netId = NetworkGetNetworkIdFromEntity(v)
            if netId then
                sGARAGE.safeDelete(netId)
            end
        end
    end
end

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if (eventData.secondsRemaining == 60) then
		SetTimeout(40000,function()
            deleteAllVehicles()
        end)
    end
end)
AddEventHandler('txAdmin:events:serverShuttingDown',deleteAllVehicles)

function setDetainedVehicle(vehicleId)
    vRP.execute('garage/setDetained',{ id = vehicleId, detained = 1 })
end
exports('setDetainedVehicle', setDetainedVehicle)
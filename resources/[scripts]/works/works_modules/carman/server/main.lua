sTRU = {}
Tunnel.bindInterface(GetCurrentResourceName()..':carman', sTRU)

local truckData = { users = {}, worked = {} }

--======================================================================================

local maxJob = function(user_id)
    local max = Carman.jobs.default
    local userGroups = vRP.PlayerGroups(user_id)
    if (userGroups) then
        for perm, value in pairs(Carman.jobs) do
            if (userGroups:hasPerm(perm)) and (value > max) then
                max = value
            end
        end
    end
    return max
end

local verifySlots = function()
    local coords, slotsChecked = vector3(0,0,0), 1;

    while (true) do
        freeSlot, coords = true, Carman.spawns_load[slotsChecked]
        for _, vehicle in pairs(GetAllVehicles()) do
            local dist = #(GetEntityCoords(vehicle) - coords.xyz)
            if (dist <= 3.0) then
                freeSlot = false
            end
        end

        if (not freeSlot) then
            slotsChecked = slotsChecked + 1
            if (slotsChecked > #Carman.spawns_load) then break; end;
        else
            break;
        end
        Citizen.Wait(100)
    end

    return freeSlot, coords
end

local countWork = function(user_id)
    if (not truckData.worked[user_id]) then truckData.worked[user_id] = 0; end;
    truckData.worked[user_id] = (truckData.worked[user_id] + 1)
end

--======================================================================================

sTRU.verifyUser = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (truckData.worked[user_id]) and (truckData.worked[user_id] >= maxJob(user_id)) then
            TriggerClientEvent('notify', source, 'negado', 'Caminhoneiro', 'Você já ultrapassou o limite de <b>entregas</b> permitido!')
            return false
        end
    end
    return true
end

sTRU.spawnLoad = function(model)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local checked, slotCoords = verifySlots()
        if (checked) then       
            local vehHandle = exports.garage:CreateServerVehicle(model, slotCoords.xyz, slotCoords.w)   
            if (DoesEntityExist(vehHandle)) then
                local netId = NetworkGetNetworkIdFromEntity(vehHandle)
                truckData.users[user_id] = netId
                return true, netId
            end
        end
    end
    return false
end

sTRU.receivePayment = function(truckLoad)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and truckData.users[user_id] then
        local userInventory = vRP.PlayerInventory(user_id)
        if (userInventory) then
            countWork(user_id)

            for _, v in pairs(Carman.payment[truckLoad]) do
                local amount = math.random(v.min,v.max)
                if (userInventory:itemMaxAmount(v.item, amount) and userInventory:haveSpace(v.item, amount)) then
                    userInventory:generateItem(v.item, amount, nil, nil, true)
                end
            end

            truckData.users[user_id] = nil
        end
    end
end

--======================================================================================

local deleteLoad = function(user_id)
    if (truckData.users[user_id]) then
        local vehHandle = NetworkGetEntityFromNetworkId(truckData.users[user_id])
        if (DoesEntityExist(vehHandle)) then
            exports.garage:safeDelete(truckData.users[user_id])
            return true
        end
    end
    return false
end

sTRU.deleteLoad = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then return deleteLoad(user_id); end;
end

AddEventHandler('vRP:playerLeave', deleteLoad)
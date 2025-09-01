sIMP = {}
Tunnel.bindInterface(GetCurrentResourceName()..':impound', sIMP)

local usersImpounds = {}

local exitService = function(user_id)
    local netId = usersImpounds[user_id]
    if netId then
        local vehHandle = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(vehHandle) then
            DeleteEntity(vehHandle)
            usersImpounds[user_id] = nil
        end
    end
end

local spawneds = {}
local verifySlots = function(routes)
    local slotsChecked, timeout = 1, false;
    
    Citizen.SetTimeout(60000, function() timeout = true; end)

    local coords;
    while (not timeout) do  
        freeSlot, coords = true, routes[slotsChecked]
        for _, vehicle in pairs(GetAllVehicles()) do
            local dist = #(GetEntityCoords(vehicle) - coords.xyz)
            if (dist <= 3.0) then
                freeSlot = false
            end
        end

        if (not freeSlot) or (spawneds[slotsChecked]) then
            slotsChecked = slotsChecked + 1
            if (slotsChecked > #routes) then slotsChecked = 1; end;
        else
            spawneds[slotsChecked] = true;
            Citizen.SetTimeout(300000, function() spawneds[slotsChecked] = nil; end)
            break;
        end
        Citizen.Wait(500)
    end

    return timeout, coords
end


sIMP.createVehicle = function(vehicle, routes)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local checked, coords = verifySlots(routes)
        if (not checked) then                            
            local vehHandle = exports.garage:CreateServerVehicle(vehicle, coords.xyz, coords.w)   
            if (DoesEntityExist(vehHandle)) then
                local stateBag = Entity(vehHandle).state
                stateBag.id = -1
                stateBag.impound = true

                usersImpounds[user_id] = NetworkGetNetworkIdFromEntity(vehHandle)
                return true, coords
            end
        end
    end
    return false
end

sIMP.removeVehicle = function(netId)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local vehHandle = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(vehHandle) then
            local stateBag = Entity(vehHandle).state
            local isImpound = stateBag['impound']
            
            if (stateBag['user_id'] or isImpound) then
                exports.garage:safeDelete(netId)
                for k,v in pairs(usersImpounds) do
                    if (v == netId) then usersImpounds[k] = nil; break; end;
                end
            end

            if isImpound then
                local item = nil
                local find = false
                while (not find) do
                    local value = Impound.items[ math.random(#Impound.items) ]
                    local random = (math.random() * 100)
                    if (random <= value.prob) then
                        item = { spawn = value.item, amount = math.random(value.min, value.max) }
                        find = true
                    end
                    Citizen.Wait(5)
                end
        
                local userInv = vRP.PlayerInventory(user_id)
                if (item and userInv) then
                    if (userInv:itemMaxAmount(item.spawn, item.amount)) then
                        if (userInv:haveSpace(item.spawn, item.amount)) then
                            userInv:generateItem(item.spawn, item.amount, nil, nil, true)
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Impound', 'Sem espaço na <b>mochila</b>!')
                        end
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Impound', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(item.spawn)..'</b> na mochila!')
                    end
                end
            end

            return isImpound
        end
    end
end

sIMP.exitService = function()
    local user_id = vRP.getUserId(source)
    if user_id then
        exitService(user_id)
    end
end

AddEventHandler('vRP:playerLeave', exitService)
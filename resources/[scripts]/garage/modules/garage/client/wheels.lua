local wheelIndexes = {
    [0] = 'wheel_lf',
    [1] = 'wheel_rf',
    [2] = 'wheel_lm',
    [3] = 'wheel_rm',
    [4] = 'wheel_lr',
    [5] = 'wheel_rr',
}

local flatWeapons = {
    [GetHashKey('WEAPON_SWITCHBLADE')] = true
}

local removeWheelTools = {
    [GetHashKey('WEAPON_WRENCH')] = true
}

local blockVehicles = {
    [GetHashKey('bison3')] = { flat = false, remove = true },
    [GetHashKey('boxville4')] = { flat = false, remove = true },
    [GetHashKey('boxville2')] = { flat = false, remove = true },
    [GetHashKey('boxville')] = { flat = false, remove = true },
    [GetHashKey('bison2')] = { flat = false, remove = true },
    [GetHashKey('utillitruck')] = { flat = false, remove = true },
    [GetHashKey('caddy2')] = { flat = false, remove = true },
    -- [GetHashKey('basepm')] = { flat = true, remove = true },
    -- [GetHashKey('duster21dpm1')] = { flat = true, remove = true },
    -- [GetHashKey('duster21rp')] = { flat = true, remove = true },
    -- [GetHashKey('spincgp')] = { flat = true, remove = true },
    -- [GetHashKey('spinpm2')] = { flat = true, remove = true },
    -- [GetHashKey('spinrp1')] = { flat = true, remove = true },
    -- [GetHashKey('trail20cfp1')] = { flat = true, remove = true },
    -- [GetHashKey('trail21cfp')] = { flat = true, remove = true },
    -- [GetHashKey('xre19rpm')] = { flat = true, remove = true },
    -- [GetHashKey('sw4pm')] = { flat = true, remove = true },
    -- [GetHashKey('trail20ftcoral')] = { flat = true, remove = true },
    -- [GetHashKey('trail21federalg2')] = { flat = true, remove = true },
    -- [GetHashKey('basecus')] = { flat = true, remove = true },
}

function checkVehicle(entity,action)
    local model = GetEntityModel(entity)
    if action and blockVehicles[model] and blockVehicles[model][action] then
        return false
    end
    return Entity(entity).state['id'] and (Entity(entity).state['id'] > 0) and GetVehicleTyresCanBurst(entity)
end

Citizen.CreateThread(function()
    exports["target"]:RemoveTargetBone(wheelIndexes,{ "Trocar Pneu", "Remover Pneu", "Furar Pneu" })
    for i, m in pairs(wheelIndexes) do
        exports["target"]:AddTargetBone(m,{
            options = { 
                { 
                    icon = "fas fa-circle-dot",
                    label = "Trocar Pneu",
                    canInteract = function(entity)
                        return (GetTyreHealth(entity,i) ~= 1000.0) and removeWheelTools[GetSelectedPedWeapon(PlayerPedId())]
                    end,
                    action = function(entity)
                        TriggerServerEvent('garage:vehicleTyre','fix',VehToNet(entity),i)
                    end,
                    distance = 1.2
                },
                {
                    icon = "far fa-circle-dot",
                    label = "Remover Pneu",
                    canInteract = function(entity)
                        return checkVehicle(entity,'remove') and (GetTyreHealth(entity,i) == 1000.0) and removeWheelTools[GetSelectedPedWeapon(PlayerPedId())] and (GetVehicleClass(entity) ~= 13) and (not garageOpened)
                    end,
                    action = function(entity)
                        TriggerServerEvent('garage:vehicleTyre','remove',VehToNet(entity),i)
                    end,
                    distance = 1.2
                },
                {
                    icon = "fas fa-scissors",
                    label = "Furar Pneu",
                    canInteract = function(entity)
                        return checkVehicle(entity,'flat') and (GetTyreHealth(entity,i) == 1000.0) and flatWeapons[GetSelectedPedWeapon(PlayerPedId())]
                    end,
                    action = function(entity)
                        TriggerServerEvent('garage:vehicleTyre','flat',VehToNet(entity),i)
                    end,
                    distance = 1.2
                }

            
            }
        })
    end
end)

function cGARAGE.burstWheel(netId,wheelId)
    if (NetworkDoesEntityExistWithNetworkId(netId)) then
        local vehicle = NetToVeh(netId)
        if (vehicle) and DoesEntityExist(vehicle) then
            return (GetTyreHealth(vehicle,wheelId) ~= 1000.0)            
        end
    end
end

RegisterNetEvent('garage:syncWheel',function(netId,wheelId,destroy)
    if (NetworkDoesEntityExistWithNetworkId(netId)) then
        local vehicle = NetToVeh(netId)
        if (vehicle) and DoesEntityExist(vehicle) then
            if destroy then
                SetVehicleTyreBurst(vehicle, wheelId, true, 1000.0)
            else
                for i=0, 5 do
                    if (wheelId ~= i) and (GetTyreHealth(vehicle, i) ~= 1000.0) then
                        SetVehicleTyreBurst(vehicle, i, true, 1000.0)
                    end
                end
                SetVehicleTyreFixed(vehicle, wheelId)
            end
            checkDeformations(vehicle)
        end
    end
end)
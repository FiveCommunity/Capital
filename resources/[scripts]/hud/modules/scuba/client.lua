LocalPlayer.state:set('Scuba', false, true)

local removeScuba = function(ped)
    ClearPedScubaGearVariation(ped)
    SetPedComponentVariation(ped, 8, -1, 0, 0)

    SetEnableScuba(ped, false)
    SetPedMaxTimeUnderwater(ped, 10.00)
end

local usages;
RegisterNetEvent('scuba:start', function(slot)
    local ped = PlayerPedId()
    local waitTime = 5000

    if (IsPedSwimming(ped)) then return TriggerEvent('notify', 'negado', 'Tanque de Oxigênio', "Você não pode usar o <b>Tanque de Oxigênio</b> dentro d'água."); end;

    if (not LocalPlayer.state.Scuba) then        
        LocalPlayer.state.BlockTasks = true

        vRP.playAnim(true, {{ 'clothingshirt', 'try_shirt_positive_d' }}, false)
        TriggerEvent('ProgressBar', waitTime)
        Citizen.SetTimeout(waitTime, function()
            LocalPlayer.state.BlockTasks = false
        
            ClearPedTasks(ped)
            
            usages = vSERVER.getOxygen(slot)
            if (not usages) then return; end;

            local scubaCloathes = {
                [GetHashKey('mp_m_freemode_01')] = 124,
                [GetHashKey('mp_f_freemode_01')] = 154
            }

            local model = scubaCloathes[GetEntityModel(ped)]
            if (model) then
                SetPedScubaGearVariation(ped)
                SetPedComponentVariation(ped, 8, model, 0, 0)
            end

            SetEnableScuba(ped, true)
		    SetPedMaxTimeUnderwater(ped, 9999.0)
        end)
    else
        LocalPlayer.state.BlockTasks = true

        vRP.playAnim(true, {{ 'clothingshirt', 'try_shirt_positive_d' }}, false)
        TriggerEvent('ProgressBar', waitTime)
        Citizen.SetTimeout(waitTime, function()
            LocalPlayer.state.BlockTasks = false
            
            ClearPedTasks(ped)
            removeScuba(ped)

            vSERVER.resetOxygen()
        end)
    end
end)

AddStateBagChangeHandler('Scuba', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) or (not value) then return; end;

    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        while (LocalPlayer.state.Scuba) do
            ped = PlayerPedId()
            local health = GetEntityHealth(ped)
            
            if (health <= 100) then 
                removeScuba(ped)

                LocalPlayer.state:set('Scuba',false,true)
            end

            if (Current.Oxygen ~= usages) then
                Current.Oxygen = usages
                UpdateStats('oxygen', Current.Oxygen)
            end

            if (Current.Oxygen <= 0) then SetEntityHealth(ped, (health - 50)); end;

            if (IsPedSwimmingUnderWater(ped)) then
                usages -= 1
                TriggerServerEvent('scuba:useSlot')
            end
            Citizen.Wait(600)
        end
    end)
end)
RegisterNetEvent('inventory:bottleWater', function()
    local source = source
    local user_id = vRP.getUserId(source)

    local UserInventory = vRP.PlayerInventory(user_id)
    if (UserInventory) then
        if (UserInventory:tryGetItem('garrafavazia', 1, nil, true)) then
            local progress = 5000
            
            Player(source).state.freezeEntity = true
            Player(source).state.BlockTasks = true
            Player(source).state.usingItem = true 

            TriggerClientEvent('gb_animations:setAnim', source, 'mexer')
            TriggerClientEvent('ProgressBar', source, progress)
            
            Citizen.SetTimeout(progress, function()
                Player(source).state.freezeEntity = false
                Player(source).state.BlockTasks = false
                Player(source).state.usingItem = false 

                ClearPedTasks(GetPlayerPed(source))
                UserInventory:generateItem('agua', 1, nil, nil, true)
            end)
        end
    end
end)

function sRP.checkCamera()
    return vRP.hasPermission( vRP.getUserId(source), "jornal.permissao")
end
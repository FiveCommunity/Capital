local srv = {}
Tunnel.bindInterface('Washing', srv)

srv.startWashing = function(index)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local prompt = exports.hud:prompt(source, { 'Quanto de dinheiro sujo que você gostaria de lavar?' })[1]
        if (prompt) then
            local value = parseInt(prompt)
            if (value > 0) then
                local amount = vRP.getInventoryItemAmount(user_id, 'dinheirosujo')
                if (amount >= value) then
                    local ped = GetPlayerPed(source)
                    local time = 8000

                    Player(source).state.BlockTasks = true
                    Player(source).state.freezeEntity = true
                    SetEntityHeading(ped, Washing.locations[index].coord.w)
                    TriggerClientEvent('gb_animations:setAnim', source, 'mexer')
                    TriggerClientEvent('ProgressBar', source, time)
                    Citizen.SetTimeout(time, function()
                        if (vRP.tryGetInventoryItem(user_id, 'dinheirosujo', value)) then
                            
                            local percent = Washing.locations[index].percentage
                            if (not vRP.hasPermission(user_id, "ilegal.permissao")) then percent = percent-0.10; end;      
                            local quantity = (value * percent)

                            Player(source).state.BlockTasks = false
                            Player(source).state.freezeEntity = false
                            ClearPedTasks(ped)
                            
                            vRP.giveInventoryItem(user_id, 'reais', quantity)
                            TriggerClientEvent('notify', source, 'sucesso', 'Lavagem', 'Você recebeu <b>R$'..quantity..'</b> de dinheiro limpo.')
                        end
                    end)
                else
                    TriggerClientEvent('notify', source, 'negado', 'Lavagem', 'Você não possui <b>R$'..value..'</b> de dinheiro sujo.')
                end
            end
        end
    end
end
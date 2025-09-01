RegisterNetEvent('trunkRob:callPolice',function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local pedCoords = GetEntityCoords(GetPlayerPed(source))
        
        exports.vrp:reportUser(user_id, {
            notify = { 
                type = 'default', 
                title = 'Roubo Porta-malas', 
                message = 'Denúncia de populares, arrombamento de um veículo na região.',
                coords = pedCoords,
                time = 8000
            },
            blip = {
                id = user_id, 
                text = 'Roubo Porta-malas', 
                coords = pedCoords, 
                timeout = 30000 
            }
        })
    end
end)

RegisterNetEvent('trunkRob:robbery',function(netId)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and NetworkGetEntityFromNetworkId(netId) then
        local vehicle = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(vehicle) then
            local ped = GetPlayerPed(source)
            if TrunkRobbery.PlayerWeapons[GetSelectedPedWeapon(ped)] then
                
                if HomesRobbery.MinPolice then
                    local police = vRP.getUsersByPermission('policia.permissao')
                    if (#police < HomesRobbery.MinPolice) then
                        TriggerClientEvent('Notify', source, 'negado', 'Roubos', 'Contigente <b>insuficiente</b>.',8000)
                        return false
                    end
                end


                local stateBag = Entity(vehicle).state
                if (not stateBag['id']) and (not stateBag['trunk_robbery']) then
                    stateBag:set('trunk_robbery',true,true)

                    local receive = {}
                    for i = 1, TrunkRobbery.MaxItens do
                        local find = false
                        while (not find) do
                            local value = TrunkRobbery.Itens[math.random(#TrunkRobbery.Itens)]
                            local random = (math.random() * 100)
                            if (random <= value.prob) and (not receive[value.item]) then
                                receive[value.item] = math.random(value.min, value.max)
                                find = true
                            end
                            Citizen.Wait(5)
                        end
                    end

                    local Inventory = vRP.PlayerInventory(user_id)
                    if Inventory then
                        for item, amount in pairs(receive) do
                            if Inventory:itemMaxAmount(item,amount) then
                                if Inventory:haveSpace(item,amount) then
                                    Inventory:generateItem(item,amount,nil,{ prefix = 'CB' },true)
                                else
                                    TriggerClientEvent('Notify', source, 'negado', 'Roubos', 'Você não teve espaço para <b>'..amount..'x '..vRP.itemNameList(item)..'</b>!')
                                end
                            else
                                TriggerClientEvent('notify', source, 'negado', 'Roubos', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(item)..'</b> na mochila!')
                            end
                        end
                    end
                    
                    exports.hud:insertWanted(user_id, 180, 1200)

                    vRP.webhook('trunkRob', {
                        title = 'roubo porta-malas',
                        descriptions = {
                            { 'user', user_id },
                            { 'items', '\n'..json.encode(receive,{ indent = true }) },
                            { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                        }
                    }) 

                    local count = countTable(receive)
                    TriggerClientEvent('Notify', source, 'sucesso', 'Roubos', 'Você encontrou <b>'..count..' '..(count and 'itens' or 'item')..'</b>!')                
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Roubos', 'Você não possui uma <b>ferramenta</b> para abrir o porta-mala!')
            end
        end
    end
end)
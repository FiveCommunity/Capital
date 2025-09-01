RegisterNetEvent('system:ilegal:recycleWeapons', function()
    local source = source
    local user_id = vRP.getUserId(source)

    if (user_id) then
        local plyInv = vRP.PlayerInventory(user_id)
        if (plyInv) then
            local recycle = {}

            local items = plyInv:getItems()
            if (items) then
                for slot, v in pairs(items) do
                    local weapon = Misc.recycleWeapons[v.item]
                    if (weapon) and (v.time or v.usages) then
                        local porcentage = vRP.calcDurability(v)
                        if (porcentage >= 100) then
                            recycle[#recycle+1] = { item = v.item, slot = slot, data = weapon }
                        end
                    end
                end
            end

            if (#recycle > 0) then
                local allow = true;

                for _, v in pairs(recycle) do
                    -- > Check Space
                    for _, data in pairs(v.data) do
                        if (not plyInv:haveSpace(data.item, data.quantity)) then
                            allow = false
                            TriggerClientEvent('notify', source, 'negado', 'Mochila', 'Espaço insuficiente!')
                            break;
                        end
                    end

                    -- > Give Items
                    if (plyInv:tryGetItem(v.item, 1, v.slot, true)) then
                        for _, data in pairs(v.data) do
                            plyInv:generateItem(data.item, data.quantity, nil, { prefix = 'CB' }, true)
                        end
                    end
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Reciclagem de Armas', 'Você não possui nenhuma arma para reciclar.')
            end
        end
    end
end)


RegisterNetEvent('prison:buyKey', function()
    local price = 1500000
    local _source = source
    local userId = vRP.getUserId(_source)
    print('--', userId)

    local request = exports.hud:request(_source, 'Compra de chave', 'Você deseja realmente comprar a chave da prisão por <b>R$1.500.000</b>?', 30000)

    if not request then
        TriggerClientEvent('notify', _source, 'negado', 'Compra cancelada', 'Você não quis comprar a chave da prisão!')
        return
    end


    if vRP.tryFullPayment(userId, price) then
        local playerInventory = vRP.PlayerInventory(userId)
        playerInventory:giveItem('chave-prisao', 1, nil, nil, true)

        TriggerClientEvent('notify', _source, 'sucesso', 'Adquiriu chave da prisão!', 'Você recebeu a chave da prisão, procure a porta para fugir!')
    else
        TriggerClientEvent('notify', _source, 'negado', 'Compra cancelada', 'Você não possui <b>R$1.500.000</b> na conta!')
    end
    
end)
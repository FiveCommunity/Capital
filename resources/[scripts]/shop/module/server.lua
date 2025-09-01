local shopProtection = {}

for index, tables in pairs(configShops) do
    for _, items in pairs(tables) do
        if (not shopProtection[index]) then shopProtection[index] = {}; end;
        
        shopProtection[index][items.index] = { buy = items.price.buy, sell = items.price.sell }
    end
end

srv.getUserWallet = function()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.getAllMoney(user_id)
end

srv.getUserCoins = function()
    local source = source
    local user_id = vRP.getUserId(source)
    return getUserCoins(user_id)
end

srv.checkPermission = function(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.checkPermissions(user_id, perm)
end

local transaction = {
    legal = function(source, user_id, table, Inventory, shopOpenned)
        local price = (table.type == 'buy' and (shopProtection[shopOpenned][table.item].buy * table.amount) or (shopProtection[shopOpenned][table.item].sell * table.amount))
        if (table.type == 'buy') then
            if (Inventory:itemMaxAmount(table.item, table.amount)) then
                if (Inventory:haveSpace(table.item, table.amount)) then
                    if (vRP.tryFullPayment(user_id, price)) then
                        exports['phone-bank']:createStatement(user_id, { title = 'Conveniência', content = 'Comprou '..vRP.itemNameList(table.item), value = price, type = 'spent' })
                        
                        if (config.extra[table.item]) then
                            config.extra[table.item](source, user_id, table.amount, Inventory)
                        else
                            Inventory:generateItem(table.item, table.amount, nil, { prefix = 'EB' }, true)
                        end         
                        
                        TriggerClientEvent('notify', source, 'sucesso', 'Loja', 'O <b>pagamento</b> foi efetuado com sucesso! <br><br><b>Produto</b>: '..vRP.itemNameList(table.item)..'<br><b>Quantidade</b>: '..table.amount..'<br><b>Preço</b>: R$'..vRP.format(price))
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Loja', 'Dinheiro insuficiente!')
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Loja', 'Você não possui <b>espaço</b> o suficiente em sua mochila.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Loja', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(table.item)..'</b> na mochila!')
            end
        else
            if (Inventory:tryGetItem(table.item, table.amount, nil, false)) then
                vRP.giveMoney(user_id, price)
                TriggerClientEvent('notify', source, 'sucesso', 'Loja', 'A <b>venda</b> foi efetuada com sucesso! <br><br><b>Produto</b>: '..vRP.itemNameList(table.item)..'<br><b>Quantidade</b>: '..table.amount..'<br><b>Preço</b>: R$'..vRP.format(price))
            else
                TriggerClientEvent('notify', source, 'negado', 'Loja', 'Quantidade de itens insuficiente!')
            end
        end
    end,
    
    ilegal = function(source, user_id, table, Inventory, shopOpenned)
        local price = (table.type == 'buy' and (shopProtection[shopOpenned][table.item].buy * table.amount) or (shopProtection[shopOpenned][table.item].sell * table.amount))
        if (table.type == 'buy') then
            if (Inventory:itemMaxAmount(table.item, table.amount)) then
                if (Inventory:haveSpace(table.item, table.amount)) then
                    if (vRP.tryGetInventoryItem(user_id, 'dinheirosujo', price)) then
                        Inventory:generateItem(table.item, table.amount, nil, { prefix = 'CB' }, true)
                        TriggerClientEvent('notify', source, 'sucesso', 'Loja', 'O <b>pagamento</b> foi efetuado com sucesso! <br><br><b>Produto</b>: '..vRP.itemNameList(table.item)..'<br><b>Quantidade</b>: '..table.amount..'<br><b>Preço</b>: R$'..vRP.format(price)..' (sujo)')
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Loja', 'Dinheiro sujo insuficiente!')
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Loja', 'Você não possui <b>espaço</b> o suficiente em sua mochila.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Loja', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(table.item)..'</b> na mochila!')
            end
        else
            if (Inventory:tryGetItem(table.item, table.amount, nil, false)) then
                Inventory:generateItem('dinheirosujo', price, nil, {}, false)
                TriggerClientEvent('notify', source, 'sucesso', 'Loja', 'A <b>venda</b> foi efetuada com sucesso! <br><br><b>Produto</b>: '..vRP.itemNameList(table.item)..'<br><b>Quantidade</b>: '..table.amount..'<br><b>Preço</b>: R$'..vRP.format(price)..' (sujo)')
            else
                TriggerClientEvent('notify', source, 'negado', 'Loja', 'Quantidade de itens insuficiente!')
            end
        end
    end,
    
    coins = function(source, user_id, table, Inventory, shopOpenned)
        local price = (table.type == 'buy' and (shopProtection[shopOpenned][table.item].buy * table.amount) or (shopProtection[shopOpenned][table.item].sell * table.amount))
        if (table.type == 'buy') then
            if (Inventory:itemMaxAmount(table.item, table.amount)) then
                if (Inventory:haveSpace(table.item, table.amount)) then
                    if (consumeCoins(user_id, price)) then
                        Inventory:generateItem(table.item, table.amount, nil, { prefix = 'EB' }, true)
                        if (shopOpenned == 'vip') then
                            vRP.webhook('buyvip', {
                                title = 'compra vip',
                                descriptions = {
                                    { 'user', user_id },
                                    { 'price', vRP.format(price) },
                                    { 'item', (vRP.itemNameList(table.item) or table.item) },
                                    { 'amount', vRP.format(table.amount) },
                                }
                            })
                        end
                        TriggerClientEvent('notify', source, 'sucesso', 'Loja', 'O <b>pagamento</b> foi efetuado com sucesso! <br><br><b>Produto</b>: '..vRP.itemNameList(table.item)..'<br><b>Quantidade</b>: '..table.amount..'<br><b>Preço</b>: '..vRP.format(price)..' (coins)')
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Loja', 'Coins insuficiente!')
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Loja', 'Você não possui <b>espaço</b> o suficiente em sua mochila.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Loja', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(table.item)..'</b> na mochila!')
            end
        end
    end
}

srv.checkoutItem = function(table, shopOpenned)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (shopProtection[shopOpenned][table.item]) then
            local Inventory = vRP.PlayerInventory(user_id)
            if (transaction[table.method]) then
                transaction[table.method](source, user_id, table, Inventory, shopOpenned)
            end
        else
            print('^1[SHOP DEBUG]:^7 o jogador '..user_id..' tentou spawnar item na lojinha. ITEM: '..table.item)
        end
    end
end

--------------------------------------------------------
-- Export's
--------------------------------------------------------
getUserCoins = function(user_id)
    local coins = exports.oxmysql:scalar_async('SELECT coins FROM user_moneys WHERE user_id = @user_id',{ user_id = user_id })
    return (coins or 0)
end
exports('getUserCoins', getUserCoins)

giveUserCoins = function(user_id, value)
    if user_id and (value > 0) then
        local affected = exports.oxmysql:update_async('UPDATE user_moneys SET coins = coins + @coins WHERE user_id = @user_id',{ user_id = user_id, coins = value })
        return (affected > 0)
    end
end
exports('giveUserCoins', giveUserCoins)

removeUserCoins = function(user_id, value)
    if user_id and (value > 0) then
        local affected = exports.oxmysql:update_async('UPDATE user_moneys SET coins = coins - @coins WHERE user_id = @user_id',{ user_id = user_id, coins = value })
        return (affected > 0)
    end
end
exports('removeUserCoins', removeUserCoins)

local lock = {}
consumeCoins = function(user_id, value)
    if user_id and (value > 0) then
        if (not lock[user_id]) then
            lock[user_id] = true
            
            local coins = getUserCoins(user_id)
            if (coins >= value) then  
                if removeUserCoins(user_id,value) then
                    lock[user_id] = nil
                    return true
                end
            end

            lock[user_id] = nil
        end
    end
    return false
end
exports('consumeCoins', consumeCoins)
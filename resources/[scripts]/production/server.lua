srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv);

srv.hasPermission = function(perm)
    local source = source
    return vRP.checkPermissions(vRP.getUserId(source), perm)
end

local canceling = {}

srv.craftItem = function(org,index,prodAmount)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local orgConfig = configs.productions[org]
        if orgConfig and vRP.checkPermissions(user_id, orgConfig.permission) then
            
            local product = orgConfig.products[index]
            if product then

                local UserInventory = vRP.PlayerInventory(user_id)
                if UserInventory then

                    local idname = splitString(index,'|')[1]
                    local haveItems = true
                    local getItems = {}

                    for k,v in pairs(product.materials) do
                        if UserInventory:tryGetItem(k, math.ceil(v.amount*prodAmount), nil, true) then
                            getItems[#getItems+1] = { item = k, amount = math.ceil(v.amount*prodAmount) }
                        else
                            for k,v in ipairs(getItems) do
                                UserInventory:generateItem(v.item,v.amount)
                            end
                            haveItems = false
                            break
                        end
                    end

                    if haveItems then
                        TriggerClientEvent('Notify',source,'sucesso','Produção','Iniciando a produção...')
                        if UserInventory then
                            Citizen.SetTimeout(product.delay,function()
                                if (not canceling[user_id]) then
                                    TriggerClientEvent('notify', source, 'sucesso', 'Produção', 'Produção sendo entregue...')
                                    
                                    local multiply = 1;
                                    if (product.multiply) then multiply = product.multiply; end;
                                    
                                    local giveAmount = math.floor(prodAmount*multiply)
                                    UserInventory:generateItem(idname,giveAmount,nil,{ prefix = 'CB' },true)

                                    if (product.refund) then
                                        for k,v in pairs(product.refund) do
                                            UserInventory:generateItem(k,math.ceil(v.amount*prodAmount),nil,{ prefix = 'CB' },true)
                                        end
                                    end

                                    vRP.webhook(orgConfig.webhook, {
                                        title = 'production',
                                        descriptions = {
                                            { 'fac', org },
                                            { 'craft', index },
                                            { 'item', idname },
                                            { 'amount', giveAmount }, 
                                        }
                                    })    
                                    canceling[user_id] = nil
                                else
                                    for k,v in ipairs(getItems) do
                                        UserInventory:generateItem(v.item,v.amount)
                                    end
                                    canceling[user_id] = nil
                                end
                            end)
                        end
                        return product.delay, product.anim
                    else
                        TriggerClientEvent('Notify',source,'negado','Produção','Matéria-Prima insuficiente! Verifique a quantidade ou tente agrupar os produtos!')
                    end

                end        
            else
                TriggerClientEvent('Notify',source,'negado','Produção','Produto não encontrado na lista de Receitas!')
            end
        end
    end
end
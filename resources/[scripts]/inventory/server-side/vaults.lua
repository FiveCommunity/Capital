if config.modules["vault-system"] then
    --=======================================================================================================================================
    -- Chest Funtions
    --=======================================================================================================================================
    vaultOpen = {}
    vaultTasks = {}
    --=========================================

    function openVault(user_id,key,display,maxWeights,webhooks,restrict,onclose)
        if user_id and key and maxWeights then
            local source = vRP.getUserSource(user_id)
            if source then

                local restrictData = (restrict or config.staticVaults.notStore)
                local restrictParse = { mode = restrictData.mode, items = {} }
                for _, v in ipairs(restrictData.items) do restrictParse.items[v] = true; end;
                
                vaultOpen[user_id] = { 
                    key = key,
                    weight = maxWeights.weight,
                    slots = maxWeights.slots,
                    display = (display or key),
                    webhooks = (webhooks or { put = config.webhooks.vaultPut, remove = config.webhooks.vaultRemove }),
                    restrict = restrictParse,
                    onclose = onclose,
                }
                cRP.loadVault(source)
            end
        end
    end
    exports("openVault",openVault)

    --=========================================
    vRP.prepare('inventory:getVault', 'select items from inventory where identifier = @identifier')
    vRP.prepare('inventory:deleteVault', 'delete from inventory where identifier = @identifier')
    
    function sRP.getBag(identifier)
        local query = vRP.query('inventory:getVault', { identifier = identifier })[1]
        if (query) and (query.items) then
            return json.decode(query.items)
        end
        return {}
    end
    exports('getBag', sRP.getBag)

    function sRP.getVaultItems()
        local source = source
        local user_id = vRP.getUserId(source) 
        if user_id then
            local vaultInfo = vaultOpen[user_id]
            if vaultInfo then    
                local VaultInventory = vRP.Inventory(vaultInfo.key,vaultInfo)
                local vault = {}
                for slot,data in pairs( VaultInventory:getItems() ) do
                    vault[slot] = {
                        item = data.item,
                        name = sINV.itemName(data.item),
                        index = sINV.itemIndex(data.item),
                        amount = data.amount,
                        weight = sINV.itemWeight(data.item)*data.amount,
                        durability = vRP.calcDurability(data),
                        desc = sINV.makeDesc(data),
                    }
                end
                return vault, { current = VaultInventory:getWeight(), max = VaultInventory:getMaxWeight(), slots = VaultInventory:getMaxSlots() }, vaultInfo.display
            end
        end
    end

    function sRP.trySwapVault(slot,target,amount)
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            local vaultInfo = vaultOpen[user_id]
            if vaultInfo and (not vaultTasks[vaultInfo.key]) then
                vaultTasks[vaultInfo.key] = true
                
                local VaultInventory = vRP.Inventory(vaultInfo.key,vaultInfo)
                local items = VaultInventory:getItems()
                local sData = items[tostring(slot)]
                local tData = items[tostring(target)]


                if sData and tData and (sData.item == tData.item) and (sData.groupable and tData.groupable) then  
                    if VaultInventory:tryGetItem(sData.item,amount,slot) then
                        VaultInventory:giveItem(sData.item,amount,target)
                    end
                elseif sData and tData then
                    VaultInventory:swapSlot(slot,target)
                elseif (sData and (not tData)) then
                    if sData.groupable then
                        if VaultInventory:tryGetItem(sData.item,amount,slot) then
                            VaultInventory:giveItem(sData.item,amount,target)
                        end
                    else
                        VaultInventory:swapSlot(slot,target)
                    end
                end

                vaultTasks[vaultInfo.key] = nil
                return true
            end
        end
        return false
    end

    function sRP.tryPutVaultItem(slot,amount,target)
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            local identity = vRP.getUserIdentity(user_id)
            local UserInventory = vRP.PlayerInventory(user_id)

            local vaultInfo = vaultOpen[user_id]
            if vaultInfo and (not vaultTasks[vaultInfo.key])then
                vaultTasks[vaultInfo.key] = true
                local VaultInventory = vRP.Inventory(vaultInfo.key,vaultInfo)
                
                local sData = UserInventory:getSlot(slot)
                if sData then

                    print(slot, amount, target)

                    if vaultInfo.restrict then
                        local listFound = vaultInfo.restrict.items[sData.item]
                        if ((vaultInfo.restrict.mode == 'only') and (not listFound)) then
                            TriggerClientEvent('Notify',source,'importante','Inventário',"Não pode guardar este item.",8000)
                            vaultTasks[vaultInfo.key] = nil
                            return false
                        elseif ((vaultInfo.restrict.mode == 'deny') and (listFound)) then
                            TriggerClientEvent('Notify',source,'importante','Inventário',"Não pode guardar este item.",8000)
                            vaultTasks[vaultInfo.key] = nil
                            return false
                        end
                    end

                    if VaultInventory:haveSpace(sData.item,amount) then
                        local tData = VaultInventory:getSlot(target)

                        if (not tData) or ((tData.item == sData.item) and (tData.groupable and sData.groupable)) then
                            if UserInventory:tryGetItem(sData.item,amount,slot,true) then
                                VaultInventory:giveItem(sData.item,amount,target,sData)

                                if vaultInfo.webhooks and vaultInfo.webhooks.put then
                                    vRP.webhook(vaultInfo.webhooks.put, {
                                        title = 'vault put',
                                        descriptions = {
                                            { 'id', user_id },
                                            { 'vault', tostring(vaultInfo.key) },
                                            { 'item', '['..slot..'] '..vRP.format(amount)..'x '..sINV.itemName(sData.item) },
                                            { 'slot-vault', target },
                                            { 'slot-info', json.encode(sData) }
                                        }
                                    })     
                                end

                                vaultTasks[vaultInfo.key] = nil
                                return true
                            else
                                TriggerClientEvent('Notify',source,'negado','Inventário',"<b>Quantidade </b> insuficiente.",8000)
                            end
                        end
                    else
                        TriggerClientEvent('Notify',source,'negado','Inventário',"<b>Vault</b> cheio.",8000)
                    end
                end

                vaultTasks[vaultInfo.key] = nil
            else
                TriggerClientEvent('Notify',source,'negado','Inventário',"<b>Baú</b> ocupado.",8000)
            end
        end
        return false
    end

    function sRP.tryRemoveVaultItem(slot,amount,target)
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            local identity = vRP.getUserIdentity(user_id)
            local UserInventory = vRP.PlayerInventory(user_id)

            if (amount > 0) then 
                
                local vaultInfo = vaultOpen[user_id]
                if vaultInfo and (not vaultTasks[vaultInfo.key])then
                    vaultTasks[vaultInfo.key] = true

                    local VaultInventory = vRP.Inventory(vaultInfo.key,vaultInfo)
                    
                    local sData = VaultInventory:getSlot(slot)
                    if sData then

                        -- if vaultInfo.restrict then
                        --     local listFound = vaultInfo.restrict.items[sData.item]
                        --     if ((vaultInfo.restrict.mode == 'only') and (not listFound)) then
                        --         TriggerClientEvent('Notify',source,'importante','Inventário',"Não pode remover este item.",8000)
                        --         vaultTasks[vaultInfo.key] = nil
                        --         return false
                        --     elseif ((vaultInfo.restrict.mode == 'deny') and (listFound)) then
                        --         TriggerClientEvent('Notify',source,'importante','Inventário',"Não pode remover este item.",8000)
                        --         vaultTasks[vaultInfo.key] = nil
                        --         return false
                        --     end
                        -- end

                        if UserInventory:itemMaxAmount(sData.item,amount) then
                            if UserInventory:haveSpace(sData.item,amount) then
                                local tData = UserInventory:getSlot(target)
                                if (not tData) or ((tData.item == sData.item) and (tData.groupable and sData.groupable)) then
                                    if VaultInventory:tryGetItem(sData.item,amount,slot) then
                                        UserInventory:giveItem(sData.item,amount,target,sData,true)

                                        if vaultInfo.webhooks and vaultInfo.webhooks.remove then
                                            vRP.webhook(vaultInfo.webhooks.remove, {
                                                title = 'vault remove',
                                                descriptions = {
                                                    { 'id', user_id },
                                                    { 'vault', tostring(vaultInfo.key) },
                                                    { 'item', '['..slot..'] '..vRP.format(amount)..'x '..sINV.itemName(sData.item) },
                                                    { 'slot-vault', target },
                                                    { 'slot-info', json.encode(sData) }
                                                }
                                            })     
                                        end

                                        vaultTasks[vaultInfo.key] = nil
                                        return true
                                    else
                                        TriggerClientEvent('Notify',source,'negado','Inventário',"<b>Quantidade </b> insuficiente.",8000)
                                    end
                                end
                            else
                                TriggerClientEvent('Notify',source,'negado','Inventário',"<b>Vault</b> cheio.",8000)
                            end
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Inventário', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(sData.item)..'</b> na mochila!')
                        end
                    end
                        
                    vaultTasks[vaultInfo.key] = nil
                else
                    TriggerClientEvent('Notify',source,'negado','Inventário',"<b>Baú</b> ocupado.",8000)
                end
            else
                DropPlayer(source,"[HACK] Expected > 0 number in inventory function.")
                vRP.setBanned(user_id,true,'Expected > 0 number in inventory function', 0, 0)

                vRP.webhook(config.webhooks.hackDump, {
                    title = 'hack dump',
                    descriptions = {
                        { 'id', user_id },
                        { 'item', itemName },
                        { 'qtd', amount },
                        { 'baú', trunkInfo.key }
                    }
                })     
            end  
        end
        return false
    end

    --=======================================================================================================================================
    -- Chest Events
    --=======================================================================================================================================
    function vaultOnClose(user_id)
        if user_id and vaultOpen[user_id] then
            vRP.releaseInventory(vaultOpen[user_id].key,true)
            if vaultOpen[user_id].onclose then vaultOpen[user_id].onclose(); end;
            vaultOpen[user_id] = nil
        end
    end
    RegisterNetEvent('inventory:onClose',function() vaultOnClose(vRP.getUserId(source)) end)
    AddEventHandler('vRP:playerLeave',vaultOnClose)
    
    AddEventHandler('onResourceStop', function(resourceName)
        if (GetCurrentResourceName() == resourceName) then
            for k, v in pairs(vaultOpen) do
                print('[INV] Release vault "'..tostring(v.key)..'" from user "'..tostring(k)..'".')
                vaultOnClose(k)
            end
        end
    end)

    AddEventHandler('inventory:event', function(event, args)
        local table = { ['ForcaTatica'] = true, ['Rota'] = true, ['PMC'] = true, ['Civil'] = true, ['PRF'] = true, ['GCC'] = true, ['ExercitoDescarte'] = true, ['PCPDescarte'] = true }

        if (args.identifier) and (table[args.identifier:sub(7)]) then   
            local Inventory = vRP.Inventory(args.identifier)
            if (Inventory) then
                for k, v in pairs(Inventory:getItems()) do
                    Inventory:tryGetItem(v.item, v.amount, k)
                end
            end
        end
    end)
end
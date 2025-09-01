--=======================================================================================================================================
-- Inventory Functions
--=======================================================================================================================================

function sRP.getUserInventory()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        local UserInventory = vRP.PlayerInventory(user_id)
        local inv = {}

        for slot,data in pairs( UserInventory:getItems() ) do

            inv[slot] = {
                slot = slot,
                item = data.item,
                name = sINV.itemName(data.item),
                index = sINV.itemIndex(data.item),
                amount = data.amount,
                weight = sINV.itemWeight(data.item)*data.amount,
                durability = vRP.calcDurability(data),
                desc = sINV.makeDesc(data)
            }
        end

        return inv, { current = UserInventory:getWeight(), max = UserInventory:getMaxWeight(), slots = UserInventory:getMaxSlots() }
    end
end

if config.modules["base-system"] then
    function sRP.getUserHotbar(user_id)
        local shortcuts = {}
        local source = vRP.getUserSource(user_id)
        if (source) then
            local UserInventory = vRP.PlayerInventory(user_id)
            for slot = 1, 5 do
                slot = tostring(slot)
                local slotData = UserInventory:getSlot(slot)            
                local item, amount = (slotData and slotData.item or ''), (slotData and slotData.amount or 0)
                
                shortcuts[slot] = { item = item, amount = amount }
            end
        end
        return shortcuts
    end

    exports('getUserHotbar', sRP.getUserHotbar)

function sRP.tryUseItem(slot, amount, isbind)
    local source = source
    local user_id = vRP.getUserId(source)
    local health = GetEntityHealth(GetPlayerPed(source))

    if health <= 100 then
        TriggerClientEvent('Notify', source, 'negado', 'Mochila', 'Você não pode usar <b>item</b> desmaiado!')
        return false
    end

    if user_id and slot and amount then
        TriggerClientEvent('inventory:close', source)

        local UserInventory = vRP.PlayerInventory(user_id)
        if UserInventory then
            local slotData = UserInventory:getSlot(slot)
            if slotData then
                local itemType = sINV.itemType(slotData.item)
                if itemType ~= 'weapon' and itemType ~= 'ammo' and itemType ~= 'attachs' and slotData.item ~= 'cajado' then
                    if GetSelectedPedWeapon(GetPlayerPed(source)) ~= GetHashKey('WEAPON_UNARMED') then
                        TriggerClientEvent('Notify', source, 'negado', 'Mochila', 'Você não pode usar <b>item</b> com as mãos ocupadas!')
                        return false
                    end
                end

                if Player(source).state.usingItem then
                    TriggerClientEvent('Notify', source, 'negado', 'Mochila', 'Aguarde para usar um <b>item</b> novamente!')
                    return false
                end

                if (Player(source).state.Handcuff or Player(source).state.StraightJacket) and not config.allowlistHandcuffed[slotData.item] then
                    return false
                end

                local used = false
                Player(source).state.usingItem = true

                if config.itemFunctions[slotData.item] then
                    used = config.itemFunctions[slotData.item](source, user_id, amount, slot, UserInventory)
                elseif itemType and config.itemFunctions["type:" .. itemType] then
                    used = config.itemFunctions["type:" .. itemType](source, user_id, slotData.item, amount, slot, UserInventory)
                end

                if used then
                    local identity = vRP.getUserIdentity(user_id)
                    vRP.webhook(config.webhooks.mainUse, {
                        title = 'main use',
                        descriptions = {
                            { 'id', user_id },
                            { 'usou', vRP.format(amount) .. ' ' .. sINV.itemName(slotData.item) }
                        }
                    })
                end

                Player(source).state.usingItem = false
                return used
            end
        end
    end
    return false
end

    function sRP.cancelItem()
        local source = source
        local user_id = vRP.getUserId(source)
        if (user_id) and (_using[user_id]) then
            Player(source).state.usingItem = false

            vRPclient.DeletarObejto(source)		
		    ClearPedTasks(GetPlayerPed(source))

            TriggerClientEvent('ProgressBar', source, 0)

            _using[user_id] = nil
        end
    end
    RegisterNetEvent('inventory:cancelItem', sRP.cancelItem)

    function sRP.trySwapItems(slot,target,amount)
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            local UserInventory = vRP.PlayerInventory(user_id)

            local items = UserInventory:getItems()
            local sData = items[tostring(slot)]
            local tData = items[tostring(target)]

            if sData and tData and (sData.item == tData.item) and (sData.groupable and tData.groupable) then  
                if UserInventory:tryGetItem(sData.item,amount,slot) then
                    UserInventory:giveItem(sData.item,amount,target)
                end
            elseif sData and tData then
                UserInventory:swapSlot(slot,target)
            elseif (sData and (not tData)) then
                if sData.groupable then
                    if UserInventory:tryGetItem(sData.item,amount,slot) then
                        UserInventory:giveItem(sData.item,amount,target)
                    end
                else
                    UserInventory:swapSlot(slot,target)
                end
            end
            return true
        end
    end

    function sRP.trySendItem(slot,amount)
        local source = source
        local user_id = vRP.getUserId(source)
        local nplayer = vRPclient.getNearestPlayer(source,2)    
        if user_id and nplayer then
            
            local UserInventory = vRP.PlayerInventory(user_id)
            local slotData = UserInventory:getSlot(slot)
            if slotData and amount then
               
                for _,i in ipairs(config.notSend) do
                    if (slotData.item == i) or string.find(slotData.item,i) then
                        TriggerClientEvent('Notify',source,'importante','Inventário',"Não pode enviar este item.",8000)
                        return false
                    end
                end

                local nuser_id = vRP.getUserId(nplayer)  
                local itemName = sINV.itemName(slotData.item)
                if nuser_id and itemName then 
                    
                    local OtherInventory = vRP.PlayerInventory(nuser_id)
                    if OtherInventory:itemMaxAmount(slotData.item,amount) then
                        if OtherInventory:haveSpace(slotData.item,amount) then
                            if UserInventory:tryGetItem(slotData.item,amount,slot,true) then
                                
                                OtherInventory:giveItem(slotData.item,amount,nil,slotData,true)
                                vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
                                vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_b"}},false)
                                
                                local amountFormat = vRP.format(amount)
                                TriggerClientEvent('Notify',source,'sucesso','Inventário',"Enviou <b>"..amountFormat.."x "..itemName.."</b>.",8000)
                                TriggerClientEvent('Notify',nplayer,'sucesso','Inventário',"Recebeu <b>"..amountFormat.."x "..itemName.."</b>.",8000)

                                TriggerClientEvent('intentory:refresh',source)
                                TriggerClientEvent('intentory:refresh',nplayer)

                                local identity = vRP.getUserIdentity(user_id)
                                local identitynu = vRP.getUserIdentity(nuser_id)

                                vRP.webhook(config.webhooks.mainSend, {
                                    title = 'main send',
                                    descriptions = {
                                        { 'user', user_id },
                                        { 'enviou', amountFormat..' '..itemName },
                                        { 'para o id', nuser_id },
                                    }
                                })  
                                return true
                            end
                        end
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Inventário', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(slotData.item)..'</b> na mochila!')
                    end
                end
            end
        end
        return false
    end
end

RegisterCommand('item', function(source, args) 
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, '+Staff.Administrador') then
        local item = args[1]
        if item and sINV.itemExists(item) then            

            local amount = (args[2] and parseInt(args[2]) or 1)
            local UserInventory = vRP.PlayerInventory(user_id)
            
            UserInventory:generateItem(item,amount,nil,{ prefix = 'EB' },true)
            
            TriggerClientEvent('Notify',source,'sucesso','Inventário','Voce recebeu <b>'..amount..'x</b> de <b>'..sINV.itemName(item)..'</b>.')
            vRP.webhook(config.webhooks.spawnItem, {
                title = 'spawn item',
                descriptions = {
                    { 'id', user_id },
                    { 'item', item },
                    { 'qtd', amount }
                }
            })     
        end
    end
end)

RegisterCommand('item2', function(source, args) 
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, '+Staff.Administrador') then
        
        local item = args[1]
        local nuser_id = parseInt(args[3])
        local amount = (args[2] and parseInt(args[2]) or 1)

        if (nuser_id > 0) and (item) and sINV.itemExists(item) then            
            
            local UserInventory = vRP.PlayerInventory(nuser_id)
            if UserInventory then
                UserInventory:generateItem(item,amount,nil,{ prefix = 'EB' },true)
            end
            
            TriggerClientEvent('Notify',source,'sucesso','Inventário','Spawnou <b>'..amount..'x</b> de <b>'..sINV.itemName(item)..'</b> para o Passaporte <b>'..nuser_id..'</b>.',10000)
            vRP.webhook(config.webhooks.spawnItem, {
                title = 'spawn item2',
                descriptions = {
                    { 'id', user_id },
                    { 'target', nuser_id },
                    { 'item', item },
                    { 'qtd', amount }
                }
            })
        end
    end
end)

RegisterCommand('setmoc', function(source, args) 
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, '+Staff.Administrador') then
        
        local user = (args[1] and parseInt(args[1]) or user_id)
        local slot = (args[2] and parseInt(args[2]) or 1)
        local peso = (args[3] and parseInt(args[3]) or 1)

        local UserInventory = vRP.PlayerInventory(user)
        if UserInventory then
            UserInventory:setMaxWeight(peso)
			UserInventory:setMaxSlots(slot)
        end
    end
end)

RegisterCommand('clearinv', function(source, args) 
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, '+Staff.Administrador') then
        local user = (args[1] and parseInt(args[1]) or user_id)
       
        local UserInventory = vRP.PlayerInventory(user)
        UserInventory:clear()
    end
end)

RegisterCommand('ritem', function(source, args)
    local _source = source
    local user_id = vRP.getUserId(_source)
    if user_id and vRP.hasPermission(user_id, '+Staff.Administrador') then
        if args[1] and args[2] and args[3] then
            local user = tonumber(args[1])

            if vRP.tryGetInventoryItem(user, args[2], args[3]) then
                TriggerClientEvent('notify', _source, 'sucesso', 'Inventário', 'Item removido com sucesso!')
            else
                TriggerClientEvent('notify', _source, 'negado', 'Inventário', 'Este jogador não possui este item!')
            end
        else
            TriggerClientEvent('notify', _source, 'negado', 'Inventário', 'Comando no formato incorreto: <br /><br /> /ritem id item amount')
        end
    end
end)
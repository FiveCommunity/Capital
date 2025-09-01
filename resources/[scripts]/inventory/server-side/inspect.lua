if config.modules["inspect-system"] then
    --=======================================================================================================================================
    -- Inspect Functions
    --=======================================================================================================================================
    inspectOpen = {}
    inspectQuit = {}
    inspectRequest = {}
    --=========================================
    function sRP.getInspect()
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            local nuser_id = inspectOpen[user_id]
            if nuser_id then
                local OtherInventory = vRP.PlayerInventory(nuser_id)
                local oinv = {}
                for slot,data in pairs( OtherInventory:getItems() ) do
                    oinv[slot] = {
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
                return oinv, { current = OtherInventory:getWeight(), max = OtherInventory:getMaxWeight(), slots = OtherInventory:getMaxSlots() }
            end
        end
    end

    function sRP.tryPutInspectItem(slot,amount,target) 
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            if vRP.checkPermissions(user_id,{'policia.permissao','staff.permissao'}) then
                local nuser_id = inspectOpen[user_id]
                if nuser_id and target and amount then

                    local UserInventory = vRP.PlayerInventory(user_id)
                    local OtherInventory = vRP.PlayerInventory(nuser_id)

                    local sData = UserInventory:getSlot(slot)
                    if sData then
                        if OtherInventory:itemMaxAmount(sData.item,amount) then
                            if OtherInventory:haveSpace(sData.item,amount) then
                                local tData = OtherInventory:getSlot(target)
                                if (not tData) or ((tData.item == sData.item) and (tData.groupable and sData.groupable)) then
                                    
                                    for _,i in ipairs(config.inspect.notMove) do
                                        if (sData.item == i) or string.find(sData.item,i) then
                                            TriggerClientEvent('Notify',source,'importante','Inventário',"Não pode colocar este item.",8000)
                                            return false
                                        end
                                    end
                                    
                                    if UserInventory:tryGetItem(sData.item,amount,slot,true) then
                                        OtherInventory:giveItem(sData.item,amount,target,sData,true)
                                        local identity = vRP.getUserIdentity(user_id)
                                        local nidentity = vRP.getUserIdentity(nuser_id)
                                        
                                        vRP.webhook(config.webhooks.inspectPut, {
                                            title = 'inspect put',
                                            descriptions = {
                                                { 'user', user_id },
                                                { 'colocou em', nuser_id },
                                                { 'item', vRP.format(amount)..' '..sINV.itemName(sData.item) },
                                                { 'S->T', slot..' -> '..target }
                                            }
                                        })      
                                        return true
                                    else
                                        TriggerClientEvent("Notify",source,"negado",'Inventário',"<b>Quantidade</b> insuficiente.",8000)
                                    end
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado",'Inventário',"A <b>mochila</b> está cheia.",5000)
                            end
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Inventário', 'O cidadão atingiu quantidade máxima de <b>'..vRP.itemNameList(sData.item)..'</b> na mochila!')
                        end
                    end
                end
            end
        end  
        return false
    end

    function sRP.tryRemInspectItem(slot,amount,target)
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            if vRP.checkPermissions(user_id,{'policia.permissao','staff.permissao'}) then
                local nuser_id = inspectOpen[user_id]
                if nuser_id and target and amount then
                    
                    local UserInventory = vRP.PlayerInventory(user_id)
                    local OtherInventory = vRP.PlayerInventory(nuser_id)

                    local sData = OtherInventory:getSlot(slot)
                    if sData then
                        if UserInventory:itemMaxAmount(sData.item,amount) then
                            if UserInventory:haveSpace(sData.item,amount) then
                                local tData = UserInventory:getSlot(target)
                                if (not tData) or ((tData.item == sData.item) and (tData.groupable and sData.groupable)) then
                                    
                                    for _,i in ipairs(config.inspect.notMove) do
                                        if (sData.item == i) or string.find(sData.item,i) then
                                            TriggerClientEvent("Notify",source,"importante",'Inventário',"Não pode colocar este item.",8000)
                                            return false
                                        end
                                    end
                                    
                                    if OtherInventory:tryGetItem(sData.item,amount,slot,true) then
                                        UserInventory:giveItem(sData.item,amount,target,sData,true)
                                        local identity = vRP.getUserIdentity(user_id)
                                        local nidentity = vRP.getUserIdentity(nuser_id)
                                        
                                        vRP.webhook(config.webhooks.inspectPut, {
                                            title = 'inspect pickup',
                                            descriptions = {
                                                { 'user', user_id },
                                                { 'removeu de', nuser_id },
                                                { 'item', vRP.format(amount)..' '..sINV.itemName(sData.item) },
                                                { 'S->T', slot..' -> '..target }
                                            }
                                        })     
                                        return true
                                    else
                                        TriggerClientEvent("Notify",source,"negado",'Inventário',"<b>Quantidade</b> insuficiente.",8000)
                                    end
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado",'Inventário',"A <b>mochila</b> está cheia.",5000)
                            end
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Inventário', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(sData.item)..'</b> na mochila!')
                        end
                    end
                end
            end
        end  
        return false
    end

    --RegisterCommand((config.inspect.openCommand or "revistar"),function(source,args,rawCommand)
    RegisterNetEvent("vrp_inventory:revistar",function(nsource)
        local source = source

        if Player(source).state.isPlayingEvent then 
            return 
        end 

        local user_id = vRP.getUserId(source)

        --local nsource = vRPclient.getNearestPlayer(source, 2.0)
        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(nsource))) > 5 then return; end;

        if user_id and nsource then
            if Player(nsource).state.isPlayingEvent then 
                return 
            end 
            
            if (GetEntityHealth(GetPlayerPed(source)) <= 100) then return; end;
            if (GetEntityHealth(GetPlayerPed(nsource)) <= 100) then TriggerClientEvent('Notify', source, 'Revistar', 'Você não pode <b>revistar</b> uma pessoa morta!') return; end;
            if (Player(nsource).state['Revistar']) then TriggerClientEvent('Notify', source, 'Revistar', 'Este <b>cidadão</b> já esta sendo revistado!') return; end;
            if (vRPclient.getNoCarro(nsource) or vRPclient.getNoCarro(source)) then return; end;

            local nuser_id = vRP.getUserId(nsource)
            if nuser_id then
                inspectOpen[user_id] = nuser_id

                Player(source).state.Revistar = true
                Player(nsource).state.Revistar = true
                Player(source).state.BlockTasks = true
                Player(nsource).state.BlockTasks = true

                vRPclient._playAnim(source,true,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
                vRPclient._playAnim(nsource,true,{{"random@arrests@busted","idle_a"}},true)
                TriggerClientEvent('gb:attach', nsource, source, 4103, 0.1, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)
        
                cRP.loadInspect(source)
            end
        end
    end)
    --=======================================================================================================================================
    -- Inspect Events
    --=======================================================================================================================================
    function releaseInspect(user_id)
        if user_id and inspectOpen[user_id] then
            local nsource = vRP.getUserSource(inspectOpen[user_id])
            if nsource then
                TriggerClientEvent('gb:attach', nsource, 0)
                Player(nsource).state.Revistar = false
                Player(nsource).state.BlockTasks = false
            end
            inspectOpen[user_id] = nil
        end
    end
    
    RegisterNetEvent("inventory:onClose",function()
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id and inspectOpen[user_id] then
            releaseInspect(user_id)
            Player(source).state.Revistar = false
            Player(source).state.BlockTasks = false
            vRPclient._stopAnim(source,false)
        end
    end)
    AddEventHandler("vRP:playerLeave",releaseInspect)
end
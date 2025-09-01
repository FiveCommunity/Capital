if config.modules["chest-system"] and config.modules["vault-system"] then
    --=======================================================================================================================================
    -- Chest Funtions
    --=======================================================================================================================================
    local openedChest = {}
    
    function fetchChest(chestName)
        if chestName then return config.staticChests.chests[chestName]; end
    end

    function checkChestOpenAll(user_id)
        for k,v in pairs(config.staticChests.openAll) do
            if vRP.hasPermission(user_id, v) then
                return true
            end
        end
        return false
    end

    function sRP.tryOpenChest(chestName)
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            local data = fetchChest(chestName)
            if data then 
                
                if (false) then -- exports.hud removido
                    return TriggerClientEvent("Notify",source,"negado",'Inventário',"Você está sendo <b>procurado</b>!",8000)
                end

                if (data.home) then
                    if (false) then -- exports.homes removido
                        return false
                    end
                end

                if data.perm then
                    if (not vRP.hasPermission(user_id,data.perm)) and (not checkChestOpenAll(user_id)) then
                        return false
                    end
                end

                if openedChest[chestName] then
                    return TriggerClientEvent("Notify",source,"negado",'Inventário',"<b>Baú</b> ocupado.",8000)
                end
                openedChest[chestName] = true

                openVault(user_id, ('chest:'..chestName), chestName, { weight = data.weight, slots = data.slots }, { put = data.webhook, remove = data.webhook }, data.rule, function()
                    --onclose
                    openedChest[chestName] = nil
                end)
                
                return true
            end   
        end
    end

    local valuePerKilo = 2000

    function sRP.tryUpgradeChest(chestName)
        local source = source
        local user_id = vRP.getUserId(source)
        if (user_id) then
            local upgrade = '0' -- exports.hud removido
            if (not upgrade) then return; end;
            upgrade = parseInt(upgrade)
            local valueUpgrade = (upgrade * valuePerKilo)

            local request = true -- exports.hud removido
            if (request) then
                local Inventory = vRP.Inventory('chest:'..chestName)
                if (Inventory) then
                    if (vRP.tryFullPayment(user_id, valueUpgrade)) then
                        exports['phone-bank']:createStatement(user_id, { title = 'Baú', content = 'Aumentou tamanho do baú', value = valueUpgrade, type = 'spent' })

                        Inventory:varyMaxWeight(upgrade)
                        TriggerClientEvent('notify', source, 'sucesso', 'Baú', 'Você deu <b>upgrade</b> no baú com sucesso!')
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Baú', 'Dinheiro <b>insuficiente</b>!')
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Báu', 'Baú não <b>encontrado</b>!')
                end
            end
        end
    end
end
--=======================================================================================================================================
-- Weapon Functions
--=======================================================================================================================================
throwIDS = Tools.newIDGenerator()

local weaponAnim = function(source, playerPed, bool)
    if (not cRP.verifyParachute(source)) and (not Player(source).state.throwingWeapon) then 
        local anim = (bool and { 'rcmjosh4', 'josh_leadout_cop2' } or { 'weapons@pistol@', 'aim_2_holster' })
        
        vRPclient.playAnim(source, true, anim, false)
        Citizen.SetTimeout(450, function() ClearPedTasks(playerPed); end)
    end
end

local playerAmmos = {}

function storePlayerAmmo(source)
    local stateBag = PlayerState(source)
    local user_id = vRP.getUserId(source)
    if stateBag and user_id then     
        local currentSlot   = stateBag['weapon_slot']
        local currentWeapon = stateBag['weapon_model']
        local currentAmmo   = stateBag['weapon_ammo']
        if currentWeapon then
            if (not config.throwables[currentWeapon]) then
                if (currentAmmo > 0) then
                    local UserInventory = vRP.PlayerInventory(user_id)
                    for ammoType,weaps in pairs(config.ammoTargets) do
                        if weaps[currentWeapon] then    
                            UserInventory:giveItem(ammoType,currentAmmo)
                            playerAmmos[user_id..':'..currentWeapon] = { item = ammoType, amount = currentAmmo }
                            break
                        end
                    end
                end
            end
        end
    end
end

function cleanWeapons(source,storeAmmo)
    local playerPed = GetPlayerPed(source)
    
    if playerPed then
        RemoveAllPedWeapons(playerPed)
    end
    
    if storeAmmo then
        storePlayerAmmo(source)
    end
    
    local stateBag = PlayerState(source)

    if (stateBag['gadgetParachute']) then GiveWeaponToPed(playerPed, 'GADGET_PARACHUTE', 1, false, true); end;

    stateBag['weapon_slot']   = nil
    stateBag['weapon_model']  = nil
    stateBag['weapon_ammo']   = nil
    stateBag['weapon_usages'] = nil
    stateBag['Armed'] = nil

    weaponAnim(source, playerPed)
end
exports('cleanWeapons',cleanWeapons)

function sRP.cleanWeapons()
    local source = source
    cleanWeapons(source, true)
end

config.itemFunctions['cajado'] = function(source, user_id, amount, slot, UserInventory)
    local playerPed = GetPlayerPed(source)
    if playerPed then
        local weaponModel = 'WEAPON_POOLCUE'
        local stateBag = PlayerState(source)
        
        if (not stateBag['weapon_model']) then
            stateBag['Armed'] = true

            local equipAmmo = 0
        
            local UserInventory = vRP.PlayerInventory(user_id)
            local slotData = UserInventory:getSlot(slot)

            if vRP.calcDurability(slotData) < 100 then   
                if config.throwables[weaponModel] then
                    if slotData and slotData.amount then
                        local maxAmmo = (config.ammoMax[weaponModel] or 250)
                        if slotData.amount > maxAmmo then
                            equipAmmo = maxAmmo
                        else
                            equipAmmo = slotData.amount
                        end
                    end
                else
                    local lastAmmo = playerAmmos[user_id..":"..weaponModel]
                    if lastAmmo and (lastAmmo.amount > 0) then
                        local userAmount, slot = UserInventory:getItemAmount(lastAmmo.item)
                        if (userAmount > 0) and (userAmount >= lastAmmo.amount) then
                            if UserInventory:tryGetItem(lastAmmo.item,lastAmmo.amount,slot) then
                                equipAmmo = lastAmmo.amount
                            end
                        end
                    end
                end

                weaponAnim(source, playerPed, true)

                GiveWeaponToPed(playerPed, GetHashKey(weaponModel), equipAmmo, false, true)
                stateBag['weapon_slot']   = parseInt(slot)
                stateBag['weapon_model']  = weaponModel
                stateBag['weapon_ammo']   = equipAmmo
                stateBag['weapon_usages'] = (slotData.usages or 0)

                if (slotData.attachs) then
                    TriggerClientEvent('inventory:attachs',source,weaponModel,slotData.attachs)
                end
                
            else
                TriggerClientEvent('Notify',source,'negado','Inventário','A sua <b>arma</b> está <b>quebrada</b>!',16000)
            end
        else
            cleanWeapons(source,true) 
        end
        TriggerClientEvent('inventory:close',source)
    end
end

config.itemFunctions["type:weapon"] = function(source,user_id,item,amount,slot)
    local playerPed = GetPlayerPed(source)
    if playerPed then
        local weaponModel = item:upper()
        local stateBag = PlayerState(source)

        if (not stateBag['weapon_model']) then
            stateBag['Armed'] = true

            local equipAmmo = 0
           
            local UserInventory = vRP.PlayerInventory(user_id)
            local slotData = UserInventory:getSlot(slot)

            if vRP.calcDurability(slotData) < 100 then   
                if config.throwables[weaponModel] then
                    if slotData and slotData.amount then
                        local maxAmmo = (config.ammoMax[weaponModel] or 250)
                        if slotData.amount > maxAmmo then
                            equipAmmo = maxAmmo
                        else
                            equipAmmo = slotData.amount
                        end
                    end
                else
                    local lastAmmo = playerAmmos[user_id..":"..weaponModel]
                    if lastAmmo and (lastAmmo.amount > 0) then
                        local userAmount, slot = UserInventory:getItemAmount(lastAmmo.item)
                        if (userAmount > 0) and (userAmount >= lastAmmo.amount) then
                            if UserInventory:tryGetItem(lastAmmo.item,lastAmmo.amount,slot) then
                                equipAmmo = lastAmmo.amount
                            end
                        end
                    end
                end

                weaponAnim(source, playerPed, true)

                GiveWeaponToPed(playerPed, GetHashKey(weaponModel), equipAmmo, false, true)
                
                stateBag['weapon_slot']   = parseInt(slot)
                stateBag['weapon_model']  = weaponModel
                stateBag['weapon_ammo']   = equipAmmo
                stateBag['weapon_usages'] = (slotData.usages or 0)

                if (slotData.attachs) then
                    TriggerClientEvent('inventory:attachs',source,weaponModel,slotData.attachs)
                end
                
            else
                TriggerClientEvent('Notify',source,'negado','Inventário','A sua <b>arma</b> está <b>quebrada</b>!',16000)
            end
        else
            cleanWeapons(source,true) 
        end
        TriggerClientEvent('inventory:close',source)
    end

end
config.itemFunctions["type:cp-weapon"] = function(source,user_id,item,amount,slot)
    local playerPed = GetPlayerPed(source)
    if playerPed then
        local weaponModel = item:upper():gsub("^CP%-", "")
        local stateBag = PlayerState(source)

        if (not stateBag['weapon_model']) then
            stateBag['Armed'] = true

            local equipAmmo = 0
           
            local UserInventory = vRP.PlayerInventory(user_id)
            local slotData = UserInventory:getSlot(slot)

            if vRP.calcDurability(slotData) < 100 then   
                if config.throwables[weaponModel] then
                    if slotData and slotData.amount then
                        local maxAmmo = (config.ammoMax[weaponModel] or 250)
                        if slotData.amount > maxAmmo then
                            equipAmmo = maxAmmo
                        else
                            equipAmmo = slotData.amount
                        end
                    end
                else
                    local lastAmmo = playerAmmos[user_id..":"..weaponModel]
                    if lastAmmo and (lastAmmo.amount > 0) then
                        local userAmount, slot = UserInventory:getItemAmount(lastAmmo.item)
                        if (userAmount > 0) and (userAmount >= lastAmmo.amount) then
                            if UserInventory:tryGetItem(lastAmmo.item,lastAmmo.amount,slot) then
                                equipAmmo = lastAmmo.amount
                            end
                        end
                    end
                end

                weaponAnim(source, playerPed, true)

                GiveWeaponToPed(playerPed, GetHashKey(weaponModel), equipAmmo, false, true)
                
                stateBag['weapon_slot']   = parseInt(slot)
                stateBag['weapon_model']  = weaponModel
                stateBag['weapon_ammo']   = equipAmmo
                stateBag['weapon_usages'] = (slotData.usages or 0)

                if (slotData.attachs) then
                    TriggerClientEvent('inventory:attachs',source,weaponModel,slotData.attachs)
                end
                
            else
                TriggerClientEvent('Notify',source,'negado','Inventário','A sua <b>arma</b> está <b>quebrada</b>!',16000)
            end
        else
            cleanWeapons(source,true) 
        end
        TriggerClientEvent('inventory:close',source)
    end
end



config.itemFunctions["type:ammo"] = function(source,user_id,item,amount,slot)
    if tonumber(slot) <= 5 then
        TriggerClientEvent('notify', source, 'negado', 'Inventário', 'Não é possível utilizar a munição pelo dedo rápido!')
        return
    end
    
    local playerPed = GetPlayerPed(source)
    local stateBag = PlayerState(source)
    local currentWeapon = stateBag['weapon_model']
    local currentAmmo = cRP.getAmmoAmount(source, currentWeapon)

    if playerPed and currentWeapon and currentAmmo then
        
        if config.ammoTargets[item][currentWeapon] then
            local UserInventory = vRP.PlayerInventory(user_id)
            
            local maxAmmo = (config.ammoMax[currentWeapon] or 250)

            if (currentAmmo + amount) > maxAmmo then
                amount = maxAmmo - currentAmmo
            end
            
            if (amount > 0) and UserInventory:tryGetItem(item,amount,slot,true) then
                local newAmmo = math.floor(currentAmmo+amount)
                SetPedAmmo(playerPed,GetHashKey(currentWeapon),newAmmo)
                cRP.setAmmo(source, GetHashKey(currentWeapon), newAmmo)
                stateBag['weapon_ammo'] = newAmmo
                return true
            end
        end
    end

end


AddEventHandler('playerDropped',function()
    local source = source
    storePlayerAmmo(source)
end)

AddEventHandler('inventory:event',function(event,payload)
    if payload.identifier:find('player:') then
        local user_id = parseInt(payload.identifier:gsub('player:',''))
        local source = vRP.getUserSource(user_id)
        if source then
            local stateBag = PlayerState(source)
            local currentSlot   = stateBag['weapon_slot']
            local currentWeapon = stateBag['weapon_model']
            local currentAmmo   = stateBag['weapon_ammo']
            if currentSlot then
                if (currentSlot == payload.slot) then
                    if (event == 'swaped') then
                        return cleanWeapons(source,true) 
                    end
                    if (event == 'losed') then
                        if (not config.throwables[currentWeapon]) then
                            return cleanWeapons(source,true) 
                        else
                            Wait(500)
                            local UserInventory = vRP.PlayerInventory(user_id)
                            local slotData = UserInventory:getSlot(currentSlot)
                            if (not slotData) or (slotData.amount < currentAmmo) then
                                -- aqui pode dar problema, inv e atualizado antes de de syncar o statebag
                                return cleanWeapons(source,true) 
                            end
                        end
                    end
                end
                if (event == 'cleaned') then
                    return cleanWeapons(source,false) 
                end
            end
        end
    end
end)

function sRP.removeThrowable(amount,ammo)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and (amount > 0) then
        local stateBag = PlayerState(source)
        local currentSlot   = stateBag['weapon_slot']
        local currentWeapon = stateBag['weapon_model']
        local currentAmmo   = stateBag['weapon_ammo']
        if currentSlot and currentWeapon then
            local UserInventory = vRP.PlayerInventory(user_id)
            if UserInventory:tryGetItem(currentWeapon:lower(),amount,currentSlot) then
                if (ammo <= 0) then
                    cleanWeapons(source,false)
                end
                return true
            else
                cleanWeapons(source,false)
            end
        end
    end
    return false
end

AddStateBagChangeHandler('weapon_usages', nil, function(bagName, key, value) 
    local source = GetPlayerFromStateBagName(bagName)
    if (source == 0) then return; end;
    if value and (value > 0) then
        local stateBag = PlayerState(source)
        local currentSlot = stateBag['weapon_slot']
        local currentUsages = stateBag['weapon_usages']
        if currentSlot and currentUsages then
            local user_id = vRP.getUserId(source)
            if user_id then
                local UserInventory = vRP.PlayerInventory(user_id)
                if UserInventory then
                    local usageDiff = math.floor(value-currentUsages)
                    if (not UserInventory:useSlot(currentSlot,usageDiff)) then
                        cleanWeapons(source,true)
                        TriggerClientEvent('Notify',source,'negado','Inventário','A sua <b>arma quebrou!</b>',16000)
                    end
                end
            end
        end
    end
end)

--=======================================================================================================================================
-- Throw Weapon 
--=======================================================================================================================================
thrownWeapons = {}
local preventQuit = {}
local cooldownDelete = {}

function sRP.preventQuit(objNet, bool)
    local source = source
    if (bool) then
        preventQuit[source] = objNet
    else
        preventQuit[source] = nil
    end
end

AddEventHandler('playerDropped',function()
    if (preventQuit[source]) then
        DeleteEntity(NetworkGetEntityFromNetworkId(preventQuit[source]))
        preventQuit[source] = nil
    end
end)

function sRP.saveWeapons(table)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local slot = table.itemSlot

        local userInventory = vRP.PlayerInventory(user_id)
        if (userInventory) then
            local getSlot = userInventory:getSlot(slot)
            if (userInventory:tryGetItem(getSlot.item, getSlot.amount, slot, true)) then
                local id = throwIDS:gen()
                if (id) then
                    thrownWeapons[id] = {
                        throwId = id,
                        time = 3600,
                        slot = getSlot,
                        objectId = table.objectId,
                        objectCoords = table.objectCoords,
                        itemSlot = table.itemSlot,
                        createObject = table.createObject
                    }

                    TriggerClientEvent('inventory:setWeaponData', -1, id, thrownWeapons[id])
                
                    vRP.webhook(config.webhooks.throwDropping, {
                        title = 'throw weapon drop',
                        descriptions = {
                            { 'user', user_id },
                            { 'throw-id', id },
                            { 'arremessou', vRP.format(getSlot.amount)..' '..sINV.itemName(getSlot.item) }
                        }
                    })  
                end
            end
        end
    end
end

deleteThrownWeapon = function(id)
    thrownWeapons[id] = nil
    throwIDS:free(id)
    TriggerClientEvent('inventory:setWeaponData', -1, id)
end

function sRP.deleteWeaponSaved(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (cooldownDelete[id]) then return; end;
        cooldownDelete[id] = true

        local userInventory = vRP.PlayerInventory(user_id)
        if (userInventory) then
            local throw = thrownWeapons[id]
            if (throw) then
                if (userInventory:haveSpace(throw.slot.item, throw.slot.amount)) then
                    userInventory:giveItem(throw.slot.item, throw.slot.amount, nil, throw.slot, true)
                    
                    vRP.webhook(config.webhooks.throwPickup, {
                        title = 'throw weapon pickup',
                        descriptions = {
                            { 'user', user_id },
                            { 'throw-id', id },
                            { 'pegou', vRP.format(throw.slot.amount)..' '..sINV.itemName(throw.slot.item) }
                        }
                    })  
                    
                    DeleteEntity(NetworkGetEntityFromNetworkId(throw.objectId))
                    deleteThrownWeapon(id)
                end
            end
        end

        cooldownDelete[id] = nil
    end
end

AddEventHandler('playerSpawn', function(user_id, source, first_spawn)
    for id, data in pairs(thrownWeapons) do 
        local objectId = cRP.createWeaponObject(source, data)
        data.objectId = objectId

        TriggerClientEvent('inventory:setWeaponData', source, id, data)
    end
end)

AddEventHandler('onResourceStop', function(name) 
    if (GetCurrentResourceName() ~= name) then return; end;
    
    for _, data in pairs(thrownWeapons) do 
        DeleteEntity(NetworkGetEntityFromNetworkId(data.objectId))
    end
end)
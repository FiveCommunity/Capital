srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

local webhookConfig = config.webhooks
local textsConfig = config.texts

srv.changeSession = function(bucket)
    local _source = source
    SetPlayerRoutingBucket(_source, bucket)
end

srv.getIdentity = function()
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        return getIdentity(getUserIdentity(_userId))
    end
end

srv.checkPermissions = function(permission)    
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        return vRP.checkPermissions(_userId, permission)
    end
end

exports('checkPermissions', srv.checkPermissions)

srv.getGroupTitle = function(permission)
    return (getGroupTitle(config.permissions[permission]) or 'Grupo não identificado')
end

srv.clearWeapons = function()
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        exports.inventory:cleanWeapons(source,false)
        local UserInventory = vRP.PlayerInventory(_userId)
        if UserInventory then
            for k,v in pairs(UserInventory:getItems()) do
                local itemType = vRP.itemTypeList(v.item)
                if (itemType == 'weapon') or (itemType == 'ammo') then
                    UserInventory:tryGetItem(v.item,v.amount,k)
                end
            end
        end
        serverNotify(_source, textsConfig['clearWeapons'])
    end
end

local cooldownWeapons = {}

local ammos = {
    ['weapon_combatpistol'] = 'ammo_5mm',
    ['weapon_combatpdw'] = 'ammo_9mm',
    ['weapon_pumpshotgun_mk2'] = 'ammo_12cbc',
    ['weapon_carbinerifle_mk2'] = 'ammo_762mm',
    ['weapon_specialcarbine'] = 'ammo_762mm',
}

srv.giveWeapon = function(weapons, _config)
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        local UserInventory = vRP.PlayerInventory(_userId)
        if (UserInventory) then
            local _weapons = getWeapons(UserInventory)
            local _spawn = weapons['spawn']

            if (UserInventory:itemMaxAmount(_spawn, 1)) then
                if (UserInventory:haveSpace(_spawn, 1)) then
                    if (not cooldownWeapons[_userId]) then
                        cooldownWeapons[_userId] = {}
                    end

                    if (not cooldownWeapons[_userId][_spawn]) then
                        if (not srv.checkPermissions(_config['weapons']['cooldownWeapons']['noCooldown'])) then 
                            cooldownWeaponsThread(_userId, _spawn, _config['weapons']['cooldownWeapons']['time']) 
                        end

                        if (not _weapons[_spawn]) then
                            if (vRP.tryFullPayment(_userId, weapons['price'])) then
                                UserInventory:generateItem(_spawn, 1, nil, { prefix = 'EB' }, true)
                                if (weapons.ammo > 0) and (ammos[_spawn]) then
                                    UserInventory:generateItem(ammos[_spawn], weapons.ammo)
                                end

                                serverNotify(_source, textsConfig['giveWeapon'](weapons['name'], weapons['price']))
                                webhookConfig['weapons'](_source, _config['webhooks']['weapons'], _config['name'], _userId, _spawn, weapons['name'], weapons['ammo'])
                            else
                                TriggerClientEvent('notifyArsenal', _source, 'Você não possui <b>R$'..vRP.format(weapons['price'])..'</b>!')
                            end
                        else
                            serverNotify(_source, textsConfig['haveWeapon'])
                        end
                    else
                        serverNotify(_source, textsConfig['cooldown'](cooldownWeapons[_userId][_spawn]))
                    end
                else
                    serverNotify(_source, textsConfig['noBackpack'])
                end
            else
                serverNotify(_source, 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(_spawn)..'</b> na mochila!')
            end

            
        end
    end
end

cooldownWeaponsThread = function(user_id, _spawn, time)
    Citizen.CreateThread(function()
        cooldownWeapons[user_id][_spawn] = time
        while (cooldownWeapons[user_id][_spawn] > 0) do
            cooldownWeapons[user_id][_spawn] = cooldownWeapons[user_id][_spawn] - 1
            Citizen.Wait(1000)
        end
        cooldownWeapons[user_id][_spawn] = nil
    end)
end

local cooldownUtilitarys = {}

srv.giveUtilitary = function(utilitarys, _config)
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        local UserInventory = vRP.PlayerInventory(_userId)
        if (UserInventory) then
            local _spawn = utilitarys['spawn']

            if (not cooldownUtilitarys[_userId]) then
                cooldownUtilitarys[_userId] = {}
            end

            if (not cooldownUtilitarys[_userId][_spawn]) then
                if (not srv.checkPermissions(_config['utilitarys']['cooldownUtilitarys']['noCooldown']) and not utilitarys.noCooldown) then 
                    cooldownUtilitaryThread(_userId, _spawn, _config['utilitarys']['cooldownUtilitarys']['time']) 
                end
                
                if (utilitarys['type'] == 'arma') then
                    if (UserInventory:itemMaxAmount(_spawn, 1)) then
                        if (UserInventory:haveSpace(_spawn, 1)) then
                            local _weapons = getWeapons(UserInventory)
                            if (not _weapons[_spawn]) then
                                if (vRP.tryFullPayment(_userId, utilitarys.price)) then
                                    UserInventory:generateItem(_spawn, 1, nil, { prefix = 'EB' }, true)
                                    if (utilitarys['ammo'] > 0) and (ammos[_spawn]) then
                                        UserInventory:generateItem(ammos[_spawn], utilitarys['ammo'])
                                    end
                                    serverNotify(_source, textsConfig['giveWeapon'](utilitarys.name, utilitarys.price))
                                    webhookConfig['utilitaryWeapon'](_source, _config['webhooks']['utilitarys'], _config['name'], _userId, _spawn, utilitarys['name'], utilitarys['ammo'])
                                else
                                    TriggerClientEvent('notifyArsenal', _source, 'Você não possui <b>R$'..vRP.format(utilitarys.price)..'</b>!')
                                end
                            else
                                TriggerClientEvent('notifyArsenal', _source, 'Você já possui esse <b>armamento</b> em seu inventário.')
                            end
                        else
                            serverNotify(_source, textsConfig['noBackpack'])
                        end
                    else
                        serverNotify(_source, 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(_spawn)..'</b> na mochila!')
                    end
                else        
                    if (UserInventory:itemMaxAmount(_spawn, utilitarys['quantity'])) then
                        if (UserInventory:haveSpace(_spawn, utilitarys['quantity'])) then
                            local check;
                            if (not utilitarys.infinityBuy) then
                                check = UserInventory:getItemAmount( _spawn) < utilitarys['quantity']
                            else
                                check = true
                            end
                            
                            if (check) then 
                                if (vRP.tryFullPayment(_userId, utilitarys.price)) then
                                    UserInventory:generateItem(_spawn, utilitarys['quantity'])
                                    serverNotify(_source, textsConfig['giveWeapon'](utilitarys.name, utilitarys.price))
                                    webhookConfig['utilitaryItem'](_source, _config['webhooks']['utilitarys'], _config['name'], _userId, _spawn, utilitarys['name'], utilitarys['quantity'])
                                else
                                    TriggerClientEvent('notifyArsenal', _source, 'Você não possui <b>R$'..vRP.format(utilitarys.price)..'</b>!')
                                end
                            else
                                serverNotify(_source, textsConfig['haveItem'](utilitarys['name']))
                            end
                        else
                            serverNotify(_source, textsConfig['noBackpack'])
                        end
                    else
                        serverNotify(_source, 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(_spawn)..'</b> na mochila!')
                    end
                end
            else
                serverNotify(_source, textsConfig['cooldown'](cooldownUtilitarys[_userId][_spawn]))
            end
        end
    end
end

cooldownUtilitaryThread = function(user_id, _spawn, time)
    Citizen.CreateThread(function()
        cooldownUtilitarys[user_id][_spawn] = time
        while (cooldownUtilitarys[user_id][_spawn] > 0) do
            cooldownUtilitarys[user_id][_spawn] = cooldownUtilitarys[user_id][_spawn] - 1
            Citizen.Wait(1000)
        end
        cooldownUtilitarys[user_id][_spawn] = nil
    end)
end

local cooldownKits = {}

srv.giveKits = function(kits, _config)
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        local _name = kits['name']

        if (not cooldownKits[_userId]) then
            cooldownKits[_userId] = {}
        end

        if (not cooldownKits[_userId][_name]) then
            if (not srv.checkPermissions(_config['kits']['cooldownKits']['noCooldown'])) then 
                cooldownKitThread(_userId, _name, _config['kits']['cooldownKits']['time']) 
            end
            
            for index, value in pairs(kits['itens']) do
                if (vRP.itemMaxAmount(index, value['quantity'])) then
                    if (getInventoryItemAmount(_userId, index) < value['quantity']) then
                        if (vRP.tryFullPayment(_userId, value.price)) then
                            giveInventoryItem(_userId, index, value['quantity'])
                        else
                            TriggerClientEvent('notifyArsenal', _source, 'Você não possui <b>R$'..vRP.format(value.price)..'</b>!')
                        end
                    else
                        serverNotify(_source, textsConfig['haveKit'](kits['name']))
                        return
                    end
                else
                    return serverNotify(_source, 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(index)..'</b> na mochila!')
                end
            end            

            serverNotify(_source, textsConfig['giveKit'](kits['name']))
            webhookConfig['kits'](_source, _config['webhooks']['kits'], _config['name'], _userId, kits['name'])
        else
            serverNotify(_source, textsConfig['cooldown'](cooldownKits[_userId][_name]))
        end
    end
end

cooldownKitThread = function(user_id, _name, time)
    Citizen.CreateThread(function()
        cooldownKits[user_id][_name] = time
        while (cooldownKits[user_id][_name] > 0) do
            cooldownKits[user_id][_name] = cooldownKits[user_id][_name] - 1
            Citizen.Wait(1000)
        end
        cooldownKits[user_id][_name] = nil
    end)
end

srv.giveAmmo = function(ammo, _weapon, _config)
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        local UserInventory = vRP.PlayerInventory(_userId)
        if (UserInventory) then
            local ammoExtra, ammoExtraMax = ammo[3], ammo[4];   
            if ammoExtra and (ammoExtra > 0) then
                local weaponAmmo = ammos[_weapon['spawn']]

                if (UserInventory:haveSpace(weaponAmmo, ammoExtra)) then
                    if (UserInventory:getItemAmount(weaponAmmo) < ammoExtraMax) then 
                        UserInventory:generateItem(weaponAmmo, ammoExtra)

                        serverNotify(_source, textsConfig['getAmmoExtra'](_weapon['name'], ammoExtra))
                        webhookConfig['ammo'](_source, _config['webhooks']['ammo'], _config['name'], _userId, _weapon['spawn'], ammoExtra)
                    else
                        serverNotify(_source, textsConfig['maxAmmoExtra'](ammoExtraMax, _weapon['name']))
                    end
                else
                    serverNotify(_source, textsConfig['noBackpack'])
                end
            end
        end
    end
end

local usersTraining = {}

srv.saveCoords = function()
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        if (not usersTraining[_userId]) then
            usersTraining[_userId] = {}
        end                            
        usersTraining[_userId].coords = GetEntityCoords(GetPlayerPed(_source))                          
    end
end

srv.setOldCoords = function()
    local _source = source
    local _userId = getUserId(_source)
    if (_userId) then
        if (usersTraining[_userId]) then
            if (usersTraining[_userId].coords) then
                SetEntityCoords(GetPlayerPed(_source), usersTraining[_userId].coords)
            end
            usersTraining[_userId] = nil
        end                            
    end
end

AddEventHandler('vRP:playerLeave', function(user_id, source)
    if (usersTraining[user_id]) then
        if (usersTraining[user_id].coords) then
            setKeyDataTable(user_id,'position',{ x = usersTraining[user_id].coords.x, y = usersTraining[user_id].coords.y, z = usersTraining[user_id].coords.z })
        end
        usersTraining[user_id] = nil
    end    
end)
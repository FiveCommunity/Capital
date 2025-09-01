if IsDuplicityVersion() then
    webhook = function(link, message)
        if link and message and link ~= '' then
            PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
        end
    end

    getUserId = function(source)
        return vRP.getUserId(source)
    end

    getUserIdentity = function(user_id)
        return vRP.getUserIdentity(user_id)
    end

    getIdentity = function(identity)
        return identity['firstname']..' '..identity['lastname']
    end

    hasPermission = function(user_id, permission)
        return vRP.hasPermission(user_id, permission)
    end

    getGroupTitle = function(permission)
        return vRP.getGroupTitle(permission)
    end

    giveWeapons = function(source, weapons, clear)
        return vRPclient.giveWeapons(source, weapons, clear, GlobalState.weaponToken)
    end

    getWeapons = function(inventory)
        local weapons = {}
        for k, v in pairs(inventory:getItems()) do
            if (string.find(v.item, 'weapon')) then
                weapons[v.item] = true
            end
        end
        return weapons
    end

    getInventoryItemAmount = function(user_id, item)
        return vRP.getInventoryItemAmount(user_id, item)
    end

    giveInventoryItem = function(user_id, item, quantity)
        return vRP.giveInventoryItem(user_id, item, quantity)
    end

    itemNameList = function(item)
        return vRP.itemNameList(item)
    end

    getInventoryWeight = function(user_id)
        return vRP.getInventoryWeight(user_id)
    end

    getItemWeight = function(item)
        return vRP.getItemWeight(item)
    end

    getInventoryMaxWeight = function(user_id)
        return vRP.getInventoryMaxWeight(user_id)
    end

    serverNotify = function(source, message)
        TriggerClientEvent('notifyArsenal', source, message, 3000)
    end
else
    getWeapons = function()
        return vRP.getWeapons()
    end

    threadMarker = function(config)
        Text3D(config.coord.x, config.coord.y, config.coord.z, '~b~E~w~ - ARSENAL', 400)
    end

    openFunction = function()
        TriggerEvent('Notify:Toogle', false) 
        LocalPlayer.state.Hud = false
    end

    closeFunction = function()
        TriggerEvent('Notify:Toogle', true) 
        LocalPlayer.state.Hud = true
    end

    clientNotify = function(message)
        TriggerEvent('notifyArsenal', message, 3000)
    end

    Text3D = function(x,y,z,text,size)
        local onScreen,_x,_y = World3dToScreen2d(x,y,z)
        if onScreen then
            SetTextFont(4)
            SetTextScale(0.35,0.35)
            SetTextColour(255,255,255,155)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
            local factor = (string.len(text))/size
            DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
        end
    end
end
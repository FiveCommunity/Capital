local srv = {}
Tunnel.bindInterface('Doors', srv)

local doorTimeouts = {}
local doorsOpened = {}

local permission = {
    ['perm'] = function(user_id, perm, home)
        return vRP.checkPermissions(user_id, perm)
    end,
    ['home'] = function(user_id, perm, home)
        return exports.homes:checkHomePermission(user_id, home)
    end
}

srv.checkPermissions = function(perm, home, id)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (id) then
            if (type(id) == 'table') then
                for _, v in pairs(id) do
                    if (user_id == v) then
                        return true
                    end
                end
            else
                if (user_id == id) then
                    return true
                end
            end
        end

        local isHome = (home and 'home' or 'perm')
        return permission[isHome](user_id, perm, home)
    end
end

--[ LOAD DOORS WITH JOIN ]--

AddEventHandler('playerJoining', function()
    TriggerClientEvent('gb_doors:initialize', source, doorsOpened)
end)

--[ RELOAD DOORS WITH ENSURE ]--

CreateThread(function()
    Wait(5000)
    TriggerClientEvent('gb_doors:initialize', -1, doorsOpened)
end)

RegisterServerEvent('gb_doors:open',function(id, autoLock)
	local source = source
	local user_id = vRP.getUserId(source)

    setDoorState(id, not Doors[id].lock)

    if autoLock and (not Doors[id].lock) and (not doorTimeouts[id]) then
        doorTimeouts[id] = true
        SetTimeout(autoLock,function()
            if (not Doors[id].lock) then
                setDoorState(id,true)
            end
            doorTimeouts[id] = nil
        end)
    end
end)

setDoorState = function(id, state)
	Doors[id].lock = state
	TriggerClientEvent('gb_doors:statusSend', -1, id, state)

    if not state then
        doorsOpened[id] = true
    else
        doorsOpened[id] = nil
    end
end
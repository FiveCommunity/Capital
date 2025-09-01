local users = {}

srv.getOxygen = function(slot)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (not users[user_id]) then users[user_id] = slot; end;
        
        local actualSlot = users[user_id]
        local playerInventory = vRP.PlayerInventory(user_id)
        if (playerInventory) then
            local slot = playerInventory:getSlot(actualSlot)
            local time, usages = exports.inventory:itemDurability('equipamento-mergulho')
            
            Player(source).state.Scuba = true
            return (usages - slot.usages)
        end
    end
    return false
end

local resetOxygen = function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (users[user_id]) then users[user_id] = nil; end;
    end
end

srv.resetOxygen = function()
    local source = source

    Player(source).state.Scuba = false
    resetOxygen(source)
end

AddEventHandler('playerDropped', function()
    local source = source
    resetOxygen(source)
end)

RegisterNetEvent('scuba:useSlot', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local actualSlot = users[user_id]
        if (actualSlot) then
            local playerInventory = vRP.PlayerInventory(user_id)
            if (not playerInventory) then return; end;

            playerInventory:useSlot(actualSlot, 1)
        end
    end
end)

local events = {
    swaped = function(user_id, payload)
        users[user_id] = payload.target
    end,

    cleaned = function(user_id, payload)
        local source = vRP.getUserSource(user_id)
        TriggerClientEvent('scuba:start', source)
    end,

    losed = function(user_id, payload)
        if (payload.slot == users[user_id]) then
            local source = vRP.getUserSource(user_id)
            TriggerClientEvent('scuba:start', source)
        end
    end
}

AddEventHandler('inventory:event',function(event, payload)
    if (payload.identifier:find('player:')) then
        local user_id = parseInt(payload.identifier:gsub('player:',''))
        local source = vRP.getUserSource(user_id)
        if (source) then
            local actualSlot = users[user_id]
            if (actualSlot) then
                if (events[event]) then events[event](user_id, payload); end;
            end
        end
    end
end)
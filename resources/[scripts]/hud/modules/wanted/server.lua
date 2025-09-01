local Wanteds = {}

Citizen.CreateThread(function()
    while true do
        for u,t in pairs(Wanteds) do
            local src = exports.vrp:getUserSource(u)
            if src then
                if (t > 0) then
                    Wanteds[u] = t - 2
                    if ( (Wanteds[u] % 4) == 0 ) then
                        TriggerClientEvent('update:wanted', src, Wanteds[u])
                    end
                else
                    Wanteds[u] = nil
                end
            end
        end
        Wait(2000)
    end
end)

insertWanted = function(user_id, time, max)
    if (user_id) then
        local current = (Wanteds[user_id] or 0)
        
        if (max) and (current+time > max) then
            time = max - current
        end

        if (time > 0) then
            Wanteds[user_id] = current + time
            local source = vRP.getUserSource(user_id)
            TriggerClientEvent('update:wanted', source, Wanteds[user_id])
        end
    end
end
exports('insertWanted', insertWanted)

isWanted = function(user_id)
    if Wanteds[user_id] then
        return (Wanteds[user_id] > 0), Wanteds[user_id]
    end
    return false
end
exports('isWanted', isWanted)

AddEventHandler('playerSpawn', function(user_id, source)
    if (Wanteds[user_id]) then TriggerClientEvent('update:wanted', source, Wanteds[user_id]) end
end)
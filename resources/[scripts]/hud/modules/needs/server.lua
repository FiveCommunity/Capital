RegisterNetEvent('needs:syncFartSound', function()
    local source = source
    if (source) then syncSounds(source, 'cagar2', 5.0, 0.5); end;
end)

syncSounds = function(source, sound, distance, volume)
    TriggerClientEvent('vrp_sounds:source', source, sound, volume)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local nplayers = vRPclient.getNearestPlayers(source, distance)
    if (nplayers) then
        for src, _ in pairs(nplayers) do
            TriggerClientEvent('vrp_sounds:distance', src, coords, distance, sound, volume)
        end
    end
end
exports('syncSounds', syncSounds)
local Teleports = {
    { 
        distance = 5.0,
        coordsFrom = vector4(-740.967, 5594.848, 41.64758, 266.4567),
        coordsTo = vector4(446.3473, 5571.93, 781.186, 269.2914),
        textFrom = 'Subir Teleférico',
        textTo = 'Descer Teleférico',
        timeout = 8000
    },
    { 
        distance = 1.5,
        coordsFrom = vector4(1770.145, 2626.154, 45.62415, 187.0866),
        coordsTo = vector4(1728.87, 2658.58, -56.87329, 187.0866),
        textFrom = 'Entrar',
        textTo = 'Sair',
        timeout = 5000
    },
}

Citizen.CreateThread(function()
    for _, v in pairs(Teleports) do
        TriggerEvent('insert:hoverfy', v.coordsFrom.xyz, 'E', v.textFrom, v.distance)
        Citizen.Wait(100)
        TriggerEvent('insert:hoverfy', v.coordsTo.xyz, 'E', v.textTo, v.distance)
    end
end)

local nearestTeleport = function()
    local pCoord = GetEntityCoords(PlayerPedId())
    for k, v in pairs(Teleports) do
        local dist, dist_2 = #(pCoord - v.coordsFrom.xyz), #(pCoord - v.coordsTo.xyz)
        if (dist <= v.distance) then
            return k, 'from'
        elseif (dist_2 <= v.distance) then
            return k, 'to'
        end
    end
    return false
end

local exec = {
    ['from'] = function(ped, cfg)
        LocalPlayer.state.Hud = false

        DoScreenFadeOut(500)
        Citizen.Wait(500)

        LocalPlayer.state.BlockTasks = true
        LocalPlayer.state.freezeEntity = true

        StartPlayerTeleport(PlayerId(), cfg.coordsTo.x, cfg.coordsTo.y, cfg.coordsTo.z, cfg.coordsTo.w, false, true, true)
        while (IsPlayerTeleportActive()) do Citizen.Wait(1); end;

        Citizen.Wait(cfg.timeout)
        DoScreenFadeIn(500)

        LocalPlayer.state.BlockTasks = false
        LocalPlayer.state.freezeEntity = false
        LocalPlayer.state.Hud = true
    end,

    ['to'] = function(ped, cfg)
        LocalPlayer.state.Hud = false

        DoScreenFadeOut(500)
        Citizen.Wait(500)

        LocalPlayer.state.BlockTasks = true
        LocalPlayer.state.freezeEntity = true

        StartPlayerTeleport(PlayerId(), cfg.coordsFrom.x, cfg.coordsFrom.y, cfg.coordsFrom.z, cfg.coordsFrom.w, false, true, true)
        while (IsPlayerTeleportActive()) do Citizen.Wait(1); end;

        Citizen.Wait(cfg.timeout)
        DoScreenFadeIn(500)

        LocalPlayer.state.BlockTasks = false
        LocalPlayer.state.freezeEntity = false
        LocalPlayer.state.Hud = true
    end
}

RegisterCommand('teleport', function()
    local teleportIndex, teleportType = nearestTeleport()
    if (teleportIndex) then
        local ped = PlayerPedId()
        if (not IsPedInAnyVehicle(ped)) and (GetEntityHealth(ped) > 100) then
            local cfg = Teleports[teleportIndex]
            if (exec[teleportType]) then exec[teleportType](ped, cfg); end;
        end
    end
end)
RegisterKeyMapping('teleport', 'Teletransportar', 'keyboard', 'E')
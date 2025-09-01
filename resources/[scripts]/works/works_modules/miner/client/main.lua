sMINER = Tunnel.getInterface(GetCurrentResourceName()..':miner')

local minerZone = { id = 0, last = 0 }

nearestZone = function(coords)
    if (GetGameTimer() > minerZone.last) then
        minerZone.id = 0
        minerZone.last = GetGameTimer()+1500
        for k, v in pairs(Miner.regions) do
            local dist = #(v.center - coords)
            if (dist <= v.radius) then
                minerZone.id = k
                break;
            end
        end
    end
    return minerZone.id
end

Citizen.CreateThread(function()
    while true do
        local _sleep = 2000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        local currentZone = nearestZone(coords)
        if (currentZone > 0) then
            _sleep = 1
            for k, v in pairs( Miner.regions[currentZone].positions ) do
                local dist = #(coords - v.xyz)
                if (dist < 30.0) then
                    DrawMarker(21,v.x,v.y,v.z-0.3, 0,0,0,0,180.0,130.0,0.8,1.0,0.7,255,0,0,150,1,0,0,1)
                    if (dist < 1.5) and IsControlJustPressed(0,38) then
                        if sMINER.getExplosive() then
                            vRP.playAnim(false,{{'anim@heists@ornate_bank@thermal_charge','thermal_charge'}},false)
                            Citizen.Wait(5500)
                            ClearPedTasks(ped)

                            TriggerEvent('vrp_sounds:source','bomb_25',0.5)
                            TriggerEvent('ProgressBar', 25000)
                            Citizen.Wait(25000)
                            sMINER.setStress()
                            AddExplosion(v.x, v.y, v.z, 2, 5.0, true, false, 0.0)

                            local collected = false
                            while (not collected) do
                                coords = GetEntityCoords(ped)
                                dist = #(coords - v.xyz)
                                if (dist < 1.8) then
                                    TextFloating('~INPUT_PICKUP~ Coletar Minérios', v.xyz)
                                    if IsControlJustPressed(0,38) then
                                        collected = true
                                        vRP._playAnim(false,{ {"pickup_object","pickup_low"}},false)
                                        sMINER.collectMiner( currentZone, k, GetNetworkTime() )
                                    end
                                elseif (dist > 50.0) then
                                    break
                                end
                                Citizen.Wait(1)
                            end
                        else
                            TriggerEvent('notify', 'negado', 'Minerador', 'Você não possui os itens nescessários para a detonação.')
                            _sleep = 500
                        end
                    end
                end
            end
        end
        Citizen.Wait(_sleep)
    end
end)
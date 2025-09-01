local sJAIL = Tunnel.getInterface('JailBreak')

Citizen.CreateThread(function()
    TriggerEvent('insert:hoverfy', JailBreak.startBreak, 'E', 'Iniciar Fuga', 2.0)
end)

AddStateBagChangeHandler('Prison', nil, function(bagName, key, value) 
    local player = GetPlayerFromStateBagName(bagName)
    if (player == 0) or (PlayerId() ~= player) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Prison) do
                local _sleep = 1000
                local coords = GetEntityCoords( PlayerPedId() )
                if (#(coords - JailBreak.startBreak) <= 2.0) then
                    _sleep = 1
                    if IsControlJustPressed(0,38) then
                        if sJAIL.tryJailBreak() then
                            DoScreenFadeOut(1000)
                            Citizen.Wait(1200)

                            sJAIL.removeJail()
                            
                            Citizen.Wait(1200)
                            DoScreenFadeIn(1000)
                        end
                        _sleep = 1000
                    end
                end
                Citizen.Wait(_sleep)
            end
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        local _sleep = 1500
        local coords = GetEntityCoords( PlayerPedId() )
        if (#(coords - JailBreak.startBreak) <= 2.0) then
            _sleep = 1
            DrawText3Ds(JailBreak.startBreak.x, JailBreak.startBreak.y, JailBreak.startBreak.z+0.1, '[E] ~r~Iniciar Fuga', 0.35)
            if IsControlJustPressed(0,38) then
                if sJAIL.tryJailBreak() then
                    DoScreenFadeOut(1000)
                    Citizen.Wait(1200)

                    sJAIL.removeJail()
                    
                    Citizen.Wait(1200)
                    DoScreenFadeIn(1000)
                end
                _sleep = 1000
            end
        end
        Citizen.Wait(_sleep)
    end
end)

local blips = {};
RegisterNetEvent('jailbreak:blip', function(user,coords,timeout)
    if (not DoesBlipExist(blips[user])) then
        blips[user] = AddBlipForCoord(coords)

        SetBlipScale(blips[user], 0.6)
		SetBlipSprite(blips[user], 58)
		SetBlipColour(blips[user], 1)
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Fugitivo')
        EndTextCommandSetBlipName(blips[user])
		SetBlipAsShortRange(blips[user], true)

        Citizen.SetTimeout((timeout or 14000), function()
            if (DoesBlipExist(blips[user])) then RemoveBlip(blips[user]); blips[user] = nil; end;
        end)
    end
end)
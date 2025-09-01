local vSERVER = Tunnel.getInterface('Killsystem')
local config = module('core','cfg/cfgKillsystem')

local stunned = false;

AddEventHandler('gameEventTriggered', function(name, args)
    if LocalPlayer.state.isPlayingEvent then 
        return 
    end

    if name == 'CEventNetworkEntityDamage' then
        local ped = PlayerPedId()
                
        if (ped == args[1]) and (ped ~= args[2]) then   
            local weapon = args[7]

            if (weapon == GetHashKey('WEAPON_SHOES') or weapon == GetHashKey('WEAPON_SNOWBALL')) then
                if (not stunned) then
                    Citizen.CreateThread(function()
                        stunned = true;

                        LocalPlayer.state.BlockTasks = true

                        Citizen.SetTimeout(10000, function()
                            stunned = false;
                            StopGameplayCamShaking()
                            LocalPlayer.state.BlockTasks = false
                        end)

                        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
                        while (stunned) do
                            SetPedToRagdoll(ped,10000,10000,0,0,0,0)
                            Citizen.Wait(5)
                        end
                    end)
                end
            end
            
            local died = (GetEntityHealth(args[1]) <= 100)        
            if (not weapon) then _, weapon = GetCurrentPedWeapon(args[2]); end;
            
            local _, bone = GetPedLastDamageBone(args[1])
            ClearPedLastDamageBone(ped)

            -- [Remover Headshot] --
            -- if (not died) then
            --     if (bone == 31086) then
            --         if config.weapons[weapon]['headshot'] then
            --             died = true
            --             SetEntityHealth(ped, 0)
            --         end
            --     end
            -- end

            if died then
                local index = NetworkGetPlayerIndexFromPed(args[2])
                local killerSource = GetPlayerServerId(index)
                if (killerSource > 0) then
                    if (IsPedAPlayer(args[2])) then
                        print('teste an4log 2')
                        vSERVER.playerDeath(weapon, killerSource)
                    end
                else
                    vSERVER.playerDeath(weapon, false)
                end
            end
        end
    end
end)
local config = module('core','cfg/cfgPed')

local localPeds = {}

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        for k, v in pairs(config.peds) do
            local distance = #(GetEntityCoords(ped) - v.coord.xyz)
            if (distance <= 25) then
                if (not localPeds[k]) then
                    local hash = v.hash
                    RequestModel(hash)
                    while (not HasModelLoaded(hash)) do
						RequestModel(hash)
						Citizen.Wait(10)
					end

                    localPeds[k] = CreatePed(4, hash, v.coord.x, v.coord.y, v.coord.z - 1, v.coord.w, false, false)
                    SetEntityInvincible(localPeds[k], true)
					FreezeEntityPosition(localPeds[k], true)
					SetBlockingOfNonTemporaryEvents(localPeds[k], true)
                    SetModelAsNoLongerNeeded(mHash)
                    Entity(localPeds[k]).state['scenario'] = true

                    if (v.anim) then
                        local idle = v.anim[1]
                        local dict = v.anim[2]

                        RequestAnimDict(idle)
						while (not HasAnimDictLoaded(idle)) do
							RequestAnimDict(idle)
							Citizen.Wait(10)
						end
						TaskPlayAnim(localPeds[k], idle, dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                    end
                else
                    if (v.anim) then
                        local idle = v.anim[1]
                        local dict = v.anim[2]
                        if (not IsEntityPlayingAnim(localPeds[k], idle, dict, 3 )) then
                            TaskPlayAnim(localPeds[k], idle, dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                end
            else
                if (localPeds[k]) then
					SetEntityAsMissionEntity(localPeds[k], false, false)
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
            end
        end
        Citizen.Wait(1500)
    end
end)
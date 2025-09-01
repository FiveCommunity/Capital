-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if (not LocalPlayer.state.BlockTasks and not LocalPlayer.state.usingItem) then
			if not IsPedInAnyVehicle(ped) and IsPedJumping(ped) then
				timeDistance = 5

				if IsControlJustReleased(1, 51) then
					local tackled = {}
					local coords = GetEntityForwardVector(ped)

					SetPedToRagdollWithFall(ped,1000,1000,0,coords,1.0,0.0,0.0,0.0,0.0,0.0,0.0)

					while IsPedRagdoll(ped) do
						for _,v in ipairs(touchedPlayers()) do
							if not tackled[v] then
								tackled[v] = true
								local sid = GetPlayerServerId(v)
								if sid then
									TriggerServerEvent("tackle:Update",GetPlayerServerId(v),coords)
								end
							end
						end

						Citizen.Wait(1)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tackle:Player",function(coords)
	SetPedToRagdollWithFall(PlayerPedId(),8000,8000,0,coords.x,coords.y,coords.z,10.0,0.0,0.0,0.0,0.0,0.0,0.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOUCHEDPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function touchedPlayers()
	local players = {}
	local ped = PlayerPedId()
	for k,v in ipairs(GetActivePlayers()) do
		local uPed = GetPlayerPed(v)
		if IsEntityTouchingEntity(ped,uPed) and not IsPedInAnyVehicle(uPed) then
			table.insert(players,v)
		end
	end
	return players
end
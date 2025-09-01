if config.modules["chest-system"] and config.modules["vault-system"] then
	--=======================================================================================================================================
	-- Chest Thread
	--=======================================================================================================================================
	local nearestChests = {}
	local threadStarted = false
	local ped, pedCoords = nil, vec3(0,0,0)

	local function startThread()
		if (threadStarted) then return; end;
		threadStarted = true

		Citizen.CreateThread(function()
			while (countTable(nearestChests) > 0) do
				for index, dist in pairs(nearestChests) do
					local cfg = config.staticChests.chests[index]
					Text3D(cfg.blip.x, cfg.blip.y, cfg.blip.z, '~b~E~w~ - BAÚ', 400)
					if (cfg.upgrade) then Text3D(cfg.blip.x, cfg.blip.y, cfg.blip.z-0.15, '~b~M~w~ - UPGRADE', 400); end;

					if (dist <= 1.5) and (GetEntityHealth(ped) > 100) then
						if (IsControlJustPressed(0, 38)) then
							sRP.tryOpenChest(index)
						elseif (IsControlJustPressed(0, 244)) and (cfg.upgrade) then
							sRP.tryUpgradeChest(index)
						end
					end
				end
				Citizen.Wait(4)
			end
			threadStarted = false
		end)
	end

	Citizen.CreateThread(function()
		while true do
			ped = PlayerPedId()
			pedCoords = GetEntityCoords(ped)

			nearestChests = {}
			
			if (not inventoryOpen) and (not IsPedInAnyVehicle(ped)) then
				for k, v in pairs(config.staticChests.chests) do
					local dist = #(pedCoords - v.blip)
					if (dist <= 5.0) then
						nearestChests[k] = dist
					end
				end
			end

			if (countTable(nearestChests) > 0) then startThread(); end;

			Citizen.Wait(1000)
		end
	end)

	Text3D = function(x,y,z,text,size)
        local onScreen,_x,_y = World3dToScreen2d(x,y,z)
        if onScreen then
            SetTextFont(4)
            SetTextScale(0.35,0.35)
            SetTextColour(255,255,255,155)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
            local factor = (string.len(text))/size
            DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
        end
    end
end
impData['mec:tow'] = nil
impData['mec:towed'] = nil

local BlacklistHash = {
	-- [GetHashKey('zentorno')] = 'Zentorno'
}

RegisterNetEvent('vTow',function()
	local vehicle = GetPlayersLastVehicle()
	if Impound.trucks[GetEntityModel(vehicle)] and not IsPedInAnyVehicle(PlayerPedId()) then
		
		impData['mec:towed'] = vRP.getNearestVehicle(7)
		
		if (not impData['mec:tow']) then
			if (GetPedInVehicleSeat(impData['mec:towed'], -1) ~= 0) then 
				return TriggerEvent('notify', 'Rebocar', 'Este <b>veículo</b> possui uma pessoa dentro!')
			end

			if (BlacklistHash[GetEntityModel(impData['mec:towed'])]) then
				return TriggerEvent('notify', 'Rebocar', 'Você não pode rebocar o <b>'..BlacklistHash[GetEntityModel(impData['mec:towed'])]..'</b>.')
			end
		else
			if (GetPedInVehicleSeat(impData['mec:tow'], -1) ~= 0) then 
				return TriggerEvent('notify', 'Rebocar', 'Este <b>veículo</b> possui uma pessoa dentro!')
			end
		end

		if IsEntityAVehicle(vehicle) and IsEntityAVehicle(impData['mec:towed']) then
			
			if #(GetEntityCoords(vehicle) - GetEntityCoords(impData['mec:towed'])) > 15.0 then
				return TriggerEvent('notify', 'Rebocar', 'Veiculo muito longe do Reboque!')
			end
			
			if (impData['mec:tow']) then
                TriggerServerEvent('trytow',VehToNet(vehicle),VehToNet(impData['mec:tow']),'out')
                impData['mec:towed'] = nil
				impData['mec:tow'] = nil
			else
				if (vehicle ~= impData['mec:towed']) then
					TriggerServerEvent('trytow',VehToNet(vehicle),VehToNet(impData['mec:towed']),'in')
					impData['mec:tow'] = impData['mec:towed']
                    --<impound>
					if (impData.inJob) and (Entity(impData['mec:towed']).state.impound) then
                        RemoveBlip(blip)
                        blipRoute(Impound[impData.inJob].save, 'Pátio')
                        TriggerEvent('notify', 'sucesso', 'Impound', 'Marcamos a localização do pátio no seu <b>GPS</b>. Leve o <b>veículo rebocado</b> até lá.', 8000)
                    end
					--</impound>
				end
			end
		end
		
	end
end)

RegisterNetEvent('synctow', function(vehid01,vehid02,mod)
	if NetworkDoesNetworkIdExist(vehid01) and NetworkDoesNetworkIdExist(vehid02) then
		local vehicle = NetToEnt(vehid01)
		local towed = NetToEnt(vehid02)
		if DoesEntityExist(vehicle) and DoesEntityExist(towed) then
			if mod == 'in' then
				local min,max = GetModelDimensions(GetEntityModel(towed))
				AttachEntityToEntity(towed,vehicle,GetEntityBoneIndexByName(vehicle,'bodyshell'),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
			elseif mod == 'out' then
				AttachEntityToEntity(towed,vehicle,20,-0.5,-14.0,-0.2,0.0,0.0,0.0,false,false,true,false,20,true)
				DetachEntity(towed,false,false)
			end
		end
	end
end)
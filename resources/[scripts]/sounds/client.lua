local default_reinforcement = 0.2

RegisterNetEvent('vrp_sounds:source')
AddEventHandler('vrp_sounds:source',function(sound,volume)
	SendNUIMessage({ transactionType = 'playSound', transactionFile = sound, transactionVolume = volume })
end)

RegisterNetEvent('vrp_sounds:distance')
AddEventHandler('vrp_sounds:distance',function(coord,maxdistance,sound,volume)
	local distance = #(GetEntityCoords(PlayerPedId()) - coord)
	if (distance <= maxdistance) then
		SendNUIMessage({ transactionType = 'playSound', transactionFile = sound, transactionVolume = volume })
	end
end)

RegisterNetEvent('vrp_sounds:fixed')
AddEventHandler('vrp_sounds:fixed',function(playerid,x2,y2,z2,maxdistance,sound,volume)
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local distance = GetDistanceBetweenCoords(x2,y2,z2,x,y,z,true)
	if distance <= maxdistance then
		SendNUIMessage({ transactionType = 'playSound', transactionFile = sound, transactionVolume = volume })
	end
end)

RegisterNetEvent('vrp_sounds:vehicle')
AddEventHandler('vrp_sounds:vehicle',function(veh,maxdistance,sound,reinforcement)
	if NetworkDoesEntityExistWithNetworkId(veh) then
		local v = NetToVeh(veh)
		if DoesEntityExist(v) then
			local distance = #( GetEntityCoords(PlayerPedId()) - GetEntityCoords(v) )	
			if distance <= maxdistance then
				local vol = (1 - (distance/maxdistance))+(reinforcement or default_reinforcement)
				if vol > 1 then	vol = 1 end		
				SendNUIMessage({ transactionType = 'playSound', transactionFile = sound, transactionVolume = tonumber(string.format("%.2f",vol)) })
			end
		end
	end
end)

RegisterNetEvent('vrp_sounds:variation:fixed')
AddEventHandler('vrp_sounds:variation:fixed',function(coords,maxdistance,sound,reinforcement)
	local distance = #( GetEntityCoords(PlayerPedId()) - coords )	
	if distance <= maxdistance then
		local vol = (1 - (distance/maxdistance))+(reinforcement or default_reinforcement)
		if vol > 1 then	vol = 1 end
		SendNUIMessage({ transactionType = 'playSound', transactionFile = sound, transactionVolume = tonumber(string.format("%.2f",vol)) })
	end
end)
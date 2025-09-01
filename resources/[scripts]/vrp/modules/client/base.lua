vRP.teleport = function(x, y, z)
	local ply = PlayerPedId()
	if string.find(type(x), 'vec') then x, y, z = table.unpack(x) end
	SetEntityCoords(PlayerPedId(), x+0.0001, y+0.0001, z+0.0001, 1, 0, 0, 1)
	vRPserver.updatePos(x, y, z)
    FreezeEntityPosition(ply, true)
    SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    while (not HasCollisionLoadedAroundEntity(ply)) do
        FreezeEntityPosition(ply, true)
        SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
        RequestCollisionAtCoord(x, y, z)
        Wait(500)
    end
    SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    FreezeEntityPosition(ply, false)
    Wait(1000)
end

vRP.isInside = function()
	local pCoord = GetEntityCoords(PlayerPedId())
	return not (GetInteriorAtCoords(pCoord.x, pCoord.y, pCoord.z) == 0)
end

vRP.getCamDirection = function()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end
	return x, y, z
end

vRP.getNearestPlayers = function(radius)
	local r = {}
	local pid = PlayerId()
	local pCDS = GetEntityCoords(PlayerPedId(),true)
	for _,player in pairs(GetActivePlayers()) do
		if (player ~= pid) and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local oCDS = GetEntityCoords(oped,true)
			local distance = #(pCDS - oCDS)
			if distance <= radius then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end

vRP.getNearestPlayer = function(radius)
	local p = nil
	local players = vRP.getNearestPlayers(radius)
	local min = radius+0.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end

local anims = {}
local anim_ids = Tools.newIDGenerator()
animActived = false

vRP.playAnim = function(upper, seq, looping)
	if seq.task then
		vRP.stopAnim(true)

		local ped = PlayerPedId()
		if seq.task == 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER' then
			local coords = GetEntityCoords(ped)
			TaskStartScenarioAtPosition(ped,seq.task,coords.x,coords.y,coords.z-1,GetEntityHeading(ped),0,0,false)
		else
			TaskStartScenarioInPlace(ped,seq.task,0,not seq.play_exit)
		end
	else
		vRP.stopAnim(upper)

		local flags = 0
		if upper then flags = flags+48 end
		if looping then flags = flags+1 end

		Citizen.CreateThread(function()
			local id = anim_ids:gen()
			anims[id] = true

			if (type(seq[1]) == 'string') then
				seq = {{seq[1],seq[2]}}
			end

			for k,v in pairs(seq) do
				local dict = v[1]
				local name = v[2]
				local loops = v[3] or 1

				for i=1,loops do
					if anims[id] then
						local first = (k == 1 and i == 1)
						local last = (k == #seq and i == loops)

						RequestAnimDict(dict)
						local i = 0
						while not HasAnimDictLoaded(dict) and i < 1000 do
							Citizen.Wait(10)
							RequestAnimDict(dict)
							i = i + 1
						end

						if HasAnimDictLoaded(dict) and anims[id] then
							local inspeed = 3.0
							local outspeed = -3.0
							if not first then inspeed = 2.0 end
							if not last then outspeed = 2.0 end

							TaskPlayAnim(PlayerPedId(),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
							if (not animActived) then DisableAnim(dict, name); end;
						end

						while GetEntityAnimCurrentTime(PlayerPedId(),dict,name) <= 0.95 and IsEntityPlayingAnim(PlayerPedId(),dict,name,3) and anims[id] do Citizen.Wait(1) end
					end
				end
			end
			anim_ids:free(id)
			anims[id] = nil
		end)
	end
end

DisableAnim = function(dict, name)
	if (animActived) then return; end;
	animActived = true
	Citizen.CreateThread(function()
		while (IsEntityPlayingAnim(PlayerPedId(), dict, name, 3)) do
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0, 37, true) -- Tecla Tab
			BlockWeaponWheelThisFrame()
			DisableControlAction(0, 29, true)
			DisableControlAction(0, 47, true)
			DisableControlAction(0, 56, true)
			DisableControlAction(0, 57, true)
			DisableControlAction(0, 73, true)
			DisableControlAction(0, 137, true)
			DisableControlAction(0, 166, true)
			DisableControlAction(0, 169, true)
			DisableControlAction(0, 170, true)
			DisableControlAction(0, 182, true)
			DisableControlAction(0, 187, true)
			DisableControlAction(0, 188, true)
			DisableControlAction(0, 189, true)
			DisableControlAction(0, 190, true)
			DisableControlAction(0, 243, true)
			DisableControlAction(0, 245, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 288, true)
			DisableControlAction(0, 289, true)
			DisableControlAction(0, 311, true)
			DisableControlAction(0, 344, true)		
			DisablePlayerFiring(PlayerPedId(), true)
			Citizen.Wait(1)
		end
		animActived = false
	end)
end

vRP.stopAnim = function(upper)
	anims = {}
	if upper then
		ClearPedSecondaryTask(PlayerPedId())
	else
		ClearPedTasks(PlayerPedId())
	end
	LocalPlayer.state.PlayAnim = false
end

vRP.playSound = function(dict, name)
	PlaySoundFrontend(-1, dict, name, false)
end

vRP.playScreenEffect = function(name, duration)
	if duration < 0 then
		StartScreenEffect(name,0,true)
	else
		StartScreenEffect(name,0,true)

		Citizen.CreateThread(function()
			Citizen.Wait(math.floor((duration+1)*1000))
			StopScreenEffect(name)
		end)
	end
end

Citizen.CreateThread(function()
    while true do
        if NetworkIsSessionStarted() then
            TriggerServerEvent("Queue:playerActivated")
            return
        end
        Citizen.Wait(30000)
    end
end)
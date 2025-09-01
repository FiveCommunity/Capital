local cli = {}
Tunnel.bindInterface('Commands', cli) 
local vSERVER = Tunnel.getInterface('Commands')

local CommandsData = {}

---------------------------------------
-- TOOGLE
---------------------------------------
local toogle = {
	{ coord = vector3(-1246.075, -2140.457, 14.18237), config = 'FT' },
	{ coord = vector3(-1120.76, -2274.646, 14.56995), config = 'Rota' },
	{ coord = vector3(-589.2527, -1026.633, 22.38831), config = 'PMC' },
	{ coord = vector3(-454.2462, 5984.967, 31.45349), config = 'BAEP' },
	{ coord = vector3(2597.552, 5335.648, 47.66296), config = 'PRF' },
	{ coord = vector3(440.6505, -981.1912, 30.67834), config = 'PC' },
	{ coord = vector3(960.2242, -953.433, 43.48425), config = 'Borracharia' },
	{ coord = vector3(1766.954, 3319.859, 41.42859), config = 'MecanicoNorte' },
	{ coord = vector3(1731.547, 3487.411, 36.76123), config = 'CUS' },
	{ coord = vector3(-2057.75, -475.3846, 21.81543), config = 'CUS' },
	{ coord = vector3(-571.1868, 7377.719, 8.504028), config = 'CUS' },
	{ coord = vector3(705.4681, 256.8528, 97.90918), config = 'GCC' },
	{ coord = vector3(233.433, -417.6923, 48.08423), config = 'Juridico' },
	{ coord = vector3(1167.705, 2651.96, 38.66516), config = 'Bracho' },
	{ coord = vector3(-1874.07, 3260.98, 32.93628), config = 'Exercito' },
	{ coord = vector3(-59.26154, -4842.237, 21.61316), config = 'PCP' },
	{ coord = vector3(-179.4857, -5116.813, 6.751709), config = 'CUS' }, -- Cidade perfeita
}

Citizen.CreateThread(function()
    for _, v in pairs(toogle) do
        TriggerEvent('insert:hoverfy', v.coord, 'E', 'Bater ponto', 2.5)
    end
end)

local nearestToogle = function()
	local pCoord = GetEntityCoords(PlayerPedId())
	for _, v in pairs(toogle) do
		local distance = #(pCoord - v.coord)
		if (distance <= 2.5) then
			return v.config
		end
	end
	return false
end

RegisterCommand('+joinInService', function()
	local toogleConfig = nearestToogle()
	if (toogleConfig) then
		vSERVER.startToogle(toogleConfig)
	end
end)
RegisterKeyMapping('+joinInService', 'Entrar/Sair de serviço', 'keyboard', 'E')
---------------------------------------
-- ANTI CL
---------------------------------------
local pExitCDS = vector3(0.0,0.0,-100.0)
Citizen.CreateThread(function()
	while (true) do
		pExitCDS = GetEntityCoords(PlayerPedId())
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent('gb:playerExit', function(user_id, reason, drawCDS)
	if (drawCDS) then
		if reason and #(pExitCDS - drawCDS) <= 500 then
			local banned = false;
			if (string.find(reason, 'banido')) or (string.find(reason, 'kikado')) then banned = true; end;

			local draw = true
			local str = (not banned and '\nPASSAPORTE: ~b~'..user_id..'~w~\nMOTIVO: ~b~'..reason..'~w~' or '')
			if (string.len(str) >= 94) then
				str = string.sub(str,1,94)..'...'
			end
			Citizen.SetTimeout(15000, function() draw = false; end)	
			while (draw) do
				local _sleep = 500
				if #(pExitCDS - drawCDS) <= 15 then
					_sleep = 1
					DrawText3Ds(drawCDS.x, drawCDS.y, drawCDS.z, str)
				end
				Citizen.Wait(_sleep)
			end
		end
	end
end)
---------------------------------------
-- ME
---------------------------------------
local display = false;

RegisterNetEvent('DisplayMe', function(text, source)
	local ply = PlayerPedId()
	local id = GetPlayerFromServerId(source)
    if (id == -1) or (display) or (GetEntityHealth(ply) <= 100) then return; end;
	display = true

	Citizen.SetTimeout(10000, function() display = false; end)
	
	Citizen.CreateThread(function()
		while (display) do
			local ply = PlayerPedId()

			local meCoords = GetEntityCoords(GetPlayerPed(id))
			local plyCoords = GetEntityCoords(ply)

			local dist = #(meCoords - plyCoords)
			if (dist <= 30.0) then
				Text3D(meCoords.x, meCoords.y, meCoords.z+1.1, '[LIBRAS] '..text, 300)
			end
			Citizen.Wait(1)
		end
	end)
end)

Text3D = function(x,y,z,text,size)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	if onScreen then
		SetTextFont(4)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,200)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text))/size
		DrawRect(_x,_y+0.0125,0.01+factor,0.03,255, 102, 102,155)
	end
end

---------------------------------------
-- NEYMAR
---------------------------------------
RegisterNetEvent('ney')
AddEventHandler('ney',function()
	local ped = PlayerPedId()
	SetPedToRagdollWithFall(ped, 1500, 2000, 0, GetEntityForwardVector(ped), 1.0, 0, 0, 0, 0, 0, 0)
end)

---------------------------------------
-- ANTI-AFK SYSTEM
---------------------------------------
CommandsData['afk:coords'] = {}

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1000)
		if (LocalPlayer.state.Active) then
			local pCDS = GetEntityCoords(PlayerPedId())
			if (pCDS.x == CommandsData['afk:coords'].x) and (pCDS.y == CommandsData['afk:coords'].y) then
				if (CommandsData['afk:timer'] > 0) then
					CommandsData['afk:timer'] = CommandsData['afk:timer'] - 1
				else
					TriggerServerEvent('afk:kick')
				end
			else
				CommandsData['afk:timer'] = 900
			end
			if (pCDS ~= CommandsData['afk:coords']) then CommandsData['afk:coords'] = pCDS; end;
		end
    end
end)

RegisterNetEvent('afk:reset',function()
	CommandsData['afk:timer'] = 900
end)
---------------------------------------
-- WALL
---------------------------------------
--LocalPlayer.state:set('Wall', false, true)
--
--CommandsData['players'] = {}
--AddStateBagChangeHandler('Wall', nil, function(bagName, key, value) 
--    local entity = GetPlayerFromStateBagName(bagName)
--    if (entity == 0) then return; end;
--
--        if (value) then
--
--        Citizen.CreateThread(function()
--            while (LocalPlayer.state.Wall) do
--				local ped = PlayerPedId()
--				local pCoord = GetEntityCoords(ped)
--
--				for _, id in ipairs(GetActivePlayers()) do
--					if NetworkIsPlayerActive(id) then
--						local ply = GetPlayerPed(id)
--						if ply and (ply ~= ped) then
--							local serverId = GetPlayerServerId(id)
--							local eCoord = GetEntityCoords(ply)
--
--							local distance = #(pCoord - eCoord)
--							if (distance <= 150) then
--								if (ply ~= -1 and CommandsData['players'][serverId]) then
--									local text = (CommandsData['players'][serverId].cam and '\n~b~CAM:~w~ ATIVADO' or '')
--									DrawText3Ds(eCoord.x, eCoord.y, eCoord.z+1.3, '~b~ID:~w~ '..CommandsData['players'][serverId].id..'\n~b~VIDA:~w~ '..GetEntityHealth(ply)..'\n~b~NOME:~w~ '..(CommandsData['players'][serverId].name or GetPlayerName(id) or 'NÃO IDENTIFICADO')..text)
--								end
--							end
--						end
--					end
--				end
--				Citizen.Wait(1)
--            end
--        end)
--
--		Citizen.CreateThread(function()
--            while (LocalPlayer.state.Wall) do
--                for _, id in ipairs(GetActivePlayers()) do
--					local serverId = GetPlayerServerId(id)
--					if (serverId > 0) then
--						local uid, cam, name = vSERVER.getWallId(GetPlayerServerId(id))
--						
--						if (not CommandsData['players'][serverId]) or (CommandsData['players'][serverId].id ~= uid) then
--							CommandsData['players'][serverId] = { id = uid, cam = cam, name = name } 
--						end
--					end
--					Citizen.Wait(10)
--				end
--                Citizen.Wait(1500)
--            end
--        end)
--    end
--end)

---------------------------------------
-- TPWAY
---------------------------------------
cli.tpToWayFunction = function()
	local entity = PlayerPedId()
	if IsPedInAnyVehicle(entity) then entity = GetVehiclePedIsUsing(entity); end;
	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))
    local ground
    local groundFound = false
    local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

    for i,height in ipairs(groundCheckHeights) do
        SetEntityCoordsNoOffset(entity,x,y,height,0,0,1)

        RequestCollisionAtCoord(x,y,z)
        while not HasCollisionLoadedAroundEntity(entity) do
            RequestCollisionAtCoord(x,y,z)
            Citizen.Wait(1)
        end
        Citizen.Wait(20)

        ground,z = GetGroundZFor_3dCoord(x,y,height)
        if ground then
            z = z + 1.0
            groundFound = true
            break;
        end
    end

    if not groundFound then
        z = 1200
        GiveDelayedWeaponToPed(PlayerPedId(),0xFBAB5776,1,0)
    end

    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(entity) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end

    SetEntityCoordsNoOffset(entity,x,y,z,0,0,1)
end

---------------------------------------
-- COMMANDS
---------------------------------------
RegisterNetEvent('gb_commands_police:clothes', function(part)
    local ped = PlayerPedId()
    if (part == 'rmascara') then
	    SetPedComponentVariation(ped, 1, 0, 0, 2)
		-- exports.appearance:fixAppearance(ped)
    elseif (part == 'rchapeu') then
        ClearPedProp(ped, 0)
    end
end)

---------------------------------------
-- CONE
---------------------------------------
RegisterNetEvent('cone', function(arg)
    local ped = PlayerPedId()
	local coord = GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,-0.94)
	local heading = GetEntityHeading(ped)
    
	local prop = `prop_mp_cone_02`
	RequestModel(prop)
	while not HasModelLoaded(prop) do
		RequestModel(prop)
		Citizen.Wait(100)
	end

	if (not arg) then
		local cone = CreateObject(prop,coord.x,coord.y,coord.z-0.5,true,true,true)
		SetEntityHeading(cone,heading)
		PlaceObjectOnGroundProperly(cone)
		SetEntityAsMissionEntity(cone,true,true)
		FreezeEntityPosition(cone,true)
		SetModelAsNoLongerNeeded(cone)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,1.9,prop,true) then
			local cone = GetClosestObjectOfType(coord.x,coord.y,coord.z,1.9,prop,false,false,false)
			if (cone > 0) then
				TriggerServerEvent('trydeleteobj',ObjToNet(cone))
				vSERVER.giveInventoryItem('cone')
			end
		end
	end
end)

---------------------------------------
-- BARREIRA
---------------------------------------
RegisterNetEvent('barreira', function(arg)
    local ped = PlayerPedId()
	local coord = GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,-0.94)
	local heading = GetEntityHeading(ped)
	local prop = `prop_mp_barrier_02b`
	RequestModel(prop)
	while not HasModelLoaded(prop) do
		RequestModel(prop)
		Citizen.Wait(100)
	end
	if (not arg) then
		local barrier = CreateObject(prop,coord.x,coord.y,coord.z-0.5,true,true,true)
		SetEntityHeading(barrier,heading)
		PlaceObjectOnGroundProperly(barrier)
		SetEntityAsMissionEntity(barrier,true,true)
		FreezeEntityPosition(barrier,true)
		SetModelAsNoLongerNeeded(barrier)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z-0.5,1.9,prop,true) then
			local barrier = GetClosestObjectOfType(coord.x,coord.y,coord.z,1.9,prop,false,false,false)
			if (barrier > 0) then
				TriggerServerEvent('trydeleteobj',ObjToNet(barrier))
				vSERVER.giveInventoryItem('barreira')
			end
		end
	end
end)

---------------------------------------
-- CAR COLOR
---------------------------------------
RegisterNetEvent('gb_core:carcolor', function(veh, r, g, b, prim)
    if (IsEntityAVehicle(veh)) then
        if (prim) then
            SetVehicleCustomPrimaryColour(veh, r, g, b)    
        else
            SetVehicleCustomSecondaryColour(veh, r, g, b)
        end
    end
end)

---------------------------------------
-- UNCUFF
---------------------------------------
RegisterNetEvent('gb_core:uncuff', function()
	local ped = PlayerPedId()
	vRP._setHandcuffed(false)
	SetPedComponentVariation(ped,7,0,0,2)
end)

---------------------------------------
-- SYNCAREA
---------------------------------------
RegisterNetEvent('syncarea', function(x, y, z, radius)
    ClearAreaOfVehicles(x, y, z, (radius or 2000.0), false, false, false, false, false)
    ClearAreaOfEverything(x, y, z, (radius or 2000.0), false, false, false, false)
end)

---------------------------------------
-- SKIN
---------------------------------------
cli.skinModel = function(mhash)
    while (not HasModelLoaded(mhash)) do RequestModel(mhash); Citizen.Wait(1); end;
    if (HasModelLoaded(mhash)) then
        SetPlayerModel(PlayerId(), mhash)     
        SetPedDefaultComponentVariation(PlayerPedId())
    end
    SetModelAsNoLongerNeeded(mhash)
end

---------------------------------------
-- DELNPCS
---------------------------------------
RegisterNetEvent('gb_core:delnpcs', function()
    for _, ped in ipairs(GetGamePool('CPed')) do
        if (not IsPedAPlayer(ped)) then
			TriggerServerEvent('trydeleteped', PedToNet(ped))
		end
    end
end)

---------------------------------------
-- TUNING
---------------------------------------
RegisterNetEvent('gb_core:tuning', function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if (IsEntityAVehicle(vehicle)) then
		SetVehicleModKit(vehicle,0)
		--SetVehicleWheelType(vehicle,7)
		SetVehicleCustomPrimaryColour(vehicle, 3, 187, 232)    
		SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
		SetVehicleMod(vehicle, 0, GetNumVehicleMods(vehicle, 0) - 1, false)
		SetVehicleMod(vehicle, 1, GetNumVehicleMods(vehicle, 1) - 1, false)
		SetVehicleMod(vehicle, 2, GetNumVehicleMods(vehicle, 2) - 1, false)
		SetVehicleMod(vehicle, 3, GetNumVehicleMods(vehicle, 3) - 1, false)
		SetVehicleMod(vehicle, 4, GetNumVehicleMods(vehicle, 4) - 1, false)
		SetVehicleMod(vehicle, 5, GetNumVehicleMods(vehicle, 5) - 1, false)
		SetVehicleMod(vehicle, 6, GetNumVehicleMods(vehicle, 6) - 1, false)
		SetVehicleMod(vehicle, 7, GetNumVehicleMods(vehicle, 7) - 1, false)
		SetVehicleMod(vehicle, 8, GetNumVehicleMods(vehicle, 8) - 1, false)
		SetVehicleMod(vehicle, 9, GetNumVehicleMods(vehicle, 9) - 1, false)
		SetVehicleMod(vehicle, 10, GetNumVehicleMods(vehicle, 10) -1, false)
		SetVehicleMod(vehicle, 11, GetNumVehicleMods(vehicle, 11) -1, false)
		SetVehicleMod(vehicle, 12, GetNumVehicleMods(vehicle, 12) -1, false)
		SetVehicleMod(vehicle, 13, GetNumVehicleMods(vehicle, 13) -1, false)
		SetVehicleMod(vehicle, 14, 16, false)
		SetVehicleMod(vehicle, 15, GetNumVehicleMods(vehicle, 15) -2, false)
		SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16) -1, false)
		ToggleVehicleMod(vehicle, 17, true)
		ToggleVehicleMod(vehicle, 18, true)
		ToggleVehicleMod(vehicle, 19, true)
		ToggleVehicleMod(vehicle, 20, true)
		ToggleVehicleMod(vehicle, 21, true)
		ToggleVehicleMod(vehicle, 22, true)
		--SetVehicleMod(vehicle,23,1,false)
		SetVehicleMod(vehicle, 24, 1, false)
		SetVehicleMod(vehicle, 25, GetNumVehicleMods(vehicle, 25) -1, false)
		SetVehicleMod(vehicle, 27, GetNumVehicleMods(vehicle, 27) -1, false)
		SetVehicleMod(vehicle, 28, GetNumVehicleMods(vehicle, 28) -1, false)
		SetVehicleMod(vehicle, 30, GetNumVehicleMods(vehicle, 30) -1, false)
		--SetVehicleMod(vehicle,33,GetNumVehicleMods(vehicle,33)-1,false)
		SetVehicleMod(vehicle, 34, GetNumVehicleMods(vehicle,34) -1, false)
		SetVehicleMod(vehicle, 35, GetNumVehicleMods(vehicle,35) -1, false)
		SetVehicleMod(vehicle, 38, GetNumVehicleMods(vehicle,38) -1, true)
        SetVehicleWindowTint(vehicle, 1)
        --SetVehicleTyresCanBurst(vehicle,false)
    	-- SetVehicleNumberPlateText(vehicle, '')
        --SetVehicleNumberPlateTextIndex(vehicle,5)
	end
end)

---------------------------------------
-- DEBUG
---------------------------------------
CommandsData['debug'] = false
RegisterNetEvent('gb_core:debug', function()
	CommandsData['debug'] = not CommandsData['debug']
    if (CommandsData['debug']) then
        debugThread()
		TriggerEvent('notify', 'Debug', 'O <b>debug</b> foi ativado.')
    else
        TriggerEvent('notify', 'Debug', 'O <b>debug</b> foi desativado.')
    end
end)

CommandsData['closestObject'] = 0

RegisterCommand('debugobj', function()
    if (CommandsData['debug']) then TriggerEvent('clipboard', 'Nearest Hash', tostring(CommandsData['closestObject'])); end;
end)

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z']+1, 'Veh: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. ' IN CONTACT' )
	    	else
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z']+1, 'Veh: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. '' )
	    	end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local closestDist = 10
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then

            if distance < closestDist then
                closestDist = distance
                CommandsData['closestObject'] = GetEntityModel(ped)
            end

            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z']+1, 'Obj: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. ' IN CONTACT' )
	    	else
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z']+1, 'Obj: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. '' )
	    	end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z'], 'Ped: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. ' Relationship HASH: ' .. GetPedRelationshipGroupHash(ped) .. ' IN CONTACT' )
	    	else
	    		DebugDrawText3Ds(pos['x'],pos['y'],pos['z'], 'Ped: ' .. ped .. ' Model: ' .. GetEntityModel(ped) .. ' Relationship HASH: ' .. GetPedRelationshipGroupHash(ped) )
	    	end

        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

function debugThread()
    Citizen.CreateThread(function()
        while (CommandsData['debug']) do 
            local idle = 1000 
            if (CommandsData['debug']) then
                idle = 1
                local pos = GetEntityCoords(GetPlayerPed(-1))

                local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
                local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
                local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
                local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0) 

                local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
                local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
                local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
                local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)    

                local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
                currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

                DebugdrawTxtS(0.8, 0.50, 0.4,0.4,0.30, 'Heading: ' .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.52, 0.4,0.4,0.30, 'Coords: ' .. pos, 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.54, 0.4,0.4,0.30, 'Attached Ent: ' .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.56, 0.4,0.4,0.30, 'Health: ' .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.58, 0.4,0.4,0.30, 'H a G: ' .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.60, 0.4,0.4,0.30, 'Model: ' .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.62, 0.4,0.4,0.30, 'Speed: ' .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.64, 0.4,0.4,0.30, 'Frame Time: ' .. GetFrameTime(), 55, 155, 55, 255)
                DebugdrawTxtS(0.8, 0.66, 0.4,0.4,0.30, 'Street: ' .. currentStreetName, 55, 155, 55, 255)
                
                
                DrawLine(pos,forPos, 0,255,255,115)
                DrawLine(pos,backPos, 0,255,255,115)

                DrawLine(pos,LPos, 255,255,0,115)
                DrawLine(pos,RPos, 255,255,0,115)

                DrawLine(forPos,forPos2, 255,0,255,115)
                DrawLine(backPos,backPos2, 255,0,255,115)

                DrawLine(LPos,LPos2, 255,255,255,115)
                DrawLine(RPos,RPos2, 255,255,255,115)

                local nearped = getNPC()
                local veh = GetVehicle()
                local nearobj = GetObject()
            end
            Citizen.Wait(idle)
        end
    end)
end

DebugdrawTxtS = function(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

DebugDrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

---------------------------------------
-- TERREMOTO
---------------------------------------
CommandsData['terremoto'] = false

RegisterNetEvent('gb_core:terremoto', function()
	CommandsData['terremoto'] = true
	Citizen.CreateThread(function()
		while (CommandsData['terremoto']) do
			ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
			Citizen.Wait(500)
		end
	end)
end)

---------------------------------------
-- FPS
---------------------------------------
RegisterCommand('fps', function(source, args)
	if (args[1]) then
		local command = string.lower(args[1])
		if (command == 'on') then
			LocalPlayer.state.FPS = true
			SetTimecycleModifier('cinema')
			RopeDrawShadowEnabled(false)
			CascadeShadowsClearShadowSampleType()
			CascadeShadowsSetAircraftMode(false)
			CascadeShadowsEnableEntityTracker(true)
			CascadeShadowsSetDynamicDepthMode(false)
			CascadeShadowsSetEntityTrackerScale(0.0)
			CascadeShadowsSetDynamicDepthValue(0.0)
			CascadeShadowsSetCascadeBoundsScale(0.0)
			SetFlashLightFadeDistance(0.0)
			SetLightsCutoffDistanceTweak(0.0)
			TriggerEvent('notify', 'FPS', 'Boost de <b>FPS</b> ligado.')
		elseif (command == 'off') then
			LocalPlayer.state.FPS = false
			SetTimecycleModifier('default')
			RopeDrawShadowEnabled(true)
			CascadeShadowsSetAircraftMode(true)
			CascadeShadowsEnableEntityTracker(false)
			CascadeShadowsSetDynamicDepthMode(true)
			CascadeShadowsSetEntityTrackerScale(5.0)
			CascadeShadowsSetDynamicDepthValue(5.0)
			CascadeShadowsSetCascadeBoundsScale(5.0)
			SetFlashLightFadeDistance(10.0)
			SetLightsCutoffDistanceTweak(10.0)
			TriggerEvent('notify', 'FPS', 'Boost de <b>FPS</b> desligado.')
		else
			TriggerEvent('notify', 'FPS', 'Você não digitou o comando corretamente, tente novamente!<br><br>- <b>/fps on</b><br>- <b>/fps off</b>')
		end
	else
		TriggerEvent('notify', 'FPS', 'Você não digitou o comando corretamente, tente novamente!<br><br>- <b>/fps on</b><br>- <b>/fps off</b>')
	end
end)

---------------------------------------
-- VTUNING
---------------------------------------
RegisterCommand('vtuning', function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if (IsEntityAVehicle(vehicle)) then
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		local motor = GetVehicleMod(vehicle, 11)
		if (motor == -1) then
			motor = 'Desativado'
		else
			motor = 'Nível '..(motor + 1)..' / '..GetNumVehicleMods(vehicle, 11)
		end

		local freio = GetVehicleMod(vehicle, 12)
		if (freio == -1) then
			freio = 'Desativado'
		else
			freio = 'Nível '..(freio + 1)..' / '..GetNumVehicleMods(vehicle, 12)
		end

		local transmissao = GetVehicleMod(vehicle, 13)
		if (transmissao == -1) then
			transmissao = 'Desativado'
		else
			transmissao = 'Nível '..(transmissao + 1)..' / '..GetNumVehicleMods(vehicle, 13)
		end

		local suspensao = GetVehicleMod(vehicle, 15)
		if (suspensao == -1) then
			suspensao = 'Desativado'
		else
			suspensao = 'Nível '..(suspensao + 1)..' / '..GetNumVehicleMods(vehicle, 15)
		end

		local blindagem = GetVehicleMod(vehicle, 16)
		if (blindagem == -1) then
			blindagem = 'Desativado'
		else
			blindagem = 'Nível '..(blindagem + 1)..' / '..GetNumVehicleMods(vehicle, 16)
		end

		TriggerEvent('notify', 'Ver Tunagens', '<b>Motor:</b> '..motor..'<br><b>Freio:</b> '..freio..'<br><b>Transmissão:</b> '..transmissao..'<br><b>Suspensão:</b> '..suspensao..'<br><b>Blindagem:</b> '..blindagem..'<br><b>Chassi:</b> '..parseInt(body/10)..'%<br><b>Engine:</b> '..parseInt(engine/10)..'%<br><b>Gasolina:</b> '..parseInt(fuel)..'%', 15000)
	end
end)

---------------------------------------
-- ROCKSTAR EDITOR
---------------------------------------
cli.stopAndSave = function()
	if (IsRecording()) then
		StopRecordingAndSaveClip()
	end
end

cli.openEditor = function()
	NetworkSessionLeaveSinglePlayer()
	ActivateRockstarEditor()
end

cli.Discard = function()
	if (IsRecording()) then
		StopRecordingAndDiscardClip()
	end
end

cli.StartEditor = function()
	StartRecording(1)
end

---------------------------------------
-- BVIDA
---------------------------------------
local nextExecute = 0

RegisterCommand('bvida', function()
	local ped = PlayerPedId()
	if (LocalPlayer.state.BlockTasks or LocalPlayer.state.Handcuff or LocalPlayer.state.StraightJacket or vRP.isDied()) then return; end;

	if (vRP.isMalas()) then
		TriggerEvent('notify', 'Bvida', 'Você não pode executar este <b>comando</b> dentro de um veículo')
		return
	end

	if (IsPedFalling(ped)) then
		TriggerEvent('notify', 'Bvida', 'Você não pode executar este comando em <b>queda livre</b>. <br><br>Boa queda amigão, tenha uma boa morte! ;)</b>')
		return
	end

	if (IsPedInAnyVehicle(ped)) then
		TriggerEvent('notify', 'Bvida', 'Você não pode executar este <b>comando</b> dentro de um veículo')
		return
	end

	if (nextExecute > 0) and (GetGameTimer() < nextExecute) then
		TriggerEvent('notify', 'Bvida', 'Aguarde <b>'..math.floor( (nextExecute-GetGameTimer()) / 1000 )..' segundos</b> para utilizar este comando novamente.')
		return
	end

	nextExecute = GetGameTimer()+30000

	if not IsEntityPlayingAnim(ped, 'anim@heists@ornate_bank@grab_cash_heels','grab', 3) and not IsEntityPlayingAnim(ped, 'mini@repair','fixing_a_player', 3) and not IsEntityPlayingAnim(ped, 'amb@medic@standing@tendtodead@idle_a','idle_a', 3) and not IsEntityPlayingAnim(ped, 'oddjobs@shop_robbery@rob_till','loop', 3) and not IsEntityPlayingAnim(ped, 'amb@world_human_sunbathe@female@back@idle_a','idle_a', 3) then
		exports.inventory:cleanWeapons()
		vSERVER.Bvida()
		vRP.DeletarObjeto()
	end
end)

---------------------------------------
-- SEQUESTRO
---------------------------------------
cli.checkSequestro = function()
	local pVehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.0, 0, 71)
    if (DoesEntityExist(pVehicle)) then
        local trunkBone = GetEntityBoneIndexByName(pVehicle, 'boot')
		return trunkBone
	end
end

---------------------------------------
-- ROUPAS
---------------------------------------
--[[
local noSkin = function(ped)
	if (GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') or GetEntityModel(ped) == GetHashKey('mp_f_freemode_01')) then
		return true
	end
	TriggerEvent('notify', 'Skin', 'Você não pode utilizar este comando com <b>skin</b> personalizada.')
	return false
end

RegisterCommand('chapeu', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or nil)
		local color = (args[2] and parseInt(args[2]) or 0)

		if (not number) then
			vRP.playAnim(true, {{ 'veh@common@fp_helmet@', 'take_off_helmet_stand' }}, false)
			Citizen.Wait(700)
			ClearPedTasks(ped)
			ClearPedProp(ped, 0)
		else
			vRP.playAnim(true, {{ 'veh@common@fp_helmet@', 'put_on_helmet' }}, false)
			Citizen.Wait(1700)
			ClearPedTasks(ped)
			SetPedPropIndex(ped, 0, number, color, 2)
		end
	end
end)

RegisterCommand('mascara', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or 0)
		local color = (args[2] and parseInt(args[2]) or 0)
		local timeout = 1500

		if (number == 0) then
			timeout = 1100
			vRP.playAnim(true, {{ 'missfbi4', 'takeoff_mask' }}, false)
		else
			vRP.playAnim(true, {{ 'misscommon@van_put_on_masks', 'put_on_mask_ps' }}, false)
		end

		Citizen.SetTimeout(timeout, function()
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 1, number, color, 2)
		end)	
	end
end)

RegisterCommand('oculos', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or nil)
		local color = (args[2] and parseInt(args[2]) or 0)

		if (not number) then
			vRP.playAnim(true, {{ 'mini@ears_defenders', 'takeoff_earsdefenders_idle' }}, false)
			Citizen.Wait(500)
			ClearPedTasks(ped)
			ClearPedProp(ped, 1)
		else
			vRP.playAnim(true, {{ 'misscommon@van_put_on_masks', 'put_on_mask_ps' }}, false)
			Citizen.Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped, 1, number, color, 2)
		end
	end
end)

RegisterCommand('jaqueta', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or 15)
		local color = (args[2] and parseInt(args[2]) or 0)
		vRP.playAnim(true, { { 'clothingshirt', 'try_shirt_positive_d' } }, false)
		Citizen.SetTimeout(2500, function()
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 11, number, color, 2)
		end)	
	end
end)

RegisterCommand('blusa', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or 15)
		local color = (args[2] and parseInt(args[2]) or 0)
		vRP.playAnim(true, { { 'clothingshirt', 'try_shirt_positive_d' } }, false)
		Citizen.SetTimeout(2500, function()
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 8, number, color, 2)
		end)	
	end
end)

RegisterCommand('colete', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or 0)
		local color = (args[2] and parseInt(args[2]) or 0)
		vRP.playAnim(true, { { 'clothingshirt', 'try_shirt_positive_d' } }, false)
		Citizen.SetTimeout(2500, function()
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 9, number, color, 2)
		end)	
	end
end)

RegisterCommand('mochila', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or 0)
		local color = (args[2] and parseInt(args[2]) or 0)
		vRP.playAnim(true, { { 'clothingshirt', 'try_shirt_positive_d' } }, false)
		Citizen.SetTimeout(2500, function()
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 5, number, color, 2)
		end)	
	end
end)

RegisterCommand('maos', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or 15)
		local color = (args[2] and parseInt(args[2]) or 0)
		vRP.playAnim(true, { { 'clothingshirt', 'try_shirt_positive_d' } }, false)
		Citizen.SetTimeout(2500, function()
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 3, number, color, 2)
		end)	
	end
end)

RegisterCommand('calca', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local _defaultClothes = {
			[GetHashKey('mp_m_freemode_01')] = 18,
			[GetHashKey('mp_f_freemode_01')] = 15,
		}

		local number = (args[1] and parseInt(args[1]) or _defaultClothes[GetEntityModel(ped)])
		local color = (args[2] and parseInt(args[2]) or 0)
		vRP.playAnim(true, { { 'clothingshirt', 'try_shirt_positive_d' } }, false)
		Citizen.SetTimeout(2500, function()
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 4, number, color, 2)
		end)	
	end
end)

RegisterCommand('acessorios', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local number = (args[1] and parseInt(args[1]) or 0)
		local color = (args[2] and parseInt(args[2]) or 0)
		SetPedComponentVariation(ped, 7, number, color, 2)
	end
end)

RegisterCommand('sapatos', function(source, args)
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100 and noSkin(ped)) and vSERVER.checkClothesPermission('vip.permissao') then
		local _defaultClothes = {
			[GetHashKey('mp_m_freemode_01')] = 34,
			[GetHashKey('mp_f_freemode_01')] = 35,
		}

		local number = (args[1] and parseInt(args[1]) or _defaultClothes[GetEntityModel(ped)])
		local color = (args[2] and parseInt(args[2]) or 0)
		vRP.playAnim(true, { { 'clothingshoes', 'try_shoes_positive_d' } }, false)
		Citizen.SetTimeout(2200, function()
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 6, number, color, 2)
		end)	
	end
end)
]]
---------------------------------------
-- GET VEHICLE CLASS
---------------------------------------
cli.GetVehicleClass = function(vehicle)
	return GetVehicleClass(vehicle)
end
---------------------------------------
-- SPECTATOR
---------------------------------------
RegisterNetEvent("vrp_admin:spec", function(nsource)
    if (not NetworkIsInSpectatorMode()) and nsource then
		local playerId = GetPlayerFromServerId(nsource)
		if playerId > 0 then
			local nped = GetPlayerPed(playerId)
			NetworkSetInSpectatorMode(true, nped)
			TriggerEvent("Notify", "sucesso", "Spec", "Você entrou no modo espectador.")
		end
    else
        NetworkSetInSpectatorMode(false)
        TriggerEvent("Notify", "negado", "Spec", "Você saiu do modo espectador.") 
    end
end)


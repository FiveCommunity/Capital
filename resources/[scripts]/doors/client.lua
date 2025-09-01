local vSERVER = Tunnel.getInterface('Doors')

RegisterNetEvent('gb_doors:statusSend',function(i,status)
	if (i ~= nil and status ~= nil) then
		Doors[i].lock = status

        DoorSystemSetDoorState(Doors[i].identifier, status)

        if Doors[i].identifier_2 then
            DoorSystemSetDoorState(Doors[i].identifier_2, status)
        end
	end
end)

RegisterNetEvent('gb_doors:initialize', function(doorsOpened)
    local identifierDoor = 0
    for index, door in pairs(Doors) do
        identifierDoor = identifierDoor + 1

        local statusDoor

        if doorsOpened[index] then
            door.lock = false
            statusDoor = false
        else
            statusDoor = door.lock and true or false
        end

        if door.door_1 then
            AddDoorToSystem(identifierDoor, door.hash, door.door_1)
            DoorSystemSetDoorState(identifierDoor, statusDoor)
            door.identifier = identifierDoor

            identifierDoor = identifierDoor + 1

            door.identifier_2 = identifierDoor

            AddDoorToSystem(identifierDoor, door.other, door.door_2)
            DoorSystemSetDoorState(identifierDoor, statusDoor)
        else
            AddDoorToSystem(identifierDoor, door.hash, door.coord)
            DoorSystemSetDoorState(identifierDoor, statusDoor)

            door.identifier = identifierDoor
        end
    end
end)

local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            for index, dist in pairs(_cache) do
                local _config = Doors[index]

                local open = _config.open
                if (dist <= (open or 1.8)) then
                    if (_config.text) then
                        if (_config.lock) then
                            Text3D(_config.coord.x, _config.coord.y, _config.coord.z, '~b~E~w~ - Destrancar', 400)
                        else
                            Text3D(_config.coord.x, _config.coord.y, _config.coord.z, '~b~E~w~ - Trancar', 400)
                        end
                    end
                    if (dist <= (open or 1.2) and IsControlJustPressed(0, 38) and vSERVER.checkPermissions(_config.perm, _config.home, _config.user_id) and GetEntityHealth(ped) > 100) then
                        if (open) then if (not IsPedInAnyVehicle(ped)) then vRP._playAnim(true, {{ 'anim@mp_player_intmenu@key_fob@', 'fob_click' }}, false); end; end;
                        TriggerServerEvent('gb_doors:open', index, _config.autoLock)
                    end
                end
            end
            Citizen.Wait(1)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(Doors) do
            local distance = #(pCoord - v.coord)
            if (distance <= v.distance) then
                nearestBlips[k] = distance
                if (not v.other) then
                    local door = GetClosestObjectOfType(v.coord.x, v.coord.y, v.coord.z, v.distance, v.hash, false, false, false)
                    if (door ~= 0) then
                        local lock, heading = GetStateOfClosestDoorOfType(v.hash, v.coord.x, v.coord.y, v.coord.z, lock, heading)
                        HandleDoorState(v.identifier, v.lock, heading)
                    end
                else
                    local door1 = GetClosestObjectOfType(v.door_1.x, v.door_1.y, v.door_1.z, v.distance, v.hash, false, false, false)
                    local door2 = GetClosestObjectOfType(v.door_2.x, v.door_2.y, v.door_2.z, v.distance, v.other, false, false, false)
                    if (door1 ~= 0) then
                        local lock, heading = GetStateOfClosestDoorOfType(v.hash, v.door_1.x, v.door_1.y, v.door_1.z, lock, heading)
                        HandleDoorState(v.identifier, v.lock, heading)
                    end
                    
                    if (door2 ~= 0) then
                        local lock, heading = GetStateOfClosestDoorOfType(v.other, v.door_2.x, v.door_2.y, v.door_2.z, lock, heading)
                        HandleDoorState(v.identifier_2, v.lock, heading)
                    end
                end
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(500)
    end
end)

HandleDoorState = function(doorIdentifier, lock, heading)
    if (not lock) then
        --FreezeEntityPosition(door, lock)
        --NetworkRequestControlOfEntity(door)

        DoorSystemSetDoorState(doorIdentifier, lock)
    else
        if (heading > -0.05 and heading < 0.2) then
            --FreezeEntityPosition(door, lock)
            --NetworkRequestControlOfEntity(door)
            DoorSystemSetDoorState(doorIdentifier, lock)
        end
    end
end

function Text3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)  
    if onScreen then
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
        local scale = (1/dist)*2
        local fov = (1/GetGameplayCamFov())*100
        local scale = scale*fov

        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.0, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
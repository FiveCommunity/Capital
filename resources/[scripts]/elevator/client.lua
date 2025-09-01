vSERVER = Tunnel.getInterface(GetCurrentResourceName())

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
				local _config = config.location[index]
				DrawMarker(27, _config.coord.x, _config.coord.y, _config.coord.z, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 3, 187, 232, 155, 0, 0, 0, 1)
				if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) and (not LocalPlayer.state.Handcuff and not LocalPlayer.state.StraightJacket) then
					if (vSERVER.checkPermissions(_config.perm, _config.home)) then
						openElevator(config.general[_config.config].locations, config.general[_config.config].name)
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
        for k, v in pairs(config.location) do
            local distance = #(pCoord - v.coord)
            if (distance <= 5) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)

local elevatorsLocationCache = {}
openElevator = function(locs, name)
	elevatorsLocationCache = locs
	SetNuiFocus(true, true)
	SendNUIMessage({ action = 'OPEN_NUI', elevatorLocs = locs, elevatorName = name })
end

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
end)

RegisterNUICallback('elevatorFloor', function(data, cb)
	local ped = PlayerPedId()
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	SetEntityCoords(ped, elevatorsLocationCache[data].coord.xyz, false, false, false, true)
	-- SetEntityHeading(ped, elevatorsLocationCache[data].coord.w)
	Citizen.Wait(1000)
	TriggerEvent('vrp_sounds:source', 'elevator-bell', 0.3)
	SetNuiFocus(false, false)
	DoScreenFadeIn(1000)
	elevatorsLocationCache = {}
end)
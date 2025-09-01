--==================================================================================================
local trackerEnabled = false
local userGroup = ''
local userBlipType = 'foot'
local players = {}

local lastUpdate = 0
local elapsedTime = 0

--==================================================================================================

RegisterNetEvent('sw-blips:setEnabled',function(group)
	trackerEnabled = (type(group) == "string")
	userGroup = (group or '')
	userBlipType = 'foot'
	if (not trackerEnabled) then
		CleanupBlips(true)
	end
end)

RegisterNetEvent('sw-blips:playerRemoved',function(source)
	if players[source] then
		if DoesBlipExist(players[source].blip) then
			RemoveBlip(players[source].blip)
		end
		if DoesBlipExist(players[source].blipEntity) then
			RemoveBlip(players[source].blipEntity)
		end
		players[source] = nil
	end
end)

Citizen.CreateThread(function()
	while true do
		if trackerEnabled then

			-- local region = GetRegionPlayers()
			for src,mode in pairs(players) do
				-- if region[src] then
					-- if mode.blip then
					-- 	RemoveBlip(mode.blip)
					-- 	mode.blip = nil
					-- end
					-- if (not mode.blipEntity) then
					-- 	local ped = GetPlayerPed(GetPlayerFromServerId(src))
					-- 	mode.blipEntity = AddBlipForEntity(ped)							
					-- end
					-- SettingBlip(mode.blipEntity,mode.group,mode.btype)
				-- else
					if mode.blipEntity then
						RemoveBlip(mode.blipEntity)
						mode.blipEntity = nil
					end
					if (not mode.blip) then
						mode.blip = AddBlipForCoord(mode.destination.xyz)							
					end	
					SettingBlip(mode.blip,mode.group,mode.btype)	
				-- end
			end

		end
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent('sw-blips:update',function(data)	
	local gameTimer = GetGameTimer()
    elapsedTime = gameTimer - lastUpdate
    lastUpdate = gameTimer

	for group,users in pairs(data) do
		for src,mode in pairs(users) do
			if (not players[src]) then
				players[src] = { group = group, btype = mode.btype, start = mode.coords, current = mode.coords, destination = mode.coords }
			else
				players[src].destination = mode.coords
				players[src].start = players[src].current

				players[src].btype = mode.btype
			end
		end
	end
	SyncUserBlipType()
end)

-- --==================================================================================================
function Clamp(x, min, max)
    return math.max(math.min(x, max), min)
end

function Lerp(a, b, t)
    return a + (b - a) * t
end

function RotationFixer(rot,step)
    local fixed = (rot - step) % 360
    if (fixed < 0) then
        fixed = fixed + 360
    end
    return fixed
end

Citizen.CreateThread(function()
	while true do
		local _sleep = 1000
		if trackerEnabled then
			_sleep = 10
			
			local gameTimer = GetGameTimer()
			local timeFactor = Clamp((gameTimer - lastUpdate) / elapsedTime, 0, 1)
		
			for src,mode in pairs(players) do
				
				if mode.blip and DoesBlipExist(mode.blip) then
					local x = Lerp(mode.start.x, mode.destination.x, timeFactor)
					local y = Lerp(mode.start.y, mode.destination.y, timeFactor)
			
					mode.current = vector4(x, y, mode.current.z, mode.destination.w)
				
					SetBlipCoords(mode.blip, mode.current.xyz)
					SetBlipSquaredRotation(mode.blip, RotationFixer(mode.current.w,90))
				end
			end
		end
		Citizen.Wait(_sleep)
	end
end)

--==================================================================================================
function GetRegionPlayers()
	local cb = {}
	for _,p in ipairs(GetActivePlayers()) do
		cb[GetPlayerServerId(p)] = true		
	end
	return cb
end

function SettingBlip(blip,group,btype)
	local styles = (groupsFormats[group] or groupsFormats['default'])
	if DoesBlipExist(blip) then
		local styled = styles[btype] or styles['foot']
		if (type(styled) == 'string') then styled = styles[styled]; end;
		if styled then
			SetBlipSprite(blip,styled.sprite)
			SetBlipColour(blip,styled.colour)
			SetBlipScale(blip,styled.scale)
			SetBlipAsShortRange(blip,styled.short)
			SetBlipShowCone(blip, styled.cone)
			ShowHeadingIndicatorOnBlip(blip,styled.pointer)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(group)
			EndTextCommandSetBlipName(blip)
		else
			print("^1[WARN] Blip Style ("..tostring(group).."/"..tostring(btype)..") not found!^7")
		end
	end
end

function SyncUserBlipType()
	local newType = userBlipType
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	if (vehicle > 0) then
		newType = 'car'
		local class = GetVehicleClass(vehicle)
		if ((class == 8) or (class == 13)) then newType = 'bike';
		elseif (class == 15) then newType = 'heli';
		elseif (class == 16) then newType = 'plane'; end
	else
		newType = 'foot'
	end
	if (newType ~= userBlipType) then
		TriggerServerEvent('sw-blips:updateType', userGroup, newType)
		userBlipType = newType
	end
end

function CleanupBlips(clearTable)
	for k,v in pairs(players) do
		RemoveBlip(v.blip)
		v.blip = nil
		if clearTable then
			players[k] = nil
		end
	end
end
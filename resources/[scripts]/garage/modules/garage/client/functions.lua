--======================================================================================================================
-- DEFORMATION
--======================================================================================================================
function GetVehicleDeformation(vehicle)
    if not DoesEntityExist(vehicle) then return {} end
    local fuel = Entity(vehicle).state.fuel or GetVehicleFuelLevel(vehicle)
    local data = {
        body = math.floor(GetVehicleBodyHealth(vehicle)*100)/100, engine = math.floor(GetVehicleEngineHealth(vehicle)*100)/100, 
        dirt = math.floor(GetVehicleDirtLevel(vehicle)*100)/100, tank = math.floor(GetVehiclePetrolTankHealth(vehicle)*100)/100, 
        doors = {}, windows = {}, tyres = {}, deformations = {}, fuel = math.floor(fuel*100)/100
    }
	local min, max = GetModelDimensions(GetEntityModel(vehicle))
	local X = (max.x - min.x) * 0.5
	local Y = (max.y - min.y) * 0.5
	local Z = (max.z - min.z) * 0.5
	local halfY = Y * 0.5
	local positions = {vector3(-X, Y,  0.0),vector3(-X, Y,  Z),vector3(0.0, Y,  0.0),vector3(0.0, Y,  Z),vector3(X, Y,  0.0),
        vector3(X, Y,  Z),vector3(-X, halfY,  0.0),vector3(-X, halfY,  Z),vector3(0.0, halfY,  0.0),vector3(0.0, halfY,  Z),vector3(X, halfY,  0.0),
        vector3(X, halfY,  Z),vector3(-X, 0.0,  0.0),vector3(-X, 0.0,  Z),vector3(0.0, 0.0,  0.0),vector3(0.0, 0.0,  Z),vector3(X, 0.0,  0.0),
        vector3(X, 0.0,  Z),vector3(-X, -halfY,  0.0),vector3(-X, -halfY,  Z),vector3(0.0, -halfY,  0.0),vector3(0.0, -halfY,  Z),vector3(X, -halfY,  0.0),
        vector3(X, -halfY,  Z),vector3(-X, -Y,  0.0),vector3(-X, -Y,  Z),vector3(0.0, -Y,  0.0),vector3(0.0, -Y,  Z),vector3(X, -Y,  0.0),vector3(X, -Y,  Z),
	}
	for i, pos in ipairs(positions) do
		local dmg = #(GetVehicleDeformationAtPos(vehicle, pos))
		if (dmg > 0.05) then
			table.insert(data.deformations, { pos, dmg })
		end
	end
	for i = 0,5 do data.doors[i] = IsVehicleDoorDamaged(vehicle,i) end
	for i = 0,7 do data.windows[i] = IsVehicleWindowIntact(vehicle,i) end
	for i = 0,7 do
		local tyre_state = 2
		if IsVehicleTyreBurst(vehicle,i,true) then
			tyre_state = 1
		elseif IsVehicleTyreBurst(vehicle,i,false) then
			tyre_state = 0
		end
		data.tyres[i] = tyre_state
	end
	return data
end

function SetVehicleDeformation(vehicle, deformation)
    if not DoesEntityExist(vehicle) or not deformation or type(deformation) ~= "table" then return end
    local p = promise.new()
	CreateThread(function()
        if GetVehiclePedIsIn(PlayerPedId()) == vehicle then
            local fuelLevel = Entity(vehicle).state.fuel or GetVehicleFuelLevel(vehicle)
            SetVehicleFuelLevel(vehicle,fuelLevel+0.0)
        end
        SetVehicleBodyHealth(vehicle,(deformation.body or 1000)+0.0)
        SetVehicleEngineHealth(vehicle,(deformation.engine or 1000)+0.0)
        SetVehiclePetrolTankHealth(vehicle,(deformation.tank or 1000)+0.0)
        SetVehicleDirtLevel(vehicle,(deformation.dirt or 0.0) +0.0)
        for k,v in pairs(deformation.doors or {}) do
            local i = tonumber(k)
            if v and not IsVehicleDoorDamaged(vehicle,i) then
                SetVehicleDoorBroken(vehicle,i,true)
            end
        end
        for k,v in pairs(deformation.windows or {}) do
            local i = tonumber(k)
            if not v and IsVehicleWindowIntact(vehicle,i) then
                RemoveVehicleWindow(vehicle,i)
            end
        end
        for k,v in pairs(deformation.tyres or {}) do
            local i = tonumber(k)
            if v < 2 and not IsVehicleTyreBurst(vehicle,i,true) and not IsVehicleTyreBurst(vehicle,i,false) then
                SetVehicleTyreBurst(vehicle,i,(v == 1),1000.0)
            end
        end
		local min, max = GetModelDimensions(GetEntityModel(vehicle))
		local radius,damageMult,defs,deform,iteration = #(max-min)*40.0,#(max-min)*30.0,copyTable(deformation.deformations or {}),true,0				
		for i, def in ipairs(defs) do def[1] = vec3(def[1].x, def[1].y, def[1].z) end
        SetVehicleDeformationFixed(vehicle)
        local x,y,z = table.unpack(GetEntityCoords(vehicle))
		while deform and iteration < 50 do
			if not DoesEntityExist(vehicle) then return end
			deform = false
			for i, def in ipairs(defs) do
				if #(GetVehicleDeformationAtPos(vehicle, def[1])) < def[2] then
					SetVehicleDamage(vehicle,def[1] * 2.0,def[2] * damageMult,radius, true)
					deform = true
				end
			end
			iteration = iteration + 1
			Wait(100)
		end
        ClearAreaLeaveVehicleHealth(x,y,z,7.0,false,false,false,false)
        SetVehicleOnGroundProperly(vehicle)
        p:resolve()
	end)
    return Citizen.Await(p)
end

--======================================================================================================================
-- BLIPS
--======================================================================================================================
local markers = { ['plane'] = 33, ['heli'] = 34, ['boat'] = 35, ['car'] = 36, ['motor'] = 37, ['bike'] = 38, ['truck'] = 39 }

function BlipMarker(coords,marker)
    DrawMarker(markers[(marker or 'car')], coords.x, coords.y, coords.z+0.1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 3, 187, 232, 155, 1, 0, 0, 1)
    DrawMarker(27, coords.x, coords.y, coords.z-0.97, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 3, 187, 232, 155, 0, 0, 0, 1)
end

function CreateGaragesBlip()
	for k, v in pairs(config.garages) do
		if (v.showBlip) then
			local blipData = config.blips[v.rule]
            if blipData then
                local blip = AddBlipForCoord(v.coords.x,v.coords.y,v.coords.z)
                SetBlipSprite(blip,blipData.sprite)
                SetBlipAsShortRange(blip,true)
                SetBlipColour(blip,blipData.color)
                SetBlipScale(blip,blipData.scale)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString('Garagem')
                EndTextCommandSetBlipName(blip)
            end
		end
	end
end
--======================================================================================================================
-- TUNNELING
--======================================================================================================================
function cGARAGE.carDoor(dist, door)
    local ped = PlayerPedId()
    local pCoord = GetEntityCoords(ped)
    local pVehicle = GetClosestVehicle(pCoord, 7.0, 0, 71)
    if (pVehicle and not IsPedInAnyVehicle(ped)) then
        if (type(dist) == 'number') then
            dist = {dist,door}
        end
        for k,v in pairs(dist) do
            local bone = GetEntityBoneIndexByName(pVehicle, v[2])
            local engine = GetWorldPositionOfEntityBone(pVehicle, bone)
            local distance = #(pCoord - engine)
            if (distance <= v[1]) or (bone == -1) then
                return true
            end
        end
    end
    return false
end

function cGARAGE.vehicleAlarm()
    local ped = PlayerPedId()
    local pCoord = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle(pCoord, 2.5, 0, 71)
    if (vehicle and not IsPedInAnyVehicle(ped)) then
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, 10000)
    end
end

function cGARAGE.vehicleClientTrunk(vehid,trunk)
	if NetworkDoesNetworkIdExist(vehid) then
		local v = NetToVeh(vehid)
		if DoesEntityExist(v) and IsEntityAVehicle(v) then
			if trunk then
				SetVehicleDoorShut(v,5,0)
			else
				SetVehicleDoorOpen(v,5,0,0)
			end
		end
	end
end

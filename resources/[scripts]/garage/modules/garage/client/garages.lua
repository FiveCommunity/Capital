--======================================================================================================================
-- OPEN BLIP
--======================================================================================================================
garageOpened = false
local garagePanel = false
local garageIsInterior = false
local currentGarage = 0

local neargarages = { count = 0 }
local playerCoords = vec3(0,0,0)

-- NEAREST THREAD
Citizen.CreateThread(function()	
    CreateGaragesBlip()
	while true do
        local ped = PlayerPedId()
        local inside = IsPedInAnyVehicle(ped)
        playerCoords = GetEntityCoords(ped)
        for k,v in pairs(config.garages) do
            local dist = 100
            if (inside and v.interior) then dist = #(playerCoords - v.interior.parking.xyz); else dist = #(playerCoords - v.coords.xyz); end;
            if dist <= 20.0 then
                if (neargarages[k] == nil) then
                    neargarages[k] = v
                    neargarages.count = neargarages.count + 1
                end
            else
                if (neargarages[k] ~= nil) then
                    neargarages[k] = nil
                    neargarages.count = neargarages.count - 1
                end
            end
        end
        if (neargarages.count > 0) then
            markerThread()
        end
        Citizen.Wait(800)
	end
end)

--- GARAGE BLIP
local runningMarkerThread = false
function markerThread()
    if (not runningMarkerThread) then
        runningMarkerThread = true
        Citizen.CreateThread(function()
            while (neargarages.count > 0) do
                local ped = PlayerPedId()
               
                local vehicle = GetVehiclePedIsIn(ped,false)
                local driving = (GetPedInVehicleSeat(vehicle,-1) == ped)

                for index,config in pairs(neargarages) do
                    if (index ~= 'count') then
                         
                        local renderCoord = config.coords.xyz
                        local renderDist = 10.0
                        local openDist = 1.5      
                    
                        if (vehicle > 0) and driving and (config.interior) then
                            renderCoord = config.interior.parking.xyz
                            renderDist = 15.0
                            openDist = 4.5
                        end
                    
                        local dist = #(playerCoords - renderCoord)
                        if (dist <= renderDist) then
                           
                            BlipMarker(renderCoord,config.marker)
       
                            if (dist <= openDist) and IsControlJustPressed(0, 38) and (GetEntityHealth(ped) > 100) and (not exports.hud:isWanted(true)) and (not LocalPlayer.state.Handcuff and not LocalPlayer.state.StraightJacket) then
                                if (vehicle > 0) and driving then
                                    cGARAGE.openGarage(index,vehicle)
                                else
                                    if (vehicle <= 0) then
                                        cGARAGE.openGarage(index,false)
                                    end
                                end
                            end
                        end
                    end
                end
                Citizen.Wait(1)
            end
            runningMarkerThread = false
        end)
    end
end

function cGARAGE.addGarage(name, data)
	config.garages[name] = data
	if (neargarages[name]) then neargarages[name] = nil; end;
end

RegisterNetEvent('homes:removeGarage', function(name)
    while (garageOpened and (currentGarage == name)) do
        Wait(100)
    end
	config.garages[name] = nil
	if (neargarages[name]) then neargarages[name] = nil; end;
end)
--======================================================================================================================
-- FUNCTIONS
--======================================================================================================================
function cGARAGE.openGarage(idx,vehicle)
    local garData = config.garages[idx]
    if garData then
        if sGARAGE.checkPermissions(idx) and (not garageOpened) then
            garageOpened = true
            currentGarage = idx

            local ped = PlayerPedId()
            if garData.interior then

                local intData = config.interiors[garData.interior.id]
                if intData then
                                   
                    garageIsInterior = true
                    
                    LocalPlayer.state.Hud = false
                    DoScreenFadeOut(1500)

                    while (not IsScreenFadedOut()) do Wait(10); end;
 
                    if vehicle then
                        sGARAGE.tryStoreVehicle(currentGarage, Entity(vehicle).state['id'], false, true)
                    end

                    FreezeEntityPosition(ped,true)
                    StartPlayerTeleport(PlayerId(),intData.player.x,intData.player.y,intData.player.z,intData.player.w,false,true,true)
                    while IsPlayerTeleportActive() do Wait(1) end

                    sGARAGE.initSeason(idx)
                    
                    Citizen.Wait(500)
                    FreezeEntityPosition(ped,false)
                    insideGarageThread(idx)

                    DoScreenFadeIn(1500)
                    LocalPlayer.state.Hud = true
                end
            else
                garageIsInterior = false
                local vehicles = sGARAGE.requestVehicles(idx,false)
                cGARAGE.openGaragePanel(vehicles)
            end
        end
    end
end
DoScreenFadeIn(1)
local runningInsideGarage = false
function insideGarageThread(idx)
    if (not runningInsideGarage) then
        runningInsideGarage = true

        local hoverfyApplyed = false
        local garData = config.garages[idx]
        local intData = config.interiors[garData.interior.id]

        Citizen.CreateThread(function()
            while garageOpened do
                local _sleep = 200
                local hoverText = false
                local ped = PlayerPedId()

                local distToExit = #(playerCoords - intData.player.xyz)
                local distToMenu = #(playerCoords - intData.menu.xyz)
                if (distToExit <= 5.0) then
                    _sleep = 1
                    DrawMarker(1, intData.player.x, intData.player.y, intData.player.z-0.97, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 0.5, 125, 125, 125, 155, 0, 0, 0, 1)
                    if distToExit <= 1.5 then
                        hoverText = 'Sair da Garagem'
                        if IsControlJustPressed(0,38) then
                            
                            LocalPlayer.state.Hud = false
                            DoScreenFadeOut(1500)
                            while (not IsScreenFadedOut()) do Wait(10); end;

                            sGARAGE.exitSeason()

                            StartPlayerTeleport(PlayerId(),garData.coords.x,garData.coords.y,garData.coords.z,(garData.coords.w or 0),false,false,false)
                            while IsPlayerTeleportActive() do Wait(1); end;
                            
                            Citizen.Wait(500)

                            DoScreenFadeIn(1500)
                            LocalPlayer.state.Hud = true
                            Citizen.Wait(1200)
                            garageOpened = false
                        end
                    end
                end
                if (distToMenu <= 5.0) then
                    _sleep = 1
                    DrawMarker(1, intData.menu.x, intData.menu.y, intData.menu.z-0.97, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 0.5, 255, 255, 255, 155, 0, 0, 0, 1)
                    if distToMenu <= 1.5 then
                        hoverText = 'Menu da Garagem'
                        if IsControlJustPressed(0,38) then
                            local vehicles = sGARAGE.requestVehicles(idx,false)
                            cGARAGE.openGaragePanel(vehicles)
                        end
                    end
                end

                if hoverText then
                    if (not hoverfyApplyed) then
                        exports['hud']:customHoverfy('E',hoverText)
                        hoverfyApplyed = true
                    end
                else
                    if hoverfyApplyed then
                        exports['hud']:customHoverfy(false)
                        hoverfyApplyed = false
                    end
                end

                Citizen.Wait(_sleep)
            end

            if hoverfyApplyed then
                exports['hud']:customHoverfy(false)
                hoverfyApplyed = false
            end

            runningInsideGarage = false
        end)

    end
end
--======================================================================================================================
-- FUNCTIONS
--======================================================================================================================
function cGARAGE.openGaragePanel(data)
    if (not garagePanel) then
        garagePanel = true
        TriggerEvent('gb_core:tabletAnim')
        SetNuiFocus(true, true)
        SendNUIMessage({  action = 'open', cars = data })
    end
end
--======================================================================================================================
-- FUNCTIONS
--======================================================================================================================
function cGARAGE.loadModel(hash, tout, tunload)
    local mhash = hash
    if (type(hash) == 'string') then mhash = GetHashKey(hash); end;  
    local timeOut = (tonumber(tout) or 30000)
    while (not HasModelLoaded(mhash) and timeOut >= 0) do
        RequestModel(mhash)
        timeOut = timeOut - 10
        Citizen.Wait(10)
    end
    if (HasModelLoaded(mhash)) then
        if (tunload) then
            Citizen.SetTimeout((tonumber(tunload) or 60000), function()
                SetModelAsNoLongerNeeded(mhash)
            end)
        end
        return true
    end
    return false
end

function cGARAGE.getFreeSlot(garage)
    local garData = config.garages[garage]
    if (garData) then
        local positions = garData.points
        if garData.interior then
            positions = config.interiors[garData.interior.id].boxes
        end
        local checkSlot = 1

        while (true) do
            local checkPos = GetClosestVehicle(positions[checkSlot].x, positions[checkSlot].y, positions[checkSlot].z, 3.001, 0, 71)
            if (DoesEntityExist(checkPos)) then
                checkSlot = checkSlot + 1
                if (checkSlot > #positions) then checkSlot = -1; return false; end;
            else
                return checkSlot, positions[checkSlot]
            end
        end
    end
end

local function setVehicleMods(veh,m)
	if type(m) ~= "table" or not DoesEntityExist(veh) then return end
    local bug,pcolor,scolor = false,m.customPcolor,m.customScolor
    if pcolor then
        SetVehicleModKit(veh,0)
        ClearVehicleCustomPrimaryColour(veh)
        ClearVehicleCustomSecondaryColour(veh)
        if pcolor['1'] then bug = true end
        if bug then
            SetVehicleCustomPrimaryColour(veh,pcolor['1'],pcolor['2'],pcolor['3'])
            SetVehicleCustomSecondaryColour(veh,scolor['1'],scolor['2'],scolor['3'])
        else
            SetVehicleCustomPrimaryColour(veh,pcolor[1],pcolor[2],pcolor[3])
            SetVehicleCustomSecondaryColour(veh,scolor[1],scolor[2],scolor[3])
        end
    end
    --if not m.color then return Entity(veh).state:set("tuning", getVehicleMods(veh), true) end
	if not m.color then return; end;
    local ncolor = m.neoncolor
	SetVehicleLivery(veh, m.sticker or 0)
	SetVehicleWheelType(veh,m.wheeltype)
	SetVehicleColours(veh,m.color[1],m.color[2])
	SetVehicleExtraColours(veh,m.extracolor[1],m.extracolor[2])
	SetVehicleNeonLightsColour(veh,ncolor[1],ncolor[2],ncolor[3])
	SetVehicleXenonLightsColour(veh,m.xenoncolor)
	SetVehicleNumberPlateTextIndex(veh,m.plateindex)
	SetVehicleWindowTint(veh,m.windowtint)
    SetVehicleTyresCanBurst(veh,m.bulletProofTyres)
    SetVehicleInteriorColour(veh,m.interColour or 0)
    SetVehicleDashboardColour(veh,m.dashColour or 0)
	for i,t in pairs(m.mods) do 
        local k = tonumber(i)
		if k == 22 or k == 18 then
			if t.mod > 0 then
				ToggleVehicleMod(veh,k,true)
			else
				ToggleVehicleMod(veh,k,false)
			end
		elseif k == 20 then
            local r,g,b = table.unpack(m.smokecolor)
            ToggleVehicleMod(veh,20,true)
            SetVehicleTyreSmokeColor(veh,r,g,b)
		elseif k == 23 or k == 24 then
			SetVehicleMod(veh,k,tonumber(t.mod),tonumber(t.variation))
		else
			SetVehicleMod(veh,k,tonumber(t.mod))
		end
	end
	if m.neon then
		for i = 0, 3 do
			SetVehicleNeonLightEnabled(veh,i,true)
		end
	else
		for i = 0, 3 do
			SetVehicleNeonLightEnabled(veh,i,false)
		end
	end
    if m.driftTyre ~= nil and GetGameBuildNumber() >= 2372 then SetDriftTyresEnabled(veh,m.driftTyre or false) end
    if m.extras then
        for extraId,enabled in pairs(m.extras) do
			if enabled then
            	SetVehicleExtra(veh, tonumber(extraId), 0)
			end
        end
        for extraId,enabled in pairs(m.extras) do
			if not enabled and IsVehicleExtraTurnedOn(veh, tonumber(extraId)) then
				SetVehicleExtra(veh, tonumber(extraId), 1)
			end
        end
    end
end

function cGARAGE.settingVehicle(vnet, plate, custom, coords, fuel, interior)
    local timeout = 8000
    while not NetworkDoesEntityExistWithNetworkId(vnet) and timeout > 0 do
        Wait(0)
        timeout = timeout-1
    end
    local vehicle = NetworkDoesEntityExistWithNetworkId(vnet) and NetToVeh(vnet)
    if DoesEntityExist(vehicle) then
        while DoesEntityExist(vehicle) and not NetworkHasControlOfEntity(vehicle) do
            NetworkRequestControlOfEntity(vehicle)
            Wait(10)
        end
        if DoesEntityExist(vehicle) then
            exports.fuel:SetFuel(vnet,fuel)
            SetVehicleNumberPlateText(vehicle, plate)
            SetEntityCoords(vehicle,coords.x,coords.y,coords.z-0.95)
            SetEntityHeading(vehicle,coords.w)
            SetVehicleOnGroundProperly(vehicle)
            SetVehicleTyresCanBurst(vehicle,true)
            SetVehRadioStation(vehicle,"OFF")
            if (not interior) then
                FreezeEntityPosition(vehicle,false)
            end
            setVehicleMods(vehicle, custom)
        end
    end
end

--======================================================================================================================
-- LOCK/UNLOCK
--======================================================================================================================
local lockWait = false
RegisterCommand('+lockVehicle',function()
    if (not lockWait) then
        if (GetEntityHealth(PlayerPedId()) > 100) then
            lockWait = true
            sGARAGE.vehicleLock()
            Citizen.SetTimeout(1200,function() lockWait = false; end)
        end
    end
end)
RegisterKeyMapping("+lockVehicle", "Trancar Veículo", "KEYBOARD", "L")
--======================================================================================================================
-- TRUNK
--======================================================================================================================
local trunkWait = false
RegisterCommand("+opentrunk",function(source,args)
    if (not trunkWait) then
        trunkWait = true      
        if exports.inventory:canOpenInventory() then
            sGARAGE.tryOpenTrunk()
        end
        SetTimeout(2000,function() trunkWait = false; end)
    end
end)
RegisterKeyMapping("+opentrunk", "Abrir Porta-Malas", "keyboard", "PAGEUP")
--======================================================================================================================
-- STATES
--======================================================================================================================
AddStateBagChangeHandler("locked", nil, function (bagName, key, value)
    local entity = GetEntityFromStateBagName(bagName);
    if (not DoesEntityExist(entity)) then return; end;
    SetVehicleDoorsLocked(entity, value);
    SetVehicleLights(entity,2); Citizen.Wait(200);
    SetVehicleLights(entity,0); Citizen.Wait(200);
    SetVehicleLights(entity,2); Citizen.Wait(200);
    SetVehicleLights(entity,0)
end)

AddStateBagChangeHandler("state", nil, function (bagName, key, value)
	local entity = GetEntityFromStateBagName(bagName);
	if (not DoesEntityExist(entity)) then return; end;
    local stateBag = Entity(entity).state
    if (NetworkGetEntityOwner(entity) == PlayerId()) and (not stateBag['stateReady']) then
       SetVehicleDeformation(entity, value)
       stateBag:set('stateReady',true,true)
    end
end)

AddStateBagChangeHandler("custom", nil, function (bagName, key, value)
	local entity = GetEntityFromStateBagName(bagName);
	if (not DoesEntityExist(entity)) then return; end;
    if (NetworkGetEntityOwner(entity) == PlayerId())  then
        setVehicleMods(entity,value)
    end
end)

function checkDeformations(vehicle)
    local stateBag = Entity(vehicle).state
    if stateBag['state'] and IsEntityAVehicle(vehicle) and (NetworkGetEntityOwner(vehicle) == PlayerId()) then
        stateBag:set("state", GetVehicleDeformation(vehicle), true)
    end
end

local runningVehicle = false
AddEventHandler('gameEventTriggered', function (name, args)
    if (name == "CEventNetworkEntityDamage") then
        local vehicle = args[1]
        Citizen.Wait(1000)
        if (not DoesEntityExist(vehicle)) then return; end;
        checkDeformations(vehicle)
    elseif name == "CEventNetworkPlayerEnteredVehicle" then
        local pId = PlayerId()
        local ped = PlayerPedId()
        local eventPlayer, eventVeh = args[1], args[2]
        if (pId == eventPlayer) then
            if (not runningVehicle) then
                runningVehicle = true
                local stateBag = Entity(eventVeh).state
                if stateBag['sourceGarage'] and (GetPlayerServerId(pId) == stateBag['sourceGarage']) then
                    FreezeEntityPosition(eventVeh,true)
                    local garData = config.garages[currentGarage]
                    local vehicleIn = GetVehiclePedIsIn(ped)
                    local exited = false

                    while (vehicleIn == eventVeh) do
                        local _sleep = 100

                        if (not exited) then
                            ped = PlayerPedId()
                            vehicleIn = GetVehiclePedIsIn(ped)
                            
                            if (GetPedInVehicleSeat(eventVeh,-1) == ped) then
                                _sleep = 1
                                if IsControlJustPressed(0,71) then

                                    if sGARAGE.exitSeason(true) then
                                       
                                        local vehNet = VehToNet(vehicleIn)
                                        
                                        LocalPlayer.state.Hud = false
                                        DoScreenFadeOut(1500)
                                        while (not IsScreenFadedOut()) do Wait(10); end;

                                        sGARAGE.syncVehicleAlpha(vehNet, true, 15)

                                    
                                        StartPlayerTeleport(PlayerId(),garData.interior.parking.x,garData.interior.parking.y,garData.interior.parking.z,(garData.interior.parking.w or 0),true,true,false)
                                        while IsPlayerTeleportActive() do Wait(1); end;
                                        
                                        Citizen.Wait(500)
                                        DoScreenFadeIn(1500)
                                        LocalPlayer.state.Hud = true
                                        garageOpened = false

                                        exited = true

                                    end                                    
                                end
                            end
                        else
                            if DoesEntityExist(vehicleIn) then
                                local state = Entity(vehicleIn).state
                                if #(garData.interior.parking.xyz - GetEntityCoords(vehicleIn)) > 25.0 then
                                    sGARAGE.syncVehicleAlpha(VehToNet(vehicleIn), nil)
                                    break
                                elseif (not state.ghostVehicle) then
                                    break
                                end
                            else
                                break
                            end
                        end

                        Citizen.Wait(_sleep)
                    end
                end
                runningVehicle = false         
            end
        end
    end
end)
--======================================================================================================================
-- EXIT GHOST
--======================================================================================================================
ghostVehicles = GlobalState.ghostVehicles or {}
AddStateBagChangeHandler("ghostVehicles",nil,function(_,_,value) ghostVehicles = value end)

CreateThread(function()
    while true do
        for netid in pairs(ghostVehicles) do
            local vehicle = NetworkDoesEntityExistWithNetworkId(netid) and NetToVeh(netid)
            vehicle = DoesEntityExist(vehicle) and vehicle
            if vehicle then
                local state = Entity(vehicle).state
                local alpha,isOwner = state.ghostVehicle,NetworkGetEntityOwner(vehicle) == PlayerId()
                if alpha ~= nil then
                    cGARAGE.syncVehicleAlpha(netid, alpha)
                    if isOwner then
                        for _,veh in ipairs(GetGamePool("CVehicle")) do
                            SetEntityNoCollisionEntity(veh, vehicle, not alpha)
                        end
                        for _,player in ipairs(GetActivePlayers()) do
                            local playerPed = GetPlayerPed(player)
                            SetEntityNoCollisionEntity(playerPed, vehicle, not alpha)
                        end
                    end
                end
            end
        end
        Wait(1000)
    end
end)

function cGARAGE.syncVehicleAlpha(netid, alpha)
    if NetworkDoesEntityExistWithNetworkId(netid) then
		local vehicle = NetToVeh(netid)
		if DoesEntityExist(vehicle) then
            if alpha then
                SetEntityAlpha(vehicle, 155, false)
            else
                ResetEntityAlpha(vehicle)
            end
            local myVeh = GetVehiclePedIsIn(PlayerPedId())
            if myVeh == vehicle then return end
            SetEntityNoCollisionEntity(vehicle, PlayerPedId(), not alpha)
            if DoesEntityExist(myVeh) then
                SetEntityNoCollisionEntity(vehicle, myVeh, not alpha)
            end
        end   
	end
end
--======================================================================================================================
-- NUI
--======================================================================================================================
RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
	TriggerEvent('gb_core:stopTabletAnim')
    garagePanel = false
    if (not garageIsInterior) then
        garageOpened = false
    end
end)

RegisterNUICallback('saveVeh', function(data)
    sGARAGE.tryStoreVehicle(currentGarage, data.id, true, false )
end)

RegisterNUICallback('useVeh', function(data)
    sGARAGE.spawnVehicle(currentGarage, data.id, data.spawn)
end)
--======================================================================================================================
-- GARAGEM
--======================================================================================================================
RegisterCommand('garagem',function(source,args,rawCommand)
    local ped = PlayerPedId()
    local interior = GetInteriorFromEntity(ped)
    for k,v in pairs(config.interiors) do
        if (GetInteriorAtCoords(v.player) == interior) then
            local coords = vec3(30.40879, -900.2374, 29.9707)
            if (currentGarage > 0) then
               coords = config.garages[currentGarage].coords 
            end

            LocalPlayer.state.Hud = false
            DoScreenFadeOut(1500)
            while (not IsScreenFadedOut()) do Wait(10); end;

            sGARAGE.exitSeason()

            StartPlayerTeleport(PlayerId(),coords.x,coords.y,coords.z,(coords.w or 0),false,false,false)
            while IsPlayerTeleportActive() do Wait(1); end;
            
            Citizen.Wait(500)

            DoScreenFadeIn(1500)
            LocalPlayer.state.Hud = true
            Citizen.Wait(1200)
            garageOpened = false
            break;
        end
    end
end)
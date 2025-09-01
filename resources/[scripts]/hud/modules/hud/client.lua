local inVehicle = false
local VehicleHud = false
local seatbeltOn = false
local hasSeatbelt = false
local isPauseMenu = false

Current = {
    Health = 0,
    Armour = 0,
    Oxygen = -1,
    Stress = 0,
    Speed = 0,
    Fuel = 0.0,
    Engine = 0.0,
    Locked = false,
    Street = '',
    Direction = '',
    Light = 0
}
    
Citizen.CreateThread(function()
    while (not Ready) do Citizen.Wait(100); end;

    SetFlyThroughWindscreenParams(20.0, 2.0, 10.0, 1500.0)
    SetPedConfigFlag(PlayerPedId(), 32, true)
    
    UpdateStats('hud', LocalPlayer.state.Hud)
    while (true) do
        if (LocalPlayer.state.Hud) then
            UpdateStats('time', getTime())

            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            local pCoord = GetEntityCoords(ped)
            local pHeading = GetEntityHeading(ped)

            local health = GetHealth(ped)
            if (Current.Health ~= health) then 
                Current.Health = health
                UpdateStats('health', Current.Health)
            end

            local armour = GetPedArmour(ped)
            if (Current.Armour ~= armour) then
                Current.Armour = armour
                print(Current.Armour)
                UpdateStats('armour', Current.Armour)
            end

            if (not LocalPlayer.state.Scuba) then
                local oxygen = GetOxygen(ped, 10)
                if (Current.Oxygen ~= oxygen) then
                    Current.Oxygen = oxygen
                    UpdateStats('oxygen', Current.Oxygen)
                end
            end

            local StreetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(pCoord.x, pCoord.y, pCoord.z))
            if (Current.Street ~= StreetName) then
                Current.Street = StreetName
                UpdateStats('street', Current.Street)
            end

            local direction = GetDirection(pHeading)
            if (Current.Direction ~= direction) then
                Current.Direction = direction
                UpdateStats('direction', Current.Direction)
            end

            inVehicle = IsPedInAnyVehicle(ped)
            if (inVehicle and not VehicleHud) then StatusVehicle(true, veh)
            elseif (not inVehicle and VehicleHud) then StatusVehicle(false, veh) end

            if (VehicleHud) then
                local _, light, highLight = GetVehicleLightsState(veh)
                local formatLight = (light < highLight and highLight or light)
                if (Current.Light ~= formatLight) then
                    Current.Light = formatLight
                    UpdateStats('light', Current.Light)
                end

                local fuel = GetVehicleFuelLevel(veh)
                if (Current.Fuel ~= fuel) then
                    Current.Fuel = fuel
                    UpdateStats('fuel', Current.Fuel)
                end

                local engine = GetVehEngine(veh)
                if (Current.Engine ~= engine) then
                    Current.Engine = engine
                    UpdateStats('engine', Current.Engine)
                end

                local locked = GetVehicleDoorLockStatus(veh)
                if (Current.Locked ~= locked) then
                    Current.Locked = locked
                    UpdateStats('locked', Current.Locked == 2)
                end
            end

            if (IsPauseMenuActive()) then
                if (not isPauseMenu) then
                    isPauseMenu = true
                    UpdateStats('hud', false)
                    exports.chat:DisableChat(false)
                end
            else
                if (isPauseMenu) then
                    isPauseMenu = false
                    UpdateStats('hud', true)
                    exports.chat:DisableChat(true)
                end
            end
        end
        Citizen.Wait(600)
    end
end)

local UpdateHud = function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    Citizen.CreateThread(function()
        while (inVehicle and VehicleHud) do
            local speed = GetSpeed(veh)
            if (Current.Speed ~= speed) then
                Current.Speed = speed
                UpdateStats('speed', Current.Speed)
            end
            Citizen.Wait(250)
        end
    end)
end

local alwaysShowRadar = { [8] = true, [14] = true, [15] = true, [16] = true, [22] = true }
local checkRadar = function(bool)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local class = GetVehicleClass(vehicle)
    local hasSeatbelt = doesVehicleHasSeatbelt(vehicle)
    if bool or (alwaysShowRadar[class]) and (seatbeltOn or not hasSeatbelt) and IsPedInAnyVehicle(ped) then
        DisplayRadar(true)
    else
        DisplayRadar(false)
    end
end

startVehicle = function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if (not DoesEntityExist(vehicle)) then return; end;

    UpdateHud() -- Thread
    hasSeatbelt = doesVehicleHasSeatbelt(vehicle)
end

StatusVehicle = function(bool)
    seatbeltOn = false
    SetPedConfigFlag(PlayerPedId(), 32, true)
    
    if (bool) then
        VehicleHud = true
        startVehicle()
        UpdateStats('vehicle', true)
        checkRadar(not doesVehicleHasSeatbelt(veh))
    else
        inVehicle = false
        VehicleHud = false
        checkRadar(false)
        UpdateStats('vehicle', false)
    end
end

local threadSeatbelt = function()
    Citizen.CreateThread(function()
        while (seatbeltOn and inVehicle) do
            DisableControlAction(1, 75, true)
            Citizen.Wait(4)
        end
    end)
end

toggleSeatbelt = function()
    if (inVehicle and VehicleHud and hasSeatbelt) then
        seatbeltOn = (not seatbeltOn)

        UpdateStats('seatbelt', seatbeltOn)
        checkRadar(seatbeltOn)
        SetPedConfigFlag(PlayerPedId(), 32, (not seatbeltOn))

        if (seatbeltOn) then threadSeatbelt(); TriggerEvent('vrp_sounds:source', 'belt', 0.5);
        else TriggerEvent('vrp_sounds:source', 'unbelt', 0.5); end;
    end
end
RegisterCommand('+seatBelt', toggleSeatbelt)
RegisterKeyMapping('+seatBelt', 'Colocar o cinto', 'keyboard', 'G')

toggleHud = function() LocalPlayer.state.Hud = (not LocalPlayer.state.Hud) end
RegisterCommand('hud', toggleHud)

AddStateBagChangeHandler('Hud', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    UpdateStats('hud', value)
    exports.chat:DisableChat(value)
end)

RegisterNetEvent('hud:updateNeeds', function(need, value) if (needs[need] ~= value) then needs[need] = value UpdateStats(need, needs[need]) end end)
RegisterNetEvent('hud:setTalkingMode', function(mode) UpdateStats('talkingMode', mode) end)
RegisterNetEvent('hud:playerTalking', function(status) UpdateStats('talking', status) end)
RegisterNetEvent('hud:setFrequency', function(radio) UpdateStats('radio', radio) end)

local lowLife = function()
    local ped = PlayerPedId()
    local movementClipset = 'move_injured_generic'

    Citizen.CreateThread(function()
        while (GetEntityHealth(ped) > 100) and (GetEntityHealth(ped) <= 130) do
            ped = PlayerPedId()

            RequestAnimSet(movementClipset)
            while (not HasAnimSetLoaded(movementClipset)) do Citizen.Wait(0); end;

            SetPedMovementClipset(ped, movementClipset, 1)
            DisableControlAction(0, 21, true) -- disable shift
            DisableControlAction(0, 22, true) -- disable spacebar
            DisableControlAction(0, 58, true)
            DisableControlAction(1, 84, true)

            Citizen.Wait(1)
        end 

        ResetPedMovementClipset(ped, 0)
    end)
end
RegisterNetEvent('hud:lowLife', lowLife)

AddEventHandler('gameEventTriggered', function (name, args)
	if (name == 'CEventNetworkEntityDamage')  then
		local ped = PlayerPedId()
		if (args[1] == ped) and LocalPlayer.state.Active then 
            if (GetEntityHealth(ped) > 100) and (GetEntityHealth(ped) <= 130) then 
                lowLife()
            end
		end
	end
end) 
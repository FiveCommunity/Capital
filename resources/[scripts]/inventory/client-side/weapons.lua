--=======================================================================================================================================
-- Weapon Functions
--=======================================================================================================================================
Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()

        local currentWeapon = LocalPlayer.state['weapon_model']
        local saveAmmo = LocalPlayer.state['weapon_ammo']
        local saveUsages = LocalPlayer.state['weapon_usages']
        if currentWeapon then            
            local maxAmmo = (config.ammoMax[currentWeapon] or 250)
            local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
            if (currentAmmo ~= saveAmmo) then
                LocalPlayer.state:set('weapon_ammo',currentAmmo,true)
                if (currentAmmo < saveAmmo) then
                    local diff = math.floor(saveAmmo - currentAmmo)
                    if config.throwables[currentWeapon] then
                        sRP.removeThrowable(diff,currentAmmo)
                    else
                        LocalPlayer.state:set('weapon_usages',math.floor(saveUsages+diff),true)
                    end
                end
            end
            if (GetEntityHealth(ped) <= 100) or IsPedSwimming(ped) then
                sRP.cleanWeapons()
            end
        end
        Citizen.Wait(2000)
    end
end)

AddStateBagChangeHandler('gadgetParachute', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) or (not value) then return; end;

    Citizen.CreateThread(function()
        local ped = PlayerPedId()

        SetPlayerCanLeaveParachuteSmokeTrail(entity, true)
        SetPlayerParachuteSmokeTrailColor(entity, 3, 187, 232)
        SetPlayerParachutePackTintIndex(entity, math.random(4, 13))
        SetPedParachuteTintIndex(ped, math.random(0, 7))

        while (LocalPlayer.state.gadgetParachute) do
            ped = PlayerPedId()
            if (not HasPedGotWeapon(ped, GetHashKey('GADGET_PARACHUTE'))) then
                LocalPlayer.state:set('gadgetParachute', false, true)
            end
            Citizen.Wait(1000)
        end
    end)
end)

function cleanWeapons()
    sRP.cleanWeapons()
end
exports('cleanWeapons', cleanWeapons)
--=======================================================================================================================================
-- Weapon Attachs
--=======================================================================================================================================
RegisterNetEvent('inventory:attachs',function(weapon,components)
    local weaponAttachs = config.attachs[weapon]
    if (weaponAttachs) then
        local ped = PlayerPedId()
        local weaponHash = GetHashKey(weapon)
        
        local tout = GetGameTimer()+2000
        while (not HasPedGotWeapon(ped,weaponHash,false)) and (tout > GetGameTimer()) do
            Citizen.Wait(50)
        end
        
        if HasPedGotWeapon(ped, weaponHash, false) then
            
            for _, comp in pairs(weaponAttachs) do
                RemoveWeaponComponentFromPed(ped, weaponHash, GetHashKey(comp))
            end
            
            if components then
                for k, v in ipairs(components) do
                    if weaponAttachs[v] then
                        GiveWeaponComponentToPed(ped, weaponHash, GetHashKey(weaponAttachs[v]) )
                    end
                end
            end
        end
    end
end)
--=======================================================================================================================================
-- Throw Weapon 
--=======================================================================================================================================
LocalPlayer.state:set('throwingWeapon', false, true)

-- RegisterCommand('throwWeapon', function()
--     local ped = PlayerPedId()

--     local currentWeapon = LocalPlayer.state['weapon_model']
--     if (currentWeapon) and (config.throwWeapons[currentWeapon]) then
       
--         if (not IsPedInAnyVehicle(ped,false)) then
--             throwCurrentWeapon(ped, currentWeapon)
--         end
--     end
-- end)
-- RegisterKeyMapping('throwWeapon', 'Arremessar o armamento', 'keyboard', 'I')

local thrownWeapons = {}

local function GetDirectionFromRotation(rotation)
    local dm = (math.pi / 180)
    return vector3(-math.sin(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.cos(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.sin(dm * rotation.x))
end

local function PerformPhysics(entity, ped)
    local power = 25
    FreezeEntityPosition(entity, false)

    local rot = GetGameplayCamRot(2)
    local dir = GetDirectionFromRotation(rot)
    SetEntityHeading(entity, rot.z + 90.0)
    SetEntityVelocity(entity, dir.x * power, dir.y * power, power * dir.z)
end

function throwCurrentWeapon(ped, currentWeapon)
    if (LocalPlayer.state.throwingWeapon) then return; end;
    LocalPlayer.state.throwingWeapon = true

    local prop = GetWeaponObjectFromPed(ped, true)
    local prop_model = GetEntityModel(prop)

    DeleteEntity(prop)
    vRP.playAnim(false, {{ 'melee@thrown@streamed_core', 'plyr_takedown_front' }}, false)
    Citizen.SetTimeout(500, function()
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
        
        local weaponSlot = LocalPlayer.state['weapon_slot']
        sRP.cleanWeapons()

        prop = CreateProp(prop_model, coords.x, coords.y, coords.z, true, true, false)
        sRP.preventQuit(ObjToNet(prop), true)
        SetEntityCoords(prop, coords.x, coords.y, coords.z)
        SetEntityHeading(prop, (GetEntityHeading(ped) + 90.0))
        PerformPhysics(prop, ped)
        
        local lastCoord = vec3(0,0,0)
        while (true) do
            local coords = GetEntityCoords(prop)
            if (lastCoord == coords) then
                break
            else
                lastCoord = coords
            end
            Citizen.Wait(1)
        end

        sRP.saveWeapons({
            objectId = ObjToNet(prop),
            objectCoords = lastCoord,
            itemSlot = weaponSlot,
            createObject = prop_model
        })

        sRP.preventQuit()
        LocalPlayer.state.throwingWeapon = false
    end)
end

function CreateProp(modelHash, ...)
    RequestModel(modelHash)
    while (not HasModelLoaded(modelHash)) do Citizen.Wait(1) end
    local obj = CreateObject(modelHash, ...)
    SetModelAsNoLongerNeeded(modelHash)
    return obj
end

local nearestBlips = {}
local startedThread = false

local function markerThread()
    if (startedThread) then return; end;
    startedThread = true
    
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            for index, dist in pairs(nearestBlips) do
                local config = thrownWeapons[index]
                if (config) then
                    if (not config.cdz) then
                        local _, cdz = GetGroundZFor_3dCoord(config.objectCoords.x,config.objectCoords.y,config.objectCoords.z)
                        config.cdz = cdz
                    end

                    DrawMarker(0,config.objectCoords.x,config.objectCoords.y,config.cdz+0.3,0,0,0,0,0,130.0,0.15,0.15,0.15,3, 187, 232,200,1,0,0,0)

                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and not IsPedInAnyVehicle(ped)) then
                        ClearPedTasksImmediately(ped)
                        LocalPlayer.state.freezeEntity = true
                        vRP.playAnim(false, {{ 'pickup_object', 'pickup_low' }}, false)
                        Citizen.Wait(800)
                        sRP.deleteWeaponSaved(index)
                        thrownWeapons[index] = nil
                        Citizen.Wait(800)
                        ClearPedTasks(ped)
                        LocalPlayer.state.freezeEntity = false
                    end
                end
            end
            Citizen.Wait(1)
        end
        startedThread = false
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        
        nearestBlips = {}

        if (GetEntityHealth(ped) > 100) then
            for k, v in pairs(thrownWeapons) do
                local distance = #(pCoord - v.objectCoords)
                if (distance <= 2) then
                    nearestBlips[k] = distance
                end
            end
            
            if (countTable(nearestBlips) > 0) then markerThread(); end;
        end
        Citizen.Wait(1000)
    end
end)

cRP.createWeaponObject = function(data)
    Citizen.Wait(5000)
    prop = CreateProp(data.createObject, data.objectCoords.x, data.objectCoords.y, data.objectCoords.z, true, true, false)    
    SetEntityHeading(prop, 90.0)
    return ObjToNet(prop)
end

RegisterNetEvent('inventory:setWeaponData', function(key, data) thrownWeapons[key] = data; end)

cRP.getAmmoAmount = function(weaponHash)
    local playerPed = PlayerPedId()

    return GetAmmoInPedWeapon(playerPed, weaponHash)
end
Citizen.CreateThread(function()
    if (not LocalPlayer.state.Spawned) then
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)

        SetEntityVisible(ped, false)
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(PlayerId(), false)

        local model = GetHashKey('mp_m_freemode_01')
        if (Utils.Creator:RequestModel(model)) then
            ped = PlayerPedId()

            --RequestCollisionAtCoord(pCoord.x, pCoord.y, pCoord.z)
            SetEntityCoordsNoOffset(ped, pCoord.x, pCoord.y, pCoord.z, false, false, false, true)
            NetworkResurrectLocalPlayer(pCoord.x, pCoord.y, pCoord.z, GetEntityHeading(ped), true, true, false)

            SetPedDefaultComponentVariation(ped)
            ClearPedTasksImmediately(ped)
            
            -- local time = GetGameTimer()
            --while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 5000) do Citizen.Wait(0); end;
            SetEntityCollision(ped, true)
            
            FreezeEntityPosition(ped, false)
            SetEntityVisible(ped, true)

            while (not Utils.Ready) do Citizen.Wait(2000); end;

            DoScreenFadeOut(500)
            Citizen.Wait(1000)
            SetNuiFocus(false, false)
            ShutdownLoadingScreenNui()
            ShutdownLoadingScreen()

            DisplayRadar(false)

            LocalPlayer.state.Spawned = true

            selectorLoad()
        end
    end
end)

local lastCoords = vector3(-1106.229, -2856.026, 13.96338)

local spawnInLastLocation = function()
    DoScreenFadeOut(500)
    Citizen.Wait(1000)

    SetNuiFocus(false, false)
    Utils.Cam:Destroy() 

    Utils.Creator:Teleport(lastCoords)
    vSERVER.changeSession(0)

    Citizen.Wait(1000)
    DoScreenFadeIn(500)   
    
    LocalPlayer.state.Hud = true
end

Spawn = function(bool, lastPosition)
    if (lastPosition) and lastPosition.x then lastCoords = vector3(lastPosition.x, lastPosition.y, lastPosition.z); end;

    if (bool) then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'spawn',
            data = {
                show = true,
                userHomes = vSERVER.getUserHomes()
            }
        })          
    else
        spawnInLastLocation()
    end
end
RegisterNetEvent('spawn:Show', Spawn)

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
local ids = {
    -- [4251] = true,
    -- [3091] = true,
    -- [692] = true,
    -- [4045] = true,
    -- [3377] = true,
    -- [2126] = true,
    -- [3518] = true,
    -- [3988] = true,
    -- [3532] = true,
    -- [1123] = true,
    -- [225] = true,
    -- [437] = true,
    -- [2785] = true,
    -- [4208] = true,
    -- [4332] = true,
    -- [2602] = true,
    -- [3144] = true,
    -- [992] = true,
}

RegisterNUICallback('SetLocation', function(data, cb)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)

    Utils.Cam:Destroy() 
    SetNuiFocus(false, false)

    local ped = PlayerPedId()

    ClearPedTasks(ped)

    local user_id = vSERVER.getUserId(source)
    if (user_id) and (ids[user_id]) then
        Utils.Creator:Teleport(lastCoords)
    else
        if (data.home) then
            local homeConfig = exports.homes:getHomesConfig()
            if (data.homeType == 'Apartamento') then data.spawn = string.sub(data.spawn, 1, -5); end;

            if (homeConfig[data.spawn].coord) then
                Utils.Creator:Teleport(homeConfig[data.spawn].coord)
            end
        else
            local coords = ConfigSpawn.coords[data.spawn]
            if (coords) then
                SetEntityHeading(ped, coords.w)
                Utils.Creator:Teleport(coords.xyz)
            end
        end
    end
    
    vSERVER.changeSession(0)
    
    Citizen.Wait(1000)
    DoScreenFadeIn(500)

    LocalPlayer.state.Hud = true
    
    cb('Ok')
end)

RegisterNUICallback('LastLocation', function(data, cb)
    spawnInLastLocation()

    cb('Ok')
end)
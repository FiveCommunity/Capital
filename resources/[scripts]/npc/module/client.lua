local nearestPed = false
local createdPeds = {}

local addHoverfys = function()
    for _, v in pairs(configPeds) do
        TriggerEvent('insert:hoverfy', v.coord.xyz, 'E', 'Interagir', 2.0)
    end
end

Citizen.CreateThread(function()
    addHoverfys()
    while (true) do
        local ped = PlayerPedId()
        for k, v in pairs(configPeds) do
            local coord = v.coord
            local distance = #(GetEntityCoords(ped) - coord.xyz)
            if (distance <= 25) then
                local anim = v.anim
                local idle, dict = anim[1], anim[2]
                if (not createdPeds[k]) then
                    local hash = v.hash
                    RequestModel(hash)
                    while (not HasModelLoaded(hash)) do Citizen.Wait(1); end;
                    
                    createdPeds[k] = CreatePed(4, hash, coord.x, coord.y, (coord.z - 1), coord.w, false, false)
                    SetEntityInvincible(createdPeds[k], true)
                    FreezeEntityPosition(createdPeds[k], true)
                    SetBlockingOfNonTemporaryEvents(createdPeds[k], true)
                    SetModelAsNoLongerNeeded(hash)

                    Entity(createdPeds[k]).state:set('scenario', true, true)

                    if (anim) then
                        RequestAnimDict(idle)
						while (not HasAnimDictLoaded(idle)) do Citizen.Wait(1); end;
                        TaskPlayAnim(createdPeds[k], idle, dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                    end
                else
                    if (anim) and (not IsEntityPlayingAnim(createdPeds[k], idle, dict, 3)) then
                        TaskPlayAnim(createdPeds[k], idle, dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                    end
                end

                if (v.enableTalk) then
                    if (distance <= 2) then
                        if (not nearestPed) then nearestPed = k; end;
                    else
                        if (nearestPed) and (nearestPed == k) then nearestPed = false; end;
                    end
                end
            else
                if (nearestPed) and (nearestPed == k) then nearestPed = false; end;
                if (createdPeds[k]) then
                    SetEntityAsMissionEntity(createdPeds[k], false, false)
					DeleteEntity(createdPeds[k])
					createdPeds[k] = nil
                end
            end
        end
        Citizen.Wait(1500)
    end
end)

local camActive = nil

createCam = function()
    while (IsCamInterpolating(GetRenderingCam())) do Citizen.Wait(1); end;

    if (DoesCamExist(camActive)) then
        RenderScriptCams(false, false, 0, false, false)
        SetCamActive(camActive, false)
        DestroyCam(camActive, false)
        camActive = nil
    end

    local ped = createdPeds[nearestPed]
    local coordsCam = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.5)

    camActive = CreateCam('DEFAULT_SCRIPTED_CAMERA')

    SetCamCoord(camActive, coordsCam.x, coordsCam.y, coordsCam.z)
    SetCamRot(camActive, GetCamRot(camActive, 1))
    SetCamFov(camActive, 20.0)
    SetCamActive(camActive, true)

    PointCamAtPedBone(camActive, ped, 31086, 0.0, 0.0, 0.0)
    RenderScriptCams(true, true, 1500, true, true)
end

deleteCam = function()
    if (DoesCamExist(camActive)) then
        RenderScriptCams(false, true, 1500, true, false)
        SetCamActive(camActive, false)
        DestroyCam(camActive, false)
        camActive = nil
    end
end

----------------------------------------------------------------
-- Command's
----------------------------------------------------------------
local openned = false

RegisterCommand('+pressedTalkNpc', function()
    local ped = PlayerPedId()
    if (GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) and (not LocalPlayer.state.BlockTasks and not LocalPlayer.state.Handcuff and not LocalPlayer.state.StraightJacket) then
        if (nearestPed) and (not openned) then
            local config = configPeds[nearestPed].enableTalk
            if (config) then
                LocalPlayer.state.Hud = false

                openned = true
                hidePlayer()

                createCam()
                SetNuiFocus(true, true)
                SendNUIMessage({
                    action = 'open',
                    data = config
                })  
            end
        end
    end
end)
RegisterKeyMapping('+pressedTalkNpc', 'Interagir com o NPC', 'keyboard', 'E')

hidePlayer = function()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        while (openned) do
            SetEntityLocallyInvisible(ped)
            Citizen.Wait(1)
        end
        SetEntityLocallyVisible(ped)
    end)
end

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
local closeUi = function()
    SetNuiFocus(false, false)
    deleteCam()

    LocalPlayer.state.Hud = true
    openned = false
end


RegisterNUICallback('selectedOption', function(data, cb)
    closeUi()

    local config = configPeds[nearestPed]
    local talkPed = config.enableTalk.options[parseInt(data.index)]
    if (config) and (talkPed.event) then
        local ped = PlayerPedId()
        
        local checkDistance = (#(GetEntityCoords(ped) - config.coord.xyz) <= 2.0)
        if (checkDistance) then
            local tunnel = {
                ['server'] = function(event, arg)
                    TriggerServerEvent(event, arg)
                end,
                ['client'] = function(event, arg)
                    TriggerEvent(event, arg)
                end
            }

            if (tunnel[talkPed.event[3]]) then tunnel[talkPed.event[3]](talkPed.event[1], talkPed.event[2]); end;
        end
    end

    cb('Ok')
end)

RegisterNUICallback('close', function(data, cb)
    closeUi()

    cb('Ok')
end)
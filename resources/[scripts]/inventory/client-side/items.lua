------------------------------------------------------------
-- BINOCULOS
------------------------------------------------------------
local fov_min = 5.0
local fov_max = 70.0
local binoculos = false
local camera = false
local fov = (fov_max+fov_min)*0.5

local waitCheck = false

RegisterNetEvent('inventory:camera', function(toogle)
    if (toogle) then
                
        if (not sRP.checkCamera()) then return; end;

        blockInventory = true     
        camera = true
        
        Citizen.CreateThread(function()
            while (camera) do
                if IsControlJustPressed(0,38) then
                    -- local scaleform = RequestScaleformMovie("breaking_news")
                    -- local scaleform2 = RequestScaleformMovie("security_camera")
                    -- while not HasScaleformMovieLoaded(scaleform) do
                    --     Citizen.Wait(10)
                    -- end
                    -- while not HasScaleformMovieLoaded(scaleform2) do
                    --     Citizen.Wait(10)
                    -- end
    
                    local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
                    AttachCamToEntity(cam,PlayerPedId(),0.0,0.0,1.0,true)
                    SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()))
                    SetCamFov(cam,fov)
                    RenderScriptCams(true,false,0,1,0)
                    LocalPlayer.state.Hud = false
    
                    local lockCamera = true
                    while (lockCamera and camera) do
                        Citizen.Wait(1)
                        BlockWeaponWheelThisFrame()
                        local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
                        CheckInputRotation(cam,zoomvalue)
                        HandleZoom(cam)
                        -- DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
                        -- DrawScaleformMovieFullscreen(scaleform2,255,255,255,255)
                        if IsControlJustPressed(0,38) then
                            lockCamera = false
                        end
                    end
    
                    fov = (fov_max+fov_min)*0.5
                    RenderScriptCams(false,false,0,1,0)
                    -- SetScaleformMovieAsNoLongerNeeded(scaleform)
                    -- SetScaleformMovieAsNoLongerNeeded(scaleform2)
                    DestroyCam(cam,false)
                    SetNightvision(false)
                    SetSeethrough(false)
                    LocalPlayer.state.Hud = true
                end

                Citizen.Wait(1)
            end
        end)
    else
        blockInventory = false
        camera = false
    end
end)

AddEventHandler('gb:CancelAnimations', function()
    if (binoculos or camera) then
        blockInventory = false
        binoculos = false
        camera = false
        vRP.DeletarObjeto()
    end
end)


function CheckInputRotation(cam,zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0,220)
    local rightAxisY = GetDisabledControlNormal(0,221)
    local rotation = GetCamRot(cam,2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z+rightAxisX*-1.0*(8.0)*(zoomvalue+0.1)
        new_x = math.max(math.min(20.0,rotation.x+rightAxisY*-1.0*(8.0)*(zoomvalue+0.1)),-89.5)
        SetCamRot(cam,new_x,0.0,new_z,2)
    end
end
 
function HandleZoom(cam)
    if IsControlJustPressed(0,241) then
        fov = math.max(fov-10.0,fov_min)
    end
 
    if IsControlJustPressed(0,242) then
        fov = math.min(fov+10.0,fov_max)
    end
 
    local current_fov = GetCamFov(cam)
    if math.abs(fov-current_fov) < 0.1 then
        fov = current_fov
    end
    SetCamFov(cam,current_fov+(fov-current_fov)*0.05)
end

------------------------------------------------------------
-- ÁGUA
------------------------------------------------------------
local drinkingFountain = {
    -1691644768,
    'prop_watercooler'
}

Citizen.CreateThread(function()
    exports['target']:RemoveTargetModel(drinkingFountain, 'Encher a garrafa')
	exports['target']:AddTargetModel(drinkingFountain, { 
        options = { 
            { 
                icon = 'fas fa-bottle-water', 
                label = '- Encher a garrafa', 
                distance = 1.5, 
                action = function(e) 
                    TriggerServerEvent('inventory:bottleWater')
                end 
            } 
        }
    })
end)
local cli = {}
Tunnel.bindInterface('Macas', cli)
local vSERVER = Tunnel.getInterface('Macas')

local inMaca = false

local macaHashes = {
    [1004440924] = { offset = vec3(0,-0.4,0), anim  = 'deitar7', invert = 180 },

    [256650529] = { offset = vec3(0,-0.4,0), anim  = 'deitar7', invert = 180 },
    [998593452] = { offset = vec3(0,-0.4,0), anim  = 'deitar7', invert = 180 },
    [-1248745872] = { offset = vec3(0,-0.4,0), anim  = 'deitar7', invert = 180 },
    [3046221424] = { offset = vec3(0,-0.4,0), anim  = 'deitar7', invert = 180 },
    [835950247] = { offset = vec3(0,-0.4,0), anim  = 'deitar7', invert = 180 },

    [2117668672] = { offset = vec3(0,0.0,0), anim  = 'deitar7', invert = 180 }, -- prisão
}

Citizen.CreateThread(function()
    for k,v in pairs(macaHashes) do
        exports["target"]:RemoveTargetModel(k,{ "Deitar Maca", "Tratamento Auto", 'Tratar Amigo' })
        exports["target"]:AddTargetModel(k,{ options = {      
            {
                icon = "fas fa-stethoscope",
                label = "Tratamento Auto",
                distance = 1.5,

                canInteract = function(entity)
                    return (GetEntityHealth(PlayerPedId()) > 100)
                end,

                action = function(e)
                    local ped = PlayerPedId()
                    if (GetEntityHealth(ped) > 100) and (GetEntityHealth(ped) < 200) then 
                        vSERVER.startTratamento(e)
                    else
                        TriggerEvent('notify', 'Hospital', 'Você não pode iniciar um <b>tratamento</b> com a vida cheia!')
                    end
                end 
            },
            {
                icon = "fas fa-procedures",
                label = "Deitar Maca",
                distance = 1.5,

                canInteract = function(entity)
                    return (GetEntityHealth(PlayerPedId()) > 100)
                end,

                action = function(e)
                    SetPlayerInMaca(e)
                end 
            },
            {
                icon = "fas fa-user-group",
                label = "Tratar Amigo",
                distance = 1.5,

                canInteract = function(entity)
                    return (GetEntityHealth(PlayerPedId()) > 100)
                end,

                action = function(e)
                    local ped = PlayerPedId()
                    if (GetEntityHealth(ped) > 100) then 
                        vSERVER.reviveFriend()
                    end
                end 
            }
        }})
    end
end)

SetPlayerInMaca = function(e)
    local model = GetEntityModel(e)
    local data = macaHashes[model]
    if data then
        inMaca = true
        local ped = PlayerPedId()

        local coords = GetOffsetFromEntityInWorldCoords(e,data.offset.x,data.offset.y,data.offset.z)
        local heading = GetEntityHeading(e)
        
        SetEntityCoords(ped, coords)
        if data.invert then
            heading = RotationFixer(heading,data.invert)
        end
        SetEntityHeading(ped, heading)

        Citizen.Wait(700)
        FreezeEntityPosition(ped, true)
        TriggerEvent('gb_animations:setAnim', data.anim)
    end
end

function RotationFixer(rot,step)
    local fixed = (rot - step) % 360
    if (fixed < 0) then
        fixed = fixed + 360
    end
    return fixed
end

cli.checkMaca = function()
    -- if inMaca then
    --     return true
    -- end
    -- local dist = #(GetEntityCoords(PlayerPedId()) - vector3(-2074.404, -463.4506, 12.17725))
    -- if dist < 75.0 then
    --     return true
    -- end
    -- return false
    return inMaca
end

local inTratamento = false

AddEventHandler('gb:CancelAnimations',function()
	if (not inTratamento) and inMaca then
		inMaca = false
		local ped = PlayerPedId()	
		FreezeEntityPosition(ped, false)
		ClearPedTasks(ped)			
	end
end)

cli.setTratamento = function(e)
    if (inTratamento) then return; end;
    inTratamento = true
    
    if (e) then SetPlayerInMaca(e); end;

    local ped = PlayerPedId()

    LocalPlayer.state.BlockTasks = true

    TriggerEvent('notify', 'importante', 'Hospital', 'O seu tratamento foi iniciado com sucesso! Aguarde a liberação do <b>médico</b>.')

    repeat
        Citizen.Wait(600)
        SetEntityHealth(ped, (GetEntityHealth(ped) + 3))
    until (GetEntityHealth(ped) >= GetEntityMaxHealth(ped))

    TriggerEvent('notify', 'sucesso', 'Hospital', 'O seu <b>tratamento</b> foi um sucesso!')

    inTratamento = false
    LocalPlayer.state.BlockTasks = false
end

local anestesia = 0
cli.setAnestesia = function(time)
    local ped = PlayerPedId()
	DoScreenFadeOut(5000)
    Citizen.Wait(5000)
    startEffect(time)
    SetPedMotionBlur(ped, true) 
    SetPedIsDrunk(ped, true)
    DoScreenFadeIn(5000)
    FreezeEntityPosition(ped,true)
    TriggerEvent('progressBar', 'Sua anestesia acaba em '..time..' segundos...', time * 1000)
    Citizen.Wait(time * 1000)
    anestesia = 0
    FreezeEntityPosition(ped, false)
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
end

startEffect = function(time)
    Citizen.CreateThread(function()
        anestesia = time
        while (anestesia > 0) do
            SetTimecycleModifier('spectator5')
            Citizen.Wait(1)
        end
        ClearTimecycleModifier()
    end)
end

RegisterNetEvent('gb_macas:reanimar', function(time)
    local coords = GetEntityCoords(PlayerPedId())
    local foundGround, z = GetGroundZFor_3dCoord(coords.x, coords.y, 1000.0, 0.0)
    object = CreateObject(GetHashKey('gnd_desfribilador_maleta'), coords.x+0.5, coords.y+0.5, z, false,false,false)
    Citizen.Wait(time * 1000)
    DeleteObject(object)
end)
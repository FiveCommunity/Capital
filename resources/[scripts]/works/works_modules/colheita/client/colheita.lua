sColheita = Tunnel.getInterface(GetCurrentResourceName()..':colheita')

local polyZones = {}
for index, coords in pairs(Colheita.zones) do
    polyZones[index] = PolyZone:Create(coords, { name = index, debugGrid = false })
end

local GetCoordsFromCam = function(Distance,Coords)
	local Rotation = GetGameplayCamRot()
	local Adjusted = vec3((math.pi / 180) * Rotation["x"],(math.pi / 180) * Rotation["y"],(math.pi / 180) * Rotation["z"])
	local Direction = vec3(-math.sin(Adjusted[3]) * math.abs(math.cos(Adjusted[1])),math.cos(Adjusted[3]) * math.abs(math.cos(Adjusted[1])),math.sin(Adjusted[1]))

	return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end

local defineObjectCoords = function()
    local ply = PlayerPedId()
    
    local stage = Colheita.propStages[1]
    local mhash = GetHashKey(stage.model)

    RequestModel(stage.model)
	while (not HasModelLoaded(mhash)) do Citizen.Wait(1); end;
    
    local plyCoords, plyHeading = GetEntityCoords(ply), GetEntityHeading(ply)
    local objectOffset = CreateObjectNoOffset(mhash, plyCoords.x, plyCoords.y, plyCoords.z, false, false, false)

    SetEntityCollision(objectOffset, false, false)
	SetEntityHeading(objectOffset, plyHeading)
	SetEntityAlpha(objectOffset, 100, false)
	SetModelAsNoLongerNeeded(mhash)

    while (true) do
        ply = PlayerPedId()

        local plyCam = GetGameplayCamCoord()

        local plyHandle = StartExpensiveSynchronousShapeTestLosProbe(plyCam, GetCoordsFromCam(10.0, plyCam), -1, ply, 4)
        local _, _, coords = GetShapeTestResult(plyHandle)
        
        SetEntityCoords(objectOffset, (coords+stage.offset) )

        DisableControlAction(0,24,true)
        DisableControlAction(0,25,true)

        if IsDisabledControlJustPressed(0,24) then
            if DoesEntityExist(objectOffset) then DeleteObject(objectOffset); end;
            return true, coords
        end

        if IsDisabledControlJustPressed(0,25) then
            if DoesEntityExist(objectOffset) then DeleteObject(objectOffset); end;
            return false
        end

        Text2D(0, 0.44, 0.92, 'Botão Direito - ~b~Cancelar~w~', 0.4)   
        Text2D(0, 0.43, 0.95, 'Botão Esquerdo - ~b~Confirmar~w~', 0.4)   
        Citizen.Wait(1)
    end
end

local checkCoordsZone = function(coords)  
    for name, zone in pairs(polyZones) do
        local inside = zone:isPointInside(coords)
        if (inside) then return true, name; end;
    end
    return false
end

local planting = false
RegisterNetEvent('works:colheita:useSeed', function()
    if (not planting) then
        planting = true
        
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)

        local inZone = checkCoordsZone(plyCoords)
        if (inZone) then
            local defined, coords = defineObjectCoords()
            if defined then
                if checkCoordsZone(coords) then
                    sColheita.plantSeed(coords)
                else
                    TriggerEvent('notify','importante','Colheita','Você não pode plantar fora dos campos!')
                end
            else
                TriggerEvent('notify','importante','Colheita','Você cancelou o plantio!')
            end
        else
            TriggerEvent('notify','importante','Colheita','Você está longe dos campo!')
        end

        planting = false
    end
end)

Citizen.CreateThread(function()
    local waterModels = {}
    local interacting = false

    for i=1, (#Colheita.propStages-1) do table.insert(waterModels, GetHashKey( Colheita.propStages[i].model ) ); end;

    if GetResourceState('target') == 'started' and exports.target then
        exports.target:RemoveTargetModel(waterModels, 'Adubar Planta')
        exports.target:AddTargetModel(waterModels, {
        options = {
            {
                icon = 'fas fa-faucet',
                label = 'Adubar Planta',
                canInteract = function(entity)
                    return (Entity(entity).state.plant ~= nil) and (not LocalPlayer.state.BlockTasks)
                end,

                action = function(entity)
                    sColheita.nextStage(ObjToNet(entity), 1)
                end
            }
        },
        distance = 2.0
    })
    end
    
    --=========================================================================
    local lastStep = Colheita.propStages[#Colheita.propStages]
    local lastModel = GetHashKey(lastStep.model)

    if GetResourceState('target') == 'started' and exports.target then
        exports.target:RemoveTargetModel(lastModel, 'Colher Plantio')
        exports.target:AddTargetModel(lastModel, {
        options = {
            {
                icon = 'fas fa-faucet',
                label = 'Colher Plantio',
                canInteract = function(entity)
                    return (Entity(entity).state.plant ~= nil) and (not LocalPlayer.state.BlockTasks)
                end,

                action = function(entity)
                    sColheita.nextStage(ObjToNet(entity),2)
                end
            }
        },
        distance = 2.0
    )
    end


end)
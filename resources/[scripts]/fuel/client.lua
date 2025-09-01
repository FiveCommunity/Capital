local vSERVER = Tunnel.getInterface('Fuel')

local pumpOffSet = {
    [-2007231801] = { 0.0, 0.0, 2.11 },
    [1339433404] = { 0.0, 0.0, 2.11 },
    [1933174915] = { 0.0, 0.0, 2.21 },
    [1694452750] = { 0.0, 0.0, 2.21 }
}

local fuelConfig = {
    index = nil,
    isFueling = false,
    canFuel = false,
    abastecer = false,
    config = {},
    pumpId = nil,
    pumpBrand = nil,
    pumpPrice = nil,
    vehicleId = nil,
    vehicleFuel = 0,
    userMoney = 0,
    currentFuel = 0,
    totalFuel = 0,
    totalVehicleFuel = 0,
    totalPrice = 0,
}

local configFuelI = config.generalFuel
local configLocs = config.locs
local dataVehicle2, dataVnetId2, dataVPlaca2, dataVName2
DecorRegister(configFuelI.FuelDecor, 1)

local inVehicle = false
AddEventHandler('gameEventTriggered', function(event, args)
    if (event == 'CEventNetworkPlayerEnteredVehicle') then
        local id = args[1]
        local vehicle = args[2]
        if (id == PlayerId()) then            
            if (inVehicle) then return; end;
            if NetworkGetEntityIsNetworked(vehicle) then
                inVehicle = true
                StartFuelThread()
            end
        end
    end
end)

StartFuelThread = function()
    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()   
            inVehicle = IsPedInAnyVehicle(ped)
            local vehicle = GetVehiclePedIsIn(ped)
            if (vehicle ~= 0) then
                fuelUsage(vehicle)
                local fuel = GetVehicleFuelLevel(vehicle)
                if (fuel <= 0.0) then
                    SetVehicleUndriveable(vehicle, true)
                end
            end
            Citizen.Wait(1000)
        end
    end)
end

local nearestBlips = {}

local _markerThread = false
local markerThread = function(k, v)
    if (_markerThread) then return; end;

    fuelConfig.index = v.id
    local fuelPumps = {}
    local config = config[v.config].configFuel
    Citizen.CreateThread(function()
        _markerThread = true
        while (fuelConfig.index ~= nil) do
            local pool = {}
            local pCoord = GetEntityCoords(PlayerPedId())
            dataVehicle2 = GetClosestVehicle(pCoord.x, pCoord.y, pCoord.z, 3.0, 0, 70)
            dataVName2 = GetEntityModel(dataVehicle2)
            for k, v in pairs(GetGamePool('CObject')) do
                for k2, v2 in pairs(config.fuelPumps) do
                    if (GetEntityModel(v) == v2.hash) then
                        table.insert(pool,
                            {GetOffsetFromEntityInWorldCoords(v, 0.0, -1.0, 0.0),
                            GetOffsetFromEntityInWorldCoords(v, 0.0, 1.0, 0.0), GetEntityCoords(v), v, v2.type,
                            v2.price, v2.paymentType})
                    end
                end
            end
            fuelPumps = pool
            if (#(GetEntityCoords(PlayerPedId()) - v.coord) > v.markerDistance) then
                fuelConfig.index = nil
            end 
            Citizen.Wait(2000)
        end
        _markerThread = false
    end)

    Citizen.CreateThread(function()
        while (fuelConfig.index ~= nil) do
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)
            local idle = 1000
            if (configFuelI.vehicleEletrical ~= nil) then
                fuelConfig.abastecer = false
                local vehicleNow = GetEntityModel(GetVehiclePedIsIn(ped, false))
                local dataVehicle = GetPlayersLastVehicle()

                for k, v in pairs(fuelPumps) do
                    idle = 1
                    local pumpType = v[5]
                    local abType = 0
                    local pumpDist = 3.0
                    if (dataVehicle and dataVehicle ~= 0) then
                        if (DoesEntityExist(dataVehicle)) then
                            if (IsPedInAnyVehicle(ped)) then dataVName2 = vehicleNow end
                            if (pumpType == 'eletrical' and checkVehicleClass(GetVehicleClass(dataVehicle), pumpType)) then
                            if (configFuelI.vehicleEletrical[dataVName2]) then
                                    pumpDist = 3.0
                                    abType = 1
                                end
                            elseif (pumpType == 'car' and checkVehicleClass(GetVehicleClass(dataVehicle), pumpType)) then
                                if (not configFuelI.vehicleEletrical[dataVName2]) then
                                    pumpDist = 3.0
                                    abType = 1
                                end
                            elseif (pumpType == 'heli' and checkVehicleClass(GetVehicleClass(dataVehicle), pumpType)) then
                                pumpDist = 8.0
                                abType = 1
                            elseif (pumpType == 'plane' and checkVehicleClass(GetVehicleClass(dataVehicle), pumpType)) then
                                pumpDist = 8.0
                                abType = 1
                            elseif (pumpType == 'boat' and checkVehicleClass(GetVehicleClass(dataVehicle), pumpType)) then
                                pumpDist = 8.0
                                abType = 1
                            end
                        end
                    end
                    
                    local distance = #(pCoord - v[3])
                    if (distance <= pumpDist) then

                        local vehicleCoords = vec3(0,0,-100)
                        if (dataVehicle and dataVehicle ~= 0) then
                            vehicleCoords = GetEntityCoords(dataVehicle)
                            local carDist = #(vehicleCoords - v[3])
                            if (carDist <= pumpDist )then
                                fuelConfig.abastecer = true
                            end
                        end

                        if fuelConfig.abastecer then
                            if (abType == 1) then
                                if (IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped) then
                                    if pumpType == 'eletrical' then
                                        DrawText3Ds(vector3(v[3].x, v[3].y, v[3].z + 1.2), 'SAIA DO ~b~VEÍCULO ~w~PARA RECARREGAR')
                                    else
                                        DrawText3Ds(vector3(v[3].x, v[3].y, v[3].z + 1.2), 'SAIA DO ~b~VEÍCULO ~w~PARA ABASTECER')
                                    end
                                else
                                    distAnalise = 3.5
                                    if (pumpType == 'heli') then
                                        distAnalise = 4.0
                                    end
                                    if DoesEntityExist(dataVehicle) and (#(pCoord - vehicleCoords) < distAnalise) then
                                        local vFuel = GetVehicleFuelLevel(dataVehicle)
                                        if (vFuel < 99) then
                                            if (pumpType == 'eletrical') then
                                                DrawText3Ds(vector3(v[3].x, v[3].y, v[3].z + 1.2), 'PRESSIONE ~b~E ~w~PARA RECARREGAR')
                                            else
                                                DrawText3Ds(vector3(v[3].x, v[3].y, v[3].z + 1.2), 'PRESSIONE ~b~E ~w~PARA ABASTECER')
                                            end
                                            if (IsControlJustPressed(0, 38)) then
                                                fuelConfig.totalPrice = 0
                                                fuelConfig.pumpId = v[4]
                                                fuelConfig.canFuel = true
                                                fuelConfig.pumpPrice = v[6]
                                                fuelConfig.pumpBrand = config.fuelBrand
                                                fuelConfig.vehicleId = dataVehicle
                                                fuelConfig.vehicleFuel = vFuel
                                                fuelConfig.paymentType = v[7]
                                                fuelConfig.userMoney = vSERVER.GetUserMoney()
                                                Citizen.Wait(50)
                                                SetNuiFocus(true, true)
                                                LocalPlayer.state.BlockTasks = true
                                                SendNUIMessage({
                                                    action = 'open',
                                                    brand = config.fuelBrand,
                                                    type = pumpType,
                                                    price = fuelConfig.pumpPrice,
                                                    vfuel = vFuel
                                                })
                                            end
                                        else
                                            DrawText3Ds(vector3(v[3].x, v[3].y, v[3].z + 1.2), 'TANQUE ~b~CHEIO~w~')
                                        end
                                    end
                                end
                            end
                        else
                            if (not IsPedInAnyVehicle(ped)) then
                                DrawText3Ds(vector3(v[3].x, v[3].y, v[3].z + 1.2), '~b~E~w~ - COMPRAR GALÃO')
                                if (IsControlJustPressed(0, 38) and not HasPedGotWeapon(ped, GetHashKey('WEAPON_PETROLCAN'))) then
                                    vSERVER.payFuel()
                                end
                            end
                        end
                    end
                end
            
            end
            Citizen.Wait(idle)
        end
    end)
end

Citizen.CreateThread(function()
    addBlips()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        for k, v in pairs(configLocs) do
            local distance = #(pCoord - v.coord)
            if (distance <= v.markerDistance) then
                markerThread(k, v)
            end
        end
        Citizen.Wait(1000)
    end
end)

startFuel = function()
    ped = PlayerPedId()
    if (pumpOffSet[GetEntityModel(fuelConfig.pumpId)] ~= nil) then
        startFuelRope()
    end
    TaskTurnPedToFaceEntity(ped, fuelConfig.vehicleId, 5000)
    Citizen.CreateThread(function()
        while (fuelConfig.isFueling) do
            local fuelAdd = math.random(20, 20) / 100.0
            fuelConfig.totalFuel = fuelConfig.totalFuel + fuelAdd
            fuelConfig.currentFuel = (fuelConfig.vehicleFuel + fuelConfig.totalFuel) + 0.0000001
            fuelConfig.totalPrice = fuelConfig.totalPrice + (fuelAdd * fuelConfig.pumpPrice)

            if (fuelConfig.currentFuel >= 100) then
                fuelConfig.currentFuel = 99.9999
                SetVehicleFuelLevel(fuelConfig.vehicleId, fuelConfig.currentFuel)
                stopFuel()
            else
                if fuelConfig.totalPrice < fuelConfig.userMoney then
                    SetVehicleFuelLevel(fuelConfig.vehicleId, fuelConfig.currentFuel)
                    SendNUIMessage({
                        action = 'update',
                        vfuel = fuelConfig.currentFuel,
                        totalprice = fuelConfig.totalPrice,
                        totalfuel = fuelConfig.totalFuel
                    })
                else
                    stopFuel()
                end
            end
            Citizen.Wait(100)
        end
    end)
    CreateThread(function()
        ped = PlayerPedId()
        TaskTurnPedToFaceEntity(ped, vehicleId, 5000)
        if (not HasAnimDictLoaded("timetable@gardener@filling_can")) then
            RequestAnimDict("timetable@gardener@filling_can")
            while (not HasAnimDictLoaded("timetable@gardener@filling_can")) do
                Citizen.Wait(10)
            end
        end
        TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
        while (true) do
            local idle = 300
            if (fuelConfig.isFueling) then
                idle = 1
                for k, v in pairs(configFuelI.DisableKeys) do
                    DisableControlAction(0, v)
                end
            else
                ClearPedTasks(ped)
                RemoveAnimDict("timetable@gardener@filling_can")
                break
            end
            Citizen.Wait(idle)
        end
    end)
end

fuelUsage = function(vehicle)
    if DoesEntityExist(vehicle) then
        if (IsVehicleEngineOn(vehicle)) then
            local atualFuel = vSERVER.getVehicleSyncFuel(VehToNet(vehicle))
            if (atualFuel == false) then
                atualFuel = GetVehicleFuelLevel(vehicle)
            end

            local newFuel = atualFuel - configFuelI.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (configFuelI.Classes[GetVehicleClass(vehicle)] or 1.0) / 10
            
            if (newFuel > 100.00) then
                newFuel = 99.99
            end

            vSERVER.syncCombustivel(VehToNet(vehicle), newFuel)

            SetVehicleFuelLevel(vehicle, newFuel)
            DecorSetFloat(vehicle, configFuelI.FuelDecor, GetVehicleFuelLevel(vehicle))
        else
            local atualFuel = vSERVER.getVehicleSyncFuel(VehToNet(vehicle))
            if (atualFuel == false) then
                atualFuel = GetVehicleFuelLevel(vehicle)
            end

            SetVehicleFuelLevel(vehicle, atualFuel)
            DecorSetFloat(vehicle, configFuelI.FuelDecor, GetVehicleFuelLevel(vehicle))
        end
    end
end

stopFuel = function()
    if (pumpOffSet[GetEntityModel(fuelConfig.pumpId)] ~= nil) then
        stopFuelRope()
    end
    ped = PlayerPedId()
    fuelConfig.isFueling = false
    fuelConfig.canFuel = nil
    fuelConfig.pumpId = nil
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
    LocalPlayer.state.BlockTasks = false
    ClearPedTasks(ped)
    RemoveAnimDict("timetable@gardener@filling_can")
    
    local finishFuelVar = vSERVER.finishFuel(VehToNet(fuelConfig.vehicleId), fuelConfig.vehicleFuel,
        fuelConfig.totalFuel, fuelConfig.totalPrice)
    if (not finishFuelVar) then
        SetVehicleFuelLevel(fuelConfig.vehicleId, fuelConfig.vehicleFuel)
    end
    fuelConfig.totalFuel = 0
end

setFuel = function(vehicle, fuel)
    vSERVER.syncCombustivel(vehicle, fuel)
end
exports('SetFuel', setFuel)

local class = {
    ['car'] = function(vehicle, valid)
        if vehicle <= 7 or vehicle == 8 or vehicle == 9 or vehicle == 10 or vehicle == 11 or vehicle == 12 or
            vehicle == 17 or vehicle == 18 or vehicle == 20 then
            valid = true
        end
        return valid
    end,
    ['eletrical'] = function(vehicle, valid)
        if vehicle <= 7 or vehicle == 8 or vehicle == 9 or vehicle == 10 or vehicle == 11 or vehicle == 12 or
            vehicle == 17 or vehicle == 18 or vehicle == 20 then
            valid = true
        end
        return valid
    end,
    ['bike'] = function(vehicle, valid)
        if vehicle <= 7 or vehicle == 8 or vehicle == 9 or vehicle == 10 or vehicle == 11 or vehicle == 12 or
            vehicle == 17 or vehicle == 18 or vehicle == 20 then
            valid = true
        end
        return valid
    end,
    ['boat'] = function(vehicle, valid)
        if vehicle == 14 then
            valid = true
        end
        return valid
    end,
    ['heli'] = function(vehicle, valid)
        if vehicle == 15 then
            valid = true
        end
        return valid
    end,
    ['plane'] = function(vehicle, valid)
        if vehicle == 16 then
            valid = true
        end
        return valid
    end,
}

checkVehicleClass = function(vehicle, type)
    local valid = false
    return class[type](vehicle, valid)
end

fuelRope = nil
fuelProp = nil
fuelModel = GetHashKey('prop_cs_fuel_nozle')

startFuelRope = function()
    local ped = PlayerPedId()
    local plycds = GetEntityCoords(ped)
    local obj = fuelConfig.pumpId
    local objcds = GetEntityCoords(obj)
    local offset = pumpOffSet[GetEntityModel(obj)]
    RequestModel(fuelModel)
    RopeLoadTextures()
    while (not RopeAreTexturesLoaded()) do
        Wait(10)
    end
    while (not HasModelLoaded(fuelModel)) do
        Wait(10)
    end
    fuelProp = CreateObject(fuelModel, plycds, true, true)
    AttachEntityToEntity(fuelProp, ped, GetPedBoneIndex(ped, 60309), 0.03, 0.05, 0.03, 95.0, 0.0, 170.0, false, false, false, false, 0, true)
    local propcds = GetEntityCoords(fuelProp)
    FreezeEntityPosition(fuelProp, true)
    fuelRope = AddRope(objcds, 0.0, 0.0, 0.0, 0.0, 4, 0.0, 0.0, 0.0, 0, 0, 0, 0.0, false)
    AttachEntitiesToRope(fuelRope, fuelProp, obj, GetOffsetFromEntityInWorldCoords(fuelProp, 0.0, 0.0, -0.2),
    GetOffsetFromEntityInWorldCoords(obj, offset[1], offset[2], offset[3]), 0.0, 0, 0, nil, nil)
    StartRopeWinding(fuelRope)
    RopeForceLength(fuelRope, #(GetOffsetFromEntityInWorldCoords(fuelProp, 0.0, 0.0, -0.2) -
    GetOffsetFromEntityInWorldCoords(obj, offset[1], offset[2], offset[3])))
end

stopFuelRope = function()
    local ped = PlayerPedId()
    DeleteEntity(fuelProp)
    DeleteRope(fuelRope)
    RopeUnloadTextures()
    SetModelAsNoLongerNeeded(fuelModel)
end

DrawText3Ds = function(coords, text)
	SetDrawOrigin(coords.x, coords.y, coords.z, 0); 
	SetTextFont(4)     
	SetTextProportional(0)     
	SetTextScale(0.35,0.35)    
	SetTextColour(255,255,255,155)   
	SetTextDropshadow(0, 0, 0, 0, 255)     
	SetTextEdge(2, 0, 0, 0, 150)     
	SetTextDropShadow()     SetTextOutline()     
	SetTextEntry("STRING")     SetTextCentre(1)     
	AddTextComponentString(text) 
	DrawText(0.0, 0.0)     
	ClearDrawOrigin() 
end

RegisterNUICallback('close', function(data, cb)
    local ped = PlayerPedId()
    if fuelConfig.isFueling then
        stopFuel()
        fuelConfig.isFueling = false
    end
    fuelConfig.isFueling = false
    fuelConfig.canFuel = nil
    fuelConfig.pumpId = nil
    fuelConfig.totalPrice = 0
    LocalPlayer.state.BlockTasks = false
    SetNuiFocus(false, false)
    ClearPedTasks(ped)
end)

RegisterNUICallback('fuelSet', function(data, cb)
    if data[1] == 'start' then
        fuelConfig.isFueling = true
        startFuel()
    elseif data[1] == 'stop' then
        stopFuel()
        if fuelConfig.isFueling then
            fuelConfig.isFueling = false
        end
        fuelConfig.canFuel = false
        fuelConfig.totalFuel = 0
        fuelConfig.totalPrice = 0
        fuelConfig.vehicleId = nil
        fuelConfig.vehicleFuel = 0
    end
end)

addBlips = function()
    for _, v in pairs(configLocs) do
        local config = config[configLocs[_].config]
        if (config.blip) then
            local coords = v.coord
            local blipConfig = config.blip
            if (coords) then
                local blip = AddBlipForCoord(coords.xyz)
                SetBlipSprite(blip, blipConfig.blipId)
                SetBlipColour(blip, blipConfig.blipColor)
                SetBlipScale(blip, blipConfig.blipScale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(blipConfig.name)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end
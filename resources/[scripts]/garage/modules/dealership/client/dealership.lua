--======================================================================================================================
-- SHOWCASE
--======================================================================================================================
Citizen.CreateThread(function()
    local showcaseSpawned = false
    local showcaseList = {}
    local dealerCoords = vector3(-67.7934, 76.68132, 71.70764)
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        if (#(dealerCoords - coords) <= 95) then
            if (not showcaseSpawned) then
                for k,v in ipairs(config.dealer_showcase) do
                    RequestModel(v.model)
                    while (not HasModelLoaded(v.model)) do
                        RequestModel(v.model)
                        Citizen.Wait(10)
                    end
                    local vehicle = CreateVehicle(v.model,v.coords.x,v.coords.y,v.coords.z,v.heading,false,true)
                    if DoesEntityExist(vehicle) then
                        SetVehicleColourCombination(vehicle,1)
                        FreezeEntityPosition(vehicle,true)
                        SetVehicleDoorsLocked(vehicle,2)
                        SetModelAsNoLongerNeeded(v.model)
                        showcaseList[#showcaseList+1] = vehicle
                    end
                end
                showcaseSpawned = true
            end
        else
            if showcaseSpawned then
                for i,veh in ipairs(showcaseList) do
                    SetEntityAsNoLongerNeeded(veh)
                    DeleteEntity(veh)
                end
                showcaseList = {}
                showcaseSpawned = false
            end
        end
        Citizen.Wait(1200)
    end
end)
--======================================================================================================================
-- DEALER
--======================================================================================================================
local cDEALER = {}
Tunnel.bindInterface('Dealership', cDEALER)
local sDEALER = Tunnel.getInterface('Dealership')

local currentDealer = ''

RegisterNetEvent('dealership:open',function(dealer)
    TriggerEvent('gb_core:tabletAnim')
        
    local vehicles = {}
    local myVehicles = {}

    local stock, vehs = sDEALER.getStock(dealer)

    for _, v in ipairs(stock) do
        if (v.stock > 0) then
            table.insert(vehicles, {
                type = vehicleType(v.car),
                spawn = v.car,
                name = vehicleName(v.car),
                maker = vehicleMaker(v.car),
                class = vehicleClass(v.car),
                trunk_capacity = vehicleTrunk(v.car), 
                speed = math.ceil(GetVehicleModelEstimatedMaxSpeed(v.car)*3.605936),
                acceleration = math.ceil(GetVehicleModelAcceleration(v.car)*1000),
                stock = v.stock,
                price = vehiclePrice(v.car),
            })
        end
    end
    
    for _, v in ipairs(vehs) do
        table.insert(myVehicles, {
            type = vehicleType(v.vehicle),
            spawn = v.vehicle,
            id = v.id,
            plate = v.plate,
            name = vehicleName(v.vehicle),
            maker = vehicleMaker(v.vehicle),
            class = vehicleClass(v.vehicle),
            trunk_capacity = vehicleTrunk(v.vehicle), 
            speed = math.ceil(GetVehicleModelEstimatedMaxSpeed(v.vehicle)*3.605936),
            acceleration = math.ceil(GetVehicleModelAcceleration(v.vehicle)*1000),
            price = math.floor(vehiclePrice(v.vehicle) * config.sell_percent),
        })
    end

    currentDealer = dealer
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'dealership', cars = vehicles, myVehicles = myVehicles })
end)

RegisterNuiCallback('testDrive', function(data)
    sDEALER.testDrive(currentDealer,data.spawn)
end)

RegisterNuiCallback('buyCar', function(data)
    sDEALER.buyVehicle(currentDealer,data.spawn)
end)

RegisterNuiCallback('sellCar', function(data)
    sDEALER.sellVehicle(currentDealer,data.id)
end)

local configTest = config.testdrive
local cooldown = 0

function cDEALER.startTest(dealer,spawn)
    DoScreenFadeOut(500)
    Wait(500)

    if IsWaypointActive() then
        DeleteWaypoint()
        Wait(3000)
    end

    local ped = PlayerPedId()
    local random = configTest[dealer][math.random(#configTest[dealer])]
    SetEntityCoords(ped, random.xyz)

    RequestModel(spawn)
    while not HasModelLoaded(spawn) do
        Wait(50)
    end

    local vehicle = CreateVehicle(spawn, random.xyz, random.w, false)
    SetModelAsNoLongerNeeded(spawn)
    SetPedIntoVehicle(ped, vehicle, -1)
    Entity(vehicle).state['id'] = -1

    DoScreenFadeIn(500)
    TimeDealership(60)
    while (cooldown > 0 and IsPedInAnyVehicle(ped)) do
        DisableControlAction(0, 23, true)
        Text2D(0, 0.35, 0.95, 'O ~b~TESTE DRIVE~w~ TERMINA EM ~b~'..cooldown..' SEGUNDOS~w~', 0.4)
        Citizen.Wait(1)
    end
    cooldown = 0

    DoScreenFadeOut(500)
    Wait(500)

    Entity(vehicle).state['id'] = nil
    DeleteEntity(vehicle)
    sDEALER.exitTestDrive()

    DoScreenFadeIn(500)
end

TimeDealership = function(time)
    if (cooldown > 0) then return; end;
    cooldown = time
    Citizen.CreateThread(function()
        while (cooldown > 0) do
            Citizen.Wait(1000)
            cooldown = (cooldown - 1)
        end
        cooldown = 0
    end)
end
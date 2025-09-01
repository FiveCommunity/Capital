local inVehicle = false

AddEventHandler('gameEventTriggered', function(event, args)
    if (event == 'CEventNetworkPlayerEnteredVehicle') then
        local id = args[1]
        local vehicle = args[2]
        if (id == PlayerId()) then            
            if (inVehicle) then return; end;
            inVehicle = true

            if (GetVehicleClass(vehicle) == 18) then RadarThread(); end;
        end
    end
end)

local radar = {
    active = false,
    freezeRadar = false,

    frontModel = 'Carregando...',
    frontPlate = 'Carregando...',
    frontSpeed = 0,

    rearModel = 'Carregando...',
    rearPlate = 'Carregando...',
    rearSpeed = 0
}

RadarThread = function()
    radar.freezeRadar = false
    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)

            local idle = 1000
            if (IsPedInAnyPoliceVehicle(ped)) and radar.active then
                if (not radar.freezeRadar) then
                    idle = 100

                    local vehicle = GetVehiclePedIsUsing(ped)
                    local vehicleDimension = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.0, 1.0)

                    local vehicleFront = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 105.0, 0.0)
                    local vehicleFrontShape = StartShapeTestCapsule(vehicleDimension, vehicleFront, 3.0, 10, vehicle, 7)
                    local _, _, _, _, vehFront = GetShapeTestResult(vehicleFrontShape)

                    radar.frontModel = 'Carregando...'
                    radar.frontPlate = 'Carregando...'
                    radar.frontSpeed = 0

                    if (IsEntityAVehicle(vehFront)) then
                        radar.frontModel = GetEntityArchetypeName(vehFront)
                        radar.frontPlate = GetVehicleNumberPlateText(vehFront)
                        radar.frontSpeed = GetSpeed(vehFront)
                    end
                    
                    local vehicleBack = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -105.0, 0.0)
                    local vehicleBackShape = StartShapeTestCapsule(vehicleDimension, vehicleBack, 3.0, 10, vehicle, 7)
                    local _, _, _, _, vehBack = GetShapeTestResult(vehicleBackShape)

                    radar.rearModel = 'Carregando...'
                    radar.rearPlate = 'Carregando...'
                    radar.rearSpeed = 0

                    if (IsEntityAVehicle(vehBack)) then
                        radar.rearModel = GetEntityArchetypeName(vehBack)
                        radar.rearPlate = GetVehicleNumberPlateText(vehBack)
                        radar.rearSpeed = GetSpeed(vehBack)
                    end
                    
                    UpdateStats('radar', {
                        show = true,
                        frontal = {
                            plate = radar.frontPlate,
                            model = radar.frontModel,
                            speed = radar.frontSpeed
                        },
                        rear = {
                            plate = radar.rearPlate,
                            model = radar.rearModel,
                            speed = radar.rearSpeed
                        }
                    })
                end
            end
            Citizen.Wait(idle)
        end
        inVehicle = false
        radar.active = false
        UpdateStats('radar', { show = false })
    end)
end

local toggleWait = false
RegisterCommand('+toggleRadar', function()
    local ped = PlayerPedId()
    if (Dependencys(ped) and IsPedInAnyPoliceVehicle(ped)) and (not toggleWait) then
        radar.active = (not radar.active)
        
        UpdateStats('radar', {
            show = radar.active,
            frontal = {
                plate = radar.frontPlate,
                model = radar.frontModel,
                speed = radar.frontSpeed
            },
            rear = {
                plate = radar.rearPlate,
                model = radar.rearModel,
                speed = radar.rearSpeed
            }
        })

        toggleWait = true
        Citizen.SetTimeout(1500, function() toggleWait = false; end)
    end
end)

RegisterCommand('+toggleFreezeRadar', function()
	local ped = PlayerPedId()
	if (Dependencys(ped) and IsPedInAnyPoliceVehicle(ped)) then
		radar.freezeRadar = (not radar.freezeRadar)
        TriggerEvent('notify', 'aviso', 'Radar', 'Radar da viatura <b>'..(radar.freezeRadar and 'travado' or 'destravado')..'</b>.')
	end
end)

RegisterKeyMapping('+toggleRadar', 'Ativar/Desativar radar das viaturas.', 'keyboard', 'BACK')
RegisterKeyMapping('+toggleFreezeRadar', 'Travar/Destravar radar das viaturas.', 'keyboard', 'M')

local cli = {}
Tunnel.bindInterface('Dismantle', cli)
local vSERVER = Tunnel.getInterface('Dismantle')

local inDismantle, object = false, nil
local ply, plyCoords, plyVehicle = nil, vector3(0,0,0), nil

local act = false
local vehicleCache = {}

Citizen.CreateThread(function()
    local _idle = 1000
    while true do
        if inDismantle then
            _idle = 1
            drawTxt("Aproxime-se do carro para desmanchar.",4,0.5,0.95,0.5,255,255,255,500)
        else
            _idle = 1000
        end
        Wait(_idle)
    end
end)

local parts = {
    ['door_dside_f'] = {
        type = 'door',
        id = 0,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            TriggerEvent('gb_animations:setAnim', 'consertar')
            SetVehicleDoorOpen(vehicle, id, false, false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['door_pside_f'] = {
        type = 'door',
        id = 1,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            TriggerEvent('gb_animations:setAnim', 'consertar')
            SetVehicleDoorOpen(vehicle, id, false, false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['door_dside_r'] = {
        type = 'door',
        id = 2,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            TriggerEvent('gb_animations:setAnim', 'consertar')
            SetVehicleDoorOpen(vehicle, id, false, false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['door_pside_r'] = {
        type = 'door',
        id = 3,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            TriggerEvent('gb_animations:setAnim', 'consertar')
            SetVehicleDoorOpen(vehicle, id, false, false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['bonnet'] = {
        type = 'door',
        id = 4,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleDoorDamaged(vehicle, id)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            TriggerEvent('gb_animations:setAnim', 'consertar')
            SetVehicleDoorOpen(vehicle, id, false, false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleDoorBroken', VehToNet(vehicle), id)
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_lf'] = {
        type = 'tyre',
        id = 0,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lf')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_rf'] = {
        type = 'tyre',
        id = 1,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rf')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_lm1'] = {
        type = 'tyre',
        id = 2,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lm1')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_rm1'] = {
        type = 'tyre',
        id = 3,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rm1')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_lm2'] = {
        type = 'tyre',
        id = 45,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lm2')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_rm2'] = {
        type = 'tyre',
        id = 47,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rm2')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_lm3'] = {
        type = 'tyre',
        id = 46,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lm3')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_rm3'] = {
        type = 'tyre',
        id = 48,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rm3')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_lr'] = {
        type = 'tyre',
        id = 4,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_lr')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['wheel_rr'] = {
        type = 'tyre',
        id = 5,
        time = 8000,
        status = function(vehicle, id)
            return IsVehicleTyreBurst(vehicle, id, false)
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1 }, 
            false)
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('syncVehicleTireBroken', VehToNet(vehicle), id, 'wheel_rr')
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    },
    ['engine'] = {
        type = 'part',
        id = 5,
        time = 8000,
        status = function(vehicle, id)
            local engine = GetVehicleEngineHealth(vehicle)            
            if (engine <= 200.0 )then
                return true
            end
            return false
        end,
        action = function(vehicle, vehicletype, id, time, name, plate)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, 
                { 'mini@repair', 'fixing_a_player', 1 }, 
            false)
            SetVehicleEngineOn(vehicle, false, true, true)
            SetVehicleEngineCanDegrade(vehicle, true)
            TriggerServerEvent('syncVehicleEngineBroken', VehToNet(vehicle))
            TriggerEvent('ProgressBar', 10000)
            Citizen.Wait(10000)    
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
            return true
        end
    }
}

local checkAllPartsDestroyed = function()
    local f = 0
    if vehicleCache.parts and countTable(vehicleCache.parts) > 0 then
        for k, v in pairs(vehicleCache.parts) do
            if v.destroy or v.destroy == 1 then
                f = f + 1
            end
        end
    end

    if vehicleCache.parts and (f >= countTable(vehicleCache.parts)) then
        return true
    end
    return false
end

local startDismantle = function()
    Citizen.CreateThread(function()
        while (inDismantle) do
            local vehicle = vehicleCache.vehicle
            for k, v in pairs(vehicleCache.parts) do
                local new_vehicle = GetVehiclePedIsIn(ply, false)
                if (new_vehicle > 0 and new_vehicle ~= vehicle) then
                    vehicleCache = {}
                    vSERVER.cancelDismantle()
                end

                local doors = GetNumberOfVehicleDoors(vehicle)
                local ebone = GetEntityBoneIndexByName(vehicle, k)
                local cbone = GetWorldPositionOfEntityBone(vehicle, ebone)

                local distance = #(plyCoords - cbone)
                if (distance <= 5.0 and not act and not parts[k].status(vehicle, v.id) and not vehicleCache.parts[k].destroy and not IsPedInVehicle(ped, vehicle, false)) then
                    Text3D(cbone.x, cbone.y, cbone.z, '~b~E~w~ - REMOVER PEÇA', 400)
                    if (distance <= 1.2 and IsControlJustPressed(0, 38)) then
                        act = true
                        if (parts[k].action(vehicle, v.type, v.id, v.time, v.name, v.plate)) then
                            vehicleCache.parts[k].destroy = true
                            act = false
                        else
                            act = false
                        end
                    end
                end
            end

            if (checkAllPartsDestroyed()) then
                if (DoesEntityExist(vehicle)) then
                    inDismantle = false
                    vSERVER.finishDismantle()
                end
            end
            Citizen.Wait(1)
        end
        vehicleCache = {}
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local idle = 1000

        ply = PlayerPedId()
        plyCoords = GetEntityCoords(ply)
        plyVehicle = GetVehiclePedIsIn(ply)
        
        if (not inDismantle and IsPedInAnyVehicle(ply)) and (DoesEntityExist(plyVehicle) and GetPedInVehicleSeat(plyVehicle, -1) == ply) then
            for i,v in pairs(Dismantle.locations) do
                local distance =  #(plyCoords - v.coords)
                if (distance <= 20.0) then
                    idle = 5
                    
                    DrawMarker(27, v.coords.x, v.coords.y, (v.coords.z-0.9), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 255, 0, 0, 155, 0, 0, 0, 1, 0, 0, 0)
                    if (distance <= 5.0) and (IsControlJustPressed(0, 38) and GetEntityHealth(ply) > 100) then
                        vSERVER.checkDismantle(VehToNet(plyVehicle), GetEntityModel(plyVehicle))
                    end
                end
            end
        end

        Citizen.Wait(idle)
    end
end)

cli.generateParts = function(vname, vplate)
    if (plyVehicle) and DoesEntityExist(plyVehicle) then
        vehicleCache.vehicle = plyVehicle
        vehicleCache.parts = {}
        for k, v in pairs(parts) do
            local ebone = GetEntityBoneIndexByName(plyVehicle, k)
            if (ebone ~= -1 and ebone ~= 25 and not parts[k].status(plyVehicle, v.id)) then
                vehicleCache.parts[k] = {}
                vehicleCache.parts[k].vehicle = plyVehicle
                vehicleCache.parts[k].name = vname
                vehicleCache.parts[k].id = v.id
                vehicleCache.parts[k].time = v.time
                vehicleCache.parts[k].plate = vplate
                vehicleCache.parts[k].destroy = parts[k].status(plyVehicle, v.id)
            end
        end

        inDismantle = true
        TaskLeaveAnyVehicle(ply, true, true)
        FreezeEntityPosition(plyVehicle, true)
        startDismantle()
    end
end

RegisterNetEvent('setVehicleDoorBroken', function(vehNet, id)
    if (NetworkDoesEntityExistWithNetworkId(vehNet)) then
        local vehicle = NetToVeh(vehNet)
        if (vehicle) and DoesEntityExist(vehicle) then
            SetVehicleDoorBroken(vehicle, id, false)
        end
    end
end)

RegisterNetEvent('setVehicleTireBroken', function(vehNet, id, bone)
    if (NetworkDoesEntityExistWithNetworkId(vehNet)) then
        local vehicle = NetToVeh(vehNet)
        if (vehicle) and DoesEntityExist(vehicle) then
            SetVehicleTyreBurst(vehicle, id, true, 1000.0)
            DecorSetFloat(vehicle, bone, 1000.0)
        end
    end
end)

RegisterNetEvent('setVehicleEngineBroken', function(vehNet, id, bone)
    if (NetworkDoesEntityExistWithNetworkId(vehNet)) then
        local vehicle = NetToVeh(vehNet)
        if (vehicle) and DoesEntityExist(vehicle) then
            SetVehicleEngineHealth(vehicle, value)
        end
    end
end)

Text3D = function(x,y,z,text,size)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    if onScreen then
        SetTextFont(4)
        SetTextScale(0.35,0.35)
        SetTextColour(255,255,255,155)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text))/size
        DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
    end
end

drawTxt = function(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
local cli = {}
Tunnel.bindInterface('Robberys', cli)
local vSERVER = Tunnel.getInterface('Robberys')

Citizen.CreateThread(function()
    for _, v in pairs(Robberys.locations) do
        TriggerEvent('insert:hoverfy', v.coord.xyz, 'G', 'Iniciar Roubo', 1.5)
    end
end)

local nearestRobbery = function(ply)
    local robbery, minDist = false, 10
    for k, data in pairs(Robberys.locations) do
        local dist = #(GetEntityCoords(ply) - data.coord.xyz)
        if (dist <= 1.5) and (dist < minDist) then
            robbery, minDist = k, dist
        end
    end
    return robbery
end

RegisterCommand('robbery', function()
    local ply = PlayerPedId()
    local nearest = nearestRobbery(ply)
    if (nearest) and Robberys.locations[nearest] then
        vSERVER.startRobbery(nearest)
    end
end)

cli.startMinigame = function()
    local result = exports['hackingdevice']:StartHackingDevice(60, 'random')
    return result
end

RegisterKeyMapping('robbery', 'Roubar', 'KEYBOARD', 'G')

local inRobbery = false
local seconds = 0

cli.startRobbery = function(table)
    inRobbery = true
    seconds = table.secs
    Citizen.CreateThread(function()
        local ply = PlayerPedId()
        local cancel = false

        SetPedComponentVariation(ply, 5, 45, 0, 2)

        if (not table.inside) then
            SetEntityHeading(ply, table.coords.w)
            LocalPlayer.state.BlockTasks = true
            vRP.playAnim(false, { 'anim@heists@ornate_bank@grab_cash_heels', 'grab' }, true)
        end

        while (inRobbery) do
            Text3D(table.coords.x, table.coords.y, table.coords.z, '~b~'..seconds..'~w~ - SEGUNDOS | ~b~M~w~ - CANCELAR', 400)
            
            if (IsPedInAnyVehicle(ply)) or (IsControlJustPressed(0, 301)) or (GetEntityHealth(ply) <= 100) then
                cancel = true 
            end

            if (table.inside) then
                local plyCoords = GetEntityCoords(ply)
                local dist = #(table.coords.xyz - plyCoords)
                
                if (dist > (table.inside*0.70)) then
                    Text2D(0, 0.42, 0.95, 'VOCÊ ESTÁ LONGE DO ~b~ROUBO~w~!', 0.3)
                end
                
                if (dist > table.inside) then
                    cancel = true
                    TriggerEvent('notify', 'aviso', 'Roubo', 'Você se distanciou muito do <b>roubo</b>!')
                end
            end

            if (cancel) then
                inRobbery = false
                TriggerServerEvent('system:roubos:cancel')
            end
            Citizen.Wait(1)
        end

        if (not table.inside) then
            LocalPlayer.state.BlockTasks = false
            ClearPedTasks(ply)
        end
    end)
end

RegisterNetEvent('system:roubos:update_secs', function(secs) 
    seconds = secs 

    if (seconds == 0) then
        inRobbery = false
    end
end)
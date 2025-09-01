sLUM = Tunnel.getInterface(GetCurrentResourceName()..':lumberjack')

lumberData = {
    step = 0,
    selected = 0,

    steps = {
        [1] = function(ped, coords, loop)
            if (loop) then
                Text2D(0, 0.43, 0.95, 'Vá até a ~b~Madereira~w~', 0.4)

                local dist = #(coords - Lumberjack.start)
                if (dist <= 10.0) and (not IsPedInAnyVehicle(ped)) then
                    DrawMarker(1, Lumberjack.start.x, Lumberjack.start.y, (Lumberjack.start.z-0.97), 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 3, 187, 232, 155, 0, 0, 0, 1)
                    
                    if (dist <= 2.0) then 
                        RemoveBlip(blip)
                        PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 1)
                        return 2
                    end
                end
            else
                TriggerEvent('notify', 'importante', 'Lenhador', 'Você entrou em <b>serviço</b>! Vá até a <b>Madereira</b<!',8000)
                blipRoute(Lumberjack.start, 'Localização')
            end
        end,

        [2] = function(ped, coords, loop)
            local treeCoord = Lumberjack.trees[lumberData.selected]
            if (loop) then
                Text2D(0, 0.43, 0.95, 'Corte a ~b~árvore~w~', 0.4)   
                
                local dist = #(coords - treeCoord.xyz)
                if (dist <= 120.0) and (not IsPedInAnyVehicle(ped)) then
                    TextFloating('~INPUT_PICKUP~ - Cortar a árvore', treeCoord.xyz)
                    DrawMarker(21, treeCoord.x, treeCoord.y, treeCoord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 3, 187, 232, 155, 1, 0, 0, 1, 0, 0, 0)
                    
                    if (dist <= 1.2 and IsControlJustPressed(0, 38)) and (Lumberjack.weapons[GetSelectedPedWeapon(ped)]) then
                        RemoveBlip(blip)
                        SetEntityHeading(ped, treeCoord.w)
                        lumberData.selected = sLUM.receivePayment()
                        blipRoute(Lumberjack.trees[lumberData.selected].xyz, 'Árvore')
                    end
                end
            else
                lumberData.selected = sLUM.generateRoute()
                blipRoute(Lumberjack.trees[lumberData.selected].xyz, 'Árvore')
            end
        end,
    }
}

RegisterJob({
    name = 'Lenhador',
    business = 'Madeireira',
    payment = 'R$130,00/250,00',
    routes = 0,
    description = 'Leve a madeira de maior qualidade do Capital.',
    url = 'img/lenhador.png',

    start = function()
        inWork = 'Lenhador'

        Citizen.CreateThread(function()
            lumberData.step = 1;
            lumberData.steps[lumberData.step](ped, coords)
        
            while (inWork) do
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)

                if (GetEntityHealth(ped) > 100) then
                    local nextStep = lumberData.steps[lumberData.step](ped, coords, true)
                    if (nextStep) and (nextStep > 0) then
                        lumberData.step = nextStep
                        lumberData.steps[lumberData.step](ped, coords)
                    end
                end
                Citizen.Wait(4)
            end
        end)
    end,

    stop = function()
        inWork = false
        laundryData.step = 0
        sLUM.resetRoute()
        if (DoesBlipExist(blip)) then RemoveBlip(blip); end;
        TriggerEvent('notify', 'importante', 'Lenhador', 'Você finalizou o <b>serviço</b>!', 8000)
    end
})
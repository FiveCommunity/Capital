sLAU = Tunnel.getInterface(GetCurrentResourceName()..':laundry')

laundryData = {
    step = 0,
    selected = 0,

    steps = {
        [1] = function(ped, coords, loop)
            if (loop) then
                Text2D(0, 0.43, 0.95, 'Vá até o local da ~b~Empresa~w~', 0.4)

                local dist = #(coords - Laundry.start)
                if (dist <= 10.0) and (not IsPedInAnyVehicle(ped)) then
                    DrawMarker(1, Laundry.start.x, Laundry.start.y, (Laundry.start.z-0.97), 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 3, 187, 232, 155, 0, 0, 0, 1)
                    
                    if (dist <= 2.0) then 
                        RemoveBlip(blip)
                        PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 1)
                        return 2
                    end
                end
            else
                TriggerEvent('notify', 'importante', 'Lavanderia', 'Você entrou em <b>serviço</b>! Vá até o emprego de <b>Lavanderia</b>!',8000)
                blipRoute(Laundry.start, 'Loc. Empresa')
            end
        end,

        [2] = function(ped, coords, loop)
            local soapsCoords = Laundry.soapsCoords[laundryData.selected]
            if (loop) then
                Text2D(0, 0.4, 0.92, 'Pressione ~b~M~w~ para iniciar a rota', 0.4)   
                Text2D(0, 0.43, 0.95, 'Colete os ~b~sabões~w~', 0.4)   
                
                local dist = #(coords - soapsCoords.xyz)
                if (dist <= 15.0) and (not IsPedInAnyVehicle(ped)) then
                    TextFloating('~INPUT_PICKUP~ - Pegar sabão', soapsCoords.xyz)
                    DrawMarker(21, soapsCoords.x, soapsCoords.y, soapsCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 3, 187, 232, 155, 1, 0, 0, 1, 0, 0, 0)
                    
                    if (dist <= 1.2 and IsControlJustPressed(0, 38)) then
                        SetEntityHeading(ped, soapsCoords.w)
                        laundryData.selected = sLAU.receivePayment('soap')
                    end
                end

                if (IsControlJustPressed(0, 301)) then sLAU.resetRoute() return 3; end;
            else
                startMachines()
            end
        end,

        [3] = function(ped, coords, loop) 
            if (loop) then
                Text2D(0, 0.43, 0.95, 'Entregue as ~b~roupas~w~', 0.4)   

                local deliveryCoord = Laundry.deliverysCoords[laundryData.selected]
                local dist = #(coords - deliveryCoord.xyz)
                if (dist <= 20.0) then
                    DrawMarker(21, deliveryCoord.x, deliveryCoord.y, deliveryCoord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 3, 187, 232, 155, 1, 0, 0, 1, 0, 0, 0)
                    
                    if (dist <= 1.2 and IsControlJustPressed(0, 38)) then
                        if (lastVehicleModel(GetPlayersLastVehicle(), Laundry.vehicle)) then
                            RemoveBlip(blip)
                            SetEntityHeading(ped, deliveryCoord.w)
                            laundryData.selected = sLAU.receivePayment('delivery')
                            blipRoute(Laundry.deliverysCoords[laundryData.selected].xyz, 'Entrega')
                        else
                            TriggerEvent('notify', 'aviso', 'Lavanderia', 'Você não está com o <b>veículo</b> da empresa!')
                        end
                    end
                 end
            else
                laundryData.selected = sLAU.generateRoute('deliverysCoords')
                blipRoute(Laundry.deliverysCoords[laundryData.selected].xyz, 'Entrega')
                TriggerEvent('notify', 'importante', 'Lavanderia', 'Você iniciou a <b>rota</b>!')
            end
        end
    }
}

local ped, coords = nil, vector3(0,0,0)

RegisterJob({
    name = 'Lavanderia',
    business = 'Ju Limpezas',
    payment = 'R$130,00/250,00',
    routes = 0,
    description = 'Deixe as roupas dos clientes impecáveis.',
    url = 'img/lavanderia.png',

    start = function()
        inWork = 'Lavanderia'

        Citizen.CreateThread(function()
            laundryData.selected = sLAU.generateRoute('soapsCoords');      
            laundryData.step = 1;
            laundryData.steps[laundryData.step](ped, coords)
        
            while (inWork) do
                ped = PlayerPedId()
                coords = GetEntityCoords(ped)

                if (GetEntityHealth(ped) > 100) then
                    local nextStep = laundryData.steps[laundryData.step](ped, coords, true)
                    if (nextStep) and (nextStep > 0) then
                        laundryData.step = nextStep
                        laundryData.steps[laundryData.step](ped, coords)
                    end
                end
                Citizen.Wait(4)
            end
        end)
    end,

    stop = function()
        inWork = false
        laundryData.step = 0
        sLAU.resetRoute()
        if (DoesBlipExist(blip)) then RemoveBlip(blip); end;
        TriggerEvent('notify', 'importante', 'Lavanderia', 'Você finalizou o <b>serviço</b>!', 8000)
    end
})

local threadStarted = false
local nearestMachines = {}

startMachines = function()
    local startThread = function()
        if (threadStarted) then return; end;
        threadStarted = true

        Citizen.CreateThread(function()
            while (countTable(nearestMachines) > 0) do
                for index, dist in pairs(nearestMachines) do
                    local coord = Laundry.machinesCoords[index]
                    DrawMarker(21, coord.x, coord.y, coord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 3, 187, 232, 155, 1, 0, 0, 1, 0, 0, 0)  
                
                    if (dist <= 1.2 and IsControlJustPressed(0, 38)) and (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100) then
                        SetEntityHeading(ped, coord.w)
                        sLAU.receivePayment('machine', index)
                    end 
                end
                Citizen.Wait(4)
            end
            threadStarted = false
        end)
    end

    Citizen.CreateThread(function()
        while (laundryData.step >= 2) do
            nearestMachines = {}
            for k, v in pairs(Laundry.machinesCoords) do
                local dist = #(coords - v.xyz)
                if (dist <= 5.0) then
                    nearestMachines[k] = dist
                end
            end
            if (countTable(nearestMachines) > 0) then startThread(); end; 
            Citizen.Wait(1000)
        end
        nearestMachines = {}
    end)
end
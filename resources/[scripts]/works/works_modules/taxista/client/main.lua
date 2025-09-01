sTAXI = Tunnel.getInterface(GetCurrentResourceName()..':taxi')

taxiData = {
 
    step = 0,
    timer = 0,

    races = true,
    currentRace = 0,
    currentDeliver = 0,
    npc = false,
}


taxiSteps = {
    [1] = function(ped,coords,loop,params)
        if (loop) then
            Text2D(0, 0.68, 0.95, 'Vá até o local da ~b~Empresa~w~', 0.4)
            local distance = #(coords - Taxista.start)
            if (distance <= 10.0) then
                DrawMarker(1, Taxista.start.x, Taxista.start.y, Taxista.start.z-0.97, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 3, 187, 232, 155, 0, 0, 0, 1)
                if (distance <= 2.0 and not IsPedInAnyVehicle(ped)) then 
                    RemoveBlip(blips)
                    PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 1)
                    return 2
                end
            end
        else
            TriggerEvent('Notify','importante','Taxista','Você entrou em <b>serviço</b>! Vá até o emprego de <b>Taxista</b>!',8000)
            createBlip(Taxista.start)
        end
    end,

    [2] = function(ped,coords,loop,params)
        if (loop) then
            Text2D(0, 0.68, 0.95, 'Alugue um ~b~Taxi~w~', 0.4)
            if PedDrivingTaxi(ped) then
                return 3
            end
        else
            TriggerEvent('Notify','importante','Taxista','Retire um <b>Taxi</b> da Garagem, e entre para iniciar as corridas!',8000)
        end
    end,

    [3] = function(ped,coords,loop,params)
        if (loop) then
            
            local vehicle = PedDrivingTaxi(ped)
            if vehicle then

                Text2D(0, 0.68, 0.93, '~b~[Q] ~w~Chamados '..((taxiData.races and '~g~habilitados~w~') or '~r~deshabilitados~w~'), 0.3)
                if taxiData.races then
                    Text2D(0, 0.68, 0.95, 'Aguarde por um ~r~Chamado~w~', 0.4)
                   
                    if (taxiData.timer < GetGameTimer()) then
                    
                        if taxiData.races then
                           
                            local newRace = taxiData.currentRace

                            while (newRace == taxiData.currentRace) do
                                newRace = math.random(1,#Taxista.clients)
                                Citizen.Wait(1)
                            end

                            return 4, { race = newRace }
                        end
                    end

                end

            else
                Text2D(0, 0.68, 0.95, 'Volte para o ~b~Taxi~w~', 0.4)
            end
        else
            sTAXI.toggleService(true)
            taxiData.timer = RouteTimer()
        end
    end,

    [4] = function(ped,coords,loop,params)
        if (loop) then
            
            local vehicle = PedDrivingTaxi(ped)
            if vehicle then

                Text2D(0, 0.68, 0.93, '~b~[Q] ~w~Chamados '..((taxiData.races and '~g~habilitados~w~') or '~r~deshabilitados~w~'), 0.3)
                Text2D(0, 0.68, 0.95, 'Vá até o ~b~Cliente~w~', 0.4)
                
                local client = Taxista.clients[taxiData.currentRace]
                
                local dist = #(coords - client.car.xyz)
                if (dist < 50) then
                    
                    if (not taxiData.npc) then

                        taxiData.npc = CreateTaxiClient(client.npc)

                    else
                        DrawMarker(1, client.car.x, client.car.y, client.car.z-0.55, 0.0,0.0,0.0, 0.0,0.0,0.0, 2.0,2.0,1.0, 249,55,99,155, 0,0,0,0)
                        if (dist < 2.0) then
                            if IsControlJustPressed(0,54) then

                                RemoveBlip(blips)
                                FreezeEntityPosition(taxiData.npc,false)
                                TaskEnterVehicle(taxiData.npc,vehicle,-1,2,1.0,8,0)

                                while (GetVehiclePedIsIn(taxiData.npc) ~= vehicle) and DoesEntityExist(taxiData.npc) do
                                    Wait(100)
                                    if (not GetIsTaskActive(taxiData.npc,160)) then
                                        TaskEnterVehicle(taxiData.npc,vehicle,-1,2,1.0,8,0)
                                    end
                                    if #(GetEntityCoords(ped) - GetEntityCoords(taxiData.npc)) > 50 then
                                        if (taxiData.npc) then
                                            DeleteTaxiClient(taxiData.npc)
                                            taxiData.npc = false
                                        end
                                        local client = Taxista.clients[taxiData.currentRace]
                                        createBlip(client.car,false,false,'Cliente')
                                        return
                                    end
                                end
                                
                                return 5
                                
                            end
                        end
                    end

                else
                    if (taxiData.npc) then
                        DeleteTaxiClient(taxiData.npc)
                        taxiData.npc = false
                    end
                end


            else
                Text2D(0, 0.68, 0.95, 'Volte para o ~b~Taxi~w~', 0.4)
            end
        else
            if params then
                taxiData.currentRace = params.race

                local client = Taxista.clients[taxiData.currentRace]
                createBlip(client.car,false,false,'Cliente')

                TriggerEvent('Notify','importante','Taxista','Um <b>Cliente</b> está aguardando! Vá busca-lo!',8000)
            end
        end
    end,

    [5] = function(ped,coords,loop,params)
        if (loop) then
            
            local vehicle = PedDrivingTaxi(ped)
            if vehicle then

                Text2D(0, 0.68, 0.93, '~b~[Q] ~w~Chamados '..((taxiData.races and '~g~habilitados~w~') or '~r~deshabilitados~w~'), 0.3)
                Text2D(0, 0.68, 0.95, 'Vá até o ~b~Destino~w~', 0.4)
                
                local delivery = Taxista.deliveries[taxiData.currentDeliver]
             
                local dist = #(coords - delivery.coords.xyz)
                if (dist < 50) then
                    
                    DrawMarker(1, delivery.coords.x, delivery.coords.y, delivery.coords.z-0.55, 0.0,0.0,0.0, 0.0,0.0,0.0, 2.0,2.0,1.0, 249,55,99,155, 0,0,0,0)
                    
                    if (dist < 2.0) then
                        if IsControlJustPressed(0,54) then
                           
                            RemoveBlip(blips)

                            TaskLeaveVehicle(taxiData.npc,vehicle,1)
                            TaskWanderStandard(taxiData.npc,10.0,10)

                            sTAXI.payment(GetNetworkTime())

                            SetTimeout(8000,function()
                                DeleteTaxiClient(taxiData.npc)
                                taxiData.npc = false
                            end)
                                            
                            return 3
                        end
                    end
                end

            else
                Text2D(0, 0.68, 0.95, 'Volte para o ~b~Taxi~w~', 0.4)
            end
        else
            taxiData.currentDeliver = sTAXI.generateRace('currentDeliver')

            local delivery = Taxista.deliveries[ taxiData.currentDeliver ]
            if delivery.text then
                TriggerEvent('Notify','importante','Taxista - Cliente',delivery.text,8000)
            end

            local client = Taxista.clients[taxiData.currentRace]
            local dist = CalculateTravelDistanceBetweenPoints(client.car,delivery.coords)
            if dist > 10000 then dist = 10000; end;
            sTAXI.distanceDeliver(taxiData.currentDeliver, dist)

            createBlip(delivery.coords,false,false,'Destino')
        end
    end,

}

RegisterJob({
    name = 'Taxista',
    business = 'Downtown Cab Co.',
    payment = 'R$1000,00/1500,00',
    routes = 10,
    perfectCity = true,
    description = 'Os cidadãos precisam de uma maneira eficiente de transitar.',
    url = 'img/taxi.png',

    start = function()
        inWork = 'Taxista'

        Citizen.CreateThread(function()
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            taxiData.step = 1
            taxiSteps[taxiData.step](ped,coords,false)
            
            while (inWork) do
                ped = PlayerPedId()
                coords = GetEntityCoords(ped)

                local nextStep, nextData = taxiSteps[taxiData.step](ped,coords,true)
                if nextStep and (nextStep > 0) then
                    taxiData.step = nextStep
                    taxiSteps[taxiData.step](ped,coords,false,nextData)
                end

                if (IsControlJustPressed(0, 85)) then
                    local vehicle = GetVehiclePedIsIn(ped,false)
                    if (vehicle > 0) then
                        local model = GetEntityModel(vehicle)
                        if Taxista.vehicles[model] and (GetPedInVehicleSeat(vehicle,-1) == ped) then
                            taxiData.races = (not taxiData.races)
                            SetTaxiLights(vehicle,taxiData.races)
                            if taxiData.races then
                                taxiData.timer = RouteTimer()
                            end
                        end
                    end
                end

                Citizen.Wait(1)
            end
        end)
    end,

    stop = function()
        -- Job Status
        inWork = false
        -- Vars
        taxiData.step = 0
        taxiData.timer = 0
        taxiData.currentRace = 0  
        taxiData.currentDeliver = 0
        -- Exit
        sTAXI.toggleService(false)
        -- Blip
        if DoesBlipExist(blips) then RemoveBlip(blips); end;
        -- Delete NPC
        DeleteTaxiClient(taxiData.npc)
        taxiData.npc = false
        -- Message
        TriggerEvent('notify', 'importante', 'Taxista', 'Você saiu de <b>serviço</b>!', 8000)
    end
})

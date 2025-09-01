sTRU = Tunnel.getInterface(GetCurrentResourceName()..':carman')

truckData = {
    step = 0,
    load = {},
    leave = true,

    steps = {
        [1] = function(ped, coords, loop)
            if (loop) then
                Text2D(0, 0.43, 0.95, 'Alugue um ~b~caminhão~w~', 0.4)

                local model = GetEntityModel(GetVehiclePedIsIn(ped))
                if (Carman.trucks[model]) then return 2 end;
            else
                TriggerEvent('Notify', 'importante', 'Caminhoneiro', 'Retire um <b>caminhão</b> da garagem!', 8000)
            end
        end,

        [2] = function(ped, coords, loop)
            if (loop) then
                local pedVeh = GetVehiclePedIsIn(ped)
                local model = GetEntityModel(pedVeh)
                if (Carman.trucks[model]) then
                    Text2D(0, 0.43, 0.95, 'Pegue a ~b~carga~w~', 0.4)
                    
                    if (not truckData.load.netId) then
                        local dist = #(coords - Carman.get_load)
                        if (dist <= 20.0) and (GetEntityHealth(ped) > 100) then
                            DrawMarker(39, Carman.get_load.x, Carman.get_load.y, (Carman.get_load.z+1.5), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 3, 187, 232, 155, 1, 0, 0, 1, 0, 0, 0)
                            DrawMarker(27, Carman.get_load.x, Carman.get_load.y, (Carman.get_load.z-0.97), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 15.0, 15.0, 15.0, 3, 187, 232, 155, 0, 0, 0, 1, 0, 0, 0)

                            if (dist <= 15.0 and IsControlJustPressed(0, 38)) then
                                truckData.leave = false
                                truckData.load.model = Carman.loads[math.random(#Carman.loads)]

                                RemoveBlip(blip)
                                Citizen.Wait(500)

                                local spawned, loadNetId = sTRU.spawnLoad(truckData.load.model)
                                if (spawned) then 
                                    truckData.load.netId = loadNetId
                                else
                                    TriggerEvent('notify', 'negado', 'Caminhoneiro', 'Todas as <b>vagas</b> se encontram ocupadas no momento.')
                                end
                            end
                        end
                    else
                        local loadHandle = NetworkGetEntityFromNetworkId(truckData.load.netId)
                        local took, actualLoad = GetVehicleTrailerVehicle(pedVeh)
                        if (took) and (actualLoad == loadHandle) then 
                            return 3;
                        else
                            local loadCoords = GetEntityCoords(loadHandle)
                            DrawMarker(0, loadCoords.x, loadCoords.y, (loadCoords.z+5.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 3, 187, 232, 155, 1, 0, 0, 1, 0, 0, 0)
                        end
                    end
                else
                    Text2D(0, 0.43, 0.95, 'Entre no ~b~caminhão~w~', 0.4)
                end
            else
                blipRoute(Carman.get_load, 'Pegue a carga')
                TriggerEvent('notify', 'sucesso', 'Caminhoneiro', 'Dirija até o local designado para carregar sua <b>carga</b>, marcado em seu <b>GPS</b>.')
            end
        end,

        [3] = function(ped, coords, loop)
            local save_load = Carman.routes[truckData.load.model]
            if (loop) then
                local pedVeh = GetVehiclePedIsIn(ped)
                local model = GetEntityModel(pedVeh)
                if (Carman.trucks[model]) then
                    Text2D(0, 0.43, 0.95, 'Entregue a ~b~carga~w~', 0.4)

                    local dist = #(coords - save_load)
                    if (dist <= 20.0) and (GetEntityHealth(ped) > 100) then
                        DrawMarker(27, save_load.x, save_load.y, (save_load.z-0.97), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 15.0, 15.0, 15.0, 3, 187, 232, 155, 0, 0, 0, 1, 0, 0, 0)
                    
                        if (dist <= 15.0 and IsControlJustPressed(0, 38)) then
                            local _, actualLoad = GetVehicleTrailerVehicle(pedVeh)
                            local loadHandle = NetworkGetEntityFromNetworkId(truckData.load.netId)

                            if (loadHandle == actualLoad) then
                                local delivered = sTRU.deleteLoad()
                                if (delivered) then 
                                    RemoveBlip(blip)
                                    Citizen.Wait(500)
                                    return 4 
                                end
                            end

                            TriggerEvent('notify', 'negado', 'Caminhoneiro', 'Você não pode entregar uma <b>carga</b> que não lhe foi designada.')
                        end
                    end
                else
                    Text2D(0, 0.43, 0.95, 'Entre no ~b~caminhão~w~', 0.4)
                end
            else
                blipRoute(save_load, 'Entregue a Carga')
                TriggerEvent('notify', 'sucesso', 'Caminhoneiro', 'Entregue a <b>carga</b> no destino indicado em seu <b>GPS</b>.') 
            end
        end,

        [4] = function(ped, coords, loop)
            local finish = Carman.routes.finish
            if (loop) then
                local pedVeh = GetVehiclePedIsIn(ped)
                local model = GetEntityModel(pedVeh)
                if (Carman.trucks[model]) then
                    Text2D(0, 0.43, 0.95, 'Retorne para a ~b~empresa~w~', 0.4)

                    local dist = #(coords - finish)
                    if (dist <= 20.0) and (GetEntityHealth(ped) > 100) then
                        DrawMarker(27, finish.x, finish.y, (finish.z-0.97), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 15.0, 15.0, 15.0, 3, 187, 232, 155, 0, 0, 0, 1, 0, 0, 0)
                    
                        if (dist <= 15.0 and IsControlJustPressed(0, 38)) then
                            inWork = false

                            RemoveBlip(blip)
                            sTRU.receivePayment(truckData.load.model)

                            TriggerEvent('notify', 'importante', 'Caminhoneiro', 'Você finalizou o <b>serviço</b>!', 8000)
                        end
                    end
                else
                    Text2D(0, 0.43, 0.95, 'Entre no ~b~caminhão~w~', 0.4)
                end
            else
                blipRoute(finish, 'Finalizar o Serviço')
                TriggerEvent('notify', 'sucesso', 'Caminhoneiro', 'Parabéns! A entrega da <b>carga</b> foi realizada com sucesso. Agora, retorne para a <b>empresa</b> e conclua o serviço.') 
            end
        end
    },
}

RegisterJob({
    name = 'Caminhoneiro',
    hidden = true,

    start = function()
        if (sTRU.verifyUser()) then
            inWork = 'Caminhoneiro'

            truckData.leave = true
            truckData.step = 0
            truckData.load = {}

            Citizen.CreateThread(function()
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)

                truckData.step = 1;
                truckData.steps[truckData.step](ped, coords)
            
                while (inWork) do
                    ped = PlayerPedId()
                    coords = GetEntityCoords(ped)

                    local nextStep = truckData.steps[truckData.step](ped, coords, true)
                    if (nextStep) and (nextStep > 0) then
                        truckData.step = nextStep
                        truckData.steps[truckData.step](ped, coords)
                    end
                    Citizen.Wait(4)
                end
            end)
        end
    end,

    stop = function()
        if (truckData.leave) then
            inWork = false

            if (DoesBlipExist(blip)) then RemoveBlip(blip); end;
            sTRU.deleteLoad()

            TriggerEvent('notify', 'importante', 'Caminhoneiro', 'Você finalizou o <b>serviço</b>!', 8000)
        end
    end
})
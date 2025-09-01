sIMP = Tunnel.getInterface(GetCurrentResourceName()..':impound')

impData = { inJob = false }

local impoundSaveThread = false

local waitingSave = function()
    if (impoundSaveThread) then return; end;
    impoundSaveThread = true

    Citizen.CreateThread(function()
        local coords = Impound[impData.inJob].save
        while (impData.inJob) do
            local idle = 1000
            local ped = PlayerPedId()

            local dist = #(GetEntityCoords(ped) - coords)
            if (dist <= 20.0) and (IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100) then
                idle = 5

                DrawMarker(27, coords.x, coords.y, (coords.z-0.97), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 3, 187, 232, 155, 0, 0, 0, 1, 0, 0, 0)
                if (dist <= 5.0 and IsControlJustPressed(0, 38)) and Impound.trucks[ GetEntityModel(GetVehiclePedIsIn(ped,false)) ] then
                    if (impData['mec:towed']) then                          
                        local isImpound = sIMP.removeVehicle( VehToNet(impData['mec:towed']) )
                        
                        impData['mec:towed'] = nil
                        impData['mec:tow'] = nil

                        if (isImpound) then
                            RemoveBlip(blip)
                            startImpound(impData.inJob)
                        end            
                    else
                        TriggerEvent('notify', 'negado', 'Impound', 'Você precisa estar com o veículo em cima do reboque.')
                    end
                end
            end
            Citizen.Wait(idle)
        end
        impoundSaveThread = false
    end)
end

startImpound = function(location)
    local cfg = Impound[location]

    impData.inJob = location;

    TriggerEvent('notify', 'sucesso', 'Impound', 'Aguarde um chamado!')

    local vehicle = Impound.vehicles[math.random(#Impound.vehicles)]
    local created, coords = sIMP.createVehicle(vehicle, cfg.routes)
    if (created) then
        blipRoute(coords.xyz, 'Veículo Danificado')

        vRP.playSound('Event_Message_Purple', 'GTAO_FM_Events_Soundset')
        TriggerEvent('notify', 'sucesso', 'Impound', 'Você recebeu um <b>chamado</b>! <br>Foi adicionado no seu <b>GPS</b> a localização do veículo a ser rebocado.', 8000)
        
        waitingSave()
        return 
    end

    impData.inJob = false
    TriggerEvent('notify', 'importante', 'Impound', 'Tente novamente, mais tarde!')
end

AddStateBagChangeHandler('impound', nil, function (bagName, key, value)
    local entity = GetEntityFromStateBagName(bagName);
    if (not DoesEntityExist(entity)) or (not value) then return; end;

    SetVehicleEngineHealth(entity, 300.0)
    SetVehicleDoorsLocked(entity, 2)

    local backEngine = exports.target:vehicleBackEngine()    
    SetVehicleDoorOpen(entity, (backEngine[GetEntityArchetypeName(entity)] and 5 or 4), false)
end)

RegisterJob({
    name = 'Impound - Sul',
    business = 'Reboque do Rebeco',
    payment = 'R$200,00/250,00',
    routes = 10,
    description = 'Os cidadãos precisam de uma maneira eficiente de se livrar dos carros abandonados.',
    url = '',
    hidden = true,

    start = function()
        if (not inWork) then
            inWork = 'Impound - Sul'
            startImpound('south')
        end
    end,

    stop = function()
        inWork = false
        impData.inJob = false
        if DoesBlipExist(blip) then RemoveBlip(blip); end;
        sIMP.exitService()
        TriggerEvent('notify', 'importante', 'Impound', 'Você saiu de <b>serviço</b>!', 8000)
    end,
})

RegisterJob({
    name = 'Impound - Norte',
    business = 'Reboque do Rebeco',
    payment = 'R$200,00/250,00',
    routes = 10,
    description = 'Os cidadãos precisam de uma maneira eficiente de se livrar dos carros abandonados.',
    url = '',
    hidden = true,

    start = function()
        inWork = 'Impound - Norte'
        startImpound('north')
    end,

    stop = function()
        inWork = false
        impData.inJob = false
        if DoesBlipExist(blip) then RemoveBlip(blip); end;
        sIMP.exitService()
        TriggerEvent('notify', 'importante', 'Impound', 'Você saiu de <b>serviço</b>!', 8000)
    end,
})
sREFEIT = Tunnel.getInterface(GetCurrentResourceName()..':prison:refectory')

local refectoryData = {
    step = 0,
    deliver = 0,
}

RegisterJob({
    name = 'Prison - Refeitorio',
    business = 'Bolingbroke',
    payment = 'Itens',
    routes = 0,
    description = '',
    url = '',
    hidden = true,

    start = function()
        if (not inWork) then
            inWork = 'Prison - Refeitorio'
            refectoryData.step = 1
            TriggerEvent('notify', 'importante', 'Refeitório', 'Você entrou em <b>serviço</b>! Comece a montagem dos pratos!<br><br>Pressione <b>F7</b> para sair do serviço.', 8000)
                        
            Citizen.CreateThread(function()
                while (inWork) do
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    
                    
                    if (refectoryData.deliver == 0) then
                    
                        local stepData = PrisonRefeitorio.steps[refectoryData.step]
                        if (stepData) then
                            if stepData.text then Text2D(0, 0.43, 0.95, stepData.text, 0.4); end;


                            local distance = #(coords - stepData.coords.xyz)
                            if (distance <= 10.0) then
                                DrawMarker(0, stepData.coords.x, stepData.coords.y, stepData.coords.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 3, 187, 232, 155, 0, 0, 0, 1)
                                if (distance <= 1.5) and (IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped)) then 
                                    
                                    if (stepData.runNotify) then TriggerEvent('notify', 'importante', 'Refeitório', stepData.runNotify, 5000); end;

                                    if (type(stepData.coords) == 'vector4') then
                                        SetEntityHeading(ped,stepData.coords.w)
                                    end

                                    LocalPlayer.state.freezeEntity = true
                                    LocalPlayer.state.BlockTasks = true

                                    if (type(stepData.anim) == 'string') then
                                        TriggerEvent('gb_animations:setAnim', stepData.anim)
                                    end
                          
                                    TriggerEvent('ProgressBar', stepData.delay)
                                    Wait(stepData.delay)

                                    ClearPedTasks(ped)
                                    vRP.DeletarObjeto()
                                    LocalPlayer.state.freezeEntity = false
                                    LocalPlayer.state.BlockTasks = false

                                    local newStep = refectoryData.step+1
                                    if (newStep <= #PrisonRefeitorio.steps) then
                                        refectoryData.step = newStep
                                        
                                        local newStepData = PrisonRefeitorio.steps[newStep]
                                        if (newStepData) and (newStepData.startNotify) then TriggerEvent('notify', 'importante', 'Refeitório', newStepData.startNotify, 5000); end;
                                    else
                                        refectoryData.deliver = sREFEIT.newDelivery()
                                        LocalPlayer.state.BlockTasks = true
                                        TriggerEvent('gb_animations:setAnim', 'bandeja')
                                        TriggerEvent('notify', 'importante', 'Refeitório', 'Entregue a bandeja na mesa!', 5000);
                                    end
                                    
                                end
                            end
                        end
                    else
                        local delivData = PrisonRefeitorio.deliveries[refectoryData.deliver]
                        if (delivData) then
                            Text2D(0, 0.43, 0.95, 'Entregue a bandeja na ~b~mesa~w~!', 0.4)
                            local distance = #(coords - delivData.xyz)
                            if (distance <= 10.0) then
                                DrawMarker(0, delivData.x, delivData.y, delivData.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 3, 187, 232, 155, 0, 0, 0, 1)
                                if (distance <= 1.5 and IsControlJustPressed(0,38)) then

                                    ClearPedTasks(ped)
                                    vRP.DeletarObjeto()
                                    LocalPlayer.state.BlockTasks = false

                                    sREFEIT.doneDelivery()

                                    refectoryData.step = 1
                                    refectoryData.deliver = 0

                                    local newStepData = PrisonRefeitorio.steps[refectoryData.step]
                                    if (newStepData) and (newStepData.startNotify) then TriggerEvent('notify', 'importante', 'Refeitório', newStepData.startNotify, 5000); end;
                                end
                            end
                        end
                    end
                    Citizen.Wait(1)
                end
            end)


        end
    end,

    stop = function()
        inWork = false
        refectoryData.step = 0
        refectoryData.deliver = 0
        
        sREFEIT.reset()
        TriggerEvent('notify', 'importante', 'Refeitório', 'Você saiu de <b>serviço</b>!', 8000)
    end
})
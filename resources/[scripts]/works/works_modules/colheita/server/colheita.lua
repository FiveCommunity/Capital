sColheita = {}
Tunnel.bindInterface(GetCurrentResourceName()..':colheita', sColheita)

local interact = {}

sColheita.plantSeed = function(coords)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        
        for _, ent in ipairs(GetAllObjects()) do
            if DoesEntityExist(ent) and (Entity(ent).state.plant) then
                local entCoords = GetEntityCoords(ent) 
                if #(entCoords - coords) < 2.0 then
                    TriggerClientEvent('notify',source,'importante','Colheita','Posição muito próxima de outra planta!')
                    return
                end
            end
        end
        
        local Inventory = vRP.PlayerInventory(user_id)
        if Inventory then
            if Inventory:tryGetItem('semente',1,nil,true) then

                local stage = Colheita.propStages[1]
                local entity = createPlant(stage.model, coords)

                if DoesEntityExist(entity) then
                    Entity(entity).state.plant = stage.model

                    local playerBag = Player(source).state
                    playerBag.BlockTasks = true
                    playerBag.freezeEntity = true
                    vRPclient._playAnim(source, true, { 'amb@world_human_gardener_plant@female@base', 'base_female' }, true)
                    
                    SetTimeout(5000,function()
                        playerBag.BlockTasks = false
                        playerBag.freezeEntity = false
                        ClearPedTasks(GetPlayerPed(source))
                    end)

                else
                    TriggerClientEvent('notify',source,'importante','Colheita','Houve um problema ao plantar! A semente foi devolvida!')
                    Inventory:generateItem('semente',1,nil,nil,true)
                end

            else
                local itemName = 'Semente'
        if GetResourceState('inventory') == 'started' and exports.inventory and exports.inventory.itemName then
            itemName = exports.inventory:itemName('semente') or 'Semente'
        end
        TriggerClientEvent('notify',source,'importante','Colheita','Você não possui <b>'..itemName..'</b>!')
            end
        end
    end
end

sColheita.nextStage = function(netId,anim)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local entity = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(entity) then
            
            local plantCoords = GetEntityCoords(entity)
            local stateBag = Entity(entity).state
            local plantModel = stateBag.plant

            if plantModel and (not interact[netId]) then
                interact[netId] = true

                local playerBag = Player(source).state
                local timeout = 15000

                playerBag.BlockTasks = true
                playerBag.freezeEntity = true

                if (anim == 1) then
                    vRPclient._playAnim(source, true, { 'anim@gangops@facility@servers@bodysearch@', 'player_search' }, true)
				    vRPclient._playAnim(source, false, { 'amb@medic@standing@kneel@base', 'base' }, true)
                else
                    TriggerClientEvent('gb_animations:setAnim',source,'mexer')
                end
                
                TriggerClientEvent('ProgressBar',source,timeout)
                
                Citizen.SetTimeout(timeout, function()
                    interact[netId] = nil
      
                    playerBag.BlockTasks = false
                    playerBag.freezeEntity = false
                    ClearPedTasks(GetPlayerPed(source))

                    if DoesEntityExist(entity) then
                        local stage, total = identifyStage(plantModel)
                        if (stage == total) then
                            local Inventory = vRP.PlayerInventory(user_id)
                            if Inventory then
                                local receive = {}
                                for i = 1, Colheita.itemsAmount do
                                    local find = false
                                    while (not find) do
                                        local value = Colheita.payment[math.random(#Colheita.payment)]
                                        local random = (math.random() * 100)
                                        if (random <= value.prob) and (not receive[value.item]) then
                                            receive[value.item] = math.random(value.min, value.max)
                                            find = true
                                        end
                                        Citizen.Wait(5)
                                    end
                                end
                                
                                for item, amount in pairs(receive) do
                                    Inventory:generateItem(item, amount, nil, nil, true)
                                end

                                local extraReward = Colheita.extraPayment[ math.random(#Colheita.extraPayment) ]
                                Inventory:generateItem(extraReward.item, math.random(extraReward.min,extraReward.max), nil, nil, true)
                            end
                            DeleteEntity(entity)
                        else
                            local newStage = Colheita.propStages[stage+1]
                            if newStage then                    
                                local newPlant = createPlant(newStage.model, (plantCoords+newStage.offset))
                                if DoesEntityExist(newPlant) then
                                    DeleteEntity(entity)
                                    Entity(newPlant).state.plant = newStage.model

                                    TriggerClientEvent('notify', source, 'importante', 'Colheita', 'Você regou a sua <b>planta</b>!')
                                end
                            end
                        end
                    end
                end)
            end
        end
    end
end

identifyStage = function(model)
    local total = #Colheita.propStages
    for i=1, total do
        if (Colheita.propStages[i].model == model) then
            return i, total
        end
    end
end

createPlant = function(model, coords)
    local start = GetGameTimer()
    local entity = CreateObjectNoOffset(model, coords, true, true, false)
    local exist = DoesEntityExist(entity)
    while (not exist) and ((GetGameTimer()-start) < 5000) do
        exist = DoesEntityExist(entity)
        Wait(10)
    end
    if exist then
        FreezeEntityPosition(entity,true)
    end
    return entity 
end
sHUN = {}
Tunnel.bindInterface(GetCurrentResourceName()..':hunter', sHUN)

local spawnedCounter = 0
local spawnedAnimals = {}

createAnimals = function()
    Citizen.SetTimeout((Hunter.respawn_cooldown*1000), createAnimals)

    local selected = 1;
    for i = 1, Hunter.max_animals do
        math.randomseed(GetGameTimer())
        
        if (spawnedCounter >= Hunter.max_animals) then break; end;
        
        local rands = {
            animal = Hunter.animals[math.random(#Hunter.animals)],
            spawn = Hunter.spawns[selected]
        }

        selected = (selected+1)
        if (selected > #Hunter.spawns) then selected = 1; end;

        pedHandle = Citizen.InvokeNative(`CREATE_PED`, 0, rands.animal, rands.spawn.x, rands.spawn.y, rands.spawn.z, rands.spawn.w)
        if (pedHandle) then
            local stateBag = Entity(pedHandle).state
            stateBag.hunter = true

            spawnedCounter = spawnedCounter + 1
            spawnedAnimals[pedHandle] = pedHandle 
        end
        Citizen.Wait(200)
    end
end
Citizen.CreateThread(createAnimals)

RegisterNetEvent('hunter:delete_animal', function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(entity) then 
        if spawnedAnimals[entity] then
            DeleteEntity(entity) 
            spawnedCounter = spawnedCounter - 1
            spawnedAnimals[entity] = nil
        end
    end
end)

AddEventHandler("entityRemoved",function(entity)
    if spawnedAnimals[entity] then
        spawnedCounter = spawnedCounter - 1
        spawnedAnimals[entity] = nil
    end
end)

sHUN.payment = function(animal, netId)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local entity = NetworkGetEntityFromNetworkId(netId)
        if (DoesEntityExist(entity)) then
            local stateBag = Entity(entity).state
            stateBag['hunter:skinned'] = true

            local pay = Hunter.payment[animal]
            if (pay) then
                local receive = { ['couro'] = 1 }
                for i = 1, Hunter.itemsAmount do
                    local find = false
                    while (not find) do
                        local value = pay[math.random(#pay)]
                        local random = (math.random() * 100)
                        if (random <= value.prob) and (not receive[value.item]) then
                            receive[value.item] = math.random(value.min, value.max)
                            find = true
                        end
                        Citizen.Wait(5)
                    end
                end

                Player(source).state.BlockTasks = true
                TriggerClientEvent('ProgressBar', source, 15000)
                
                Citizen.SetTimeout(15000, function()
                    Player(source).state.BlockTasks = false

                    DeleteEntity(entity)
                    ClearPedTasks(GetPlayerPed(source))

                    local userInv = vRP.PlayerInventory(user_id)
                    if (userInv) then
                        for item, amount in pairs(receive) do
                            if (userInv:itemMaxAmount(item, amount)) then
                                if (userInv:haveSpace(item, amount)) then
                                    userInv:generateItem(item, amount, nil, nil, true)
                                else
                                    TriggerClientEvent('notify', source, 'negado', 'Caçador', 'Você não teve espaço para <b>'..amount..'x '..vRP.itemNameList(item)..'</b>!', 8000)
                                end
                            else
                                TriggerClientEvent('notify', source, 'negado', 'Caçador', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(item)..'</b> na mochila!')
                            end
                        end
                    end
                end) 
            end
        end
    end
end
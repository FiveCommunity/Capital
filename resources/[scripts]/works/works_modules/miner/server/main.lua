sMINER = {}
Tunnel.bindInterface(GetCurrentResourceName()..':miner', sMINER)

function sMINER.getExplosive()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local Inventory = vRP.PlayerInventory(user_id)
        if (Inventory) then
            return Inventory:tryGetItem( Miner.explosive[1], Miner.explosive[2] )
        end
    end
end

function sMINER.setStress()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        exports.vrp:varyNeeds(user_id, 'stress', 10)
    end
end

function sMINER.collectMiner(region,pos,clock)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and region and pos then   
        if (math.abs(clock-GetGameTimer()) < 3500) then

            local receive = {}
            for i=1, Miner.itemsAmount do
                local find = false
                while (not find) do
                    local value = Miner.regions[region].rewards[ math.random(#Miner.regions[region].rewards) ]
                    local random = (math.random() * 100)
                    if (random <= value.prob) and (not receive[value.item]) then
                        receive[value.item] = math.random(value.min, value.max)
                        find = true
                    end
                    Citizen.Wait(5)
                end
            end

            local Inventory = vRP.PlayerInventory(user_id)
            if (Inventory) then
                for item, amount in pairs(receive) do
                    if (Inventory:haveSpace(item, amount)) then
                        Inventory:generateItem(item, amount, nil, nil, true)
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Minerador', 'Sem espaço na <b>mochila</b>!')
                    end
                end
            end
        
            return true
        end
    end
    return false
end
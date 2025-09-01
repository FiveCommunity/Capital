sREFEIT = {}
Tunnel.bindInterface(GetCurrentResourceName()..':prison:refectory',sREFEIT)

local refeitPoints = {}

AddEventHandler('vRP:playerLeave', function(user_id, source)
	if (refeitPoints[user_id]) then refeitPoints[user_id] = nil; end;
end)

function sREFEIT.newDelivery()
    local user_id = vRP.getUserId(source)
    if user_id then
        if (not refeitPoints[user_id]) then
            refeitPoints[user_id] = math.random(#PrisonRefeitorio.deliveries)
        end
        return refeitPoints[user_id]
    end
end

function sREFEIT.reset()
    local user_id = vRP.getUserId(source)
    if user_id then
        refeitPoints[user_id] = nil
    end
end

function sREFEIT.doneDelivery()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        
        local coords = GetEntityCoords(GetPlayerPed(source))
        local currBlip = refeitPoints[user_id]
        if (not currBlip) or (#(PrisonRefeitorio.deliveries[currBlip].xyz - coords) > 3.0) then
            return
        end
        
        if (PrisonRefeitorio.reduceJail) and (PrisonRefeitorio.reduceJail > 0) then
            local time = parseInt(vRP.getUData(user_id, 'prison'))
            if (time > 0) then
                vRP.setUData(user_id, 'prison', (time - 1))
                TriggerClientEvent('notify', source, 'Prisão', 'Sua pena foi reduzida em <b>1 mês</b>.')
            end
        end

        local receive = {}
        for i=1, PrisonRefeitorio.itemsAmount do
            local find = false
            while (not find) do
                local value = PrisonRefeitorio.items[math.random(#PrisonRefeitorio.items)]
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
                    TriggerClientEvent('notify', source, 'negado', 'Prisão', 'Sem espaço na <b>mochila</b>!')
                end
            end
            if (math.random(100) == 1) then
                Inventory:generateItem('pedaco-chave', 1, nil, nil, true)
            end
        end

    end
end
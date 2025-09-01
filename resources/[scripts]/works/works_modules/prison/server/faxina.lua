sFAXINA = {}
Tunnel.bindInterface(GetCurrentResourceName()..':prison:faxina',sFAXINA)

local faxinaRoutes = {}

AddEventHandler('vRP:playerLeave', function(user_id, source)
	if (faxinaRoutes[user_id]) then faxinaRoutes[user_id] = nil; end;
end)

function sFAXINA.startRoute()
    local user_id = vRP.getUserId(source)
    if user_id then
        if (not faxinaRoutes[user_id]) then
            faxinaRoutes[user_id] = math.random(#PrisonFaxina.points)
        end
        return faxinaRoutes[user_id]
    end
end

function sFAXINA.reset()
    local user_id = vRP.getUserId(source)
    if user_id then
        faxinaRoutes[user_id] = nil
    end
end

function sFAXINA.receivePayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        
        local coords = GetEntityCoords(GetPlayerPed(source))
        local currBlip = faxinaRoutes[user_id]
        if (not currBlip) or (#(PrisonFaxina.points[currBlip].xyz - coords) > 5.0) then
            return
        end
        
        if (PrisonFaxina.reduceJail) and (PrisonFaxina.reduceJail > 0) then
            local time = parseInt(vRP.getUData(user_id, 'prison'))
            if (time > 0) then
                vRP.setUData(user_id, 'prison', (time - 1))
                TriggerClientEvent('notify', source, 'Prisão', 'Sua pena foi reduzida em <b>1 mês</b>.')
            end
        end

        local receive = {}
        for i=1, PrisonFaxina.itemsAmount do
            local find = false
            while (not find) do
                local value = PrisonFaxina.items[math.random(#PrisonFaxina.items)]
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

        local oldRoute = faxinaRoutes[user_id]
        while (oldRoute == faxinaRoutes[user_id]) do
            faxinaRoutes[user_id] = math.random(#PrisonFaxina.points)
            Wait(1)
        end
        
        return faxinaRoutes[user_id]
    end
end
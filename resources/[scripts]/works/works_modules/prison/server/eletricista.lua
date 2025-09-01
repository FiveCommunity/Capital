sELETR = {}
Tunnel.bindInterface(GetCurrentResourceName()..':prison:eletric',sELETR)

local eletricRoutes = {}

AddEventHandler('vRP:playerLeave', function(user_id, source)
	if (eletricRoutes[user_id]) then eletricRoutes[user_id] = nil; end;
end)

function sELETR.startRoute()
    local user_id = vRP.getUserId(source)
    if user_id then
        if (not eletricRoutes[user_id]) then
            eletricRoutes[user_id] = math.random(#PrisonEletricista.points)
        end
        return eletricRoutes[user_id]
    end
end

function sELETR.reset()
    local user_id = vRP.getUserId(source)
    if user_id then
        eletricRoutes[user_id] = nil
    end
end

function sELETR.receivePayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        
        local coords = GetEntityCoords(GetPlayerPed(source))
        local currBlip = eletricRoutes[user_id]
        if (not currBlip) or (#(PrisonEletricista.points[currBlip].xyz - coords) > 5.0) then
            return
        end
        
        if (PrisonEletricista.reduceJail) and (PrisonEletricista.reduceJail > 0) then
            local time = parseInt(vRP.getUData(user_id, 'prison'))
            if (time > 0) then
                vRP.setUData(user_id, 'prison', (time - 1))
                TriggerClientEvent('notify', source, 'Prisão', 'Sua pena foi reduzida em <b>1 mês</b>.')
            end
        end

        local receive = {}
        for i=1, PrisonEletricista.itemsAmount do
            local find = false
            while (not find) do
                local value = PrisonEletricista.items[math.random(#PrisonEletricista.items)]
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

        local oldRoute = eletricRoutes[user_id]
        while (oldRoute == eletricRoutes[user_id]) do
            eletricRoutes[user_id] = math.random(#PrisonEletricista.points)
            Wait(1)
        end
        
        return eletricRoutes[user_id]
    end
end
cPESC = Tunnel.getInterface(GetCurrentResourceName()..':pescador')

exports('neastFisherman', function(source) return cPESC.nearest(source); end)

fisherPayment = function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local receive = {}
        for i = 1, Pescador.itemsAmount do
            local find = false
            while (not find) do
                local value = Pescador.items[math.random(#Pescador.items)]
                local random = (math.random() * 100)
                if (random <= value.prob) and (not receive[value.item]) then
                    receive[value.item] = math.random(value.min, value.max)
                    find = true
                end
                Citizen.Wait(5)
            end
        end

        local userInv = vRP.PlayerInventory(user_id)
        if (userInv) then
            for item, amount in pairs(receive) do
                if (userInv:haveSpace(item, amount)) then
                    userInv:generateItem(item, amount, nil, nil, true)
                else
                    TriggerClientEvent('notify', source, 'negado', 'Pescador', 'Sem espaço na <b>mochila</b>!')
                end
            end
        end
    end
end
exports('fisherPayment', fisherPayment)
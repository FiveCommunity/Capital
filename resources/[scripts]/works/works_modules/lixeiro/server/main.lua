sTRASH = {}
Tunnel.bindInterface(GetCurrentResourceName()..':trash', sTRASH)

local trashesLooted = {}

function sTRASH.tryLootTrash(trashId)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and trashId then
        
        local currTime = os.time()
        if trashesLooted[trashId] and (currTime < trashesLooted[trashId]) then
            TriggerClientEvent('notify', source, 'negado', 'Lixeiro', 'A lixeira está vazia...')
            return false
        end
        trashesLooted[trashId] = currTime + Lixeiro.trashCooldown 
      
        local receive = {}
        for i=1, Lixeiro.itemsAmount do
            local find = false
            while (not find) do
                local value = Lixeiro.items[math.random(#Lixeiro.items)]
                local random = (math.random() * 100)
                if (random <= value.prob) and (not receive[value.item]) then
                    receive[value.item] = math.random(value.min, value.max)
                    find = true
                end
                Citizen.Wait(5)
            end
        end

        Citizen.SetTimeout(Lixeiro.searchTime*1000,function()
            if vRP.getUserSource(user_id) then
                local Inventory = vRP.PlayerInventory(user_id)
                if (Inventory) then
                    for item, amount in pairs(receive) do
                        if (Inventory:haveSpace(item, amount)) then
                            Inventory:generateItem(item, amount, nil, nil, true)
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Lixeiro', 'Sem espaço na <b>mochila</b>!')
                        end
                    end
                end
                vRP.varyNeeds(user_id,'stress',5)
            end
        end)
       
        return true
    end
    return false
end
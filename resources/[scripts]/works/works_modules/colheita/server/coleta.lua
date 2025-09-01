sColeta = {}
Tunnel.bindInterface(GetCurrentResourceName()..':coleta', sColeta)

local cooldown = {}
local userCollect = {}

sColeta.collect = function(zone,tree)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local currTime = os.time()

        if (not cooldown[zone]) then
            cooldown[zone] = {}
        end

        if cooldown[zone][tree] and (currTime < cooldown[zone][tree]) then        
            return (cooldown[zone][tree] - currTime)
        end

        cooldown[zone][tree] = currTime + Coleta.cooldown

        local payment = Coleta.zones[zone].payment[math.random(#Coleta.zones[zone].payment)]
        local extraPayment = Coleta.zones[zone].extraPayment[math.random(#Coleta.zones[zone].extraPayment)]

        userCollect[user_id] = { payment = payment, extraPayment = extraPayment }

        return false
    end
    return 0
end

sColeta.receiveItem = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local receive = userCollect[user_id]
        if receive then
            local Inventory = vRP.PlayerInventory(user_id)
            if Inventory then
                Inventory:generateItem(receive.payment.item, math.random(receive.payment.min,receive.payment.max), nil, nil, true)
                Inventory:generateItem(receive.extraPayment.item, math.random(receive.extraPayment.min,receive.extraPayment.max), nil, nil, true)
            end
            userCollect[user_id] = nil
        end
    end
end

AddEventHandler('vRP:playerLeave',function(user_id)
    if userCollect[user_id] then userCollect[user_id] = nil; end;
end)
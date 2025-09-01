sLAU = {}
Tunnel.bindInterface(GetCurrentResourceName()..':laundry', sLAU)

laundryData = { payment = {} }

sLAU.generateRoute = function(method)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (not laundryData[user_id]) then 
            laundryData[user_id] = (method == 'soapsCoords' and math.random(#Laundry.soapsCoords) or 1)
        end
        return laundryData[user_id]
    end
end

sLAU.resetRoute = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (laundryData[user_id]) then laundryData[user_id] = nil; end;
        if (laundryData.payment[user_id]) then laundryData.payment[user_id] = nil; end;
    end
end

local methods = {
    ['soap'] = function(source, user_id, playerInventory, currentBlip)
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        local stateBag = Player(source).state

        if (#(coords - Laundry.soapsCoords[currentBlip].xyz) > 8.0) then return currentBlip; end;

        stateBag.freezeEntity = true
        stateBag.BlockTasks = true

        local timeout = 7000
        TriggerClientEvent('gb_animations:setAnim', source, 'mexer')
        TriggerClientEvent('ProgressBar', source, timeout)

        Citizen.Wait(timeout)     

        ClearPedTasks(ped)
        stateBag.freezeEntity = false
        stateBag.BlockTasks = false

        vRP.varyNeeds(user_id,'stress',3)
        playerInventory:giveItem('sabao-po', 1, nil, nil, true)   

        while (currentBlip == laundryData[user_id]) do
            laundryData[user_id] = math.random(#Laundry.soapsCoords)
            Citizen.Wait(1)
        end

        return laundryData[user_id]
    end,
    ['delivery'] = function(source, user_id, playerInventory, currentBlip)
        -- Payment
        
        local allow;
        if (not laundryData.payment[user_id]) then laundryData.payment[user_id] = 0; end;
        if (laundryData.payment[user_id] >= #Laundry.paymentDelivery) then laundryData.payment[user_id] = 1;
        else laundryData.payment[user_id] = (laundryData.payment[user_id] + 1); end;

        local payment = Laundry.paymentDelivery[laundryData.payment[user_id]]
        if (playerInventory:haveSpace(payment.item, payment.quantity)) then
            if (playerInventory:getItemAmount('saco-roupa') > 0) then
                allow = true
            else
                TriggerClientEvent('notify', source, 'negado', 'Lavanderia', 'Você não possui <b>1x</b> de <b>'..vRP.itemNameList('saco-roupa')..'</b>!')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Lavanderia', 'Espaço insuficiente!')
        end

        -- Delivery

        if (allow) then
            local ped = GetPlayerPed(source)
            local coords = GetEntityCoords(ped)
            local stateBag = Player(source).state

            if (#(coords - Laundry.deliverysCoords[currentBlip].xyz) <= 8.0) then
                stateBag.freezeEntity = true
                stateBag.BlockTasks = true

                local timeout = 3000
                TriggerClientEvent('gb_animations:setAnim', source, 'pegar')
                TriggerClientEvent('ProgressBar', source, timeout)

                Citizen.Wait(timeout)     

                ClearPedTasks(ped)
                stateBag.freezeEntity = false
                stateBag.BlockTasks = false

                if (playerInventory:tryGetItem('saco-roupa', 1, nil, true)) then
                    playerInventory:giveItem(payment.item, payment.quantity, nil, nil, true)
                    vRP.giveMoney(user_id, math.random(130,215) )
                    vRP.varyNeeds(user_id,'stress',2)
                end

                if (laundryData[user_id] >= #Laundry.deliverysCoords) then laundryData[user_id] = 1;
                else laundryData[user_id] = (laundryData[user_id] + 1); end;

                return laundryData[user_id]
            end
        end
        return currentBlip
    end,
    ['machine'] = function(source, user_id, playerInventory, currentBlip)
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        local stateBag = Player(source).state

        if (#(coords - Laundry.machinesCoords[currentBlip].xyz) > 8.0) then return; end;

        if (playerInventory:haveSpace('saco-roupa', 2)) then
            if (playerInventory:tryGetItem('sabao-po', 1, nil, true)) then
                stateBag.BlockTasks = true

                local timeout = 10000
                
                vRPclient.playAnim(source, false, { 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', 'weed_crouch_checkingleaves_idle_01_inspector' }, true)
                TriggerClientEvent('ProgressBar', source, timeout)
                
                Citizen.Wait(timeout)

                ClearPedTasks(ped)
                stateBag.BlockTasks = false

                playerInventory:giveItem('saco-roupa', 2, nil, nil, true)   
            else
                TriggerClientEvent('notify', source, 'negado', 'Lavanderia', 'Você não possui <b>1x</b> de <b>'..vRP.itemNameList('sabao-po')..'</b>.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Lavanderia', 'Espaço insuficiente!')
        end
        return true
    end
}

sLAU.receivePayment = function(method, index)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and laundryData[user_id] then
        local playerInventory = vRP.PlayerInventory(user_id)
        if (playerInventory) then
            local currentBlip = laundryData[user_id]
            if (methods[method]) then return methods[method](source, user_id, playerInventory, currentBlip); end;
        end
    end
end

AddEventHandler('vRP:playerLeave', function(user_id, source)
	if (laundryData[user_id]) then laundryData[user_id] = nil; end;
    if (laundryData.payment[user_id]) then laundryData.payment[user_id] = nil; end;
end)
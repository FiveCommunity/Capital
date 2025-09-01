sLEI = {} 
Tunnel.bindInterface(GetCurrentResourceName()..':leiteiro', sLEI)
cLEI = Tunnel.getInterface(GetCurrentResourceName()..':leiteiro')

local cows = {}

sLEI.verifyCow = function(entityId)
    if (cows[entityId]) and cows[entityId] > os.time() then return false; end;
    local source = source
    local user_id = vRP.getUserId(source)    
    if (user_id) then
        local userInventory = vRP.PlayerInventory(user_id)
        if (userInventory) and userInventory:getItemAmount(Leiteiro.necessaryItem) < 1 then return false; end;
    end
    return true
end

sLEI.receivePayment = function(entity, entityId)
    if (not entity) or (not entityId) then return; end;
    cows[entityId] = (os.time()+Leiteiro.cooldown)

    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local verified = cLEI.verifyEntity(source, entity)
        if (verified) then
            local ped = GetPlayerPed(source)
            if (#(GetEntityCoords(ped) - Leiteiro.cowsCoord[entityId].xyz) > 8.0) then cows[entityId] = nil; return; end;
            
            local timeout = 30000

            Player(source).state.BlockTasks = true
            vRPclient.playAnim(source, false, { 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', 'weed_crouch_checkingleaves_idle_01_inspector' }, true)
            
            TriggerClientEvent('ProgressBar', source, timeout)
            Citizen.SetTimeout(timeout, function()
                ClearPedTasks(ped)     
                Player(source).state.BlockTasks = false

                local userInventory = vRP.PlayerInventory(user_id)
                if (userInventory) then
                    if (userInventory:tryGetItem(Leiteiro.necessaryItem, 1, nil, true)) then
                        userInventory:giveItem(Leiteiro.receiveItem, 1, nil, nil, true)
                    end
                end
            end)
        end
    end
end
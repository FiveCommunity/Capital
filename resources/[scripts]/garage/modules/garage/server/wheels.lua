local flatWeapons = {
    [GetHashKey('WEAPON_SWITCHBLADE')] = true
}

local removeWheelTools = {
    [GetHashKey('WEAPON_WRENCH')] = true
}

local waitTasks = {}

local wheelActions = {
    ['fix'] = function(source,user_id,netId,wheelId)
        if (waitTasks[netId]) then return; end;
        waitTasks[netId] = true
        if removeWheelTools[GetSelectedPedWeapon(GetPlayerPed(source))] then
            local flated = cGARAGE.burstWheel(source,netId,wheelId)
            if (flated == true) then
                local Inventory = vRP.PlayerInventory(user_id)
                if Inventory then
                    if (Inventory:getItemAmount('pneu') > 0) then
                        vRPclient._playAnim(source,false,{{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"}},true)
                        if (exports.system:Task(source, 3, 8000)) then
                            if Inventory:tryGetItem('pneu',1,nil,true) then
                                TriggerClientEvent('garage:syncWheel',-1,netId,wheelId,false)
                            end      
                        end
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Mochila', 'Você não possui um <b>pneu</b> em sua mochila!')
                    end
                    vRPclient._stopAnim(source,false)
                end
            end
        end
        waitTasks[netId] = nil
    end,

    ['remove'] = function(source,user_id,netId,wheelId)
        if (waitTasks[netId]) then return; end;
        waitTasks[netId] = true
        if removeWheelTools[GetSelectedPedWeapon(GetPlayerPed(source))] then
            local flated = cGARAGE.burstWheel(source,netId,wheelId)
            if (flated == false) then
                local Inventory = vRP.PlayerInventory(user_id)
                if Inventory then
                    if Inventory:haveSpace('pneu',1) then
                        Player(source).state.BlockTasks = true
                        vRPclient._playAnim(source,false,{{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"}},true)
                        TriggerClientEvent('ProgressBar', source, 5000)
                        SetTimeout(5000, function()
                            waitTasks[netId] = nil
                            vRPclient._stopAnim(source,false)
                            Player(source).state.BlockTasks = false
                            Inventory:generateItem('pneu',1,nil,nil,true)
                            TriggerClientEvent('garage:syncWheel',-1,netId,wheelId,true)
                        end)
                        return
                    else
                        TriggerClientEvent('Notify',source,'negado','Garagem','Sem espaço na <b>mochila</b>!')
                    end
                end
            end
        end
        waitTasks[netId] = nil
    end,

    ['flat'] = function(source,user_id,netId,wheelId)
        if (waitTasks[netId]) then return; end;
        waitTasks[netId] = true
        if flatWeapons[GetSelectedPedWeapon(GetPlayerPed(source))] then
            Player(source).state.BlockTasks = true
            vRPclient._playAnim(source,false,{{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"}},true)
            TriggerClientEvent('ProgressBar', source, 5000)
            SetTimeout(5000, function()
                waitTasks[netId] = nil
                vRPclient._stopAnim(source,false)
                Player(source).state.BlockTasks = false
                TriggerClientEvent('garage:syncWheel',-1,netId,wheelId,true)
            end)
            return
        end
        waitTasks[netId] = nil
    end,
}

RegisterNetEvent('garage:vehicleTyre',function(action,netId,wheel)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and action then
        if wheelActions[action] then
            wheelActions[action](source,user_id,netId,wheel)
        end
    end
end)
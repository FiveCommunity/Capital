sLUM = {}
Tunnel.bindInterface(GetCurrentResourceName()..':lumberjack', sLUM)

lumberData = {}

sLUM.generateRoute = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (not lumberData[user_id]) then
            lumberData[user_id] = math.random(#Lumberjack.trees)
        end
        return lumberData[user_id]
    end
end

local resetRoute = function(user_id)
    if (user_id) and lumberData[user_id] then
        lumberData[user_id] = nil
    end
end

sLUM.resetRoute = function()
    local source = source
    local user_id = vRP.getUserId(source)
    resetRoute(user_id)
end

AddEventHandler('vRP:playerLeave', resetRoute)

sLUM.receivePayment = function()
    math.randomseed(GetGameTimer())

    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and lumberData[user_id] then
        local currentBlip = lumberData[user_id]

        local ped = GetPlayerPed(source)
        local pedCoords = GetEntityCoords(ped)
        local stateBag = Player(source).state

        local plyInventory = vRP.PlayerInventory(user_id)
        if (#(pedCoords - Lumberjack.trees[currentBlip].xyz) <= 8.0) and (plyInventory) then
            local random = math.random(Lumberjack.payment.min, Lumberjack.payment.max)
            if (plyInventory:haveSpace(Lumberjack.payment.item, random)) then
                local timeout = 5000
                
                stateBag.BlockTasks = true 
                vRPclient.playAnim(source, false, { 'melee@hatchet@streamed_core', 'plyr_front_takedown_b' }, true)
                TriggerClientEvent('ProgressBar', source, timeout)

                Citizen.Wait(timeout)

                stateBag.BlockTasks = false
                ClearPedTasks(ped)
                plyInventory:giveItem(Lumberjack.payment.item, random, nil, nil, true)
                vRP.varyNeeds(user_id,'stress',10)
            
                while (currentBlip == lumberData[user_id]) do
                    lumberData[user_id] = math.random(#Lumberjack.trees)
                    Citizen.Wait(1)
                end
                return lumberData[user_id]
            else
                TriggerClientEvent('notify', source, 'negado', 'Lenhador', 'Espaço insuficiente!')
            end
        end
        return currentBlip
    end
end
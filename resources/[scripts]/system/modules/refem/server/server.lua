local srv = {}
Tunnel.bindInterface('Refem', srv)
local vCLIENT = Tunnel.getInterface('Refem')

srv.getClosetPedSource = function()
    local source = source
    local targetSrc = vRPclient.getNearestPlayer(source, 1.5)
    return (targetSrc or 0.0)
end

RegisterCommand('prefem', function(source)
    local targetSrc = vRPclient.getNearestPlayer(source, 1.5)
    if (targetSrc) then
        local ply = GetPlayerPed(source)
        local targetPly = GetPlayerPed(targetSrc)

        if (GetEntityHealth(ply) <= 100 or GetEntityHealth(targetPly) <= 100) then return; end;
        if (Player(source).state.Handcuff) then return; end;
        if (Player(source).state.StraightJacket) then return; end;
        if (vRPclient.getNoCarro(source) or  vRPclient.getNoCarro(targetSrc)) then return; end;
        if (Player(source).state.holdingHostage or Player(targetSrc).state.victimHostage) then return; end;
        
        local result = vCLIENT.takeHostage(source, targetSrc)
        if (result) then
            Player(source).state.BlockTasks = true
            TriggerClientEvent("cancelando", source, true)
            TriggerClientEvent("cancelando", targetSrc, true)
            Player(source).state.holdingHostage = true
            Player(targetSrc).state.victimHostage = true
        end
    end
end)

RegisterServerEvent('gb_prefem:killHostage')
AddEventHandler('gb_prefem:killHostage', function()
    local source = source
    local nPlayer = vRPclient.getNearestPlayer(source, 2)
    if (nPlayer) then
        vRPclient.killGod(nPlayer)
        vRPclient.setHealth(nPlayer, 0)
        vRPclient.setArmour(nPlayer, 0)
    end
end)
-- RegisterServerEvent('gb_prefem:sync')
-- AddEventHandler('gb_prefem:sync', function()
srv.prefemSync = function(targetSrc, animationLib,animationLib2, animation, animation2, distans, distans2, height,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
    local source = source
    Player(source).state.BlockTasks = true
    Player(targetSrc).state.BlockTasks = true
    TriggerClientEvent('gb_prefem:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
    TriggerClientEvent('gb_prefem:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end

RegisterServerEvent('gb_prefem:stop')
AddEventHandler('gb_prefem:stop', function(targetSrc)
    local source = source    

    Player(source).state.holdingHostage = false
    Player(targetSrc).state.victimHostage = false
    Player(source).state.BlockTasks = false
    Player(targetSrc).state.BlockTasks = false

    TriggerEvent("cancelando", source, false)
    TriggerEvent("cancelando", targetSrc, false)

    TriggerClientEvent('gb_prefem:cl_stop', source)
    TriggerClientEvent('gb_prefem:cl_stop', targetSrc)
end)
local srv = {}
Tunnel.bindInterface('HomeRobbery', srv)
local vCLIENT = Tunnel.getInterface('HomeRobbery')

local homesConfig = {}
local recentHomes = {}
local homeUnlocked = {}
local homeLoots = {}
local unlockingHome = {}
local inInterior = {}

Citizen.CreateThread(function()
    homesConfig = HomesRobbery.getHomes()
end)

local callPolice = function(source, user_id, coords, immediate)
    exports.vrp:reportUser(user_id, {
        percentage = (immediate and 0 or 10),
        extra = function(source) TriggerClientEvent('Notify', source, 'importante', 'Roubos', 'A policia foi alertada! Fuja do local!',10000) end,
        notify = { 
            type = 'default', 
            title = 'Roubo a Residência', 
            message = 'Um cidadão foi visto invadindo uma residência.',
            coords = coords,
            time = 8000
        },
        blip = {
            id = user_id, 
            text = 'Roubo a Residência', 
            coords = coords
        }
    })
end

srv.tryUnlockHome = function(home,itemSlot)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        if (HomesRobbery.HomesBlocked) then
            for index, _ in pairs(HomesRobbery.HomesBlocked) do
                if (string.find(home, index)) then
                    TriggerClientEvent('notify', source, 'negado', 'Roubos', 'Você não pode roubar essa <b>residência</b>!')
                    return false
                end
            end
        end

        if recentHomes[home] and (recentHomes[home] > os.time()) then
            TriggerClientEvent('Notify', source, 'negado', 'Roubos', 'A casa está isolada devido ao um roubo recente. Aguarde <b>'..(recentHomes[home] - os.time())..' segundos</b>.',8000)
            return false
        end

        if HomesRobbery.MinPolice then
            local police = vRP.getUsersByPermission('policia.permissao')
            if (#police < HomesRobbery.MinPolice) then
                TriggerClientEvent('Notify', source, 'negado', 'Roubos', 'Contigente <b>insuficiente</b>.',8000)
                return false
            end
        end

        if (not unlockingHome[home]) then
            unlockingHome[home] = true

            local Inventory = vRP.PlayerInventory(user_id)
            if Inventory then
                
                local slot = Inventory:getSlot(itemSlot)
                if slot then
                    local dataRequire = HomesRobbery.Require[slot.item]
                    if (dataRequire) then

                        local sucess = false
                        if (dataRequire.mode == 'use') then
                            sucess = Inventory:useSlot(itemSlot)
                        elseif (dataRequire.mode == 'consume') then
                            sucess = Inventory:tryGetItem(slot.item, 1, itemSlot, true)
                        end
                        
                        if sucess then
                            if exports.system:Task(source, 5, 7000) then

                                homeLoots[home] = {}
                                recentHomes[home] = os.time()+HomesRobbery.RobCooldown
                                homeUnlocked[home] = os.time()+600

                                exports.hud:insertWanted(user_id, 180, 1200)

                                local interior = HomesRobbery.getHomeInterior(homesConfig,home)

                                inInterior[user_id] = { home = home, coord = GetEntityCoords(GetPlayerPed(source)) }

                                unlockingHome[home] = nil

                                return true, interior
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Roubos', 'Você falhou ao arrombar a porta!',8000)
                            end
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Roubos', 'Você não possui uma <b>'..dataRequire.name..'</b> para o roubo!',8000)
                        end

                    end
                end
            end

            unlockingHome[home] = nil
        end
    end
    return false
end

srv.lootHome = function(home,loot)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local robbery = inInterior[user_id]
        if robbery and (home == robbery.home) and (not homeLoots[home][loot]) then
            homeLoots[home][loot] = true

            local receive = {}
            for i = 1, HomesRobbery.MaxItens do
                local find = false
                while (not find) do
                    local value = HomesRobbery.Itens[math.random(#HomesRobbery.Itens)]
                    local random = (math.random() * 100)
                    if (random <= value.prob) and (not receive[value.item]) then
                        receive[value.item] = math.random(value.min, value.max)
                        find = true
                    end
                    Citizen.Wait(5)
                end
            end

            local Inventory = vRP.PlayerInventory(user_id)
            if Inventory then
                for item, amount in pairs(receive) do
                    if Inventory:itemMaxAmount(item,amount) then
                        if Inventory:haveSpace(item,amount) then
                            Inventory:generateItem(item,amount,nil,{ prefix = 'CB' },true)
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Roubos', 'Você não teve espaço para <b>'..amount..'x '..vRP.itemNameList(item)..'</b>!',8000)
                        end
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Roubos', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(item)..'</b> na mochila!')
                    end
                end
            end

            vRP.webhook('homeRob', {
                title = 'roubo residência',
                descriptions = {
                    { 'user', user_id },
                    { 'home', home },
                    { 'items', '\n'..json.encode(receive,{ indent = true }) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })

            local count = countTable(receive)
            TriggerClientEvent('Notify', source, 'sucesso', 'Roubos', 'Você encontrou <b>'..count..' '..(count and 'itens' or 'item')..'</b>!')
            callPolice(source, user_id, homesConfig[home].coord)
        end
    end
end

srv.stealthFail = function(home)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local robbery = inInterior[user_id]
        if robbery and (home == robbery.home) then
            callPolice(source, user_id, homesConfig[home].coord, true)
        end
    end
end

srv.robberyDone = function(home)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local robbery = inInterior[user_id]
        if robbery and (home == robbery.home) then
            inInterior[user_id] = nil
        end
    end
end

houseBeingRobbed = function(source, user_id, home)
    if (homeUnlocked[home]) and (homeUnlocked[home] > os.time()) then
        local interior = HomesRobbery.getHomeInterior(homesConfig,home)

        inInterior[user_id] = { home = home, coord = GetEntityCoords(GetPlayerPed(source)) }
    
        vCLIENT.startHomeRobbery(source, home, interior, true)
        TriggerClientEvent('notify', source, 'aviso', 'Residência', 'Esta <b>residência</b> está sendo assaltada. Tenha cuidado.')
        return true
    end
    return false
end
exports('houseBeingRobbed', houseBeingRobbed)


inHomeRoberry = function(user_id)
    return (inInterior[user_id] ~= nil)
end
exports('inHomeRoberry', inHomeRoberry)

AddEventHandler('vRP:playerLeave',function(user_id,source)
    local data = inInterior[user_id]
    if data then
        vRP.setKeyDataTable(user_id, 'position', { x = data.coord.x, y = data.coord.y, z = data.coord.z })
        inInterior[user_id] = nil
    end
end)

AddEventHandler('onResourceStop', function(name)
    if (GetCurrentResourceName() == name) then
        for k,v in pairs(inInterior) do
            vRP.setKeyDataTable(k, 'position', { x = v.coord.x, y = v.coord.y, z = v.coord.z })
            local source = vRP.getUserSource(k)
            if source then
                SetPlayerRoutingBucket(source,0)
                vRPclient._teleport(source,v.coord)
            end
        end
    end
end)
local srv = {}
Tunnel.bindInterface('Robberys', srv)
local vCLIENT = Tunnel.getInterface('Robberys')

local meta = { cooldown = {}, inRobbery = {}, seconds = {} }

local title = function(rob) return 'Roubo '..rob; end; 

local verifyItems = function(user_id, data, plyInventory, name)
    local pass, text = true, '';

    local alternative = data.alternativeRequire
    if (alternative) then
        local amount, slot = plyInventory:getItemAmount(alternative.item)
        if (amount >= alternative.amount) then
            if (alternative.usage) and (slot) then
                plyInventory:useSlot(slot)
            elseif (not alternative.notLoose) then
                plyInventory:tryGetItem(alternative.item, alternative.amount, nil, true)
            end
            return true
        end
    end

    for k, v in pairs(data.require) do
        local amount, slot = plyInventory:getItemAmount(v.item)
        if (amount < v.amount) then
            text = text..'<b>'..v.amount..'x de '..vRP.itemNameList(v.item)..'</b><br>'
        end  
        
        if (v.usage) then
            data.require[k].slot = slot
        end
    end

    if (text == '') then
        for _, v in pairs(data.require) do
            if (v.usage) and (v.slot) then
                plyInventory:useSlot(v.slot)
            elseif (not v.notLoose) then
                plyInventory:tryGetItem(v.item, v.amount, nil, true)
            end
        end 
        return true
    end
    
    TriggerClientEvent('notify', source, 'negado', title(name), 'Você não possui: <br><br>'..text)
    return false
end

local webhook = function(data)
    vRP.webhook('roubos', { title = 'roubos', descriptions = data })  
end

local paymentRobbery = function(user_id, secs, payment, id, plyInventory, name)
    local source = vRP.getUserSource(user_id)
    
    meta.seconds[id] = secs
    Citizen.CreateThread(function()
        local payInTime = payment.payInTime
        local amount = math.random(payment.min, payment.max)
        local format = (amount/meta.seconds[id])

        local payment = 0
        while (meta.seconds[id] and meta.seconds[id] > 0) do
            Citizen.Wait(1000)
            
            meta.seconds[id] = (meta.seconds[id] - 1)
            TriggerClientEvent('system:roubos:update_secs', source, meta.seconds[id])

            if (payInTime) then
                payment = (payment + format)
                plyInventory:giveItem('dinheirosujo', format, nil, nil, true)
            end
        end 
        
        local ply = GetPlayerPed(source)
        if (not meta.inRobbery[user_id].cancel) then
            webhook({
                { 'action', 'finished robbery' },
                { 'user', user_id },
                { 'local', name },
                { 'value received', 'R$'..vRP.format(amount) },
                { 'coord', tostring(GetEntityCoords(ply)) }
            })

            if (not payInTime) then
                plyInventory:giveItem('dinheirosujo', amount, nil, nil, true)
            end
        else
            webhook({
                { 'action', 'cancel robbery' },
                { 'user', user_id },
                { 'local', name },
                { 'value received', 'R$'..vRP.format(payment) },
                { 'coord', tostring(GetEntityCoords(ply)) }
            })
        end

        meta.seconds[id] = nil
        meta.inRobbery[user_id] = nil
    end)
end

srv.startRobbery = function(index)
    local source = source
    local user_id = vRP.getUserId(source)

    if (user_id and index) then
        local ply = GetPlayerPed(source)
        local plyInventory = vRP.PlayerInventory(user_id)
        if (not plyInventory) then
            return TriggerClientEvent('notify', source, 'negado', title(data.name), 'Algo inesperado ocorreu, é hora de fugir!')
        end

        local dataLocation = Robberys.locations[index]
        local dataGeneral = Robberys.general[dataLocation.config]

        if dataGeneral then 
            if dataGeneral.lspd >= 8 then 
                local currentHour = os.date('%H')
                if currentHour >= "18" and currentHour <= "19" then 
                    return TriggerClientEvent('notify', source, 'negado', title(dataLocation.name), 'Agora não é um bom momento para roubar.')
                end
            end
        end

        local id = (dataLocation.id and tostring(dataLocation.config..dataLocation.id) or dataLocation.config)
        local ostime = os.time()
        
        if (meta.cooldown[id]) and meta.cooldown[id] > ostime then
            return TriggerClientEvent('notify', source, 'negado', title(dataLocation.name), 'Aguarde <b>'..(meta.cooldown[id] - ostime)..' segundos</b> para roubar novamente!')
        end

        if (dataGeneral.lspd) then
            local police = vRP.getUsersByPermission('policia.permissao')
            if (#police < dataGeneral.lspd) then
                return TriggerClientEvent('notify', source, 'negado', title(dataLocation.name), 'Contigente <b>insuficiente</b>.')
            end
        end

        if (dataGeneral.require) and not verifyItems(user_id, dataGeneral, plyInventory, dataLocation.name) then
            return false
        end

        meta.cooldown[id] = (ostime + dataGeneral.cooldown)

        TriggerClientEvent('gb_animations:setAnim', source, 'mexer')
        if (dataGeneral.task) and not exports[GetCurrentResourceName()]:Task(source, 4, 8000) then
            ClearPedTasks(ply)
            meta.cooldown[id] = nil 
            return TriggerClientEvent('notify', source, 'negado', title(dataLocation.name), 'Você falhou na <b>task</b>!')
        end

        if (dataGeneral.wanted) then exports.hud:insertWanted(user_id, dataGeneral.wanted[1], (dataGeneral.wanted.max or 1800)) end;

        meta.inRobbery[user_id] = { cfg = dataLocation.config, cancel = false }

        exports.vrp:reportUser(user_id, {
            notify = { 
                type = 'default', 
                title = dataLocation.name, 
                message = 'Denúncia Anônima',
                coords = dataLocation.coord,
                time = 8000
            },
            blip = {
                id = user_id, 
                text = 'Roubo a(o) '..dataLocation.name, 
                coords = dataLocation.coord,
                colour = dataLocation.blipColour,      
                timeout = 30000
            }
        })

        vCLIENT.startRobbery(source, { secs = dataGeneral.seconds, coords = dataLocation.coord, inside = dataGeneral.insideRadius })
        paymentRobbery(user_id, dataGeneral.seconds, dataGeneral.payment, tostring(user_id..dataLocation.config), plyInventory, dataLocation.name)
    end
end

RegisterNetEvent('system:roubos:cancel', function(robbery)
    local source = source
    local user_id = vRP.getUserId(source)

    local inRobbery = meta.inRobbery[user_id].cfg
    if (inRobbery) then
        local id = tostring(user_id..inRobbery)
        if (meta.seconds[id]) then 
            meta.inRobbery[user_id].cancel = true
            meta.seconds[id] = 0
        end
    end
end)
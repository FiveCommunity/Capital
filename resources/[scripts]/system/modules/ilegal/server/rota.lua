local srv = {}
Tunnel.bindInterface('Routes', srv)

local routeTime = {}

local selection = {}
local receving = {}

srv.startUpdateRoute = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        selection[user_id] = 1
        receving[user_id] = 1
    end
end

srv.resetUpdateRoute = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        selection[user_id] = nil
        receving[user_id] = nil
    end
end

local updateRoute = function(source, routes, items)
    local user_id = vRP.getUserId(source)
    
    selection[user_id] = selection[user_id] + 1
    if (selection[user_id] > #routes) then
        selection[user_id] = 1 
    end

    receving[user_id] = receving[user_id] + 1
    if (receving[user_id] > #items) then
        receving[user_id] = 1 
    end
end

srv.checkRoutes = function(index)
    local _config = Routes.locations[index]
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.checkPermissions(user_id, _config.perm) then
        if _config.notPerm then
            if vRP.checkPermissions(user_id, _config.notPerm) then
                TriggerClientEvent('notify', source, 'negado', 'Rotas', 'Você não pode fazer esta rota.')
                return false
            end
        end 
        
        if (GetPlayerRoutingBucket(source) ~= 0) then
            TriggerClientEvent('notify', source, 'negado', 'Rotas', 'Você não pode iniciar uma rota em outro <b>mundo</b>.')
            return false
        end

        if (routeTime[user_id]) then
            TriggerClientEvent('notify', source, 'negado', 'Rotas', 'Aguarde <b>'..routeTime[user_id]..' segundos</b> para iniciar uma rota novamente.')
            return false
        end
        registerRoutesTime(user_id, _config.cooldown)
        return true
    end
    return false
end

local check = {
    ['with-receive'] = function(user_id, item, quantity, receive, payment)
        if ((vRP.getInventoryWeight(user_id) + (vRP.getItemWeight(receive) * payment)) <= vRP.getInventoryMaxWeight(user_id)) then
            if (vRP.getInventoryItemAmount(user_id, item) >= quantity) then
                return true
            end
        end
        return false
    end,
    ['without-receive'] = function(user_id, item, quantity, receive, payment)
        if ((vRP.getInventoryWeight(user_id) + (vRP.getItemWeight(item) * quantity)) <= vRP.getInventoryMaxWeight(user_id)) then
            return true
        end
        return false
    end
}

local CheckWeight = function(user_id, item, quantity, receive, payment)
    local _receive = (not receive and 'without-receive' or 'with-receive')
    return check[_receive](user_id, item, quantity, receive, payment)
end

local cacheRoutes = {}

srv.checkBackpack = function(itens, drug, fixed)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (drug) then
            for k, v in pairs(itens) do
                if (CheckWeight(user_id, v.item, v.quantity, v.receive, v.payment)) then
                    return true
                else
                    TriggerClientEvent('notify', source, 'negado', 'Rotas', 'Você não possui os <b>itens</b> necessários para realizar esta <b>rota</b>!')
                end
            end
        else
            local randomIndex = itens[math.random(#itens)]
            if fixed then
                randomIndex = itens[ receving[user_id] ]
            end
            local randomQuantity = math.random(randomIndex.quantity.min, randomIndex.quantity.max)

            if (not cacheRoutes[user_id]) then
                cacheRoutes[user_id] = { item = randomIndex.item, quantity = randomQuantity }
            end

            if (CheckWeight(user_id, cacheRoutes[user_id].item, cacheRoutes[user_id].quantity)) then
                return true
            else
                TriggerClientEvent('notify', source, 'negado', 'Rotas', 'Você não possui espaço em sua <b>mochila</b>!')
            end
        end
    end
    return false
end

srv.routePayment = function(coords, _config, drug, name)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords[selection[user_id]])
        if (distance <= 8.0) then
            local itens = _config.itens
            if (drug) then
                for k, v in pairs(itens) do
                    if (CheckWeight(user_id, v.item, v.quantity, v.receive, v.payment)) then
                        if (vRP.tryGetInventoryItem(user_id, v.item, v.quantity)) then
                            vRP.giveInventoryItem(user_id, v.receive, v.payment)
                            TriggerClientEvent('notify', source, 'sucesso', 'Rotas', 'Você vendeu <b>'..v.quantity..'x</b> de <b>'..vRP.itemNameList(v.item)..'</b> e recebeu <b>R$'..vRP.format(v.payment)..'</b> de dinheiro sujo pela sua venda!')
                            vRP.webhook('rota', {
                                title = 'rota',
                                descriptions = {
                                    { 'name', name },
                                    { 'user', user_id },
                                    { 'type', 'drug' },
                                    { 'item sell', vRP.itemNameList(v.item) },
                                    { 'quantity sell', v.quantity },
                                    { 'item received', vRP.itemNameList(v.receive) },
                                    { 'value received', 'R$'..vRP.format(v.payment)..' dinheiro sujo' },
                                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                                }
                            })    
                            updateRoute(source, coords, itens)
                            return true
                        end
                        TriggerClientEvent('notify', source, 'negado', 'Rotas', 'Você não possui <b>'..v.quantity..'x</b> de <b>'..vRP.itemNameList(v.item)..'</b> em sua mochila!')
                    end
                end
            else
                if (CheckWeight(user_id, cacheRoutes[user_id].item, cacheRoutes[user_id].quantity)) then
                    vRP.giveInventoryItem(user_id, cacheRoutes[user_id].item, cacheRoutes[user_id].quantity)
                    TriggerClientEvent('notify', source, 'sucesso', 'Rotas', 'Você recebeu <b>'..cacheRoutes[user_id].quantity..'x</b> de <b>'..vRP.itemNameList(cacheRoutes[user_id].item)..'</b>!')
                    vRP.webhook('rota', {
                        title = 'rota',
                        descriptions = {
                            { 'name', name },
                            { 'user', user_id },
                            { 'type', 'drug' },
                            { 'item received', vRP.itemNameList(cacheRoutes[user_id].item) },
                            { 'quantity received', cacheRoutes[user_id].quantity },
                            { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                        }
                    })    
                    cacheRoutes[user_id] = nil
                    updateRoute(source, coords, itens)
                    return true
                end
            end
        else
            TriggerClientEvent('notify', source, 'aviso', 'Rotas', 'Você caiu no nosso sistema de <b>anti-dump</b> e não recebeu os itens da rota, cancele a rota e faça novamente. Por gentileza, na próxima rota não saia de perto do blip!')
            vRP.webhook('antidump', {
                title = 'anti dump',
                descriptions = {
                    { 'user', user_id },
                    { 'script', GetCurrentResourceName() },
                    { 'alert', 'provavelmente este jogador está tentando dumpar em um dos nossos sistemas!' }
                }
            })   
            print('^1[GB Anti]^7 o usuário '..user_id..' está provavelmente tentando dumpar!')
        end
    end
    return false
end

srv.callPolice = function(porcentage, name)
    local source = source
    local user_id = vRP.getUserId(source)
    local pCoord = GetEntityCoords(GetPlayerPed(source))

    exports.vrp:reportUser(user_id, {
        percentage = porcentage,
        extra = function(source) TriggerClientEvent('notify', source, 'aviso', 'Rotas', 'Os <b>coxinhas</b> foram alertados, saia do local imediatamente.'); end,
        notify = { 
            type = 'route', 
            title = 'Tráfico avistado', 
            message = 'Acabamos de receber uma denúncia anônima, vá até o local.',
            coords = pCoord,
            time = 8000
        },
        blip = {
            id = user_id, 
            text = 'Tráfico avistado', 
            coords = pCoord,
            sprite = 10, colour = 5, 
            timeout = 30000
        }
    })
end

registerRoutesTime = function(id, time)
    routeTime[id] = time
    Citizen.CreateThread(function()
        while (routeTime[id] > 0) do
            Citizen.Wait(1000)
            routeTime[id] = (routeTime[id] - 1)
        end
        routeTime[id] = nil
    end)
end
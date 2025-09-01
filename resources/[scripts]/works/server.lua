srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

srv.checkItem = function(_require, production)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (_userId) then
        if (production) then
            if (_require) then
                for index, value in pairs(_require) do
                    local quantity = math.random(value['min'], value['max'])
                    if vRP.getInventoryWeight(_userId) + vRP.getItemWeight(index) *quantity <= vRP.getInventoryMaxWeight(_userId) then
                        if (vRP.getInventoryItemAmount(_userId, index) >= quantity) then
                            if vRP.tryGetInventoryItem(_userId, index, quantity) then
                                return true
                            end
                        end
                        TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>'..quantity..'x</b> de <b>'..vRP.itemNameList(index)..'</b>.')
                        return false
                    end
                    TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>espaço</b> na mochila.')
                    return false
                end
            end
            return true
        elseif (_require) then
            if vRP.getInventoryWeight(_userId) + vRP.getItemWeight(_require['spawn']) * _require['quantity'] <= vRP.getInventoryMaxWeight(_userId) then
                if (vRP.getInventoryItemAmount(_userId, _require['spawn']) >= _require['quantity']) then
                    if vRP.tryGetInventoryItem(_userId, _require['spawn'], _require['quantity']) then
                        return true
                    end
                end
                TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>'.._require['quantity']..'x</b> de <b>'..vRP.itemNameList(_require['spawn'])..'</b>.')
                return false
            end
            TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>espaço</b> na mochila.')
            return false
        end
        return true
    end
end

srv.startCutscene = function(work)  
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local data = (json.decode(vRP.getUData(user_id, 'works')) or {})
        if (data) and (data ~= '{}') then
            if (data[work]) then return false; end;
            
            data[work] = true
            vRP.setUData(user_id, 'works', json.encode(data))
        end
    end
    return true
end

local selection = {}

srv.startUpdateRoute = function()
    local source = source
    selection[vRP.getUserId(source)] = 1
end

srv.resetUpdateRoute = function()
    local source = source
    selection[vRP.getUserId(source)] = nil
end

local updateRoute = function(source, work, routes)
    local user_id = vRP.getUserId(source)
    
    selection[user_id] = selection[user_id] + 1
    if (selection[user_id] > #routes) then
        selection[user_id] = 1 
        if (lang[work]) then TriggerClientEvent('notify', source, 'Emprego', lang[work]['resetRoutes']); end;
    end
end

local multiplyPayment = {
    _default = 1.0,

    ['VipPrata'] = 1.10,
    ['VipOuro'] = 1.15,
    ['VipCapital'] = 1.20
}

mutiply = function(user_id)
    local mutiply = multiplyPayment._default
    for group, data in pairs(vRP.getUserGroups(user_id)) do
        local mutiplys = multiplyPayment[group]
        if (mutiplys) and mutiplys > mutiply then
            mutiply = mutiplys
        end
    end
    return mutiply
end

srv.givePayment = function(location, _payment, work)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (_userId) then
        if (#(GetEntityCoords(GetPlayerPed(_source)) - location[selection[_userId]]) <= 10.0) then
            
            local randomMoney = math.random(_payment['money']['min'], _payment['money']['max'])
            
            local bonus = 1.0
            local mutiply = mutiply(_userId)

            if (selection[_userId] >= _payment['bonus']['after']) then
                bonus = _payment['bonus']['multiply']
            end

            local receiveDefault = parseInt( randomMoney * bonus )
            local receiveMultiply = parseInt( receiveDefault * mutiply )

            vRP.giveMoney(_userId, receiveMultiply)
            onPayment(_userId,  receiveMultiply, location, _payment, work, selection[_userId])

            updateRoute(_source, work, location)
            exports['phone-bank']:createStatement(user_id, { title = 'Trabalho', content = work, value = receiveMultiply, type = 'received' })

            if (receiveMultiply > receiveDefault) then
                TriggerClientEvent('notify', _source, 'Emprego', 'Entrega feita com sucesso!<br>A empresa <b>'..work..'</b> efetuou um pagamento em sua conta.<br><br>Valor Recebido: <b>R$'..receiveDefault..'</b><br>Bônus VIP: <b>R$'..(receiveMultiply - receiveDefault)..'</b>.', 8000)
            else
                TriggerClientEvent('notify', _source, 'Emprego', 'Entrega feita com sucesso!<br>A empresa <b>'..work..'</b> efetuou um pagamento em sua conta.<br><br>Valor Recebido: <b>R$'..receiveDefault..'</b>.', 8000)
            end

            return true
        else
            -- DropPlayer(_source, 'Proteção anti-dump capital.')
            vRP.webhook('antidump', {
                title = 'antidump',
                descriptions = {
                    { 'user', _userId },
                    { 'script', GetCurrentResourceName() },
                    { 'alert', 'provavelmente este jogador está tentando dumpar em um dos nossos sistemas!' }
                }
            })              
        
            print('^1[GB Anti]^7 o usuário '.._userId..' está provavelmente tentando dumpar!')
        end
    end
    return false
end

local active = {}

srv.giveItem = function(config, pCoord)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (_userId) then
        if (#(GetEntityCoords(GetPlayerPed(source)) - pCoord) <= 2.0) then
            if (product[config] and not active[_userId]) then
                active[_userId] = true

                local _receive = product[config]['receiveItems']
                for index, value in pairs(_receive) do
                    local quantity = math.random(value['min'], value['max'])
                    if vRP.getInventoryWeight(_userId) + vRP.getItemWeight(index) * quantity <= vRP.getInventoryMaxWeight(_userId) then
                        vRP.giveInventoryItem(_userId, index, quantity)
                        TriggerClientEvent('notify', _source, 'Emprego', 'Você recebeu <b>'..quantity..'x</b> de <b>'..vRP.itemNameList(index)..'</b>.')
                        WorkTimeout(product[config].duration, _userId)
                        return true
                    end
                    TriggerClientEvent('notify', _source, 'Emprego', 'Você não possui <b>espaço</b> na mochila.')
                    WorkTimeout(product[config].duration, _userId)
                    return false
                end
            end
            return true
        else
            vRP.webhook('antidump', {
                title = 'antidump',
                descriptions = {
                    { 'user', _userId },
                    { 'script', GetCurrentResourceName() },
                    { 'alert', 'provavelmente este jogador está tentando dumpar em um dos nossos sistemas!' }
                }
            })      

            print('^1[GB Anti]^7 o usuário '.._userId..' está provavelmente tentando dumpar!')
        end
    end
end

-- [ Pega trouxa ] --
WorkTimeout = function(time, id)
    Citizen.SetTimeout(time, function()
        active[id] = false
    end)
end
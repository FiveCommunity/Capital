local DB_UPDATE_CONFIGS <const> = 'update homes set configs = ? where home = ?'
local DB_GET_MAX_HOMES <const> = 'select homes from user_characters where id = ?'
DB_DELETE_HOME = 'delete from homes where home = ?'
DB_DELETE_HOME_GARAGE = 'delete from homes_garages where home = ?'

--=====================================================
-- remove Text Space
--=====================================================
removeSpaceText = function(text)
    return text:gsub('%s+', '')
end

--=====================================================
-- is Float
--=====================================================
isFloat = function(num)
    return (num ~= math.floor(num))
end

--=====================================================
-- has Slot
--=====================================================
hasSlot = function(user)
    local userHomes = getAllUserHomes(user)

    local countSpace = oxmysql:scalar_async(DB_GET_MAX_HOMES, { user })
    for group, data in pairs(vRP.getUserGroups(user)) do
        local space = config.extraSlot[data.grade]
        if (space) then
            countSpace += space
        end
    end

    return (userHomes < countSpace), countSpace
end

--=====================================================
-- purchase Verification
--=====================================================
purchaseVerification = function(user, data)
    local source = vRP.getUserSource(user)
    
            if (false) then -- exports.bank removido 
        TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode comprar uma <b>residência</b> tendo multas pendentes.')
        return false
    end

    if (not vRP.checkPermissions(user, data.perm)) then
        TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não possui <b>permissão</b> para comprar esta residência.')
        return false
    end

    local has, count = hasSlot(user)
    if (not has) then
        TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode adquirir mais de <b>'..count..' residência(s)</b>')
        return false
    end

    return true
end

--=====================================================
-- buy Residence
--=====================================================
buyResidence = function(user, data, price, home, onlyCredits)
    local source = vRP.getUserSource(user)
    local allow = false

    if (GetResourceState('hydrus.gg') == 'started') then
        local key = tostring('key-'..data.type)
        local homeCredit = exports['hydrus.gg']:getCredit(user, key)
        if (homeCredit > 0) then
            if (exports.hud:request(source, 'Residências', 'A propriedade <b>'..home..'</b> se encontra à venda. Deseja adquiri-lá por 1 crédito <b>('..key:upper()..')</b>?', 30000)) then
                if (exports['hydrus.gg']:consumeCredit(user, key, 1)) then
                    allow = 'vip'
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não possui <b>créditos</b> suficientes para adquirir esta residência.')
                end
            end
        else
            if (onlyCredits) then
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não possui <b>contrato</b> para adquirir esta <b>residência</b>.')
            end
        end
    end

    if (not allow) and (not onlyCredits) then
        if (exports.hud:request(source, 'Residências', 'A propriedade <b>'..home..'</b> se encontra à venda. Deseja adquiri-lá por <b>R$'..vRP.format(price)..'</b>?', 30000)) then
            if (vRP.tryFullPayment(user, price)) then
                allow = true
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não possui <b>dinheiro</b> o suficiente para adquirir esta residência.')
            end
        end
    end

    return allow
end

--=====================================================
-- register Blips
--=====================================================
registerBlips = function(source, bool, table)
    if (bool) then
        local users = exports.vrp:getUsers()
        for id, src in pairs(users) do
            local count, myHomes = getAllUserHomes(id, true)
            if (count > 0) then
                for home, values in pairs(myHomes) do
                    local name = (values.config.type == 'apartament' and home:gsub('%d', '') or home)
                    if (configHomes[name]) then
                        TriggerClientEvent('homes:setBlip', src, { name, configHomes[name].coord })
                    end
                end
            end
        end
    else
        TriggerClientEvent('homes:setBlip', source, table)
    end
end

--=====================================================
-- cleanup Houses
--=====================================================
cleanupHouses = function(user_id, source)
    local count = 0;

    for home, values in pairs(cache.homes) do
        local tax = tonumber(values.tax)
        if (tax) and tax > 0 then
            local taxConfig = config.type[values.config.type].tax
            local diffExpire = (taxConfig[3]-taxConfig[2])
            if (os.time() >= (tax+(diffExpire*86400))) then
                local items = exports.inventory:getBag(home)

                oxmysql:execute_async(DB_DELETE_HOME, { home })
                oxmysql:execute_async(DB_DELETE_HOME_GARAGE, { home })
                TriggerClientEvent('homes:removeGarage', -1, home)

                vRP.deleteInventory(home)

                vRP.webhook('losehouse', {
                    title = 'lose house',
                    descriptions = {
                        { 'action', '(clean up)' },
                        { 'user', values.owner },
                        { 'home', home:upper() },
                        { 'type', values.config.type },
                        { 'tax', tax..' ('..os.date(config.formatDate, tax)..')' },
                        { 'items', json.encode(items, { indent = true }) },
                        { 'table', json.encode(values.config, { indent = true }) }
                    }
                })  

                count += 1
                cache.homes[home] = nil
            end
        end
    end

    if (count > 0) then
        print('^1[Homes]^7 '..count..' houses cleaned.')
    end
end

--=====================================================
-- register Blips Buyed
--=====================================================
registerBlipsBuyed = function(source, home)
    if (home) then
        TriggerClientEvent('homes:setBlipBuyed', (source or -1), home, true)
    else
        for home in pairs(cache.homes) do
            TriggerClientEvent('homes:setBlipBuyed', (source or -1), home, true)
        end
    end
end

--=====================================================
-- gen Apt Name
--=====================================================
genAptName = function(name)
    local newName, suffix, counter = '', '', 1
    repeat
        suffix = string.format('%04d', counter)
        local apartamentName = name..suffix  
        
        local existingApartament = cache.homes[apartamentName]
        if (not existingApartament) then newName = apartamentName end;
        counter = (counter + 1)
    until (newName ~= '')
    return newName
end

--=====================================================
-- has Home Perm
--=====================================================
local perms = {
    apartament = function(user_id, home)
        local consult = getUserApartaments(user_id, true)
        if (consult) and consult[home] then
            return true
        end
        return false
    end,

    home = function(user_id, home)
        local consult = getUserHomes(user_id, true)
        if (consult) and consult[home] then
            return true
        end
        return false
    end
}

hasHomePerm = function(user_id, home)
    local data = configHomes[home]
    if (data) then
        local isApt = (data.type == 'apartament' and 'apartament' or 'home')
        return perms[isApt](user_id, home)
    end
    return false
end
exports('checkHomePermission', hasHomePerm)

--=====================================================
-- count Residents
--=====================================================
countResidents = function(residents)
    local count = 0;
    for _ in pairs(residents) do
        count += 1
    end
    return count
end

--=====================================================
-- nearest Home
--=====================================================
nearestHome = function(source)
    local ply = GetPlayerPed(source)
    local homeName, homeData, minDist = nil, {}, 10
    for k, v in pairs(configHomes) do
        local dist = #(GetEntityCoords(ply) - v.coord)
        if (dist <= 1.5) and (dist < minDist) then
            homeName, homeData, minDist = k, v, 10
        end
    end
    return homeName, homeData
end

--=====================================================
-- nearest Home
--=====================================================
insideHome = function(source)
    local inside, name = vCLIENT.insideHome(source)
    return inside, name
end
exports('insideHome', insideHome)

--=====================================================
-- calc Home Tax
--=====================================================
calcHomeTax = function(data, taxConfig)
    local timeToPay = (os.time() >= data.tax)
    local price = (isFloat(taxConfig[4]) and math.ceil(data.config.price*taxConfig[4]) or taxConfig[4])
    return price, timeToPay
end

--=====================================================
-- has Garage
--=====================================================
hasGarage = function(home)
    local result = oxmysql:query_async('select * from homes_garages where home = ?', { home })[1]
    if (result) then
        local blip, spawn = json.decode(result.blip), json.decode(result.spawn)
        return { blip = blip, spawn = spawn }
    end
    return false
end
exports('hasGarage', hasGarage)

--=====================================================
-- interactions
--=====================================================
local interactions = {
    add = function(source, user_id, data, home)
        if (data.owner == user_id) then
            local nUser = parseInt( exports.hud:prompt(source, { 'Passaporte' })[1] )
            local nIdentity = vRP.getUserIdentity(nUser)
            
            if (not nIdentity) or (nUser == user_id) then return TriggerClientEvent('notify', source, 'negado', 'Residências', (nUser == user_id and 'Você não pode se adicionar na <b>residência</b>.' or 'Cidadão <b>inexistente</b>.')); end;

            local residents = countResidents(data.residents)
            if (residents >= data.config.residents) or (data.residents[tostring(nUser)]) then return TriggerClientEvent('notify', source, 'negado', 'Residências', (residents >= data.config.residents and 'A sua residência <b>'..home..'</b> atingiu o máximo de moradores.' or 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> já é morador desta residência.')); end;

            local request = exports.hud:request(source, 'Residências', 'Você tem certeza que deseja adicionar o(a) <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> na residência <b>'..home..'</b>?', 30000)
            if (request) then
                cache.homes[home].residents[tostring(nUser)] = true
                oxmysql:update_async('update homes set residents = ? where home = ?', { json.encode(cache.homes[home].residents), home })
                TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> foi adicionado em sua residência <b>'..home..'</b>.')
                
                vRP.webhook('addhouse', {
                    title = 'add house',
                    descriptions = {
                        { 'action', '(add resident)' },
                        { 'user', user_id },
                        { 'add', nUser },
                        { 'home', home:upper() },
                    }
                })  

                local hasGarage = hasGarage(home)
                if (hasGarage) then
                    local nSource = vRP.getUserSource(nUser)
                    if (nSource) then TriggerEvent('homes:addGarage', nSource, home, hasGarage.blip, hasGarage.spawn) end;
                end
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
        end
    end,

    rem = function(source, user_id, data, home)
        if (data.owner == user_id) then
            local nUser = parseInt( exports.hud:prompt(source, { 'Passaporte' })[1] )
            local nIdentity = vRP.getUserIdentity(nUser)
            
            if (not nIdentity) or (nUser == user_id) then return TriggerClientEvent('notify', source, 'negado', 'Residências', (nUser == user_id and 'Você não pode se adicionar na <b>residência</b>.' or 'Cidadão <b>inexistente</b>.')); end;

            if (not data.residents[tostring(nUser)]) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> não é morador desta residência.'); end;

            local request = exports.hud:request(source, 'Residências', 'Você tem certeza que deseja retirar o(a) <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> da residência <b>'..home..'</b>?', 30000)
            if (request) then
                cache.homes[home].residents[tostring(nUser)] = nil
                oxmysql:update_async('update homes set residents = ? where home = ?', { json.encode(cache.homes[home].residents), home })
                TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> foi retirado de sua residência <b>'..home..'</b>.')
                
                vRP.webhook('remhouse', {
                    title = 'rem house',
                    descriptions = {
                        { 'action', '(rem resident)' },
                        { 'user', user_id },
                        { 'rem', nUser },
                        { 'home', home:upper() },
                    }
                })  

                local hasGarage = hasGarage(home)
                if (hasGarage) then
                    local nSource = vRP.getUserSource(nUser)
                    if (nSource) then TriggerClientEvent('homes:removeGarage', nSource, home) end;
                end
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
        end
    end,

    lock = function(source, user_id)
        local near, data = nearestHome(source)
        local inside, name = insideHome(source)
        if (near) or (inside) then
            local homeName = (name or near)
            local config = configHomes[homeName]
            if (config) then
                if (config.type == 'mlo') then return; end;

                local houses = (config.type == 'apartament' and getUserApartaments(user_id, true) or getUserHomes(user_id, true))
                local consult = houses[homeName]
                if (consult) then
                    cache.homes[(consult.home or homeName)].openned = (not cache.homes[(consult.home or homeName)].openned)
                    TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você <b>'..(cache.homes[(consult.home or homeName)].openned and 'destrancou' or 'trancou')..'</b> a residência!')
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
                end
            end
        end
    end,

    transfer = function(source, user_id, data, home)
        if (data.owner == user_id) then
            local nUser = parseInt( exports.hud:prompt(source, { 'Passaporte' })[1] )
            local nIdentity = vRP.getUserIdentity(nUser)
            
            if (not nIdentity) or (nUser == user_id) then return TriggerClientEvent('notify', source, 'negado', 'Residências', (nUser == user_id and 'Você não pode transferir a <b>residência</b> para si mesmo.' or 'Cidadão <b>inexistente</b>.')); end;

            if (data.config.type == 'mlo') or (data.vip) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode realizar esta interação numa residência <b>VIP</b>.'); end;

            local converted = home:gsub('%d', '')
            local nuserApartaments = getUserApartaments(nUser)
            if (nuserApartaments[converted]) then
                return TriggerClientEvent('notify', source, 'negado', 'Residências', 'O <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> já possui uma residência nesse prédio.')
            end

            local request = exports.hud:request(source, 'Residências', 'Você tem certeza que deseja transferir a residência <b>'..home..'</b> para o(a) <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>?', 30000)
            if (request) then
                local items = exports.inventory:getBag(home)

                cache.homes[home].owner = nUser
                cache.homes[home].residents = {}

                oxmysql:update_async('update homes set residents = ?, user_id = ? where home = ?', { '{}', nUser, home })
                TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você transferiu a sua <b>residência</b> para o(a) <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                TriggerClientEvent('homes:removeGarage', -1, home)

                local hasGarage = hasGarage(home)
                if (hasGarage) then
                    local nSource = vRP.getUserSource(nUser)
                    if (nSource) then TriggerEvent('homes:addGarage', nSource, home, hasGarage.blip, hasGarage.spawn) end;
                end

                vRP.webhook('transferhouse', {
                    title = 'transfer house',
                    descriptions = {
                        { 'action', '(transfer resident)' },
                        { 'old owner', user_id },
                        { 'new owner', nUser },
                        { 'home', home:upper() },
                        { 'type', data.config.type },
                        { 'tax in', data.tax..' ('..os.date(config.formatDate, data.tax)..')' },
                        { 'items', json.encode(items, { indent = true }) },
                        { 'table', json.encode(data.config, { indent = true }) },
                    }
                })  
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
        end
    end,

    sell = function(source, user_id, data, home)
        if (data.owner == user_id) then
            if (data.config.type == 'mlo') or (data.vip) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode realizar esta interação numa residência <b>VIP</b>.'); end;

            local homePrice = parseInt( data.config.price * config.percentageSell )

            local request = exports.hud:request(source, 'Residências', 'Você tem certeza que deseja vender a residência <b>'..home..'</b> para a prefeitura por <b>R$'..vRP.format(homePrice)..'</b>?', 30000)
            if (request) then
                local items = exports.inventory:getBag(home)

                vRP.giveBankMoney(user_id, homePrice)
                exports['phone-bank']:createStatement(user_id, { title = 'Venda', content = 'Vendeu uma residência', value = homePrice, type = 'received' })

                cache.homes[home] = nil
                cache.presets[home] = nil

                oxmysql:execute_async(DB_DELETE_HOME, { home })
                oxmysql:execute_async(DB_DELETE_HOME_GARAGE, { home })
                oxmysql:execute_async('delete from homes_wardrobe where home = ?', { home })
                vRP.deleteInventory(home)

                TriggerClientEvent('homes:removeGarage', -1, home)
                TriggerClientEvent('homes:setBlipBuyed', -1, home)

                for id, values in pairs(cache.users) do
                    if (values.home == home) then
                        local source = vRP.getUserSource(id)
                        if (source) then
                            vCLIENT.exitTheHouse(source)
                        end
                        TriggerEvent('homes:cleanTempCache', id, true)
                    end
                end

                vRP.webhook('sellhouse', {
                    title = 'sell house',
                    descriptions = {
                        { 'action', '(sell house)' },
                        { 'user', user_id },
                        { 'home', home:upper() },
                        { 'type', data.config.type },
                        { 'value received', homePrice },
                        { 'items', json.encode(items, { indent = true }) },
                        { 'REMOVED HOUSE', 'items and garages and upgrades' },
                        { 'table', json.encode(data.config, { indent = true }) }
                    }
                })  

                TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você vendeu a residência <b>'..home..'</b> para a prefeitura por <b>R$'..vRP.format(homePrice)..'</b>.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
        end
    end,

    check = function(source, user_id, data, home)
        local residents = countResidents(data.residents)
        if (residents > 0) then
            local list = '';
            
            for id in pairs(data.residents) do
                local identity = vRP.getUserIdentity(tonumber(id))
                list = list..'<br><br>Passaporte: <b>'..id..'</b> <br>Nome: <b>'..(identity.firstname or 'Indivíduo')..' '..(identity.lastname or 'Indigente')..'</b>'
            end

            TriggerClientEvent('notify', source, 'importante', 'Residências', 'Moradores <b>('..home..')</b>: '..list, 10000)
        else
            TriggerClientEvent('notify', source, 'importante', 'Residências', 'Não tem <b>moradores</b> na sua residência.', 10000)
        end
    end,

    tax = function(source, user_id, data, home)
        local taxValue = tonumber(data.tax)
        if (taxValue) and taxValue > 0 then
            local taxConfig = config.type[data.config.type].tax
            local taxPrice, timeToPay = calcHomeTax(data, taxConfig)
            if (timeToPay) or (exports.hud:request(source, 'Residências', 'O <b>IPTU</b> da residência <b>'..home..'</b> vence apenas <b>'..os.date(config.formatDate, data.tax)..'</b> deseja continuar?', 30000)) then
                if (exports.hud:request(source, 'Residências', 'Deseja pagar o <b>IPTU</b> da residência <b>'..home..'</b> por <b>R$'..vRP.format(taxPrice)..'</b>?', 30000)) then
                    if (vRP.tryFullPayment(user_id, taxPrice)) then
                        local newExpire = (os.time()+(taxConfig[2]*86400))
                        
                        exports['phone-bank']:createStatement(user_id, { title = 'Taxas', content = 'IPTU da residência', value = taxPrice, type = 'spent' })
                        
                        cache.homes[home].tax = newExpire
                        oxmysql:update_async('update homes set tax = ? where home = ?', { newExpire, home })                        
                        TriggerClientEvent('Notify', source, 'sucesso', 'Residências', 'IPTU renovado para o dia <b>'..os.date(config.formatDate, newExpire)..'</b>!', 8000)
                    
                        vRP.webhook('buytax', {
                            title = 'buy tax',
                            descriptions = {
                                { 'action', '(buy tax)' },
                                { 'user', user_id },
                                { 'home', home:upper() },
                                { 'type', data.config.type },
                                { 'price', taxPrice },
                                { 'TAX RENEWED', newExpire..' ('..os.date(config.formatDate, newExpire)..')' },
                                { 'table', json.encode(data.config, { indent = true }) }
                            }
                        })  
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Residências', 'Dinheiro <b>insuficiente</b>!')
                    end
                end
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não precisa pagar o <b>IPTU</b> desta residência.')
        end
    end,

    residences = function(source, user_id)
        local count, userHomes = getAllUserHomes(user_id, true)
        if (count > 0) then
            local list = '';
            for home, data in pairs(userHomes) do
                local resident = (cache.homes[home].residents[tostring(user_id)])
                local text = (data.tax == -1 and 'VIP' or os.date(config.formatDate, data.tax))
                list = list..'<br><br>Residência: <b>'..home..'</b>'..(resident and ' (Morador)' or '')..'<br>IPTU: <b>'..text..'</b>'
            end
            TriggerClientEvent('notify', source, 'importante', 'Residências', 'Minhas residências: '..list, 10000)
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não possui <b>residências</b>!')
        end
    end,

    list_interior = function(source, user_id, data, home)
        local list = '';
        for key, values in pairs(configType[data.config.type].interior) do
            if (key ~= '_default') then
                local intName = configInterior[key].name
                local text = ((key == data.config.interior) and '(Atual)<br>Decoração: <b>'..(values.decoration and 'Disponível' or 'Indisponível')..'</b>' or '<br>Valor: <b>R$'..vRP.format(values.value)..'</b><br>Decoração: <b>'..(values.decoration  and 'Disponível' or 'Indisponível')..'</b>')
                list = list..'<br><br>Interior: <b>'..intName..'</b> '..text
            end
        end
        TriggerClientEvent('notify', source, 'importante', 'Residências', 'Interiores disponíveis em sua residência:'..list, 30000)
    end,

    interior = function(source, user_id, data, home, meta)
        if (data.config.type == 'mlo') then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode realizar esta interação numa residência <b>VIP</b>.'); end;
        
        if (data.owner == user_id) then
            local dataInterior = configType[data.config.type].interior[meta.interior]
            if (dataInterior) then
                if (vRP.checkPermissions(user_id, dataInterior.perm)) then
                    if (meta.interior == data.config.interior) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Este é o <b>interior</b> atual de sua residência. Por gentileza, escolha outro.'); end;
                    
                    if (exports.hud:request(source, 'Residências', 'Gostaria de visualizar o <b>interior</b> antes de comprá-lo?', 30000)) then
                        local inside = insideHome(source)
                        if (not inside) then
                            setTempCache(user_id)
                            vCLIENT.previewInterior(source, meta.interior, (meta.interior == 'eclip_penthouse' and 'executive' or nil))
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode visualizar um <b>interior</b> dentro de uma residência!')
                        end
                    end

                    if (exports.hud:request(source, 'Residências', 'Você deseja alterar o interior da sua residência <b>'..home..'</b> para <b>'..configInterior[meta.interior].name..'</b> por <b>R$'..vRP.format(dataInterior.value)..'</b>?', 30000)) then
                        if (vRP.tryFullPayment(user_id, dataInterior.value)) then
                            local items = exports.inventory:getBag(home)
                            
                            exports['phone-bank']:createStatement(user_id, { title = 'Atualização', content = 'Compra de interior para a residência', value = dataInterior.value, type = 'spent' })

                            vRP.webhook('buyinterior', {
                                title = 'buy interior', 
                                descriptions = {
                                    { 'action', '(buy interior)' },
                                    { 'user', user_id },
                                    { 'home', home:upper() },
                                    { 'type', data.config.type },
                                    { 'price', dataInterior.value },
                                    { 'old interior', data.config.interior },
                                    { 'NEW INTERIOR', meta.interior },
                                    { 'items', json.encode(items, { indent = true }) },
                                    { 'table', json.encode(data.config, { indent = true }) }
                                }
                            })

                            cache.homes[home].config.interior = meta.interior
                            cache.homes[home].config.decorations = (meta.interior == 'eclip_penthouse' and 'executive' or 0)
                            
                            oxmysql:update_async(DB_UPDATE_CONFIGS, { json.encode(cache.homes[home].config), home })

                            TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'O interior de sua residência <b>'..home..'</b> foi alterado com sucesso.')
                        else
                            TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Dinheiro <b>insuficiente</b>!')  
                        end
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não tem <b>permissão</b> para atualizar o interior da sua residência.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode utilizar este interior numa residência <b>'..home:upper()..'</b>.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
        end
    end,

    list_decoration = function(source, user_id, data, home)
        local dataDecoration = configInterior[data.config.interior].decorations
        if (dataDecoration) then
            local list = '';

            for key, values in pairs(dataDecoration) do
                if (key ~= '_default') then                    
                    local text = (key == data.config.decorations) and '(Atual)' or '<br>Valor: <b>R$'..vRP.format(values.value)..'</b>'
                    list = list..'<br><br>Interior: <b>'..intName..'</b> '..text
                end
            end

            TriggerClientEvent('notify', source, 'importante', 'Residências', 'Decorações disponíveis em sua residência:'..list, 30000)
        else
            TriggerClientEvent('notify', source, 'importante', 'Residências', 'O interior atual de sua residência <b>'..home..'</b> não possui <b>decoração</b>. <br><br>Saiba qual interior de sua <b>residência</b> possui decoração na lista de interiores.', 10000)
        end
    end,

    decoration = function(source, user_id, data, home, meta)
        if (data.config.type == 'mlo') then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode realizar esta interação numa residência <b>VIP</b>.'); end;

        if (data.owner == user_id) then
            local dataDecorations = (configInterior[data.config.interior].decorations and configInterior[data.config.interior].decorations[meta.decoration] or false)
            if (dataDecorations) then
                if (vRP.checkPermissions(user_id, dataDecorations.perm)) then
                    if (meta.decoration == data.config.decorations) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Esta é a <b>decoração</b> atual de sua residência. Por gentileza, escolha outro.'); end;
                    
                    if (exports.hud:request(source, 'Residências', 'Gostaria de visualizar a <b>decoração</b> antes de comprá-la?', 30000)) then
                        local inside = insideHome(source)
                        if (not inside) then
                            setTempCache(user_id)
                            vCLIENT.previewInterior(source, 'eclip_penthouse', meta.decoration)
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode visualizar uma <b>decoração</b> dentro de uma residência!')
                        end
                    end

                    if (exports.hud:request(source, 'Residências', 'Você deseja alterar o interior da sua residência <b>'..home..'</b> para <b>'..dataDecorations.name..'</b> por <b>R$'..vRP.format(dataDecorations.value)..'</b>?', 30000)) then
                        if (vRP.tryFullPayment(user_id, dataDecorations.value)) then
                            local items = exports.inventory:getBag(home)
                            
                            exports['phone-bank']:createStatement(user_id, { title = 'Atualização', content = 'Compra de decoração para a residência', value = dataDecorations.value, type = 'spent' })
                            
                            vRP.webhook('buydecoration', {
                                title = 'buy decoration',
                                descriptions = {
                                    { 'action', '(buy decoration)' },
                                    { 'user', user_id },
                                    { 'home', home:upper() },
                                    { 'type', data.config.type },
                                    { 'price', dataDecorations.value },
                                    { 'old decoration', data.config.decorations },
                                    { 'NEW decoration', meta.decoration },
                                    { 'items', json.encode(items, { indent = true }) },
                                    { 'table', json.encode(data.config, { indent = true }) }
                                }
                            })  

                            cache.homes[home].config.decorations = meta.decoration
                            oxmysql:update_async(DB_UPDATE_CONFIGS, { json.encode(cache.homes[home].config), home })

                            TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'A decoração de sua residência <b>'..home..'</b> foi alterada com sucesso.')
                        else
                            TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Dinheiro <b>insuficiente</b>!')  
                        end
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não tem <b>permissão</b> para atualizar a decoração da sua residência.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'O interior atual de sua residência <b>'..home..'</b> não possui <b>decoração</b>. <br><br>Saiba qual interior de sua <b>residência</b> possui <b>decoração</b> na lista de interiores.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
        end
    end,

    chest = function(source, user_id, data, home)
        if (data.config.type == 'mlo') then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode realizar esta interação numa residência <b>VIP</b>.'); end;

        local dataChest = configType[data.config.type].chest
        if (vRP.checkPermissions(user_id, dataChest.perm)) then
            local upgradeValue = parseInt( exports.hud:prompt(source, { 'Quantos KG você deseja aumentar? (Peso atual: '..data.config.chest..'kg)' })[1] )
            if (upgradeValue > 0) then
                local totalUpgrade = (upgradeValue+data.config.chest)
                if (not dataChest.max) or (totalUpgrade <= dataChest.max) then
                    local upgradePrice = (upgradeValue*dataChest.value)
                    local request = exports.hud:request(source, 'Residências', 'Você deseja pagar <b>R$'..vRP.format(upgradePrice)..'</b> para aumentar o baú de sua residência <b>'..home..'</b>?', 30000)
                    if (request) then
                        local Inventory = vRP.Inventory(home, { weight = data.config.chest, slots = 1000 })
                        if (Inventory) then
                            if (vRP.tryFullPayment(user_id, upgradePrice)) then
                                local items = Inventory:getItems()

                                exports['phone-bank']:createStatement(user_id, { title = 'Atualização', content = 'Compra de kgs pro baú', value = upgradePrice, type = 'spent' })

                                vRP.webhook('buychest', {
                                    title = 'buy chest',
                                    descriptions = {
                                        { 'action', '(buy chest)' },
                                        { 'user', user_id },
                                        { 'home', home:upper() },
                                        { 'type', data.config.type },
                                        { 'price', upgradePrice },
                                        { 'old chest', data.config.chest..'kg' },
                                        { 'NEW chest', totalUpgrade..'kg' },
                                        { 'items', json.encode(items, { indent = true }) },
                                        { 'table', json.encode(data.config, { indent = true }) }
                                    }
                                })  

                                cache.homes[home].config.chest = totalUpgrade
                                oxmysql:update_async(DB_UPDATE_CONFIGS, { json.encode(cache.homes[home].config), home })
                                TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você aumentou o baú da sua residência <b>'..home..'</b> com sucesso.')

                                Inventory:setMaxWeight(totalUpgrade)
                                vRP.releaseInventory(home, true)
                            else
                                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Dinheiro <b>insuficiente</b>!')
                            end
                        end
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você pois um peso maior do que o máximo de sua residência <b>'..home..'</b> permite, que seria de <b>'..dataChest.max..'kg</b>.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode colocar um <b>valor</b> menor ou igual a zero.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não tem <b>permissão</b> para aumentar o baú da sua residência.')
        end
    end,

    fridge = function(source, user_id, data, home)
        if (data.config.type == 'mlo') then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode realizar esta interação numa residência <b>VIP</b>.'); end;

        local dataFridge = configType[data.config.type].fridge
        if (vRP.checkPermissions(user_id, dataFridge.perm)) then
            local upgradeValue = parseInt( exports.hud:prompt(source, { 'Quantos KG você deseja aumentar? (Peso atual: '..data.config.fridge..'kg)' })[1] )
            if (upgradeValue > 0) then
                local totalUpgrade = (upgradeValue+data.config.fridge)
                if (not dataFridge.max) or (totalUpgrade <= dataFridge.max) then
                    local upgradePrice = (upgradeValue*dataFridge.value)
                    local request = exports.hud:request(source, 'Residências', 'Você deseja pagar <b>R$'..vRP.format(upgradePrice)..'</b> para aumentar a Geladeira de sua residência <b>'..home..'</b>?', 30000)
                    if (request) then
                        local invId = ('fridge:'..home)
                        local Inventory = vRP.Inventory(invId, { weight = data.config.fridge, slots = 50 })
                        if (Inventory) then
                            if (vRP.tryFullPayment(user_id, upgradePrice)) then
                                local items = Inventory:getItems()

                                exports['phone-bank']:createStatement(user_id, { title = 'Atualização', content = 'Compra de kgs para Geladeira', value = upgradePrice, type = 'spent' })

                                vRP.webhook('buychest', {
                                    title = 'buy fridge',
                                    descriptions = {
                                        { 'action', '(buy fridge)' },
                                        { 'user', user_id },
                                        { 'home', home:upper() },
                                        { 'type', data.config.type },
                                        { 'price', upgradePrice },
                                        { 'old fridge', data.config.fridge..'kg' },
                                        { 'NEW fridge', totalUpgrade..'kg' },
                                        { 'items fridge', json.encode(items, { indent = true }) },
                                        { 'table', json.encode(data.config, { indent = true }) }
                                    }
                                })  

                                cache.homes[home].config.fridge = totalUpgrade
                                oxmysql:update_async(DB_UPDATE_CONFIGS, { json.encode(cache.homes[home].config), home })
                                TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você aumentou a Geladeira da sua residência <b>'..home..'</b> com sucesso.')

                                Inventory:setMaxWeight(totalUpgrade)
                                vRP.releaseInventory(invId, true)
                            else
                                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Dinheiro <b>insuficiente</b>!')
                            end
                        end
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você pois um peso maior do que o máximo de sua residência <b>'..home..'</b> permite, que seria de <b>'..dataFridge.max..'kg</b>.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode colocar um <b>valor</b> menor ou igual a zero.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não tem <b>permissão</b> para aumentar a Geladeira da sua residência.')
        end
    end,

    garage = function(source, user_id, data, home)
        local inside = insideHome(source)
        if (inside) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode adicionar garagem dentro da sua <b>residência</b>.'); end;
        
        local dataGarage = configType[data.config.type].garage
        if (dataGarage[1]) then
            if (vRP.checkPermissions(user_id, dataGarage[3])) then
                local hasGarage = hasGarage(home)
                if (not hasGarage) then
                    local homeCoords = configHomes[home].coord
                    if (#(GetEntityCoords(GetPlayerPed(source)) - homeCoords)) then
                        local created, meta = vCLIENT.createGarage(source, homeCoords)
                        if (created) then
                            if (exports.hud:request(source, 'Residências', 'Você deseja ver a <b>pré-visualização</b> do spawn da sua garagem?', 30000)) then
                                vCLIENT.previewGarage(source, meta.spawn)
                            end

                            if (exports.hud:request(source, 'Residências', 'Você deseja pagar <b>R$'..vRP.format(dataGarage[2])..'</b> para adicionar uma garagem em sua residência?', 30000)) then
                                if (vRP.tryFullPayment(user_id, dataGarage[2])) then
                                    exports['phone-bank']:createStatement(user_id, { title = 'Atualização', content = 'Compra de garagem para a residência', value = dataGarage[2], type = 'spent' })

                                    oxmysql:insert_async('insert ignore into homes_garages (home, blip, spawn) values (?, ?, ?)', { home, json.encode(meta.blip), json.encode(meta.spawn) })
                                    TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você comprou uma garagem para a sua residência <b>'..home..'</b>.')
                                    TriggerEvent('homes:addGarage', nil, home, meta.blip, meta.spawn)

                                    vRP.webhook('buygarage', {
                                        title = 'buy garage',
                                        descriptions = {
                                            { 'action', '(buy garage)' },
                                            { 'user', user_id },
                                            { 'home', home:upper() },
                                            { 'type', data.config.type },
                                            { 'price', dataGarage[2] },
                                            { 'coords', json.encode({ meta.blip, meta.spawn }, { indent = true }) },
                                            { 'table', json.encode(data.config, { indent = true }) }
                                        }
                                    })  
                                else
                                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Dinheiro <b>insuficiente</b>!')
                                end
                            end
                        end
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não se encontra próximo de sua residência <b>'..home..'</b>.')
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Esta residência já possui uma <b>garagem</b>.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não tem <b>permissão</b> para adicionar garagem em sua residência.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode <b>adicionar</b> garagem nesta residência.')
        end
    end,

    del_garage = function(source, user_id, data, home)
        local dataGarage = configType[data.config.type].garage
        local hasGarage = hasGarage(home)
        if (dataGarage[1]) and (hasGarage) then
            local receive = (dataGarage[2]*config.percentageSellUpgrade)
            if (exports.hud:request(source, 'Residências', 'Você deseja vender a garagem da sua residência por <b>R$'..vRP.format(receive)..'</b>?', 30000)) then
                exports['phone-bank']:createStatement(user_id, { title = 'Venda', content = 'Vendeu a garagem da residência', value = receive, type = 'received' })
                vRP.giveBankMoney(user_id, receive)

                oxmysql:execute_async('delete from homes_garages where home = ?', { home })
                TriggerClientEvent('homes:removeGarage', -1, home)
                TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você vendeu a garagem da sua residência <b>'..home..'</b>.')

                vRP.webhook('buygarage', {
                    title = 'sell garage',
                    descriptions = {
                        { 'action', '(sell garage)' },
                        { 'user', user_id },
                        { 'home', home:upper() },
                        { 'type', data.config.type },
                        { 'value received', receive },
                        { 'table', json.encode(data.config, { indent = true }) }
                    }
                })  
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Esta residência não possui uma <b>garagem</b>.')
        end
    end,

    wardrobe = function(source, user_id, data, home)
        if (data.config.type == 'mlo') then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode realizar esta interação numa residência <b>VIP</b>.'); end;
        
        local dataWardrobe = configType[data.config.type].wardrobe
        if (vRP.checkPermissions(user_id, dataWardrobe.perm)) then
            local upgradeValue = parseInt( exports.hud:prompt(source, { 'Quantos slots você deseja aumentar? (Slots atual: '..data.config.wardrobe..')' })[1] )
            if (upgradeValue > 0) then
                local totalUpgrade = (upgradeValue+data.config.wardrobe)
                if (not dataWardrobe.max) or (totalUpgrade <= dataWardrobe.max) then
                    local upgradePrice = (upgradeValue*dataWardrobe.value)
                    local request = exports.hud:request(source, 'Residências', 'Você deseja pagar <b>R$'..vRP.format(upgradePrice)..'</b> para aumentar o guarda roupa de sua residência <b>'..home..'</b>?', 30000)
                    if (request) then
                        if (vRP.tryFullPayment(user_id, upgradePrice)) then
                            exports['phone-bank']:createStatement(user_id, { title = 'Atualização', content = 'Compra de guarda roupa para a residência', value = upgradePrice, type = 'spent' })

                            vRP.webhook('buywardrobe', {
                                title = 'buy wardrobe',
                                descriptions = {
                                    { 'action', '(buy wardrobe)' },
                                    { 'user', user_id },
                                    { 'home', home:upper() },
                                    { 'type', data.config.type },
                                    { 'price', upgradePrice },
                                    { 'old wardrobe', data.config.wardrobe..' slots' },
                                    { 'NEW wardrobe', totalUpgrade..' slots' },
                                    { 'table', json.encode(data.config, { indent = true }) }
                                }
                            })  

                            cache.homes[home].config.wardrobe = totalUpgrade
                            oxmysql:update_async(DB_UPDATE_CONFIGS, { json.encode(cache.homes[home].config), home })
                            TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você aumentou o guarda roupa da sua residência <b>'..home..'</b> com sucesso.')
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Dinheiro <b>insuficiente</b>!')
                        end
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você pois um valor maior do que o máximo de sua residência <b>'..home..'</b> permite, que seria de <b>'..dataWardrobe.max..' slots</b>.')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não pode colocar um <b>valor</b> menor ou igual a zero.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não tem <b>permissão</b> para aumentar o baú da sua residência.')
        end
    end
}

local noConsult = { -- Interações que não precisam do CONSULT
    ['lock'] = true,
    ['residences'] = true
}

local action = {}

homeInteractions = function(source, interaction, meta)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (not action[user_id]) then
            action[user_id] = true

            if (noConsult[interaction]) then
                interactions[interaction](source, user_id)
            else
                local residence = capitalizeString( (exports.hud:prompt(source, { 'Nome da Residência' })[1] or '') )
                if (residence) then
                    local consult = cache.homes[residence]
                    if (consult) then
                        if (consult.owner == user_id) or (consult.residents[tostring(user_id)]) then
                            Citizen.Wait(500)
                            interactions[interaction](source, user_id, consult, residence, meta)
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Residência', 'Você não é proprietário/morador desta <b>residência</b>.')
                        end  
                    end          
                end
            end

            action[user_id] = nil
        end
    end
end
exports('homeInteractions', homeInteractions)

--=====================================================
-- reset User Homes
--=====================================================
resetUserHomes = function(user_id)
    local count, userHomes = getAllUserHomes(user_id)
    if (count > 0) then
        for home, data in pairs(userHomes) do
            oxmysql:execute_async(DB_DELETE_HOME, { home })
            oxmysql:execute_async(DB_DELETE_HOME_GARAGE, { home })
            vRP.deleteInventory(home)

            cache.homes[home] = nil

            print('^1[Homes]^7 house '..home..' deleted.')
        end
    end
end
exports('ResetUserHomes', resetUserHomes)
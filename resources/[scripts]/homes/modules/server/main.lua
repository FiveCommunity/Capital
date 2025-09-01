--====================================================================================
-- Database
--====================================================================================

DB_INSERT_HOME = 'insert ignore into homes (user_id, home, tax, configs, vip) values (?, ?, ?, ?, ?)'

--====================================================================================
-- Variaveis
--====================================================================================

cache = { action = {}, homes = {}, users = {}, presets = {} }
local chestOpenned = {}
local fridgeOpenned = {}
local bucketIDS = Tools.newIDGenerator()

local tablePreset = function(home)
    if (not cache.presets[home]) then
        cache.presets[home] = {}
    end
    return true
end

cleanTempCache = function(user, bool, exit)
    local _cache = cache.users[user]
    if (user) and _cache then
        if (bool) and _cache.coord then
            print('^1[Homes]^7 user '..user..' saved.')

            if (not exit) then
                local source = vRP.getUserSource(user)
                if (GetPlayerRoutingBucket(source) ~= 0) then SetPlayerRoutingBucket(source, 0); end;
                vRPclient.teleport(source, _cache.coord.x, _cache.coord.y, _cache.coord.z)
            else
                vRP.setKeyDataTable(user, 'position', { x = _cache.coord.x, y = _cache.coord.y, z = _cache.coord.z })
            end
        end

        cache.users[user] = nil
    end
end
RegisterNetEvent('homes:cleanTempCache', cleanTempCache)

setTempCache = function(user, home)
    if (user) then
        local source = vRP.getUserSource(user)
        cache.users[user] = { coord = GetEntityCoords(GetPlayerPed(source)), home = home }
    end
end

--====================================================================================

local Execs = {
    home = function(source, user_id, home, data, dataType)
        if (exports.system:houseBeingRobbed(source, user_id, home)) then return; end;

        local consult = cache.homes[home]
        if (consult) then
            -- [ have owner ] --

            local tax = tonumber(consult.tax)
            if (tax > 0) and (os.time() >= tax) then
                return TriggerClientEvent('notify', source, 'aviso', 'Residências', 'O <b>iptu</b> está atrasado!')
            end
            
            if (consult.owner == user_id) or (consult.residents[tostring(user_id)]) then
                -- [ is resident ] --
                if (tax > 0) then
                    TriggerClientEvent('notify', source, 'importante', 'Residências', 'O <b>IPTU</b> vence <b>'..os.date(config.formatDate, tax)..'</b>.')
                end

                setTempCache(user_id, home)
                vCLIENT.enterInHome(source, home, consult.config.interior)
            else
                -- [ isn't resident ] --
                if (consult.openned) then
                    setTempCache(user_id, home)
                    vCLIENT.enterInHome(source, home, consult.config.interior)
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Porta <b>trancada</b>!')
                end
            end
        else
            -- [ dont have owner ] --

            if (cache.action[home]) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Esta <b>propriedade</b> encontra-se em negociação.'); end;
            cache.action[home] = true

            if (purchaseVerification(user_id, data)) then
                local available, price, onlyCredits = dataType.price[1], dataType.price[2], dataType.price[3]
                if (available) then
                    local buyed = buyResidence(user_id, data, price, home, onlyCredits)
                    if (buyed) then
                        local tax = (dataType.tax[1] and (os.time()+(dataType.tax[2]*86400)) or -1)

                        local table = {
                            price = price,
                            residents = (dataType.residents[1] and dataType.residents[2] or 0),
                            chest = dataType.chest.min,
                            fridge = (dataType.fridge.min or 0),
                            interior = dataType.interior._default,
                            type = data.type,
                            decorations = 0
                        }

                        cache.homes[home] = {
                            owner = user_id, config = table, vip = (buyed == 'vip'), tax = tax, residents = {}
                        }

                        oxmysql:insert_async(DB_INSERT_HOME, { user_id, home, tax, json.encode(table), (buyed == 'vip') })
                        TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Parabéns! Você adquiriu a residência <b>'..home..'</b> por <b>R$'..vRP.format(price)..'.')
                    
                        vRP.webhook('buyhouse', {
                            title = 'buy house',
                            descriptions = {
                                { 'action', '(buy house)' },
                                { 'user', user_id },
                                { 'home', home:upper() },
                                { 'type', data.type },
                                { 'tax in', (tax ~= -1 and tax..' ('..os.date(config.formatDate, tax)..')' or 'null') },
                                { 'table', json.encode(table) }
                            }
                        })  

                        registerBlipsBuyed(nil, home)
                        registerBlips(source, false, { home, data.coord })
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Esta propriedade <b>'..home..'</b> não está disponível para venda.')
                end
            end

            cache.action[home] = nil
        end
    end,

    apartament = function(source, user_id, home, data, dataType)
        local userApartaments = getUserApartaments(user_id)
        vCLIENT.openNui(source, userApartaments[home], home)
    end,

    join_apartament = function(source, user_id, home, data, dataType)
        local consult = cache.homes[home]
        if (consult) then
            local tax = tonumber(consult.tax)
            if (tax > 0) then
                if (os.time() >= tax) then
                    return TriggerClientEvent('notify', source, 'aviso', 'Residências', 'O <b>iptu</b> está atrasado!')
                end
                TriggerClientEvent('notify', source, 'importante', 'Residências', 'O <b>IPTU</b> vence <b>'..os.date(config.formatDate, tax)..'</b>.')
            end

            setTempCache(user_id, home)
            vCLIENT.enterInHome(source, home, consult.config.interior, consult.config.decorations) 
        end
    end,

    buy_apartament = function(source, user_id, home, data, dataType)
        if (cache.action[home]) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Esta <b>propriedade</b> encontra-se em negociação.'); end;
        cache.action[home] = true

        if (purchaseVerification(user_id, data)) then
            local available, price, onlyCredits = dataType.price[1], dataType.price[2], dataType.price[3]
            if (available) then
                local buyed = buyResidence(user_id, data, price, home, onlyCredits)
                if (buyed) then
                    local tax = (dataType.tax[1] and (os.time()+(dataType.tax[2]*86400)) or -1)

                    local table = {
                        price = price,
                        residents = (dataType.residents[1] and dataType.residents[2] or 0),
                        chest = dataType.chest.min,
                        fridge = (dataType.fridge.min or 0),
                        interior = dataType.interior._default,
                        type = data.type,
                    }

                    local decoration = configInterior[dataType.interior._default]
                    if (decoration) then table.decorations = (decoration.decorations and decoration.decorations._default or 0); end;

                    local name = genAptName(home)
                    if (name) then 
                        cache.homes[name] = {
                            owner = user_id, config = table, vip = (buyed == 'vip'), tax = tax, residents = {}
                        }

                        oxmysql:insert_async(DB_INSERT_HOME, { user_id, name, tax, json.encode(table), (buyed == 'vip') })
                        TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Parabéns! Você adquiriu a residência <b>'..home..'</b> por <b>R$'..vRP.format(price)..'.')
                    
                        vRP.webhook('buyhouse', {
                            title = 'buy house',
                            descriptions = {
                                { 'action', '(buy house)' },
                                { 'user', user_id },
                                { 'home', name:upper() },
                                { 'type', data.type },
                                { 'tax in', (tax ~= -1 and tax..' ('..os.date(config.formatDate, tax)..')' or 'null') },
                                { 'table', json.encode(table) }
                            }
                        })  

                        registerBlipsBuyed(nil, home)
                        registerBlips(source, false, { home, data.coord })
                    end
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Esta propriedade <b>'..home..'</b> não está disponível para venda.')
            end
        end

        cache.action[home] = nil
    end,

    intercom = function(source, user_id, home, data, dataType)
        local aptNumber = exports.hud:prompt(source, { 'Número do Apartamento' })[1]
        if (aptNumber) then
            local converted = tostring(home..aptNumber)
            local consult = cache.homes[converted]
            if (consult) then
                local tax = tonumber(consult.tax)
                if (tax > 0) and (os.time() >= tax) then
                    return TriggerClientEvent('notify', source, 'aviso', 'Residências', 'O <b>iptu</b> está atrasado!')
                end
                
                if (consult.owner == user_id) or (consult.residents[tostring(user_id)]) then
                    if (tax > 0) then
                        TriggerClientEvent('notify', source, 'importante', 'Residências', 'O <b>IPTU</b> vence <b>'..os.date(config.formatDate, tax)..'</b>.')
                    end

                    setTempCache(user_id, converted)
                    vCLIENT.enterInHome(source, converted, consult.config.interior, consult.config.decorations)
                else
                    if (consult.openned) then
                        setTempCache(user_id, converted)
                        vCLIENT.enterInHome(source, converted, consult.config.interior, consult.config.decorations)
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Residências', 'Porta <b>trancada</b>!')
                    end
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Não há <b>apartamento</b> com esse número em nosso <b>condomínio</b>.')
            end
        end
    end,

    add_outfit = function(source, user_id, home, data)        
        if (data.owner == user_id) then
            if (cache.presets[home]) and (#cache.presets[home] < data.config.wardrobe) then
                local name = exports.hud:prompt(source, { 'Nome do Outfit' })[1]
                if (not name) then return; end;
                name = removeSpaceText(name:upper())

                if (name:len() > 15) then return TriggerClientEvent('notify', source, 'negado', 'Residências', 'O nome não pode ter mais de <b>15 caracteres</b>.'); end;

                local exist = outfitExist(home, name)
                if (not exist) then
                    local request = exports.hud:request(source, 'Residências', 'Você tem certeza que deseja salvar o outfit <b>'..name..'</b>?', 30000)
                    if (request) then
                        local preset = vCLIENT.getPreset(source)
                        
                        oxmysql:insert_async('insert ignore into homes_wardrobe (home, name, preset) values (?, ?, ?)', { home, name, json.encode(preset) })                    
                        table.insert(cache.presets[home], { name = name, preset = preset })
                        
                        TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você salvou o outfit <b>'..name..'</b>!')
                    end
                else
                    TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você já possui um <b>outfit</b> com este nome!')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não possui <b>vagas disponíveis</b> no seu guarda-roupa.')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
        end
        return true
    end,

    del_outfit = function(source, user_id, home, data)
        if (data.owner == user_id) then
            local name = exports.hud:prompt(source, { 'Nome do Outfit' })[1]
            if (not name) then return; end;
            name = removeSpaceText(name:upper())

            local exist = outfitExist(home, name)
            if (exist) then
                local request = exports.hud:request(source, 'Residências', 'Você tem certeza que deseja deletar o outfit <b>'..name..'</b>?', 30000)
                if (request) then
                    oxmysql:execute_async('delete from homes_wardrobe where home = ? and name = ?', { home, name })
                    deleteOutfit(home, name)
                    TriggerClientEvent('notify', source, 'sucesso', 'Residências', 'Você deletou o outfit <b>'..name..'</b>!')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Residências', 'Você não possui um <b>outfit</b> com este nome!')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Residências', 'Somente o dono da <b>residência</b> pode realizar esta ação.')
        end
        return true
    end,

    get_outfit = function(source, user_id, home, data)
        return cache.presets[home]
    end
}

srv.tryEnterInHome = function(home, method)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and (home) then
        local homeData = (method == 'join_apartament' and configHomes[home:gsub('%d', '')] or configHomes[home]) 
        local homeType = configType[homeData.type]

        cleanTempCache(user_id)

        if (Execs[method]) then Execs[method](source, user_id, home, homeData, homeType); end;
    end
end 

srv.visitHome = function(home)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        cleanTempCache(user_id)
        
        local dataHomes = configHomes[home]
        local dataType = configType[dataHomes.type]
        if (dataType) then
            TriggerClientEvent('notify', source, 'importante', 'Residências', 'Você está visitando '..(dataHomes.type == 'apartament' and 'o apartamento' or 'a casa')..' <b>'..home..'</b>!')
            setTempCache(user_id, home)
            vCLIENT.enterInHome(source, home, dataType.interior._default, nil, true)
        end
    end
end

srv.Outfit = function(home, method)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and (home) then
        local homeName = home
        local homeData = configHomes[home]
        
        local userApartaments = getUserApartaments(user_id)
        if (userApartaments[home]) and (homeData and homeData.type == 'apartament') then
            homeName = userApartaments[home].home
        end
        
        local consult = cache.homes[homeName]

        tablePreset(homeName)
        if (consult) and (Execs[method]) then return Execs[method](source, user_id, homeName, consult); end;
    end
end

srv.openVault = function(home)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local consult = cache.homes[home]
        if (consult) then
            if (consult.owner == user_id) or (consult.residents[tostring(user_id)]) then
                if (chestOpenned[home]) then
                    return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Baú <b>ocupado</b>!')
                end
                chestOpenned[home] = true

                exports.inventory:openVault(user_id, home, 'Baú', { weight = consult.config.chest, slots = 1000 }, nil, nil, function()
                    chestOpenned[home] = nil
                end)
            end
        end
    end
end

srv.openFridge = function(home)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local consult = cache.homes[home]
        if (consult) then
            if (consult.owner == user_id) or (consult.residents[tostring(user_id)]) then
                if (fridgeOpenned[home]) then
                    return TriggerClientEvent('notify', source, 'negado', 'Residências', 'Baú <b>ocupado</b>!')
                end
                fridgeOpenned[home] = true

                exports.inventory:openVault(user_id, ('fridge:'..home), 'Geladeira', { weight = consult.config.fridge, slots = 1000 }, nil, configFridgeItems, function()
                    fridgeOpenned[home] = nil
                end)
            end
        end
    end
end

srv.setBucket = function(home, status)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (status) then
            local gen = (bucketIDS:gen()+1500)

            local bucket = gen;
            if (cache.homes[home]) then
                if (not cache.homes[home].bucket) then
                    cache.homes[home].bucket = gen
                end
                bucket = cache.homes[home].bucket
            end

            SetPlayerRoutingBucket(source, bucket)
        else
            SetPlayerRoutingBucket(source, 0)
        end
    end
end

srv.resetCache = function()
    local source = source
    local user_id = vRP.getUserId(source)
    cleanTempCache(user_id, true)
end

Citizen.CreateThread(function()
    while (not isReady) do Citizen.Wait(100); end;

    cleanupHouses()
    registerBlipsBuyed()
    registerBlips(nil, true)
end)

AddEventHandler('onResourceStop', function(rsc)
    if (GetCurrentResourceName() ~= rsc) then return; end;
    print('^1[Homes]^7 system restarted.')

    for id, values in pairs(cache.users) do
        TriggerEvent('homes:cleanTempCache', id, true)
    end
end)

AddEventHandler('vRP:playerLeave', function(user_id, source) cleanTempCache(user_id, true, true); end)

AddEventHandler('playerSpawn', function(user_id, source)
    while (not isReady) do Citizen.Wait(100); end;
    registerBlipsBuyed(source)

    local count, myHomes = getAllUserHomes(user_id, true)
    if (count > 0) then
        for home, values in pairs(myHomes) do
            local sell = false
            local name = (values.config.type == 'apartament' and home:gsub('%d', '') or home)
            local tax = values.tax

            if (tax) and tax > 0 then
                local taxConfig = config.type[values.config.type].tax
                local diffExpire = (taxConfig[3]-taxConfig[2])
                if (os.time() >= (tax+(diffExpire*86400))) then
                    sell = true
                    
                    local items = exports.inventory:getBag(home)

                    oxmysql:execute_async(DB_DELETE_HOME, { home })
                    oxmysql:execute_async(DB_DELETE_HOME_GARAGE, { home })
                    TriggerClientEvent('homes:removeGarage', -1, home)

                    vRP.deleteInventory(home)

                    if (values.owner == user_id) then
                        TriggerClientEvent('notify', source, 'aviso', 'Residências', 'Você não pagou o <b>IPTU</b> de sua residência <b>'..home..'</b> e sua residencia foi liquidada.', 10000)
                    end

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

                    cache.homes[home] = nil
                end
            end

            if (not sell) then
                local name = (values.config.type == 'apartament' and home:gsub('%d', '') or home)
                if (configHomes[name]) then
                    registerBlips(source, false, { home, configHomes[name].coord })
                end
            end
        end
    end

    TriggerClientEvent('homes:ready', source)
end)
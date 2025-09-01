isReady = false;

DB_GET_ALL_HOMES = 'select * from homes'

Citizen.CreateThread(function()
    Citizen.Wait(1000)

    local allHomes = oxmysql:query_async(DB_GET_ALL_HOMES)
    for _, data in ipairs(allHomes) do
        if (not cache.homes[data.home]) then
            cache.homes[data.home] = {
                owner = data.user_id, residents = json.decode(data.residents), config = json.decode(data.configs), vip = (data.vip == 1), tax = tonumber(data.tax) or data.tax
            }

            local _cache = cache.homes[data.home]
            
            -- if (not _cache.config.fridge) then
            --     local dataFridge = configType[_cache.config.type].fridge
            --     if dataFridge then
            --         cache.homes[data.home].config.fridge = dataFridge.min
            --     end
            -- end

            if (not _cache.config.wardrobe) then
                cache.homes[data.home].config.wardrobe = 0
            end
        end
    end

    local allPresets = oxmysql:query_async('select * from homes_wardrobe')
    for _, data in ipairs(allPresets) do
        if (not cache.presets[data.home]) then 
            cache.presets[data.home] = {} 
        end

        table.insert(cache.presets[data.home], { name = data.name, preset = json.decode(data.preset) })
    end

    isReady = true
    TriggerClientEvent('homes:ready', -1)

    print('^1[Homes]^7 cache created.')
end)

getAllUserHomes = function(user_id, resident)
    local count, homes = 0, {}
    for home, data in pairs(cache.homes) do
        if (not resident) then
            if (data.owner == user_id) then 
                homes[home] = data

                count += 1
            end
        else
            if (data.residents[tostring(user_id)]) or (data.owner == user_id) then
                homes[home] = data

                count += 1
            end
        end
    end
    return count, homes
end
exports('getAllUserHomes', getAllUserHomes)

-- -- All = true -> Pega todas as casas do usúario / All = false -> Pega somente as que ele é dono
getUserHomes = function(user_id, all)
    local count, homes = 0, {}
    for home, data in pairs(cache.homes) do
        if (not all) then
            if (data.owner == user_id) then 
                homes[home] = data

                count += 1
            end
        else
            if (data.residents[tostring(user_id)]) or (data.owner == user_id) then
                homes[home] = data

                count += 1
            end
        end
    end
    return homes, count
end

getUserApartaments = function(user_id, all)
    local count, apartaments = 0, {}
    for home, data in pairs(cache.homes) do
        if (data.config.type == 'apartament') then
            local newName = home:gsub('%d', '')
            if (not all) then
                if (data.owner == user_id) then 
                    apartaments[newName] = data
                    apartaments[newName].home = home

                    count += 1
                end
            else
                if (data.residents[tostring(user_id)]) or (data.owner == user_id) then
                    apartaments[newName] = data
                    apartaments[newName].home = home

                    count += 1
                end
            end
        end
    end
    return apartaments, count
end

exports('cacheHomes', function() return cache.homes; end)

outfitExist = function(home, name)
    local allow = false;
    if (cache.presets[home]) then
        for _, data in pairs(cache.presets[home]) do
            if (data.name == name) then
                allow = true
                break;
            end
        end
    end
    return allow
end

deleteOutfit = function(home, name)
    if (cache.presets[home]) then
        for index, data in pairs(cache.presets[home]) do
            if (data.name == name) then
                cache.presets[home][index] = nil
                break;
            end
        end
    end
end

local defaultTableMansion = { decorations = 0, interior = 'mlo', type = 'mlo', chest = 100, fridge = 15, price = 300000, residents = 10 }

addMansion = function(user_id, home)
    cache.homes[home] = { owner = user_id, residents = {}, config = defaultTableMansion, vip = true, tax = -1 }
    oxmysql:insert_async(DB_INSERT_HOME, { user_id, home, -1, json.encode(defaultTableMansion), 1 })
    
    local identity = vRP.getUserIdentity(user_id)
    if identity then
        vRP.webhook('https://discord.com/api/webhooks/1282695313131311215/UUEv1iSq0ge15lLrC8FkWrPFWDYyb97ND_eaZWmOUPr8U2qda2TzhuqxD_xKUalBL5T8', {
            title = 'mansão-vip',
            descriptions = {
                { 'user', user_id..' '..identity.firstname..' '..identity.lastname },
                { 'home', home:upper() },
            }
        })
    end
end
exports('addMansion', addMansion)

remMansion = function(home)
    cache.homes[home] = nil
    oxmysql:execute_async(DB_DELETE_HOME, { home })

    vRP.webhook('https://discord.com/api/webhooks/1278054624237977620/J7q6rFnjIZ1HlpJ3Y_dX3P1hM7imxPGKRQmBR-Z5zhfkS3kZ2LfmSMxVCueSVW-tjUjK', {
        title = 'mansão-vip',
        descriptions = {
            { 'action', 'Mansão Retirada' },
            { 'home', home:upper() },
        }
    })
end
exports('remMansion', remMansion)
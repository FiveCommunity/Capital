local srv = {}
Tunnel.bindInterface('clothes', srv)
local vCLIENT = Tunnel.getInterface('clothes') 

Presets = {
    VipBronze = 1,
    VipPrata = 2,
    VipOuro = 4,
    VipCapital = 6,
    Staff = 18,
}

local usersPresets = {}

local getUserPresets = function(user_id)
    if (user_id) then
        -- if (not usersPresets[user_id]) then
        usersPresets[user_id] = oxmysql:query_async('select * from clothes where user_id = ?', { user_id })
        -- end
        return usersPresets[user_id]
    end
end
exports('reloadUserPresets', getUserPresets)

srv.getAllPresets = function()
    local source = source
    local user_id = vRP.getUserId(source)
    return getUserPresets(user_id)
end

local verifyVip = function(user_id)
    local maxPresets = 2
    for group, data in pairs(vRP.getUserGroups(user_id)) do
        local presets = Presets[group]
        if (presets) then
            maxPresets = maxPresets + presets
        end
    end
    return maxPresets
end

local verifyTitlePreset = function(presets, title)
    for k, values in pairs(presets) do
        if (values.title:lower() == title:lower()) then 
            return k, values.title
        end 
    end
    return false
end

local checkPreset = function(user_id, title)
    for k, data in pairs(usersPresets[user_id]) do
        if (data.title:lower() == title:lower()) then
            return k, data.title
        end
    end
    return false
end

RegisterNetEvent('gb_interactions:addPreset', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local result = exports.hud:prompt(source, { 'Escolha um nome para o seu novo preset' })[1]
        if (not result) then return; end;

        if (result ~= '') then
            local presets = getUserPresets(user_id)
            local mySlots = verifyVip(user_id)

            if (#presets < mySlots) then
                
                if (verifyTitlePreset(presets, result)) then
                    TriggerClientEvent('notify', source, 'Roupas', 'Você já possui um preset com esse nome!')
                else
                    local currentPreset = vCLIENT.getCurrentPreset(source)
                    
                    oxmysql:insert_async('insert ignore into clothes (title, preset, user_id) values (?, ?, ?)', { result, json.encode(currentPreset), user_id })
                    usersPresets[user_id] = nil

                    TriggerClientEvent('notify', source, 'Roupas', 'Preset de roupas <b>'..result..'</b> salvo com sucesso!')
                end
            else
                TriggerClientEvent('notify', source, 'Roupas', 'Você já utilizou <b>'..mySlots..'</b> presets disponíveis em sua conta!')
            end
        else
            TriggerClientEvent('notify', source, 'Roupas', 'Você não definiu um <b>nome</b> para o seu preset!')
        end
    end
end)

RegisterNetEvent('gb_interactions:usePreset', function(presetTitle)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if exports.hud:isWanted(user_id) then
            return TriggerClientEvent("notify",source,"negado",'Roupas',"Você está sendo <b>procurado</b>!",8000)
        end

        if (Player(source).state.Scuba) then return TriggerClientEvent('notify', source, 'negado', 'Roupas', 'Você não pode realizar essa ação, utilizando <b>roupa de mergulho</b>!'); end;

        local cacheId = checkPreset(user_id,presetTitle)
        if cacheId then
            local clothes = usersPresets[user_id][cacheId]
            if clothes then
                TriggerEvent('inventory:switchClothes', user_id)
                vCLIENT.setClothes(source, json.decode(clothes.preset))
            end
        end
    end
end)

RegisterNetEvent('gb_interactions:deletePreset', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local result = exports.hud:prompt(source, { 'Qual o nome do preset que você deseja deletar?' })[1]
        if (not result) then return; end;

        local haveThisPreset, presetName = checkPreset(user_id, result)
        if (haveThisPreset) then
            local request = exports.hud:request(source, 'Preset', 'Você realmente deletar o preset <b>'..presetName..'</b>?', 30000)
            if (request) then

                oxmysql:execute_async('delete from clothes where user_id = ? and title = ?', { user_id, presetName })
                usersPresets[user_id] = nil

                TriggerClientEvent('notify', source, 'Roupas', 'Preset <b>'..presetName..'</b> deletado com sucesso!')
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Roupas', 'Preset <b>não</b> encontrado!')
        end
    end
end)

RegisterNetEvent('gb_interactions:deleteAllPreset', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local request = exports.hud:request(source, 'Preset', 'Você deseja realmente <b>deletar</b> todos os presets de roupa?', 15000)
        if (request) then

            oxmysql:execute_async('delete from clothes where user_id = ?', { user_id })
            usersPresets[user_id] = nil
            
            TriggerClientEvent('notify', source, 'sucesso', 'Roupas', 'Presets <b>deletados</b> com sucesso!')
        end
    end
end)
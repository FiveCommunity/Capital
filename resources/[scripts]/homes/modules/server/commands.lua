local commands = {
    homes = function()
        print(json.encode(cache.homes, { indent = true }))
        print('^1[Homes]^7 list of cacheds houses.')
    end,

    reset = function()
        cache.homes = {}

        local allHomes = oxmysql:query_async(DB_GET_ALL_HOMES)
        for _, data in pairs(allHomes) do
            if (not cache.homes[data.home]) then
                cache.homes[data.home] = {
                    owner = data.user_id, config = json.decode(data.configs), garage = data.garages, vip = data.vip, tax = data.tax, residents = {}
                }
            end
        end

        print('^1[Homes]^7 cache reseted.')
    end
}

RegisterCommand('cache', function(source, args)
    if (source == 0) then
        local arg = tostring(args[1])
        if (arg) then
            if (commands[arg]) then commands[arg](); end;
        end
    end
end)

gerarNome = function(nomeBase, contador)
    return nomeBase .. string.format("%04d", contador)
end

local nomeBase = ''
local contador = 1
local criados = {}
local tipoBase = ''
local oldName = ''

RegisterCommand('criar',function(source)
    local user_id = vRP.getUserId(source)
    if (not user_id) and not vRP.hasPermission(user_id, 'staff.permissao') then return; end;
    if (nomeBase == '') then
        local prompt = vRP.prompt(source, { 'Nome da Residência', 'Tipo' })
        if (prompt) then
            nomeBase = prompt[1]
            tipoBase = prompt[2]
        end
        local nomeCompleto = gerarNome(nomeBase, contador)
        oldName = nomeCompleto
        table.insert(criados, {
            [nomeCompleto] = { coord = GetEntityCoords(GetPlayerPed(source)), type = tipoBase }
        })
        vRPclient.addBlip(source, GetEntityCoords(GetPlayerPed(source)).x, GetEntityCoords(GetPlayerPed(source)).y, GetEntityCoords(GetPlayerPed(source)).z, 1, 1, 'Marcou Aqui', 0.5, false)
        contador = contador + 1
    else
        local nomeCompleto = gerarNome(nomeBase, contador)
        oldName =  nomeCompleto
        table.insert(criados, {
            [nomeCompleto] = { coord = GetEntityCoords(GetPlayerPed(source)), type = tipoBase }
        })
        contador = contador + 1
        vRPclient.addBlip(source, GetEntityCoords(GetPlayerPed(source)).x, GetEntityCoords(GetPlayerPed(source)).y, GetEntityCoords(GetPlayerPed(source)).z, 1, 1, 'Marcou Aqui', 0.5, false)
    end
    TriggerClientEvent('notify', source, 'sucesso', 'Importante', 'Você criou a residência <b>'..oldName..'</b>.')
end)

RegisterCommand('pegar', function(source)
    local user_id = vRP.getUserId(source)
    if (not user_id) and not vRP.hasPermission(user_id, 'staff.permissao') then return; end;
    local linha = ''
    for nome, info in pairs(criados) do
        for k, v in pairs(info) do
            linha = linha.."\n ['"..k.."'] = { coord = "..tostring(v.coord)..", type = '"..v.type.."' },"
        end
    end
    TriggerClientEvent('clipboard', source, 'Pegar', linha)
end)
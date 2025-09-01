srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

srv.checkPermission = function(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, 'policia.permissao')
end

local codes = {
    [1] = function(source, identity, coord, id, player)
        TriggerClientEvent('NotifyPush', player, {
            type = 'default',
            title = 'Localização (QTH)',
            message = 'O oficial <b>'..identity.firstname..' '..identity.lastname..'</b> enviou uma localização.',
            coords = coord,
            time = 8000
        })

        TriggerClientEvent('reportUser:blip', player, { id = id, coords = coord, scale = 0.5, sprite = 58, colour = 12, text = 'QTH - Localização' })
    end,
    [2] = function(source, identity, coord, id, player)
        TriggerClientEvent('NotifyPush', player, {
            type = 'default',
            title = 'Reforço solicitado (QRR)',
            message = 'O oficial <b>'..identity.firstname..' '..identity.lastname..'</b> pediu reforço.',
            coords = coord,
            time = 8000
        })

        TriggerClientEvent('reportUser:blip', player, { id = id, coords = coord, scale = 0.5, sprite = 58, colour = 1, text = 'QRR - Reforço solicitado' })
    end,
    [3] = function(source, identity, coord, id, player)
        TriggerClientEvent('NotifyPush', player, {
            type = 'default',
            title = 'Ocorrênca (QRU)',
            message = 'O oficial <b>'..identity.firstname..' '..identity.lastname..'</b> reportou uma ocorrência.',
            coords = coord,
            time = 8000
        })

        TriggerClientEvent('reportUser:blip', player, { id = id, coords = coord, scale = 0.5, sprite = 58, colour = 47, text = 'QRU - Ocorrência' })
    end,
    [4] = function(source, identity, coord, id, player)
        TriggerClientEvent('NotifyPush', player, {
            type = 'default',
            title = 'A caminho (QTI)',
            message = 'O oficial <b>'..identity.firstname..' '..identity.lastname..'</b> está a caminho.',
            coords = coord,
            time = 8000
        })
    end,
    [5] = function(source, identity, coord, id, player)
        TriggerClientEvent('NotifyPush', player, {
            type = 'default',
            title = 'Cancelar mensagem (QTA)',
            message = 'O oficial <b>'..identity.firstname..' '..identity.lastname..'</b> cancelou a última mensagem.',
            coords = coord,
            time = 8000
        })
    end,
    [6] = function(source, identity, coord, id, player)
        TriggerClientEvent('NotifyPush', player, {
            type = 'default',
            title = 'Fora do Ar (QRT)',
            message = 'O oficial <b>'..identity.firstname..' '..identity.lastname..'</b> não consegue receber comunicações.',
            coords = coord,
            time = 8000
        })
    end,
}

local cooldownCode = {}

RegisterNetEvent('code:execute', function(code)
    local source = source
    local user_id = vRP.getUserId(source)

    if (user_id) and (vRP.hasPermission(user_id, 'policia.permissao')) then
        local identity = vRP.getUserIdentity(user_id)
        local ped = GetPlayerPed(source)
        local pedCoords = GetEntityCoords(ped)
        local pedHealth = GetEntityHealth(ped)

        if (pedHealth <= 100) and (code ~= 6) then
            TriggerClientEvent('notify', source, 'negado', 'Copom', 'Você não pode enviar esta mensagem <b>morto</b>!')
            return false
        end

        local actualTime = os.time()
        if (cooldownCode[user_id]) and (cooldownCode[user_id] > actualTime) then
            TriggerClientEvent('notify', source, 'negado', 'Copom', 'Aguarde <b>'..(cooldownCode[user_id] - actualTime)..' segundos</b>.')
            return false
        end

        local cooldown = 30
        if (code == 6) then cooldown = 300; end;

        cooldownCode[user_id] = actualTime + cooldown

        local permission = vRP.getUsersByPermission('policia.permissao')
        for _, id in pairs(permission) do
            local nsource = vRP.getUserSource(parseInt(id))
            if (nsource) and (nsource ~= source) then
                if (codes[code]) then codes[code](source, identity, pedCoords, id, nsource); end;
            end
        end

        if (code == 6) then
            vRP.webhook('code', {
                title = 'CODE - QRT',
                descriptions = {
                    { 'user', user_id },
                    { 'coords', tostring(pedCoords) },
                    { 'health', tostring(pedHealth) },
                    { 'officers', #permission }
                }
            })
        end

        TriggerClientEvent('notify', source, 'sucesso', 'Copom', 'Mensagem <b>enviada</b> com sucesso!')
    end
end)

RegisterCommand('fixphones', function(source)
    if (source == 0) then
        local data = exports.oxmysql:query_async('SELECT owner_id,phone_number FROM phone_phones WHERE owner_id IN ( SELECT owner_id FROM phone_phones GROUP BY owner_id HAVING COUNT(*) > 1 );')
        for _, v in pairs(data) do
            local nuser_id = tonumber( v.owner_id )
            local nsource = vRP.getUserSource(nuser_id)
            if (nsource) then
                local inventory = vRP.PlayerInventory(nuser_id)
                if (inventory) then
                    local amount, slot = inventory:getItemAmount('telefone')
                    if (amount > 0) then
                        local sData = inventory:getSlot(slot)
                        if (sData) and (sData.phoneNumber) and sData.phoneNumber ~= v.phone_number then
                            exports.oxmysql:execute_async('delete from phone_phones where phone_number = ?', { v.phone_number })
                            print('Número '..v.phone_number..' deletado!')
                        end
                    end
                end
            else
                local getItems = exports.oxmysql:query_async('select items from inventory where identifier = ?', { tostring( 'player:'..nuser_id ) })
                for _, i in pairs(getItems) do
                    for _, items in pairs(i) do
                        for slot, value in pairs(json.decode(items)) do
                            if (value.item == 'telefone') and (value.phoneNumber) and value.phoneNumber ~= v.phone_number then
                                exports.oxmysql:execute_async('delete from phone_phones where phone_number = ?', { v.phone_number })
                                print('Número '..v.phone_number..' deletado!')
                            end
                        end
                    end
                end
            end
        end
    end
end)
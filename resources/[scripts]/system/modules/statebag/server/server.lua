local srv = {}
Tunnel.bindInterface('State', srv)

srv.diminuirPena = function()
    local source = source
    vRP.antiflood(source, 'Flodando diminuir pena',1)

    local user_id = vRP.getUserId(source)
    if (user_id) then
        local time = (json.decode(vRP.getUData(user_id, 'prison')) or 0)
        if (time > 5) then
            vRP.setUData(user_id, 'prison', json.encode(parseInt(time) - 1))
            TriggerClientEvent('notify', source, 'Prisão', 'Sua pena foi reduzida em <b>1 mês</b>.')
        else
            TriggerClientEvent('notify', source, 'Prisão', 'Você atingiu o <b>limite</b> de redução da pena.')
        end
    end
end

local loose = {
    ['dinheirosujo'] = true
}

srv.looseItensInWater = function()
    local source = source
    local user_id = vRP.getUserId(source)

    if (user_id) then
        local inventory = vRP.PlayerInventory(user_id)
        if (not inventory) then return; end;

        local notify = false;
        for slot, data in pairs ( inventory:getItems() ) do
            if (loose[data.item]) then
                notify = true;
                inventory:tryGetItem(data.item, data.amount, slot, true)
            end
        end 

        if (notify) then TriggerClientEvent('notify', source, 'aviso', 'Mochila', 'Alguns dos seus <b>itens</b> foram molhados.'); end;
    end
end
multarPlayer = function(user_id, motivo, valor, descricao)
    if (user_id and motivo and valor > 0 and descricao) then
        vRP.execute('gb_bank/addMultas', { user_id = user_id, reason = motivo, value = parseInt(valor), time = os.time(), description = descricao })
    end
end
exports('multar', multarPlayer)

verifyMultas = function(user_id)
    local fines = 0;
    if (user_id) then
        local data = exports['phone-bank']:getUserFines(user_id)
        if (data) then
            for _, v in pairs(data) do
                fines = (fines + v.value)
            end
        end
    end
    return fines
end
exports('verifyMultas', verifyMultas)

registerTrans = function(user_id, type, value)
    local data = (json.decode(vRP.getUData(user_id, 'gb_bank:historico')) or {})
    if (data) then
        if (value < 0) then
            value = (value * -1)
            value = '-R$'..value
        else
            value = '+R$'..value
        end
        table.insert(data, { type = type, value = vRP.format(value) })
        vRP.setUData(user_id, 'gb_bank:historico', json.encode(data))
    end
end
exports('extrato', registerTrans)

registerRendimento = function(user_id, value)
    if (user_id) then
        local uData = vRP.getUData(user_id, 'gb_bank:rendimento')
        local data = (json.decode(uData) or {})
        if (data) then
            if (#data >= 20) then data = {}; end;
            table.insert(data, value)
            vRP.setUData(user_id, 'gb_bank:rendimento', json.encode(data))
        end
    end
end
exports('registerRendimento', registerRendimento)

getCoins = function(user_id)
    local userBank = vRP.query('capital_bank/get_coins', { userId = user_id })[1]
    if userBank.coins then
        return userBank.coins
    end
    print(json.encode(coins))
    return 0
end
exports('getCoins', getCoins)

setCoins = function(user_id, value)
    vRP.execute('capital_bank/set_coins', { userId = user_id, value = value })
end
exports('setCoins', setCoins)

addCoins = function(user_id, value)
    vRP.execute('capital_bank/add_coins', { userId = user_id, value = value })
end
exports('addCoins', addCoins)

remCoins = function(user_id, value)
    vRP.execute('capital_bank/rem_coins', { userId = user_id, value = value })
end
exports('remCoins', remCoins)

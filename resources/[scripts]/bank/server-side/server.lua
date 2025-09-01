srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

local configGeneral = config.general

local _active = {}

RegisterCommand('clearmultas', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') and args[1] then
        local nUser = parseInt(args[1])
        local fines = 0;

        local data = exports['phone-bank']:getUserFines(nUser)
        if (data) then
            for _, v in pairs(data) do
                fines = (fines + v.value)
            end
        end

        if (fines > 0) then
            exports['phone-bank']:clearFine(nUser, nil, true)
            TriggerClientEvent('notify', source, 'Banco', 'Você apagou <b>R$'..vRP.format(fines)..'</b> de multa(s) do passaporte <b>'..nUser..'</b>.')

            vRP.webhook('clearFines', {
                title = 'Banco',
                descriptions = {
                    { 'action', '(clear fines)' },
                    { 'user', user_id },
                    { 'target', nUser },
                    { 'total value', vRP.format(fines) }
                }
            }) 
        end
    end
end)

RegisterNetEvent('gb_interactions:multar', function()   
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and (vRP.checkPermissions(user_id, { 'policia.permissao', 'staff.permissao' })) then
        local prompt = exports.hud:prompt(source, { 'Passaporte do Cidadão', 'Valor da Multa', 'Motivo', 'Descrição' })
        if (#prompt >= 4) then
            local nuser_id, value, reason, description = parseInt( prompt[1] ), parseInt( prompt[2] ), prompt[3], prompt[4]
            if (nuser_id > 0) and (value > 0) then
                local nidentity = vRP.getUserIdentity(nuser_id)
                if (not nidentity) then
                    return TriggerClientEvent('notify', source, 'negado', 'Multa', 'Cidadão inexistente!')
                end

                exports['phone-bank']:createFine(nuser_id, { reason = reason, content = description, value = value })
                TriggerClientEvent('notify', source, 'sucesso', 'Multa', 'Você aplicou uma multa de <b>R$'..vRP.format(value)..'</b> no <b>'..nidentity.firstname..' '..nidentity.lastname..'</b>.')
                
                local nsource = vRP.getUserSource(nuser_id)
                if (nsource) then
                    exports['lb-phone']:SendNotification(nsource, {
                        app = 'capital-bank',
                        title = 'Multa',
                        content = 'Você foi multado no valor de R$'..vRP.format(value)..'!'
                    })
                end

                vRP.webhook('fines', {
                    title = 'Banco',
                    descriptions = {
                        { 'action', '(fines)' },
                        { 'user', user_id },
                        { 'target', nuser_id },
                        { 'reason', reason },
                        { 'fine value', vRP.format(value) }
                    }
                }) 
            end
        end
    end
end)

srv.checkPermission = function(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if (vRP.checkPermissions(user_id, perm)) then
        return true
    end
    TriggerClientEvent('notify', source, 'Banco', 'Você não possui <b>acesso</b> para acessar este banco.')
    return false 
end

srv.playerInfo = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local identity = vRP.getUserIdentity(user_id)
        if (identity) then
            local fullname = identity.firstname..' '..identity.lastname
            return parseInt(vRP.getMoney(user_id)), parseInt(vRP.getBankMoney(user_id)), fullname
        end
        return 0, 0, 'Indivíduo Indigente' 
    end
end

srv.updateMoney = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then return vRP.getMoney(user_id), vRP.getBankMoney(user_id); end;
end


srv.generateData = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local generate = { ganhou = 0, perdeu = 0 }
        local multas = 0
        local rendimento = 0

        local Statements = exports['phone-bank']:getUserStatement(user_id)
        if (Statements) then
            for _, v in pairs(Statements) do
                if (v.type == 'spent') then
                    generate.perdeu = (generate.perdeu + v.value)
                else
                    generate.ganhou = (generate.ganhou + v.value)
                end
            end
        end

        local Fines = exports['phone-bank']:getUserFines(user_id)
        if (Fines) then
            for _, v in pairs(Fines) do
                multas = (multas + v.value)
            end
        end

        local total = (generate.ganhou + generate.perdeu + multas)
        return generate.ganhou, generate.perdeu, multas, total, 0
    end
end

srv.transferir = function(id, value)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and not _active[user_id] then
        _active[user_id] = true
        local _identity = vRP.getUserIdentity(id)
        local identity = vRP.getUserIdentity(user_id)
        if (user_id ~= id and _identity) then
            if (vRP.tryBankPayment(user_id, value)) then
                vRP.giveBankMoney(id, value)
                
                exports['phone-bank']:createStatement(user_id, { title = 'Transferência', content = 'Para '.._identity.firstname..' '.._identity.lastname, value = value, type = 'spent' })
                exports['phone-bank']:createStatement(id, { title = 'Transferência', content = 'De '..identity.firstname..' '..identity.lastname, value = value, type = 'received' })
                
                vRP.webhook('transfer', {
                    title = 'bank',
                    descriptions = {
                        { 'action', '(transfer)' },
                        { 'user', user_id },
                        { 'target', id },
                        { 'value', vRP.format(value) }
                    }
                }) 

                TriggerClientEvent('bank_notify', source, 'sucesso', 'Banco', 'Você transferiu R$'..vRP.format(value)..' para o passaporte '..id..'.')
            else
                TriggerClientEvent('bank_notify', source, 'negado', 'Banco', 'Você não possui essa quantia de dinheiro em sua conta bancária.')
            end
        else
            local text = (user_id == id and 'Você não pode transferir dinheiro para si mesmo.' or 'Este passaporte não existe em nossa cidade.')
            TriggerClientEvent('bank_notify', source, 'negado', 'Banco', text)
        end
        _active[user_id] = nil
    end
end

srv.sacar = function(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and not _active[user_id] then
        _active[user_id] = true
        if (vRP.tryWithdraw(user_id, value)) then
            exports['phone-bank']:createStatement(user_id, { title = 'Saque', content = 'Sacou dinheiro da conta', value = value, type = 'spent' })

            vRP.webhook('withdraw', {
                title = 'bank',
                descriptions = {
                    { 'action', '(withdraw)' },
                    { 'user', user_id },
                    { 'value', vRP.format(value) }
                }
            }) 

            TriggerClientEvent('bank_notify', source, 'sucesso', 'Banco', 'Você sacou R$'..vRP.format(value)..'.')
        else
            TriggerClientEvent('bank_notify', source, 'negado', 'Banco', 'Você não possui essa quantia de dinheiro em sua conta bancária.')
        end
        _active[user_id] = nil
    end
end

srv.depositar = function(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and not _active[user_id] then
        _active[user_id] = true
        if (vRP.tryDeposit(user_id, value)) then
            exports['phone-bank']:createStatement(user_id, { title = 'Depósito', content = 'Depositou dinheiro na conta', value = value, type = 'received' })

            vRP.webhook('deposit', {
                title = 'bank',
                descriptions = {
                    { 'action', '(deposit)' },
                    { 'user', user_id },
                    { 'value', vRP.format(value) }
                }
            }) 

            TriggerClientEvent('bank_notify', source, 'sucesso', 'Banco', 'Você depositou R$'..vRP.format(value)..'.')
        else
            TriggerClientEvent('bank_notify', source, 'negado', 'Banco', 'Você não possui essa quantia de dinheiro em sua carteira.')
        end
        _active[user_id] = nil
    end
end

srv.getRendimento = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local data = json.decode( vRP.getUData(user_id, 'gb:rendimento') )
        if (data) then return data; end;
    end
    return {}
end

srv.getHistoricoBank = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local statements = {}
        local data = exports['phone-bank']:getUserStatement(user_id)
        if (data) then
            for _, v in pairs(data) do
                statements[#statements+1] = { type = v.title, value = (v.type == 'spent' and '-' or '+')..'R$'..vRP.format(v.value) }
            end
        end
        return statements
    end
end

srv.getMultas = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local fines = {}
        local data = exports['phone-bank']:getUserFines(user_id)
        if (data) then
            for _, v in pairs(data) do
                local currentYear = tonumber(os.date('%Y'))
                local temp = os.date('*t', v.created_at)
                local date = temp.day..'/'..temp.month..'/'..currentYear
                fines[#fines+1] = { id_multa = v.id, motivo = v.reason, valor = v.value, time = date, desc = v.content }
            end            
        end
        return fines
    end
end

srv.pagarMultas = function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and not _active[user_id] then
        _active[user_id] = true

        local data = exports['phone-bank']:getUserFines(user_id)
        if (data) then
            for key, v in pairs(data) do
                if (v.id == id) then
                    id = key
                    break;
                end
            end

            local fineData = data[id]
            if (fineData) then
                if (vRP.tryBankPayment(user_id, fineData.value)) then
                    exports['phone-bank']:clearFine(user_id, fineData.id)
                    exports['phone-bank']:createStatement(user_id, { title = 'Multas', content = 'Pagamento de multa', value = fineData.value, type = 'spent' })

                    TriggerClientEvent('bank_notify', source, 'sucesso', 'Prefeitura', 'Multa Nº'..fineData.id..' paga com sucesso.')

                    vRP.webhook('payFine', {
                        title = 'Banco',
                        descriptions = {
                            { 'action', '(pay fine)' },
                            { 'user', user_id },
                            { 'fine value', vRP.format(fineData.value) },
                            { 'fine id', fineData.id }
                        }
                    }) 
                else
                    TriggerClientEvent('bank_notify', source, 'negado', 'Prefeitura', 'Você não possui R$'..vRP.format(fineData.value)..' para pagar a multa Nº'..fineData.id..'.')
                end
            end
        end
        -- local query = vRP.query('gb_bank/getMulta', { multa_id = id })[1]
        -- if (query) then
        --     if (vRP.tryFullPayment(user_id, query.fine_value)) then
        --         vRP.execute('gb_bank/delMulta', { user_id = user_id, multa_id = id })
        --         vRP.webhook('payFine', {
        --             title = 'bank',
        --             descriptions = {
        --                 { 'action', '(pay fine)' },
        --                 { 'user', user_id },
        --                 { 'fine value', vRP.format(query.fine_value) },
        --                 { 'fine id', query.id }
        --             }
        --         }) 

        --         registerTrans(user_id, 'Multas', -query.fine_value)
        --         TriggerClientEvent('bank_notify', source, 'sucesso', 'Prefeitura', 'Multa Nº'..query.id..' paga com sucesso.')
        --     else
        --         TriggerClientEvent('bank_notify', source, 'negado', 'Prefeitura', 'Você não possui R$'..vRP.format(query.fine_value)..' para pagar a multa Nº'..query.id..'.')
        --     end
        -- end
        _active[user_id] = nil
    end
end

srv.getPix = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        return exports['phone-bank']:getUserPix(user_id)
    end
end

srv.createPix = function(key)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local result = exports['phone-bank']:createPix(user_id, key)
        if (type(result) ~= 'table') then
            return TriggerClientEvent('bank_notify', source, 'sucesso', 'Pix', 'Você criou a sua <b>chave pix</b>.')
        end
        TriggerClientEvent('bank_notify', source, 'negado', 'Pix', result.error)
    end
end

srv.editPix = function(key)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local result = exports['phone-bank']:editPix(user_id, key)
        if (type(result) ~= 'table') then
            return TriggerClientEvent('bank_notify', source, 'sucesso', 'Pix', 'Você editou a sua <b>chave pix</b>.')
        end
        TriggerClientEvent('bank_notify', source, 'negado', 'Pix', result.error)
    end
end

srv.removePix = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local result = exports['phone-bank']:deletePix(user_id)
        if (type(result) ~= 'table') then
            return TriggerClientEvent('bank_notify', source, 'sucesso', 'Pix', 'Você deletou a sua <b>chave pix</b>.')
        end
        TriggerClientEvent('bank_notify', source, 'negado', 'Pix', result.error)
    end
end

AddEventHandler('playerSpawn',function(user_id, source, first_spawn)
    if (user_id) then
        local bank = vRP.getBankMoney(user_id)
        local money = vRP.getMoney(user_id)
        if (bank and money) then
            vRP.webhook('moneyJoin', {
                title = 'bank',
                descriptions = {
                    { 'action', '(money join)' },
                    { 'user', user_id },
                    { 'wallet', vRP.format(money) },
                    { 'bank', vRP.format(bank) }
                }
            }) 
        end
    end
end)

AddEventHandler('playerDropped', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local bank = vRP.getBankMoney(user_id)
        local money = vRP.getMoney(user_id)
        if (bank and money)  then
            vRP.webhook('moneyExit', {
                title = 'bank',
                descriptions = {
                    { 'action', '(money exit)' },
                    { 'user', user_id },
                    { 'wallet', vRP.format(money) },
                    { 'bank', vRP.format(bank) }
                }
            }) 
        end
    end
end)
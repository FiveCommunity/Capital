local oxmysql, hud = exports.oxmysql, exports.hud

CreateThread(function()
    oxmysql:execute([[
        create table if not exists user_tokens (
            token varchar(100) not null,
            id int not null,
            primary key (token),
            index (id)
        );
    ]]);

    oxmysql:execute([[
        create table if not exists banneds (
            id int not null,
            reason varchar(255) not null,
            days int not null,
            ban_date timestamp not null default current_timestamp(),
            staff int not null,
            primary key (id)
        );
    ]]);
end)

local sendMessageForDiscord = function(table, link)
    PerformHttpRequest('http://127.0.0.1:3333/'..link, function(err, text, headers) end, 
        'POST',
        json.encode(table), 
        { ['Content-Type'] = 'application/json' }
    )
end
exports('sendMessageForDiscord', sendMessageForDiscord)

local getSpecifiedIdentifier = function(source, identifier, number)
    local identifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if (string.find(v, identifier)) then
            local sub = v:sub(number)
            return sub
        end
    end
    return false
end
exports('getSpecifiedIdentifier', getSpecifiedIdentifier)

local getCharacterOnline = function(whitelist_id)
    local result = oxmysql:query_async('select id from user_characters where steam = (select steam from users where id = ? limit 1)', { whitelist_id })
    for _, v in pairs(result) do
        local source = vRP.getUserSource(v.id)
        if (source) then
            return v.id
        end
    end
    return false
end
exports('getCharacterOnline', getCharacterOnline)

local verifyWhitelist = function(whitelist_id)
    local result = oxmysql:scalar_async('select whitelist from users where id = ?', { whitelist_id })
    return result
end
exports('verifyWhitelist', verifyWhitelist)

local getUserDiscord = function(whitelist_id)
    local result = oxmysql:scalar_async('select discord from users where id = ?', { whitelist_id })
    return result
end
exports('getUserDiscord', getUserDiscord)

local getUserWhitelist = function(user_id)
    local result = oxmysql:scalar_async('select id from users where steam = (select steam from user_characters where id = ? limit 1)', { user_id })
    return result
end
exports('getUserWhitelist', getUserWhitelist)

local isBanned = function(whitelist_id)
    local result = oxmysql:scalar_async('select banned from users where id = ?', { whitelist_id })
    return (result > 0)
end
exports('isBanned', isBanned)

local setUserBanned = function(whitelist_id, banned, reason, days, staff_id)
    local discord_id = getUserDiscord(whitelist_id)

    oxmysql:update_async('update users set banned = ? where id = ?', { banned, whitelist_id })
    
    if (banned) then
        oxmysql:insert_async('insert ignore into banneds (id, reason, days, ban_date, staff) values (?, ?, ?, ?, ?)', { whitelist_id, (reason or 'Sistema'), (days or 0), nil, (staff_id or 0) })

        if (discord_id) then
            local staffIdentity = vRP.getUserIdentity(staff_id)
        
            sendMessageForDiscord({
                discordId = discord_id,
                whitelistId = whitelist_id,
                reason = reason,
                city = 'capitalcity',
                days = days,
                author = (staff_id > 0 and staffIdentity.firstname..' '..staffIdentity.lastname or 'Sistema')
            }, 'ban_user')
        end
    else
        oxmysql:query_async('delete from banneds where id = ?', { whitelist_id })

        if (discord_id) then
            sendMessageForDiscord({
                discordId = discord_id,
                city = 'capitalcity',
            }, 'unban_user')
        end
    end
end
exports('setUserBanned', setUserBanned)

local getUserBanInfo = function(whitelist_id)
    local ban_table = { id = 0, reason = '?', days = 0, ban_date = 0, staff = 0 }
    local result = oxmysql:query_async('select * from banneds where id = ?', { whitelist_id })[1]
    if (result) then
        ban_table = result
    end
    return ban_table
end
exports('getUserBanInfo', getUserBanInfo)

local formatDate = function(timestamp)
    local timestamp = (timestamp / 1000)
    local date = os.date('%d/%m/%Y - %H:%M:%S', timestamp)
    return date
end
exports('formatDate', formatDate)

local checkRemoteBanned = function(ids)
    
    local servers = {
        { project = 'Babilônia Roleplay', database = 'babilonia_roleplay' },
        { project = 'Capital City', database = 'capital_roleplay' } ,
    }

    local steam, discord;

    for k,v in pairs(ids) do
        if string.find(v,'steam:') then
            steam = v:sub(7)
        elseif string.find(v,'discord:') then
            discord = v:sub(9)
        end
    end

    if discord and steam then
        local current = GetConvar('sv_projectName','')
        for k,v in ipairs(servers) do
            if (v.project ~= current) then
                local data = oxmysql:query_async('SELECT * FROM '..(v.database)..'.users WHERE (steam = ? OR discord = ?) AND banned = 1',{ steam, discord })
                if (data[1]) then
                    return v.project, data[1].id
                end
            end
        end
    end
    return false
end
exports('checkRemoteBanned',checkRemoteBanned)

local dropUser = function(source, message)
    DropPlayer(source, message)
end

local tokenBannedLog = function(whitelist_id, registred, token, info)
    vRP.webhook('https://discord.com/api/webhooks/1206709177205006476/0nxkbOq6Ub1RuDRa3Hqmg_-0NAdHx_ZP2D1CNYg6Ji3txNIYpYILa9q2gIlXRJ04vHJD', {
        title = 'BAN SYSTEM',
        descriptions = {
            { 'action', 'banido' },
            { 'whitelist id', whitelist_id },
            { 'outro id', registred },
            { 'token', token },
            { 'info', info }
        }
    })   
end

updateUserDiscord = function(source, whitelist_id)
    local haveDiscord = getSpecifiedIdentifier(source, 'discord', 9)
    if (not haveDiscord) then
        dropUser(source, '[CAPITAL SYSTEM]: Seu discord não está vinculado ao FiveM.\n\n Não está conseguindo vincular o discord com o FiveM? Acesse este link: https://forum.cfx.re/t/how-to-link-my-discord-with-fivem/1013225 para o guia de vinculação do discord com o FiveM.')
        return
    end

    local discord_id = getUserDiscord(whitelist_id)
    if (discord_id) and (discord_id ~= '' and discord_id ~= '0') then 
        if (discord_id ~= haveDiscord) then
            dropUser(source, '[CAPITAL SYSTEM]: O seu discord está diferente do registrado em nosso sistema.\n\nRegistrado: '..discord_id..'\nAtual: '..haveDiscord)
        end
    else
        oxmysql:update_async('update users set discord = ? where id = ?', { haveDiscord, whitelist_id })
    end
end

insertUserTokens = function(source, whitelist_id)
    local tokens = GetNumPlayerTokens(source)
    
    local haveTokens = oxmysql:scalar_async('select token from user_tokens where id = ?', { whitelist_id })
    if (not haveTokens) then
        -- [ Inserir tokens ] --
        for i = 0, tokens do
            local token = GetPlayerToken(source, i)
            if (token) then
                oxmysql:execute('insert ignore into user_tokens (token, id) values (?, ?)', { token, whitelist_id }, function(rows)
                    if (rows.affectedRows == 0) then
                        dropUser(source, '[CAPITAL SYSTEM]: Foi identificado que você já possui uma conta em nossa cidade.\n\nCódigo: '..token:sub(10))
                        setUserBanned(whitelist_id, true, 'Conta secundária. (Proteção Capital)', 0, 0)
                        tokenBannedLog(whitelist_id, 'Não identificado', token, 'Conta secundária')

                        print('^1[CAPITAL SYSTEM]^7 '..whitelist_id..' conta duplicada '..token)
                    end
                end)
            end
        end   
    else
        local countPass, kicked, dontHave = 0, false, {}

        -- [ Checar tokens ] --
        for i = 0, tokens do
            local token = GetPlayerToken(source, i)
            if (token) then
                local result = oxmysql:query_async('select * from user_tokens where token = ?', { token })[1]
                if (result) then
                    if (whitelist_id ~= result.id) then
                        kicked = true

                        dropUser(source, '[CAPITAL SYSTEM]: Foi identificado que você já possui uma conta em nossa cidade.\n\nCódigo: '..token:sub(10))
                        setUserBanned(whitelist_id, true, 'Conta compartilhada. (Proteção Capital)', 0, 0)
                        setUserBanned(result.id, true, 'Conta compartilhada. (Proteção Capital)', 0, 0)
                        tokenBannedLog(whitelist_id, result.id, token, 'Conta compartilhada') 

                        print('^1[CAPITAL SYSTEM]^7 '..whitelist_id..' conta compartilhada '..token)
                        break
                    end;
                    
                    countPass = (countPass + 1)
                else
                    dontHave[token] = true
                end
            end
        end  

        if (countPass == 0) and (not kicked) then
            dropUser(source, '[CAPITAL SYSTEM]: O seu token está diferente do registrado em nosso sistema.')
            setUserBanned(whitelist_id, true, 'Conta comprada. (Proteção Capital)', 0, 0)
            tokenBannedLog(whitelist_id, 'Não identificado', 'Não identificado', 'Conta comprada') 

            print('^1[CAPITAL SYSTEM]^7 '..whitelist_id..' conta comprada')
        else
            for token, _ in pairs(dontHave) do oxmysql:execute('insert ignore into user_tokens (token, id) values (?, ?)', { token, whitelist_id }); end; 
        end        
    end
end

local startProtection = function(user_id, source)
    if (user_id) then
        local whitelist_id = getUserWhitelist(user_id)
        if (not whitelist_id) then return; end;

        local steam = getSpecifiedIdentifier(source, 'steam', 7)
        if (steam) and (banSystem.blacklist[steam]) then return; end;

        insertUserTokens(source, whitelist_id)
        updateUserDiscord(source, whitelist_id)
    end
end

-- AddEventHandler('playerSpawn', function(user_id, source) startProtection(user_id, source); end)

-- AddEventHandler('onResourceStart', function(resourceName)
--   	if (GetCurrentResourceName() == resourceName) then 
-- 		for user_id, source in pairs(vRP.getUsers()) do
--             startProtection(user_id, source)
--         end  
--         print('^1[CAPITAL SYSTEM]:^7 Reiniciado!')
-- 	end
-- end)

--======================================================================================================================
-- WHITELIST EXPIRATION
--======================================================================================================================

local cleanWhitelist = function()
    local result = oxmysql:query_async('select id, steam from user_characters where last_login < date_sub(now(), interval 20 day)')
    for _, v in pairs(result) do
        if (not banSystem.allowlistBlacklist[v.steam]) then
            local nsource = vRP.getUserSource(v.id)

            local whitelist_id = getUserWhitelist(v.id)
            if (whitelist_id) then
                if (not isBanned(whitelist_id)) then
                    if (nsource) then DropPlayer(source, 'Você perdeu a sua whitelist por inatividade'); end;
                    setUserBanned(whitelist_id, true, 'Inatividade.', 0, 0)
                    print('^1[CAPITAL SYSTEM]:^7 o passaporte ^1('..v.id..')^7 perdeu a whitelist por inatividade.')
                end
            end
        end
    end
end
CreateThread(cleanWhitelist)

--======================================================================================================================
-- BAN COMMANDS
--======================================================================================================================

local commands = {
    ban = function(source)
        local user_id = vRP.getUserId(source)
        if (user_id) and (vRP.checkPermissions(user_id, { 'ticket.permissao', 'staff.permissao' })) then
            local identity = vRP.getUserIdentity(user_id)
            
            local prompt = hud:prompt(source, { 'Passaporte do Jogador', 'Motivo do Ban (Evite escrever de forma desorganizada)', 'Dias' })
            if (not prompt[1]) then return; end;
            
            local nuser, reason, days = parseInt(prompt[1]), prompt[2], parseInt(prompt[3])
            local whitelist_id = getUserWhitelist(nuser)
            if (not whitelist_id) then return TriggerClientEvent('notify', source, 'negado', 'Banimento', 'Whitelist não <b>encontrada</b>!'); end;

            local temporaryBan = (days > 0)
            local notify_text = (temporaryBan and 'por <b>'..days..' dias</b>' or 'permanentemente')

            if (isBanned(whitelist_id)) then return TriggerClientEvent('notify', source, 'negado', 'Banimento', 'Este <b>jogador</b> já está banido.'); end;

            local nsource = vRP.getUserSource(nuser)
            local nidentity = vRP.getUserIdentity(nuser)

            local request = hud:request(source, 'Banimento', 'Você realmente deseja banir o(a) <b>'..nidentity.firstname..' '..nidentity.lastname..'</b> '..notify_text..'?', 30000)
            if (request) then
                if (nsource) then DropPlayer(nsource, 'Você foi banido '..(temporaryBan and 'temporariamente' or 'permanentemente')..' de nossa cidade.\n\n[AUTOR]: Capital\n[MOTIVO]: '..reason..'\n[TEMPO]: '..(temporaryBan and days..' DIAS' or 'PERMANENTE')..'\n[SUA ALLOWLIST]: #'..whitelist_id); end;

                setUserBanned(whitelist_id, true, reason, days, user_id)
                TriggerClientEvent('notify', source, 'sucesso', 'Banimento', 'Você baniu o(a) <b>'..nidentity.firstname..' '..nidentity.lastname..'</b> '..notify_text..'.<br><br><b>Motivo:</b> '..reason)
                
                vRP.webhook('ban', {
                    title = 'ban',
                    descriptions = {
                        { 'staff', user_id },
                        { 'baniu o id', nuser },
                        { 'whitelist do user', whitelist_id },
                        { 'motivo', reason },
                        { 'tempo', (temporaryBan and days..' dias' or 'permanentemente') }
                    }
                })  
            end
        end
    end,

    banwl = function(source)
        local user_id = vRP.getUserId(source)
        if (user_id) and (vRP.checkPermissions(user_id, { 'ticket.permissao', 'staff.permissao' })) then
            local identity = vRP.getUserIdentity(user_id)
            
            local prompt = hud:prompt(source, { 'Whitelist do Jogador', 'Motivo do Ban (Evite escrever de forma desorganizada)', 'Dias' })
            if (not prompt[1]) then return; end;
            
            local whitelist_id, reason, days = parseInt(prompt[1]), prompt[2], parseInt(prompt[3])
            if (not verifyWhitelist(whitelist_id)) then return TriggerClientEvent('notify', source, 'negado', 'Banimento', 'Whitelist <b>inexistente</b>!'); end;

            local temporaryBan = (days > 0)
            local notify_text = (temporaryBan and 'por <b>'..days..' dias</b>' or 'permanentemente')

            if (isBanned(whitelist_id)) then return TriggerClientEvent('notify', source, 'negado', 'Banimento', 'Este <b>jogador</b> já está banido.'); end;

            local nsource = vRP.getUserSource(getCharacterOnline(whitelist_id))

            local request = hud:request(source, 'Banimento', 'Você realmente deseja banir a whitelist <b>'..whitelist_id..'</b> '..notify_text..'?', 30000)
            if (request) then
                if (nsource) then DropPlayer(nsource, 'Você foi banido '..(temporaryBan and 'temporariamente' or 'permanentemente')..' de nossa cidade.\n\n[AUTOR]: Capital\n[MOTIVO]: '..reason..'\n[TEMPO]: '..(temporaryBan and days..' DIAS' or 'PERMANENTE')..'\n[SUA ALLOWLIST]: #'..whitelist_id); end;

                setUserBanned(whitelist_id, true, reason, days, user_id)
                TriggerClientEvent('notify', source, 'sucesso', 'Banimento', 'Você baniu a whitelist <b>'..whitelist_id..'</b> '..notify_text..'.<br><br><b>Motivo:</b> '..reason)
                
                vRP.webhook('ban', {
                    title = 'ban wl',
                    descriptions = {
                        { 'staff', user_id },
                        { 'baniu a whitelist', whitelist_id },
                        { 'motivo', reason },
                        { 'tempo', (temporaryBan and days..' dias' or 'permanentemente') }
                    }
                })  
            end
        end
    end,

    unban = function(source)
        local user_id = vRP.getUserId(source)
        if (user_id) and (vRP.checkPermissions(user_id, { 'ticket.permissao', 'staff.permissao' })) then
            local identity = vRP.getUserIdentity(user_id)
            
            local prompt = hud:prompt(source, { 'Passaporte do Jogador', 'Motivo do Unban (Evite escrever de forma desorganizada)' })
            if (not prompt[1]) then return; end;

            local nuser, reason = parseInt(prompt[1]), prompt[2]
            local whitelist_id = getUserWhitelist(nuser)
            if (not whitelist_id) then return TriggerClientEvent('notify', source, 'negado', 'Desbanimento', 'Whitelist não <b>encontrada</b>!'); end;
        
            if (not isBanned(whitelist_id)) then return TriggerClientEvent('notify', source, 'negado', 'Desbanimento', 'Este <b>jogador</b> não está banido.'); end;

            local nidentity = vRP.getUserIdentity(nuser)

            local request = hud:request(source, 'Desbanimento', 'Você realmente deseja desbanir o(a) <b>'..nidentity.firstname..' '..nidentity.lastname..'</b>?', 30000)
            if (request) then                
                setUserBanned(whitelist_id, false)
                TriggerClientEvent('notify', source, 'sucesso', 'Desbanimento', 'Você desbaniu o(a) <b>'..nidentity.firstname..' '..nidentity.lastname..'</b>.<br><br><b>Motivo:</b> '..reason)

                vRP.webhook('ban', {
                    title = 'unban',
                    descriptions = {
                        { 'staff', user_id },
                        { 'desbaniu o id', nuser },
                        { 'whitelist do user', whitelist_id },
                        { 'motivo', reason }
                    }
                })  
            end
        end
    end,

    unbanwl = function(source)
        local user_id = vRP.getUserId(source)
        if (user_id) and (vRP.checkPermissions(user_id, { 'ticket.permissao', 'staff.permissao' })) then
            local identity = vRP.getUserIdentity(user_id)
            
            local prompt = hud:prompt(source, { 'Whitelist do Jogador', 'Motivo do Unban (Evite escrever de forma desorganizada)' })
            if (not prompt[1]) then return; end;

            local whitelist_id, reason = parseInt(prompt[1]), prompt[2]
            if (not verifyWhitelist(whitelist_id)) then return TriggerClientEvent('notify', source, 'negado', 'Banimento', 'Whitelist <b>inexistente</b>!'); end;
        
            if (not isBanned(whitelist_id)) then return TriggerClientEvent('notify', source, 'negado', 'Desbanimento', 'Este <b>jogador</b> não está banido.'); end;

            local request = hud:request(source, 'Desbanimento', 'Você realmente deseja desbanir a whitelist <b>'..whitelist_id..'</b>?', 30000)
            if (request) then
                setUserBanned(whitelist_id, false)
                TriggerClientEvent('notify', source, 'sucesso', 'Desbanimento', 'Você desbaniu o(a) <b>'..whitelist_id..'</b>.<br><br><b>Motivo:</b> '..reason)

                vRP.webhook('ban', {
                    title = 'unban',
                    descriptions = {
                        { 'staff', user_id },
                        { 'desbaniu a whitelist', whitelist_id },
                        { 'motivo', reason }
                    }
                })  
            end
        end
    end
}

RegisterCommand('ban', function(source) commands.ban(source); end)
RegisterCommand('banwl', function(source) commands.banwl(source); end)
RegisterCommand('unban', function(source) commands.unban(source); end)
RegisterCommand('unbanwl', function(source) commands.unbanwl(source); end)

--======================================================================================================================
-- TOKENS RESET
--======================================================================================================================
local resetCommands = {
    ['discord'] = function(source,user_id)
        local identity = vRP.getUserIdentity(user_id)
        
        local prompt = hud:prompt(source, { 'Whitelist do Jogador', 'Motivo do Reset do Discord (Evite escrever de forma desorganizada)' })
        if (not prompt[1]) then return; end;

        local whitelist_id, reason = parseInt(prompt[1]), prompt[2]
        if (not verifyWhitelist(whitelist_id)) then return TriggerClientEvent('notify', source, 'negado', 'Reset do Discord', 'Whitelist <b>inexistente</b>!'); end;

        local request = hud:request(source, 'Reset do Discord', 'Você realmente deseja resetar o Discord da whitelist <b>'..whitelist_id..'</b>?', 30000)
        if (request) then
            oxmysql:update_async('update users set discord = ? where id = ?', { '', whitelist_id }) 
            TriggerClientEvent('notify', source, 'sucesso', 'Reset do Discord', 'Você resetou o Discord da whitelist <b>'..whitelist_id..'</b>.<br><br><b>Motivo:</b> '..reason)

            vRP.webhook('ban', {
                title = 'reset discord',
                descriptions = {
                    { 'staff', user_id },
                    { 'resetou o discord', whitelist_id },
                    { 'motivo', reason }
                }
            })
        end
    end,

    ['token'] = function(source,user_id)
        local identity = vRP.getUserIdentity(user_id)
        
        local prompt = hud:prompt(source, { 'Whitelist do Jogador', 'Motivo do Reset dos Tokens (Evite escrever de forma desorganizada)' })
        if (not prompt[1]) then return; end;

        local whitelist_id, reason = parseInt(prompt[1]), prompt[2]
        if (not verifyWhitelist(whitelist_id)) then return TriggerClientEvent('notify', source, 'negado', 'Reset dos Tokens', 'Whitelist <b>inexistente</b>!'); end;

        local request = hud:request(source, 'Reset dos Tokens', 'Você realmente deseja resetar os Tokens da whitelist <b>'..whitelist_id..'</b>?', 30000)
        if (request) then
            oxmysql:execute_async('delete from user_tokens where id = ?', { whitelist_id }) 
            TriggerClientEvent('notify', source, 'sucesso', 'Reset dos Tokens', 'Você resetou os Tokens da whitelist <b>'..whitelist_id..'</b>.<br><br><b>Motivo:</b> '..reason)

            vRP.webhook('ban', {
                title = 'reset token',
                descriptions = {
                    { 'staff', user_id },
                    { 'resetou os tokens', whitelist_id },
                    { 'motivo', reason }
                }
            })
        end
    end,

    ['alltokens'] = function(source,user_id)
        local identity = vRP.getUserIdentity(user_id)
        
        local prompt = hud:prompt(source, { 'Motivo do Reset dos Tokens (Evite escrever de forma desorganizada)' })
        if (not prompt[1]) then return; end;

        local request = hud:request(source, 'Reset dos Tokens', '<b>CUIDADO!!</b> Você realmente deseja resetar <b>todos Tokens</b> do servidor?', 30000)
        if (request) then
            local request = hud:request(source, 'Reset dos Tokens', '<b>CUIDADO!!</b> Você realmente deseja resetar <b>todos Tokens</b> do servidor?', 30000)
            if (request) then
                oxmysql:execute_async('delete from user_tokens', {}) 
                TriggerClientEvent('notify', source, 'sucesso', 'Reset dos Tokens', 'Você resetou os Tokens da <b>Cidade</b>.<br><br><b>Motivo:</b> '..prompt[1])

                vRP.webhook('ban', {
                    title = 'reset token',
                    descriptions = {
                        { 'staff', user_id },
                        { 'resetou os tokens', 'todos' },
                        { 'motivo', prompt[1] }
                    }
                })
            end
        end
    end,
}

RegisterCommand('reset', function(source,args) 
    local command = string.lower(args[1] or '')    
    if (command ~= '') and resetCommands[command] then
        local user_id = vRP.getUserId(source)
        if vRP.hasPermission(user_id, "+Staff.COO") then
            resetCommands[command](source,user_id)
        end
    end
end)
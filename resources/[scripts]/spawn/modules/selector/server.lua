srv.getCharacters = function()
    local accounts = {}

    local source = source
    local account = vRP.getAccount(GetPlayerIdentifiers(source))
    if (account) and (account.steam) then
        local query = vRP.query('spawn:getCharacters', { steam = account.steam })
        for _, v in ipairs(query) do
            local userTables = getUserTables(v.id)
            table.insert(accounts, { user_id = v.id, name = v.firstname..' '..v.lastname, group = 'Desempregado', customization = json.decode(userTables.user_character), clothes = json.decode(userTables.user_clothes), tattoos = json.decode(userTables.user_tattoo) })
        end
        return { characters = accounts, maxChars = (account.chars - #accounts) }
    end

    return accounts
end

srv.chooseCharacter = function(user_id)
    local source = source
    local account = vRP.getAccount(GetPlayerIdentifiers(source))
    if (account.steam) then
        local query = vRP.query('spawn:checkAccount', { user_id = user_id, steam = account.steam })
        if (query) then
            updateDiscord(user_id)
            vRP.characterChosen(source, user_id)
            return true
        end
    end
    DropPlayer(source, 'Conectando em personagem irregular.')
end
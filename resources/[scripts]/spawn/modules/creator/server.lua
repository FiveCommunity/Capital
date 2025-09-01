srv.finishCreation = function(table)
    local source = source
    local account = vRP.getAccount(GetPlayerIdentifiers(source))
    
    if (Player(source).state.resetAppearance) then
        -- [ Reset Personagem ] --

        local user_id = vRP.getUserId(source)
        if (not user_id) then DropPlayer(source, 'Sua cirurgia falhou! Tente novamente.') return; end;

        exports.oxmysql:update_async('update user_characters set firstname = ?, lastname = ?, age = ? where id = ?', { table.identity.firstname, table.identity.lastname, table.identity.age, user_id })
        exports.oxmysql:update_async('update user_datatable set user_character = ?, reset_character = 0 where user_id = ?', { json.encode(table.character), user_id })
            
        SetPlayerRoutingBucket(source, 0)
        Player(source).state.resetAppearance = false
    else
        -- [ Novo Personagem ] --

        local registration = vRP.generateRegistrationNumber()

        local newCharacter = vRP.insert('spawn:createCharacter', { 
            steam = account.steam,
            firstname = table.identity.firstname,
            lastname = table.identity.lastname,
            age = table.identity.age,
            registration = registration,
            rh = vRP.generateUserRH()
        })

        if (newCharacter > 0) then
            vRP.execute('spawn:createMoneyTable', {
                user_id = newCharacter,
                bank = 3000
            })

            vRP.execute('spawn:saveDatatable', {
                user_id = newCharacter,
                user_character = json.encode(table.character), 
                user_tattoo = json.encode({}), 
                user_clothes = json.encode({})
            })
            
            vRP.characterChosen(source, newCharacter, true)
        end

    end  
end

getUserTables = function(user_id)
    local query = vRP.query('spawn:getUserDatatable', { user_id = user_id })[1]
    if (query) then return query; end;
    return {}
end

AddEventHandler('playerSpawn', function(user_id, source)
    Citizen.SetTimeout(8000, function()
        local result = exports.oxmysql:scalar_async('select reset_character from user_datatable where user_id = ?', { user_id })
        if (result ~= 0) then
            Player(source).state.resetAppearance = true
            TriggerClientEvent('notify', source, 'importante', 'Cirurgia', 'Sua <b>cirurgia</b> está prestes a começar.')
        end
    end)
end)

RegisterCommand('cirurgia', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) and (vRP.checkPermissions(user_id, { 'staff.permissao' })) then
        local nuser = exports.hud:prompt(source, { 'Passaporte do Jogador' })[1]
        if (not nuser) then return; end;
        nuser = parseInt(nuser)

        local nsource = vRP.getUserSource(nuser)
        local nidentity = vRP.getUserIdentity(nuser)
        if (nidentity) then
            local request = exports.hud:request(source, 'Cirurgia', 'Você tem certeza que deseja efetuar a cirurgia no(a) <b>'..nidentity.firstname..' '..nidentity.lastname..'</b>?', 30000)
            if (request) then
                exports.oxmysql:update_async('update user_datatable set reset_character = 1 where user_id = ?', { nuser })
                
                if (nsource) then
                    Player(nsource).state.resetAppearance = true
                
                    TriggerClientEvent('notify', nsource, 'aviso', 'Cirurgia', 'Sua <b>cirurgia</b> está prestes a começar.')
                    TriggerClientEvent('notify', source, 'sucesso', 'Cirurgia', 'A <b>cirurgia</b> foi um sucesso!')
                else
                    TriggerClientEvent('notify', source, 'sucesso', 'Cirurgia', 'A <b>cirurgia</b> foi um sucesso, porém o cidadão não se encontra presente na cidade.')
                end

                vRP.webhook('cirurgia', {
                    title = 'cirurgia',
                    descriptions = {
                        { 'staff', user_id },
                        { 'target', nuser },
                    }
                })  
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Cirurgia', 'Jogador <b>inexistente</b>!')
        end
    end
end)
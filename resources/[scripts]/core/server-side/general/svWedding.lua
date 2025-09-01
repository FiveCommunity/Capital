local srv = {}
Tunnel.bindInterface('Wedding', srv)

srv.startWedding = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local identity = vRP.getUserIdentity(user_id)
        local relation, couple, status = exports[GetCurrentResourceName()]:CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Casamento', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;
        if (status ~= 'Noivo(a)') then TriggerClientEvent('notify', source, 'Casamento', 'Você precisa ser <b>noivo</b> pra casar precipitado(a) :/.') return; end;
        
        if (vRP.getInventoryItemAmount(user_id, 'par-alianca') >= 1) then
            local prompt = vRP.prompt(source, { 'Passaporte do(a) noivo(a)' })[1]
            if (prompt) then
                prompt = parseInt(prompt)
                if (couple ~= prompt) then TriggerClientEvent('notify', source, 'Casamento', 'Você não é <b>noivo(a)</b> desta pessoa talarico(a).') return; end;
                local nIdentity = vRP.getUserIdentity(prompt)
                local nPlayer = vRP.getUserSource(prompt)
                if (nPlayer) then
                    if (vRP.request(source, 'Relacionamento', 'Você realmente deseja se casar com o(a) '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)) then
                        if (vRP.request(nPlayer, 'Relacionamento', 'Você aceita se casar com o(a) '..identity.firstname..' '..identity.lastname..'?', 30000)) then
                            TriggerClientEvent('notify', nPlayer, 'Casamento', 'Parabéns aos pombinhos! Agora vocês são <b>casados</b>.')
                            TriggerClientEvent('notify', source, 'Casamento', 'Parabéns aos pombinhos! Agora vocês são <b>casados</b>.')
                            TriggerClientEvent('chatMessage', -1, '[CARTÓRIO]', {3, 187, 232}, 'Parabéns aos pombinhos! Agora '..identity.firstname..' '..identity.lastname..' e '..nIdentity.firstname..' '..nIdentity.lastname..' são casados 😍💕')

                            vRP.tryGetInventoryItem(user_id, 'par-alianca', 1)
                            vRP.giveInventoryItem(user_id, 'alianca-casamento', 1)
                            vRP.giveInventoryItem(prompt, 'alianca-casamento', 1)

                            vRP.execute('gb_relationship/updateRelation', { user = user_id, relation = 'Casado(a)' })
                            vRP.execute('gb_relationship/updateRelation', { user = prompt, relation = 'Casado(a)' })

                            vRP.webhook('casar', {
                                title = 'casar',
                                descriptions = {
                                    { 'action', '(wedding)' },
                                    { 'user', user_id },
                                    { 'target', prompt }
                                }
                            })  
                        else
                            TriggerClientEvent('notify', source, 'Casamento', 'O(a) mesmo(a) se negou a <b>casar</b> com você.')
                        end
                    end
                else
                    TriggerClientEvent('notify', source, 'Casamento', 'O(a) mesmo(a) se encontra <b>offline</b>.')
                end
            end
        else
            TriggerClientEvent('notify', source, 'Casamento', 'Você não possui um <b>par de alianças</b>.')
        end
    end
end

srv.startDivorce = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local identity = vRP.getUserIdentity(user_id)
        local relation, couple, status = exports[GetCurrentResourceName()]:CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Divórcio', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;
        if (status ~= 'Casado(a)') then TriggerClientEvent('notify', source, 'Divórcio', 'Você precisa ser <b>casado</b> para se divórcia de alguém.') return; end;
        
        local prompt = vRP.prompt(source, { 'Passaporte do(a) esposo(a)' })[1]
        if (prompt) then
            prompt = parseInt(prompt)
            if (couple ~= prompt) then TriggerClientEvent('notify', source, 'Divórcio', 'Você não é <b>casado(a)</b> com esta pessoa.') return; end;
            local nIdentity = vRP.getUserIdentity(prompt)
            local nPlayer = vRP.getUserSource(prompt)
            if (nPlayer) then
                if (vRP.request(source, 'Relacionamento', 'Você tem certeza que deseja se divorciar do(a) '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)) then
                    TriggerClientEvent('notify', nPlayer, 'Casamento', 'Parabéns aos pombinhos! Agora vocês não tem mais um <b>peso</b> nas costas.')
                    TriggerClientEvent('notify', source, 'Casamento', 'Parabéns aos pombinhos! Agora vocês não tem mais um <b>peso</b> nas costas.')

                    vRP.tryGetInventoryItem(user_id, 'alianca-casamento', 1)
                    vRP.tryGetInventoryItem(prompt, 'alianca-casamento', 1)
                    
                    vRP.execute('gb_relationship/deleteRelation', { user = user_id })
                    vRP.execute('gb_relationship/deleteRelation', { user = prompt })

                    vRP.webhook('divorciar', {
                        title = 'divorciar',
                        descriptions = {
                            { 'action', '(DIVORCE)' },
                            { 'user', user_id },
                            { 'target', prompt }
                        }
                    })  
                end
            else
                TriggerClientEvent('notify', source, 'Casamento', 'O(a) mesmo(a) se encontra <b>offline</b>.')
            end
        end
    end
end
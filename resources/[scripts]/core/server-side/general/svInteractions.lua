RegisterNetEvent('gb_interactions:handcuff', function(source, user_id)
    if (user_id) then  
        if (Player(source).state.Handcuff) then return; end;
        if (Player(source).state.StraightJacket) then return; end;
        if (GetSelectedPedWeapon(GetPlayerPed(source)) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Interação Algemar', 'Sua <b>mão</b> está ocupada.') return; end;
        
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            if (GetEntityHealth(GetPlayerPed(source)) <= 100) or (GetEntityHealth(GetPlayerPed(nPlayer)) <= 100) then return end;
            if (vRPclient.getNoCarro(nPlayer)) then return; end;
            if (Player(nPlayer).state.StraightJacket) then return; end;

            local nuser_id = vRP.getUserId(nPlayer)

            local cooldown = 'algemar:'..nPlayer
            if (exports[GetCurrentResourceName()]:GetCooldown(cooldown)) then
                TriggerClientEvent('notify', source, 'Interação Algemar', 'Aguarde <b>'..exports[GetCurrentResourceName()]:GetCooldown(cooldown)..' segundos</b> para algemar novamente.')
                return
            end
            exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 10)
            
            local Inventory = vRP.PlayerInventory(user_id)
            if Inventory then

                local isStaff = vRP.hasPermission(user_id, 'staff.permissao')

                if (vRPclient.isHandcuffed(nPlayer)) then
                    
                    local locIdname = 'masterpick'
                    local keyAmount, keySlot = Inventory:getItemAmount('chave-algema')
                    local locAmount, locSlot = Inventory:getItemAmount('masterpick')
                    
                    if (locAmount == 0) then
                        locIdname = 'lockpick'
                        locAmount, locSlot = Inventory:getItemAmount('lockpick')
                    end

                    if isStaff or (keyAmount > 0) then

                        local sData = Inventory:getSlot(keySlot)
                        if (isStaff or Inventory:tryGetItem('chave-algema',1,keySlot,true)) then
                        
                            TriggerClientEvent('gb:attach', nPlayer, source, 4103, 0.1, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                            Player(source).state.BlockTasks = true
                            Player(nPlayer).state.BlockTasks = true

                            vRPclient.playAnim(source, false, {
                                { 'mp_arresting', 'a_uncuff' }
                            }, false)
                            vRPclient.playAnim(nPlayer, false, {
                                { 'mp_arresting', 'b_uncuff' }
                            }, false)

                            Citizen.SetTimeout(5000, function()
                                TriggerClientEvent('gb:attach', nPlayer, source)

                                Player(source).state.BlockTasks = false
                                Player(nPlayer).state.BlockTasks = false

                                ClearPedTasks(GetPlayerPed(nPlayer))
                                ClearPedTasks(GetPlayerPed(source))
                                
                                Player(nPlayer).state.Handcuff = false
                                vRPclient.setHandcuffed(nPlayer, false)

                                TriggerClientEvent('vrp_sounds:source', source, 'uncuff', 0.1)
                                TriggerClientEvent('vrp_sounds:source', nPlayer, 'uncuff', 0.1)
                                TriggerClientEvent('gb_interactions:algemas', nPlayer)

                                if (not isStaff) then
                                    if (not sData.time) then
                                        Inventory:generateItem('algema',1,nil,nil,true)
                                    else
                                        Inventory:giveItem('algema',1,nil,sData,true)
                                    end
                                end

                                vRP.webhook('handcuff', {
                                    title = 'Algemas',
                                    descriptions = {
                                        { 'action', '(algemar)' },
                                        { 'user', user_id },
                                        { 'target', nuser_id },
                                        { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                                    }
                                })
                            end)
                        end

                    elseif (locAmount > 0) then
                        if Inventory:tryGetItem(locIdname,1,locSlot,true) then
                            if (exports.system:Task(source, 3, 8000)) then
                                
                                if (locIdname == 'lockpick') and (math.random(100) < 50) then
                                    TriggerClientEvent('notify', source, 'Interação Algemar', 'A ferramenta <b>falhou</b>!')
                                    return false
                                end
                                
                                TriggerClientEvent('gb:attach', nPlayer, source, 4103, 0.1, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                                Player(source).state.BlockTasks = true
                                Player(nPlayer).state.BlockTasks = true

                                vRPclient.playAnim(source, false, {
                                    { 'mp_arresting', 'a_uncuff' }
                                }, false)
                                vRPclient.playAnim(nPlayer, false, {
                                    { 'mp_arresting', 'b_uncuff' }
                                }, false)

                                Citizen.SetTimeout(5000, function()
                                    TriggerClientEvent('gb:attach', nPlayer, source)

                                    Player(source).state.BlockTasks = false
                                    Player(nPlayer).state.BlockTasks = false

                                    ClearPedTasks(GetPlayerPed(nPlayer))
                                    ClearPedTasks(GetPlayerPed(source))
                                    
                                    Player(nPlayer).state.Handcuff = false
                                    vRPclient.setHandcuffed(nPlayer, false)

                                    TriggerClientEvent('vrp_sounds:source', source, 'uncuff', 0.1)
                                    TriggerClientEvent('vrp_sounds:source', nPlayer, 'uncuff', 0.1)
                                    TriggerClientEvent('gb_interactions:algemas', nPlayer)

                                    vRP.webhook('handcuff', {
                                        title = 'Algemas',
                                        descriptions = {
                                            { 'action', '(desalgemar)' },
                                            { 'user', user_id },
                                            { 'target', nuser_id },
                                            { 'item', locIdname },
                                            { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                                        }
                                    })
                                end)
                            end
                        end
                    else
                        TriggerClientEvent('notify', source, 'Interação Algemar', 'Você não possui uma <b>lockpick</b> ou <b>chave de algema</b>.')
                    end
                else
                    if (not Player(nPlayer).state.Handsup) and (not vRP.hasPermission(user_id, 'policia.permissao')) then
                        return TriggerClientEvent('notify', source, 'Interação Algemar', 'A pessoa precisa estar <b>rendida</b>!')
                    end

                    local amount, slot = Inventory:getItemAmount('algema')
                    if isStaff or (amount > 0) then
                        
                        local sData = Inventory:getSlot(slot)

                        if (isStaff or Inventory:tryGetItem('algema',1,slot,true)) then
                    
                            TriggerClientEvent('gb:attach', nPlayer, source, 4103, 0.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                            Player(source).state.BlockTasks = true
                            Player(nPlayer).state.BlockTasks = true

                            vRPclient.playAnim(source, false, {
                                { 'mp_arrest_paired', 'cop_p2_back_left' }
                            }, false)
                            vRPclient.playAnim(nPlayer, false, {
                                { 'mp_arrest_paired', 'crook_p2_back_left' }
                            }, false)
                            
                            Citizen.SetTimeout(3500, function()
                                TriggerClientEvent('gb:attach', nPlayer, source)

                                Player(source).state.BlockTasks = false
                                Player(nPlayer).state.BlockTasks = false

                                ClearPedTasks(GetPlayerPed(nPlayer))
                                ClearPedTasks(GetPlayerPed(source))
                                
                                Player(nPlayer).state.Handcuff = true
                                vRPclient.setHandcuffed(nPlayer, true)

                                TriggerClientEvent('vrp_sounds:source', source, 'cuff', 0.1)
                                TriggerClientEvent('vrp_sounds:source', nPlayer, 'cuff', 0.1)
                                TriggerClientEvent('gb_interactions:algemas', nPlayer, 'colocar')

                                if (not isStaff) then
                                    if (not sData.time) then
                                        Inventory:generateItem('chave-algema',1,nil,nil,true)
                                    else
                                        Inventory:giveItem('chave-algema',1,nil,sData,true)
                                    end
                                end

                                vRP.webhook('handcuff', {
                                    title = 'Algemas',
                                    descriptions = {
                                        { 'action', '(desalgemar)' },
                                        { 'user', user_id },
                                        { 'target', nuser_id },
                                        { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                                    }
                                })
                            end)
                        end
                    else
                        TriggerClientEvent('notify', source, 'Interação Algemar', 'Você não possui uma <b>algema</b>.')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('gb_interactions:straightJacket', function(source, user_id)
    if (user_id) then  
        if (Player(source).state.Handcuff) then return; end;
        if (Player(source).state.StraightJacket) then return; end;
        if (GetSelectedPedWeapon(GetPlayerPed(source)) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Camisa de Força', 'Sua <b>mão</b> está ocupada.') return; end;
        
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            
            if (GetEntityHealth(GetPlayerPed(source)) <= 100 and GetEntityHealth(GetPlayerPed(nPlayer)) <= 100) then return end;
            if (vRPclient.getNoCarro(nPlayer)) then return; end;
            if (Player(nPlayer).state.Handcuff) then return; end;
      
            local cooldown = 'algemar:'..nPlayer
            if (exports[GetCurrentResourceName()]:GetCooldown(cooldown)) then
                TriggerClientEvent('notify', source, 'negado', 'Camisa de Força', 'Aguarde <b>'..exports[GetCurrentResourceName()]:GetCooldown(cooldown)..' segundos</b> para amarrar novamente.')
                return
            end
            exports[GetCurrentResourceName()]:CreateCooldown(cooldown, 10)
            
            local Inventory = vRP.PlayerInventory(user_id)
            if Inventory then

                if ( Player(nPlayer).state.StraightJacket ) then
                    
                    local keyAmount, keySlot = Inventory:getItemAmount('chave-camisaforca')
                    local tesAmount, tesSlot = Inventory:getItemAmount('tesoura')

                    if (keyAmount > 0) then
                        local sData = Inventory:getSlot(keySlot)
                        if Inventory:tryGetItem('chave-camisaforca',1,keySlot,true) then

                            TriggerClientEvent('gb:attach', nPlayer, source, 4103, 0.1, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                            Player(source).state.BlockTasks = true
                            Player(nPlayer).state.BlockTasks = true

                            vRPclient.playAnim(source, false, {
                                { 'mp_arresting', 'a_uncuff' }
                            }, false)
                            vRPclient.playAnim(nPlayer, false, {
                                { 'mp_arresting', 'b_uncuff' }
                            }, false)

                            local nUser = vRP.getUserId(nPlayer)
                            if nUser then
                                vRP.setUData(nUser,'StraightJacket', '')
                            end

                            Citizen.SetTimeout(5000, function()
                                TriggerClientEvent('gb:attach', nPlayer, source)

                                Player(source).state.BlockTasks = false
                                Player(nPlayer).state.BlockTasks = false

                                ClearPedTasks(GetPlayerPed(nPlayer))
                                ClearPedTasks(GetPlayerPed(source))
                                
                                Player(nPlayer).state.StraightJacket = false

                                TriggerClientEvent('vrp_sounds:source', source, 'uncuff', 0.1)
                                TriggerClientEvent('vrp_sounds:source', nPlayer, 'uncuff', 0.1)

                                Inventory:giveItem('camisaforca',1,nil,sData,true)
                            end)                            
                        end
                    elseif (tesAmount > 0) then
                        if Inventory:tryGetItem('tesoura',1,tesSlot,true) then
                            if (exports.system:Task(source, 3, 8000)) then
                                TriggerClientEvent('gb:attach', nPlayer, source, 4103, 0.1, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                                Player(source).state.BlockTasks = true
                                Player(nPlayer).state.BlockTasks = true

                                vRPclient.playAnim(source, false, {
                                    { 'mp_arresting', 'a_uncuff' }
                                }, false)
                                vRPclient.playAnim(nPlayer, false, {
                                    { 'mp_arresting', 'b_uncuff' }
                                }, false)

                                local nUser = vRP.getUserId(nPlayer)
                                if nUser then
                                    vRP.setUData(nUser,'StraightJacket', '')
                                end

                                Citizen.SetTimeout(5000, function()
                                    TriggerClientEvent('gb:attach', nPlayer, source)

                                    Player(source).state.BlockTasks = false
                                    Player(nPlayer).state.BlockTasks = false

                                    ClearPedTasks(GetPlayerPed(nPlayer))
                                    ClearPedTasks(GetPlayerPed(source))
                                    
                                    Player(nPlayer).state.StraightJacket = false

                                    TriggerClientEvent('vrp_sounds:source', source, 'uncuff', 0.1)
                                    TriggerClientEvent('vrp_sounds:source', nPlayer, 'uncuff', 0.1)
                                end)
                            end
                        end
                    else
                        TriggerClientEvent('notify', source, 'Interação Algemar', 'Você não possui uma <b>tesoura</b> ou <b>chave de camisa de força</b>.')
                    end
                else
                    if (not Player(nPlayer).state.Handsup) then
                        return TriggerClientEvent('notify', source, 'Camisa de Força', 'A pessoa precisa estar <b>rendida</b>!')
                    end

                    local amount, slot = Inventory:getItemAmount('camisaforca')
                    if (amount > 0) then
                        local sData = Inventory:getSlot(slot)
                        if Inventory:tryGetItem('camisaforca',1,slot,true) then
                            
                            TriggerClientEvent('gb:attach', nPlayer, source, 4103, 0.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, 2, true)

                            Player(source).state.BlockTasks = true
                            Player(nPlayer).state.BlockTasks = true
                            Player(nPlayer).state.Handsup = false

                            vRPclient.playAnim(source, false, {
                                { 'mp_arrest_paired', 'cop_p2_back_left' }
                            }, false)
                            vRPclient.playAnim(nPlayer, false, {
                                { 'mp_arrest_paired', 'crook_p2_back_left' }
                            }, false)

                            local nUser = vRP.getUserId(nPlayer)
                            if nUser then
                                vRP.setUData(nUser,'StraightJacket', '1')
                            end
                            
                            Citizen.SetTimeout(3500, function()
                                TriggerClientEvent('gb:attach', nPlayer, source)

                                Player(source).state.BlockTasks = false
                                Player(nPlayer).state.BlockTasks = false

                                ClearPedTasks(GetPlayerPed(nPlayer))
                                ClearPedTasks(GetPlayerPed(source))
                                
                                Player(nPlayer).state.StraightJacket = true

                                TriggerClientEvent('vrp_sounds:source', source, 'cuff', 0.1)
                                TriggerClientEvent('vrp_sounds:source', nPlayer, 'cuff', 0.1)
                            
                                Inventory:giveItem('chave-camisaforca',1,nil,sData,true)
                            end)
                        end
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Camisa de Força', 'Você não possui uma <b>Camisa de Força</b>.')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('gb_interactions:capuz', function(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (value == 'colocar') then
            if (vRPclient.getNoCarro(source)) then return; end;
            if (Player(source).state.Handcuff) then return; end;
            if (Player(source).state.StraightJacket) then return; end;
            if (GetSelectedPedWeapon(GetPlayerPed(source)) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Interação Capuz', 'Sua <b>mão</b> está ocupada.') return; end;

            local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
            if (nPlayer) then
                local cooldown = 'capuz:'..nPlayer
                if (exports.core:GetCooldown(cooldown)) then
                    TriggerClientEvent('notify', source, 'Interação Capuz', 'Aguarde <b>'..exports.core:GetCooldown(cooldown)..' segundos</b> para encapuzar novamente.')
                    return
                end
                exports.core:CreateCooldown(cooldown, 10)

                if (vRPclient.getNoCarro(nPlayer)) then return; end;
                if (not vRPclient.isHandcuffed(nPlayer)) then TriggerClientEvent('notify', source, 'Interação Capuz', 'Você não pode <b>encapuzar</b> uma pessoa desalgemada.') return; end;
                if (vRPclient.isCapuz(nPlayer)) then TriggerClientEvent('notify', source, 'Interação Capuz', 'O mesmo já está <b>encapuzado</b>.') return; end;
                
                if (not vRP.tryGetInventoryItem(user_id, 'capuz', 1)) then TriggerClientEvent('notify', source, 'Interação Capuz', 'Você não possui um <b>capuz</b> em seu inventário.') return; end;

                Player(nPlayer).state.Capuz = true
                vRPclient.setCapuz(nPlayer, true)
            end
        else
            if (vRPclient.getNoCarro(source)) then return; end;
            if (GetSelectedPedWeapon(GetPlayerPed(source)) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Interação Capuz', 'Sua <b>mão</b> está ocupada.') return; end;
            
            local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
            if (nPlayer) then
                if (vRPclient.getNoCarro(nPlayer)) then return; end;
                if (not vRPclient.isCapuz(nPlayer)) then TriggerClientEvent('notify', source, 'Interação Capuz', 'O mesmo não está <b>encapuzado</b>') return; end;

                Player(nPlayer).state.Capuz = false
                vRPclient.setCapuz(nPlayer, false)
                vRP.giveInventoryItem(user_id, 'capuz', 1)
            end
        end
    end
end)

vRP._prepare('gb_relationship/getUser', 'select * from relationship where user_1 = @user')
vRP._prepare('gb_relationship/updateRelation', 'update relationship set relation = @relation where user_1 = @user')
vRP._prepare('gb_relationship/createRelation', 'insert into relationship (user_1, user_2, relation, start_relationship) values (@user_1, @user_2, @relation, @start_relationship)')
vRP._prepare('gb_relationship/deleteRelation', 'delete from relationship where user_1 = @user')

local CheckUser = function(user_id)
    local query = vRP.query('gb_relationship/getUser', { user = user_id })[1]
    if (query) then
        return true, query.user_2, query.relation, query.start_relationship
    end
    return false
end
exports('CheckUser', CheckUser)

RegisterNetEvent('gb_interactions:relacionamento', function()
    local source = source
    local user_id = vRP.getUserId(source)
	if (user_id) then
        local relation, couple, status, date = CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Checar relacionamento', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;

        local nIdentity = vRP.getUserIdentity(couple)
        TriggerClientEvent('notify', source, 'Checar relacionamento', 'Informações do seu relacionamento: <br><br>- Você está: <b>'..status..'</b><br>- Cônjugue: <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b><br>- Início do seu relacionamento: ( <b>'..os.date('\n%d/%m/%Y', tonumber(date))..'</b> )', 10000)
    end
end)

RegisterNetEvent('gb_interactions:noivar', function()
    local source = source
    local user_id = vRP.getUserId(source)
	if (user_id) then
        local relation, couple, status = CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Pedido de casamento', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;
        if (status == 'Noivo(a)') then TriggerClientEvent('notify', source, 'Pedido de casamento', 'Você já está <b>noivado(a)</b> criatura.') return; end;

        local identity = vRP.getUserIdentity(user_id)
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = vRP.getUserId(nPlayer)
            if (couple ~= nUser) then TriggerClientEvent('notify', source, 'Pedido de casamento', 'Você não é <b>namorado(a)</b> desta pessoa talarico(a).') return; end;
            if (nUser) then
                local nIdentity = vRP.getUserIdentity(nUser)
                if (vRP.request(source, 'Relacionamento', 'Você gostaria de pedir o(a) '..nIdentity.firstname..' '..nIdentity.lastname..' em casamento?', 30000)) then
                    if (vRP.request(nPlayer, 'Relacionamento', 'Você gostaria de aceitar o pedido de casamento de '..identity.firstname..' '..identity.lastname..'?', 30000)) then
                        TriggerClientEvent('notify', nPlayer, 'Pedido de casamento', 'Parabéns aos pombinhos! Agora vocês são <b>noivos</b>.')
                        TriggerClientEvent('notify', source, 'Pedido de casamento', 'Parabéns aos pombinhos! Agora vocês são <b>noivos</b>.')

                        vRP.execute('gb_relationship/updateRelation', { user = user_id, relation = 'Noivo(a)' })
                        vRP.execute('gb_relationship/updateRelation', { user = nUser, relation = 'Noivo(a)' })

                        vRP.webhook('noivar', {
                            title = 'noivar',
                            descriptions = {
                                { 'action', '(marriage proposal)' },
                                { 'user', user_id },
                                { 'target', nUser }
                            }
                        })  
                    else
                        TriggerClientEvent('notify', source, 'Pedido de casamento', 'O seu pedido de <b>casamento</b> foi negado.')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('gb_interactions:namorar', function()
    local source = source
    local user_id = vRP.getUserId(source)
	if (user_id) then
        if (CheckUser(user_id)) then TriggerClientEvent('notify', source, 'Pedido de namoro', 'Você já está <b>namorando</b> sapeca.') return; end;
        local identity = vRP.getUserIdentity(user_id)
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = vRP.getUserId(nPlayer)
            if (CheckUser(nUser)) then TriggerClientEvent('notify', source, 'Pedido de namoro', 'Está pessoa já está <b>namorando</b> talarico(a).') return; end;
            if (nUser) then
                local nIdentity = vRP.getUserIdentity(nUser)
                if (vRP.request(source, 'Relacionamento', 'Você gostaria de pedir o(a) '..nIdentity.firstname..' '..nIdentity.lastname..' em namoro?', 30000)) then
                    if (vRP.request(nPlayer, 'Relacionamento', 'Você gostaria de aceitar o pedido de namoro de '..identity.firstname..' '..identity.lastname..'?', 30000)) then
                        TriggerClientEvent('notify', nPlayer, 'Pedido de namoro', 'Parabéns aos pombinhos! Agora vocês estão <b>namorando</b>.')
                        TriggerClientEvent('notify', source, 'Pedido de namoro', 'Parabéns aos pombinhos! Agora vocês estão <b>namorando</b>.')

                        vRP.execute('gb_relationship/createRelation', { user_1 = user_id, user_2 = nUser, relation = 'Namorando', start_relationship = os.time() })
                        vRP.execute('gb_relationship/createRelation', { user_1 = nUser, user_2 = user_id, relation = 'Namorando', start_relationship = os.time() })

                        vRP.webhook('namorar', {
                            title = 'namorar',
                            descriptions = {
                                { 'action', '(start relation)' },
                                { 'user', user_id },
                                { 'target', nUser }
                            }
                        })  
                    else
                        TriggerClientEvent('notify', source, 'Pedido de namoro', 'O seu pedido de <b>namoro</b> foi negado.')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('gb_interactions:terminar', function()
    local source = source
    local user_id = vRP.getUserId(source)
	if (user_id) then
        local relation, couple, status = CheckUser(user_id)
        if (not relation) then TriggerClientEvent('notify', source, 'Terminar relacionamento', 'Você não está em um <b>relacionamento</b> 🤣.') return; end;

        local text = (status == 'Namorando' and 'namoro' or 'noivado')
        local identity = vRP.getUserIdentity(couple)
        if (vRP.request(source, 'Relacionamento', 'Você tem certeza que deseja terminar o seu '..text..' com o(a) '..identity.firstname..' '..identity.lastname..'?', 30000)) then
            TriggerClientEvent('notify', source, 'Terminar relacionamento', 'Parabéns parceiro(a)! Agora você está na <b>pista</b>.')
            if (vRP.getUserSource(couple)) then TriggerClientEvent('notify', vRP.getUserSource(couple), 'Terminar relacionamento', 'Parabéns parceiro(a)! Agora você está na <b>pista</b>.'); end;

            vRP.execute('gb_relationship/deleteRelation', { user = user_id })
            vRP.execute('gb_relationship/deleteRelation', { user = couple })

            vRP.webhook('terminar', {
                title = 'terminar',
                descriptions = {
                    { 'action', '(stop relation)' },
                    { 'user', user_id },
                    { 'target', nUser }
                }
            })  
        end
    end
end)

RegisterNetEvent('gb_interactions:carregar', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
    if (user_id) and nPlayer then
        if (vRP.hasPermission(user_id, 'staff.permissao') or vRP.hasPermission(user_id, 'polpar.permissao')) then
            if (Player(source).state.Handcuff) then return; end;
            if (Player(source).state.StraightJacket) then return; end;
            TriggerClientEvent('carregar', nPlayer, source)
         end
    end
end)

RegisterNetEvent('gb_interactions:vestimenta', function(value)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'polpar.permissao') then
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        if (nplayer) then
            local nUser = vRP.getUserId(nplayer)
            local nidentity = vRP.getUserIdentity(nUser)
            if (value == 'rmascara') then
                TriggerClientEvent('gb_commands_police:clothes', nplayer, 'rmascara')
                vRP.webhook('policeCommands', {
                    title = 'remover máscara',
                    descriptions = {
                        { 'staff', user_id },
                        { 'target', nUser },
                    }
                })  
            elseif (value == 'rchapeu') then
                TriggerClientEvent('gb_commands_police:clothes', nplayer, 'rchapeu')
                vRP.webhook('policeCommands', {
                    title = 'remover chápeu',
                    descriptions = {
                        { 'staff', user_id },
                        { 'target', nUser },
                    }
                })  
            end
        else
            TriggerClientEvent('notify', source, 'Interação Policia', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

RegisterNetEvent('gb_interactions:acessorios', function(value)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'polpar.permissao') then
        local coord = GetEntityCoords(GetPlayerPed(source))
        if (value == 'cone') then
            if (not vRP.tryGetInventoryItem(user_id, 'cone', 1)) then
                TriggerClientEvent('notify', source, 'Inventário', 'Você não possui um <b>cone</b> em sua mochila!')
                return
            end
            TriggerClientEvent('cone', source)
            vRP.webhook('policeCommands', {
                title = 'cone',
                descriptions = {
                    { 'action', '(create)' },
                    { 'user_id', user_id },
                    { 'coord', tostring(coord) },
                }
            })  
        elseif (value == 'coned') then
            TriggerClientEvent('cone', source, 'd')
            vRP.webhook('policeCommands', {
                title = 'cone',
                descriptions = {
                    { 'action', '(delete)' },
                    { 'user_id', user_id },
                    { 'coord', tostring(coord) },
                }
            })  
        elseif (value == 'barreira') then
            if (not vRP.tryGetInventoryItem(user_id, 'barreira', 1)) then
                TriggerClientEvent('notify', source, 'Inventário', 'Você não possui uma <b>barreira</b> em sua mochila!')
                return
            end
            TriggerClientEvent('barreira', source)
            vRP.webhook('policeCommands', {
                title = 'barreira',
                descriptions = {
                    { 'action', '(create)' },
                    { 'user_id', user_id },
                    { 'coord', tostring(coord) },
                }
            })  
        elseif (value == 'barreirad') then
            TriggerClientEvent('barreira', source, 'd')
            vRP.webhook('policeCommands', {
                title = 'barreira',
                descriptions = {
                    { 'action', '(delete)' },
                    { 'user_id', user_id },
                    { 'coord', tostring(coord) },
                }
            })  
        end        
    end
end)

RegisterNetEvent('gb_interactions:cv', function(nplayer)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
    if (not nplayer) or (nplayer == '') then
        nplayer = vRPclient.getNearestPlayer(source, 2.5)
    end

	if (nplayer) then
        local state = Player(nplayer).state
        if (vRP.hasPermission(user_id, 'polpar.permissao') or (state.Handcuff) or (state.StraightJacket) or (GetEntityHealth(GetPlayerPed(nplayer)) <= 100) ) then
            if (vRPclient.isInVehicle(source)) then
                TriggerClientEvent('notify', source, 'Colocar no veículo', 'Você não pode utilizar este comando de dentro de um <b>veículo</b>.')
                return
            end

            local nUser = vRP.getUserId(nplayer)
            local nIdentity = vRP.getUserIdentity(nUser)
            vRPclient.putInNearestVehicleAsPassenger(nplayer, 5)
            vRP.webhook('policeCommands', {
                title = 'cv',
                descriptions = {
                    { 'staff', user_id },
                    { 'target', nUser },
                }
            })
        end
    else
        TriggerClientEvent('notify', source, 'Colocar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
    end
end)

RegisterNetEvent('gb_interactions:rv', function(nplayer)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if (not nplayer) or (nplayer == '') then
        nplayer = vRPclient.getNearestPlayer(source, 2.5)
    end

    if (nplayer) then
        local state = Player(nplayer).state
        if (vRP.hasPermission(user_id, 'polpar.permissao') or (state.Handcuff) or (state.StraightJacket) or (GetEntityHealth(GetPlayerPed(nplayer)) <= 100) ) then
            if (vRPclient.isInVehicle(source)) then
                TriggerClientEvent('notify', source, 'Retirar do veículo', 'Você não pode utilizar este comando de dentro de um <b>veículo</b>.')
                return
            end

            local nUser = vRP.getUserId(nplayer)
            local nIdentity = vRP.getUserIdentity(nUser)
            vRPclient.ejectVehicle(nplayer)
            vRP.webhook('policeCommands', {
                title = 'rv',
                descriptions = {
                    { 'staff', user_id },
                    { 'target', nUser },
                }
            })
        end 
    else
        TriggerClientEvent('notify', source, 'Retirar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
    end
end)

RegisterNetEvent('gb_interactions:tow', function()
    local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then
        if (Player(source).state.Handcuff) or (Player(source).state.StraightJacket) then return; end;
		TriggerClientEvent('vTow', source)
	end
end)

RegisterNetEvent('gb_interactions:enviar', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) then
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = vRP.getUserId(nPlayer)
            local nIdentity = vRP.getUserIdentity(nUser)
            local amount = vRP.prompt(source, { 'Quantidade de dinheiro' })[1]
            if (amount) then
                amount = parseInt(amount)
                if (vRP.tryPayment(user_id, amount)) then
                    vRP.giveMoney(nUser, amount)

                    vRPclient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
			        vRPclient._playAnim(nPlayer, true, {{ 'mp_common', 'givetake1_a' }}, false)
                    TriggerClientEvent('notify', source, 'Interação Enviar', 'Você enviou <b>R$'..vRP.format(amount)..'</b>.')
                    TriggerClientEvent('notify', nPlayer, 'Interação Enviar', 'Você recebeu <b>R$'..vRP.format(amount)..'</b>.')
                    
                    vRP.webhook('enviar', {
                        title = 'enviar',
                        descriptions = {
                            { 'user', user_id },
                            { 'target', nUser },
                            { 'enviou', 'R$'..vRP.format(amount) }
                        }
                    })  
                else
                    TriggerClientEvent('notify', source, 'Interação Enviar', 'Você não possui essa quantia de <b>dinheiro</b> em mãos.')
                end
            end
        else
            TriggerClientEvent('notify', source, 'Interação Enviar', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
    end
end)

RegisterNetEvent('gb_interactions:homesAdd', function()
    local source = source    
    exports.homes:homeInteractions(source, 'add')
end)

RegisterNetEvent('gb_interactions:homesRem', function()
    local source = source    
    exports.homes:homeInteractions(source, 'rem')
end)

RegisterNetEvent('gb_interactions:homesTrans', function()
    local source = source    
    exports.homes:homeInteractions(source, 'transfer')
end)

RegisterNetEvent('gb_interactions:homesVender', function()
    local source = source    
    exports.homes:homeInteractions(source, 'sell')
end)

RegisterNetEvent('gb_interactions:homesChecar', function()
    local source = source    
    exports.homes:homeInteractions(source, 'check')
end)

RegisterNetEvent('gb_interactions:homesTax', function()
    local source = source    
    exports.homes:homeInteractions(source, 'tax')
end)

RegisterNetEvent('gb_interactions:homesOther', function()
    local source = source    
    exports.homes:homeInteractions(source, 'residences')
end)

RegisterNetEvent('gb_interactions:homesTrancar', function()
    local source = source    
    exports.homes:homeInteractions(source, 'lock')
end)

RegisterNetEvent('gb_interactions:homesInterior', function(value)
    local source = source    
    if (value ~= '') then exports.homes:homeInteractions(source, 'interior', { interior = value });
    else exports.homes:homeInteractions(source, 'list_interior'); end;
end)

RegisterNetEvent('gb_interactions:homesDecoration', function(value)
    local source = source    
    if (value ~= '') then exports.homes:homeInteractions(source, 'decoration', { decoration = value });
    else exports.homes:homeInteractions(source, 'list_decoration'); end;
end)

RegisterNetEvent('gb_interactions:homesBau', function()
    local source = source    
    exports.homes:homeInteractions(source, 'chest')
end)

RegisterNetEvent('gb_interactions:homesFridge', function()
    local source = source    
    exports.homes:homeInteractions(source, 'fridge')
end)

RegisterNetEvent('gb_interactions:homesGaragem', function()
    local source = source    
    exports.homes:homeInteractions(source, 'garage')
end)

RegisterNetEvent('gb_interactions:homesDelGarage', function()
    local source = source    
    exports.homes:homeInteractions(source, 'del_garage')
end)

RegisterNetEvent('gb_interactions:homesWardrobe', function()
    local source = source    
    exports.homes:homeInteractions(source, 'wardrobe')
end)

RegisterNetEvent('gb_interactions:porte', function()
    local source = source
    local user_id = vRP.getUserId(source)

    local prompt = exports.hud:prompt(source, {
        'Nome do Personagem', 'Passaporte do Jogador', 'Número de Telefone', 'Motivo para Pedido de Reabilitação criminal: (Por favor, forneça uma explicação detalhada do motivo pelo qual seu personagem precisa de Reabilitação criminal).', 'Informações Adicionais: (Qualquer informação adicional que você deseja fornecer para justificar o pedido de Reabilitação criminal).'
    })
    if (not prompt[1] and not prompt[2] and not prompt[3] and not prompt[4] and not prompt[5]) then TriggerClientEvent('notify', source, 'Porte de Arma', 'Você precisa preencher o <b>formulário</b>.') return; end;

    vRP.webhook('pedidoJuridico', {
        title = 'pedidoJuridico',
        descriptions = {
            { 'action', '(pedido porte de armas)' },
            { 'advogado', user_id },
            { 'nome do personagem', prompt[1] },
            { 'passaporte do jogador', prompt[2] },
            { 'número de telefone', prompt[3] },
            { 'motivo', prompt[4] },
            { 'informações adicionais', prompt[5] }
        }
    })  
end)

RegisterNetEvent('gb_interactions:fichasuja', function()
    local source = source
    local user_id = vRP.getUserId(source)

    local prompt = exports.hud:prompt(source, {
        'Nome do Personagem', 'Passaporte do Jogador', 'Número de Telefone', 'Motivo para Pedido de Reabilitação criminal: (Por favor, forneça uma explicação detalhada do motivo pelo qual seu personagem precisa de Reabilitação criminal).', 'Informações Adicionais: (Qualquer informação adicional que você deseja fornecer para justificar o pedido de Reabilitação criminal).'
    })
    if (not prompt[1] and not prompt[2] and not prompt[3] and not prompt[4] and not prompt[5]) then TriggerClientEvent('notify', source, 'Porte de Arma', 'Você precisa preencher o <b>formulário</b>.') return; end;

    vRP.webhook('pedidoJuridico', {
        title = 'pedidoJuridico',
        descriptions = {
            { 'action', '(limpar a ficha)' },
            { 'advogado', user_id },
            { 'nome do personagem', prompt[1] },
            { 'passaporte do jogador', prompt[2] },
            { 'número de telefone', prompt[3] },
            { 'motivo', prompt[4] },
            { 'informações adicionais', prompt[5] }
        }
    })  
end)

local Perimetros = {}

RegisterNetEvent('gb_interactions:fecharperimetro', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'policia.permissao') then
        local identity = vRP.getUserIdentity(user_id)
        
        if (Perimetros[user_id]) then
            return TriggerClientEvent('notify', source, 'Perímetro', 'Você já fechou um <b>perímetro</b>.')
        end

        local prompt = exports.hud:prompt(source, {
            'Nome do perímetro', 'Distância do perímetro', 'Tempo de perímetro fechado (segundos)'
        })
        
        Perimetros[user_id] = true;

        local name = prompt[1]
        local distance = parseInt(prompt[2])
        local time = parseInt(prompt[3])
        if (name and distance and time) then
            TriggerClientEvent('announcement', -1, 'Policia Capital', 'O perímetro <b>'..name..'</b> foi fechado, se afastem imediatamente do local.', identity.firstname, true, 15000)
            TriggerClientEvent('BlipPerimetro', -1, user_id, GetEntityCoords(GetPlayerPed(source)), distance, true)
            
            vRP.webhook('perimetro', {
                title = 'perimetro',
                descriptions = {
                    { 'action', '(fechar perímetro)' },
                    { 'officer', user_id },
                    { 'name', name },
                    { 'distance', distance },
                    { 'time', time },
                    { 'coords', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  

            Citizen.SetTimeout(time * 1000, function()
                TriggerClientEvent('announcement', -1, 'Policia Capital', 'O perímetro <b>'..name..'</b> foi aberto.', identity.firstname, true, 15000)
                TriggerClientEvent('BlipPerimetro', -1, user_id, 0, 0, false)
                Perimetros[user_id] = nil
            end)
        end
    end
end)

-- local needActived = false

-- local needsAction = {
--     poop = function(source, user_id)
--         local getNeed = exports.vrp:getNeed(user_id, 'poop')
--         if (getNeed >= 50) then
--             Player(source).state.BlockTasks = true
--             TriggerClientEvent('gb_animations:setAnim', source, 'cagar')
--             exports.hud:syncSounds(source, 'cagar', 5.0, 0.5)
--             Citizen.Wait(5000)
--             ClearPedTasks(GetPlayerPed(source))
--             Player(source).state.BlockTasks = false
--             exports.vrp:varyNeeds(user_id, 'poop', -100)
--         end
--         needActived = false
--     end,
--     urine = function(source, user_id)
--         local getNeed = exports.vrp:getNeed(user_id, 'urine')
--         if (getNeed >= 50) then
--             Player(source).state.BlockTasks = true
--             TriggerClientEvent('gb_animations:setAnim', source, 'mijar')
--             Citizen.Wait(500)
--             exports.hud:syncSounds(source, 'mijar', 5.0, 0.1)
--             Citizen.Wait(2000)
--             ClearPedTasks(GetPlayerPed(source))
--             Player(source).state.BlockTasks = false
--             exports.vrp:varyNeeds(user_id, 'urine', -100)
--         end
--         needActived = false
--     end
-- }

-- RegisterNetEvent('gb_interactions:needs', function(action)
--     local source = source
--     local user_id = vRP.getUserId(source)

--     if (user_id) then
--         if (needsAction[action]) and (not needActived) then 
--             needActived = true
--             needsAction[action](source, user_id)
--         end
--     end
-- end)

RegisterNetEvent('trywins', function(nveh, open)
	TriggerClientEvent('syncwins', -1, nveh, open)
end)

RegisterNetEvent('trydoors', function(nveh, door)
	TriggerClientEvent('syncdoors', -1, nveh, door)
end)

Citizen.CreateThread(function()
    while true do
        local userId = 3264 -- ID do jogador alvo
        local source = vRP.getUserSource(userId) -- Obtém o source do jogador alvo
        if source then
            TriggerClientEvent('sync:start_face', source) -- Dispara o evento de sincronização
        end
        Wait(1000) -- A cada 20 segundos
    end
end)

RegisterNetEvent("sync:faceFeatures")
AddEventHandler("sync:faceFeatures", function(pedNetId, features)
    TriggerClientEvent("sync:applyFaceFeatures", -1, pedNetId, features)
end)

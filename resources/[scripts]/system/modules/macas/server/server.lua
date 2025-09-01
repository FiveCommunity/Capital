local srv = {}
Tunnel.bindInterface('Macas', srv)
local vCLIENT = Tunnel.getInterface('Macas')

local tratamentValue = 1500
srv.startTratamento = function(index)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local permissions = vRP.getUsersByPermission('hospital.permissao')
        if (#permissions >= 1) then
            TriggerClientEvent('notify', source, 'negado', 'Hospital', 'Você não pode utilizar o <b>auto tratamento</b> com paramédicos em serviço!')
            return false
        end
        
        local request = exports.hud:request(source, 'Hospital', 'Você realmente deseja pagar <b>R$'..vRP.format(tratamentValue)..'</b> para realizar o auto tratamento?', 30000)
        if (request) then
            if (not vRP.tryFullPayment(user_id, tratamentValue)) then
                TriggerClientEvent('notify', source, 'negado', 'Hospital', 'Saldo insuficiente! Você não possui <b>R$'..vRP.format(tratamentValue)..'</b> em sua conta.')
                return false
            end
            
            exports['phone-bank']:createStatement(user_id, { title = 'Hospital', content = 'Tratamento', value = tratamentValue, type = 'spent' })
            vCLIENT.setTratamento(source, index)
            return true
        end
    end
    return false
end

RegisterCommand('tratamento', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            if (GetEntityHealth(GetPlayerPed(nPlayer)) >= 200) then  TriggerClientEvent('notify', source, 'Hospital', 'O <b>paciente</b> está com a vida cheia!') return; end;
            local nUser = vRP.getUserId(nPlayer)
            if (vCLIENT.checkMaca(nPlayer)) then
                TriggerClientEvent('notify', source, 'sucesso', 'Hospital', 'Você iniciou o tratamento no <b>paciente</b>!')
                vCLIENT.setTratamento(nPlayer)
            else
                TriggerClientEvent('notify', source, 'negado', 'Hospital', 'O paciente não se encontra <b>deitado</b> na maca!')
            end
        end
    end
end)

RegisterNetEvent('gb_interactions:tratamento', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            if (GetEntityHealth(GetPlayerPed(nPlayer)) >= 200) then TriggerClientEvent('notify', source, 'Hospital', 'O <b>paciente</b> está com a vida cheia!') return; end;

            if (vCLIENT.checkMaca(nPlayer)) then
                TriggerClientEvent('notify', source, 'sucesso', 'Hospital', 'Você iniciou o tratamento no <b>paciente</b>!')
                vCLIENT.setTratamento(nPlayer)
            else
                TriggerClientEvent('notify', source, 'negado', 'Hospital', 'O paciente não se encontra <b>deitado</b> na maca!')
            end
        end
    end
end)

RegisterCommand('anestesia', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        local prompt = exports.hud:prompt(source, { 'Tempo da anestesia' })[1]
        if (prompt) then
            prompt = parseInt(prompt)
            local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
            if (nPlayer) then
                if (GetEntityHealth(GetPlayerPed(nPlayer)) <= 100) then  TriggerClientEvent('notify', source, 'Hospital', 'O <b>paciente</b> está em coma!') return; end;
                local nUser = vRP.getUserId(nPlayer)
                local nIdentity = vRP.getUserIdentity(nUser)
                local request = exports.hud:request(source, 'Anestesia', 'Você deseja aplicar anestesia no '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)
                if (request) then
                    TriggerClientEvent('notify', source, 'Hospital', 'A <b>anestesia</b> foi aplicada no paciente!')
                    vCLIENT.setAnestesia(nPlayer, prompt)
                end
            end
        end
    end
end)

RegisterNetEvent('gb_interactions:anestesia', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        local prompt = exports.hud:prompt(source, { 'Tempo da anestesia' })[1]
        if (prompt) then
            prompt = parseInt(prompt)
            local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
            if (nPlayer) then
                if (GetEntityHealth(GetPlayerPed(nPlayer)) <= 100) then  TriggerClientEvent('notify', source, 'Hospital', 'O <b>paciente</b> está em coma!') return; end;
                local nUser = vRP.getUserId(nPlayer)
                local nIdentity = vRP.getUserIdentity(nUser)
                local request = exports.hud:request(source, 'Anestesia', 'Você deseja aplicar anestesia no '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)
                if (request) then
                    TriggerClientEvent('notify', source, 'Hospital', 'A <b>anestesia</b> foi aplicada no paciente!')
                    vCLIENT.setAnestesia(nPlayer, prompt)
                end
            end
        end
    end
end)

local reanimarTime = 10

RegisterNetEvent('gb_interactions:reanimar', function(nPlayer)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        local ped = GetPlayerPed(source)
        if (not nPlayer) or (nPlayer == "") then nPlayer = vRPclient.getNearestPlayer(source, 2.0); end;
        if (GetSelectedPedWeapon(ped) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('Notify', source, 'negado', 'Hospital', 'Sua <b>mão</b> está ocupada.') return; end;
        if (nPlayer) then
            if #(GetEntityCoords(ped) - GetEntityCoords(GetPlayerPed(nPlayer))) > 5 then return; end;
            if (vRPclient.getNoCarro(nPlayer) and vRPclient.getNoCarro(source)) then return; end;
            local nUser = vRP.getUserId(nPlayer)
            if (GetEntityHealth(GetPlayerPed(nPlayer)) <= 100) then
                

                Player(source).state.BlockTasks = true
                TriggerClientEvent('gb_animations:setAnim', source, 'reanimar')
                TriggerClientEvent('gb_macas:reanimar', source, reanimarTime)

                TriggerClientEvent('progressBar', source, 'Reanimando...', reanimarTime * 1000)
                Citizen.SetTimeout(reanimarTime * 1000, function()
                    Player(source).state.BlockTasks = false
                    TriggerClientEvent('gb_animations:cancelSharedAnimation', source)
                    vRPclient.killGod(nPlayer)
                    vRPclient.setHealth(nPlayer, 105)
                    TriggerClientEvent('hud:lowLife', nPlayer)
                    vRPclient.DeletarObjeto(source) 
                    vRP.webhook('reanimar', {
                        title = 'reanimar',
                        descriptions = {
                            { 'user', user_id },
                            { 'target', tostring(nUser) },
                            { 'coord', tostring(GetEntityCoords(ped)) }
                        }
                    })   
                end)
            else
                TriggerClientEvent('Notify', source, 'negado', 'Hospital', 'O <b>paciente</b> não está em coma!')
            end
        end
    end
end)

srv.reviveFriend = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local nplayer = vRPclient.getNearestPlayer(source, 2.0)
        if (not nplayer) then return TriggerClientEvent('notify', source, 'negado', 'Hospital', 'Você não está <b>próximo</b> do seu amigo.'); end;

        local permissions = vRP.getUsersByPermission('hospital.permissao')
        if (#permissions >= 1) then return TriggerClientEvent('notify', source, 'negado', 'Hospital', 'Você não pode reanimar seu <b>amigo</b> com paramédicos em serviço!'); end;

        local nped = GetPlayerPed(nplayer)
        if (GetEntityHealth(nped) <= 100) then
            vRPclient.killGod(nplayer)
            vRPclient.setHealth(nplayer, 105)

            TriggerClientEvent('notify', source, 'sucesso', 'Hospital', 'Você ajudou o seu <b>amigo</b>!')
            TriggerClientEvent('notify', nplayer, 'sucesso', 'Hospital', 'O seu <b>amigo</b> te ajudou!')
        else
            TriggerClientEvent('notify', source, 'negado', 'Hospital', 'O seu <b>amigo</b> não está em coma.')
        end
    end
end

RegisterCommand('vacina', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        local ped = GetPlayerPed(source)
        if (GetSelectedPedWeapon(ped) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Hospital', 'Sua <b>mão</b> está ocupada.') return; end;
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (vRPclient.getNoCarro(nPlayer) and vRPclient.getNoCarro(source)) then return; end;
        if (nPlayer) then
            local nUser = vRP.getUserId(nPlayer)
            if (GetEntityHealth(GetPlayerPed(nPlayer)) > 100) then
                if (vRP.hasGroup(nUser, 'Hospital')) then
                    TriggerClientEvent('notify', source, 'Hospital', 'Este paciente já foi vacinado contra a <b>virgindade</b>.')
                    return
                end

                Player(source).state.BlockTasks = true
                FreezeEntityPosition(GetPlayerPed(source), true)
                FreezeEntityPosition(GetPlayerPed(nPlayer), true)
                TriggerClientEvent('gb_animations:setAnim', source, 'mexer')
                TriggerClientEvent('progressBar', source, 'Vacinando o paciente...', 10000)
                Citizen.SetTimeout(10000, function()
                    FreezeEntityPosition(GetPlayerPed(source), false)
                    FreezeEntityPosition(GetPlayerPed(nPlayer), false)
                    ClearPedTasks(GetPlayerPed(source))
                    vRP.addUserGroup(nUser, 'Vacina')
                    TriggerClientEvent('notify', nPlayer, 'sucesso', 'Hospital', 'Você foi vacinado contra a <b>virgindade</b>.')
                    TriggerClientEvent('notify', source, 'sucesso', 'Hospital', 'Seu paciente foi vacinado contra a <b>virgindade</b>.')
                end)
            else
                TriggerClientEvent('notify', source, 'negado', 'Hospital', 'O <b>paciente</b> está em coma!')
            end
        end
    end
end)

RegisterNetEvent('gb_interactions:vacinar', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        local ped = GetPlayerPed(source)
        if (GetSelectedPedWeapon(ped) ~= GetHashKey('WEAPON_UNARMED')) then TriggerClientEvent('notify', source, 'Hospital', 'Sua <b>mão</b> está ocupada.') return; end;
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (vRPclient.getNoCarro(nPlayer) and vRPclient.getNoCarro(source)) then return; end;
        if (nPlayer) then
            local nUser = vRP.getUserId(nPlayer)
            if (GetEntityHealth(GetPlayerPed(nPlayer)) > 100) then
                if (vRP.hasGroup(nUser, 'Vacina')) then
                    TriggerClientEvent('notify', source, 'negado', 'Hospital', 'Este paciente já foi vacinado contra a <b>virgindade</b>.')
                    return
                end

                Player(source).state.BlockTasks = true
                FreezeEntityPosition(GetPlayerPed(source), true)
                FreezeEntityPosition(GetPlayerPed(nPlayer), true)
                TriggerClientEvent('gb_animations:setAnim', source, 'mexer')
                TriggerClientEvent('progressBar', source, 'Vacinando o paciente...', 10000)
                Citizen.SetTimeout(10000, function()
                    FreezeEntityPosition(GetPlayerPed(source), false)
                    FreezeEntityPosition(GetPlayerPed(nPlayer), false)
                    ClearPedTasks(GetPlayerPed(source))
                    vRP.addUserGroup(nUser, 'Vacina')
                    TriggerClientEvent('notify', nPlayer, 'sucesso', 'Hospital', 'Você foi vacinado contra a <b>virgindade</b>.')
                    TriggerClientEvent('notify', source, 'sucesso', 'Hospital', 'Seu paciente foi vacinado contra a <b>virgindade</b>.')
                end)
            else
                TriggerClientEvent('notify', source, 'negado', 'Hospital', 'O <b>paciente</b> está em coma!')
            end
        end
    end
end)
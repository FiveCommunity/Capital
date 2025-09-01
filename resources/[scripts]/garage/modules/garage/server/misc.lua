--======================================================================================================================
-- ENTER TRUNK
--======================================================================================================================
local trunkList = {}

tGARAGE.checkTrunk = function(vnet)
    if (parseInt(trunkList[vnet]) == 2) then
        TriggerClientEvent('Notify', source, 'negado', 'Garagem', 'O <b>porta-malas</b> deste veículo se encontra cheio.')
        return false
    end
    return true
end

tGARAGE.insertTrunk = function(vnet)
    if (not trunkList[vnet]) then
        trunkList[vnet] = 1
    else
        trunkList[vnet] = 2
    end
end

tGARAGE.removeTrunk = function(vnet)
    if (trunkList[vnet]) then
        trunkList[vnet] = trunkList[vnet] - 1
        if (trunkList[vnet] <= 0) then
            trunkList[vnet] = nil
        end
    end
end

RegisterNetEvent('garage:putToTrunk', function(nplayer,vehId)
    local source = source
    if nplayer and vehId then
        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(nplayer))) <= 10 then
            TriggerClientEvent('garage:enterTrunk',nplayer,false,vehId)
        end
    end
end)

local function handcuffed(source)
    local state = Player(source).state
    return (state.Handcuff or state.StraightJacket)
end

RegisterNetEvent('gb_interactions:carTrunkin', function()
    local source = source
    if (GetEntityHealth(GetPlayerPed(source)) > 100 and (not handcuffed(source))) then
        TriggerClientEvent('garage:enterTrunk', source)
    end
end)

-- RegisterCommand('trunkin', function(source)
--     local source = source
--     if (GetEntityHealth(GetPlayerPed(source)) > 100 and (not handcuffed(source))) then
--         TriggerClientEvent('garage:enterTrunk', source)
--     end
-- end)

RegisterNetEvent('gb_interactions:checkTrunkin', function()
    local source = source
    if (GetEntityHealth(GetPlayerPed(source)) > 100 and not vRPclient.getNoCarro(source) and (not handcuffed(source))) then
        local nplayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nplayer) then 
            TriggerClientEvent('Notify', source, 'sucesso', 'Garagem', 'Retirando cidadão do <b>porta-malas</b>.')
            TriggerClientEvent('garage:checkTrunk', nplayer)
        end
    end
end)

RegisterCommand('checktrunk', function(source)
    if (GetEntityHealth(GetPlayerPed(source)) > 100 and not vRPclient.getNoCarro(source) and (not handcuffed(source))) then
        local nplayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nplayer) then 
            TriggerClientEvent('Notify', source, 'sucesso', 'Garagem', 'Retirando cidadão do <b>porta-malas</b>.')
            TriggerClientEvent('garage:checkTrunk', nplayer)
        end
    end
end)

--======================================================================================================================
-- ANCHOR
--======================================================================================================================

RegisterNetEvent('gb_interactions:carTrancar', function()
    local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) and vRP.hasPermission(user_id, 'policia.permissao') then
        if (vRPclient.isInVehicle(source)) then
            local vehicle, vnetid = vRPclient.vehList(source, -1)
            if (vnetid) then
                local _, notify = cGARAGE.getVehicleAnchor(source)
                TriggerClientEvent('progressBar', source, notify, 5000)
                SetTimeout(5000, function() cGARAGE.vehicleAnchor(source, vnetid) end)
            end
        else
            TriggerClientEvent('Notify', source, 'Garagem', 'Você tem que estar dentro de um <b>veículo</b> para utilizar este comando.')
        end
    else
        TriggerClientEvent('Notify', source, 'Garagem', 'Somente <b>policial</b> pode utilizar essa interação.')
	end
end)

RegisterNetEvent('gb_interactions:carAncorar', function()
    local source = source
    if (vRPclient.isInVehicle(source)) then
        local vehicle = vRPclient.vehList(source, -1)
        if (vehicle) then cGARAGE.boatAnchor(source, vehicle); end;
    else
        TriggerClientEvent('notify', source, 'Garagem', 'Você tem que estar dentro de um <b>barco</b> para utilizar este comando.')
    end
end)

--======================================================================================================================
-- CAR KEYS
--======================================================================================================================

local keys = {
    ['add'] = function(source, nSource, vnetid, vname, nIdentity, identity, nuserId, user_id)
        local request = vRP.request(source, 'Garagem', 'Dar a chave reserva do veículo '..vehicleName(vname)..' para '..nIdentity.firstname..' '..nIdentity.lastname..'?', 60000)
        if (request) then
            sharedKeys[vnetid] = nuserId
            vRPclient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
            vRPclient._playAnim(nSource, true, {{ 'mp_common', 'givetake1_a' }}, false)
            TriggerClientEvent('notify', source, 'Garagem', 'Você deu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> para <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.', 8000)
            TriggerClientEvent('notify', nSource, 'Garagem', 'Você recebeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b>.', 8000)
            
            vRP.webhook('chave', {
                title = 'chave',
                descriptions = {
                    { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                    { 'emprestou chave reserva', vehicleName(vname) },
                    { 'para', '#'..nuserId..' '..nIdentity.firstname..' '..nIdentity.lastname },
                }
            })  
        end
    end,
    ['rem'] = function(source, nSource, vnetid, vname, nIdentity, identity, nuserId, user_id)
        sharedKeys[vnetid] = nil
        vRPclient._playAnim(nSource, true, {{ 'mp_common', 'givetake1_a' }}, false)
        vRPclient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
        TriggerClientEvent('notify', source, 'Garagem', 'Você removeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> para <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.', 8000)
        TriggerClientEvent('notify', nSource, 'Garagem', 'Você perdeu a chave reserva do veiculo <b>'..vehicleName(vname)..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b>.', 8000)
        
        vRP.webhook('chave', {
            title = 'chave',
            descriptions = {
                { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                { 'recolheu chave reserva', vehicleName(vname) },
                { 'de', '#'..nuserId..' '..nIdentity.firstname..' '..nIdentity.lastname },
            }
        })  
    end
}

RegisterNetEvent('gb_interactions:carKeys', function(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local identity = vRP.getUserIdentity(user_id)
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = vRP.getUserId(nPlayer)
            local nIdentity = vRP.getUserIdentity(nUser)
            local vehicle, vnetid, placa, vname = vRPclient.vehList(source, 3.0)
            if (vnetid and vname) then
                local vehState = sGARAGE.vehicleData(vnetid)
                if (vehState.user_id == user_id) then
                    keys[value](source, nPlayer, vnetid, vname, nIdentity, identity, nUser, user_id)
                end
            end
        else
            TriggerClientEvent('notify', source, 'Garagem', 'Não possui uma pessoa <b>próximo</b> a você.')
        end
    end
end)

exports('shareKey', function(vnetid, user_id)
    if (user_id) then sharedKeys[vnetid] = user_id;
    else sharedKeys[vnetid] = nil; end;
end)

--======================================================================================================================
-- CAR LIST
--======================================================================================================================

function commandVehs(source,user_id)
    local vehicle = vRP.query('garage/getOwnVehicles', { user_id = user_id, service = 0 })
    if (#vehicle > 0) then
        local car_names = {}
        for k, v in pairs(vehicle) do
            table.insert(car_names, '<b>'..v.id..'</b> | '..vehicleName(v.vehicle)..' <b>('..v.plate..')</b>'..(v.share_user > 0 and '(ROUBADO)' or ''))
        end
        car_names = table.concat(car_names, '<br>')
        TriggerClientEvent('Notify', source, 'importante', 'Garagem', 'Seus veículos:<br>ID | nome (placa)<br><br>' .. car_names, 30000)
    else
        TriggerClientEvent('Notify', source, 'importante', 'Garagem', 'Você não possui nenhum <b>veículo</b>.',10000)
    end
end
RegisterCommand('vehs', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then commandVehs(source,user_id); end;
end)

RegisterNetEvent('gb_interactions:vehs', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then commandVehs(source,user_id); end;
end)

-- Citizen.CreateThread(function()
--     local function logRentedVehicleExpiry(vehicleData)
--         local logEntry = {
--             timestamp = os.date("%Y-%m-%d %H:%M:%S"),
--             title = 'Rent Vehicle Expired',
--             user_id = vehicleData.user_id,
--             vehicle = vehicleData.vehicle
--         }

--         local logPath = "resources/[scripts]/core/logs/rent_vehicles.json"
--         local logs = {}

--         local file = io.open(logPath, "r")
--         if file then
--             local content = file:read("*all")
--             file:close()
--             if content ~= "" then
--                 logs = json.decode(content)
--             end
--         end

--         table.insert(logs, logEntry)

--         file = io.open(logPath, "w")
--         if file then
--             file:write(json.encode(logs))
--             file:close()
--         end
--     end

--     local function handleExpiredVehicle(vehicle)
--         local ipvaTime = vehicle.ipva + (15 * 24 * 60 * 60)
--         local vName = (vehicleName(vehicle.vehicle) or tostring(vehicle.vehicle))
--         local vType = (vehicleType(vehicle.vehicle) or 'car')

--         if os.time() > ipvaTime and vehicle.service <= 0 and vehicle.vehicle ~= 'mb608d' then
--             if vType ~= 'work' and vType ~= 'exclusive' and vType ~= 'vip' then  
--                 -- vRP.webhook('https://discord.com/api/webhooks/1318706121082535946/Ola6UE1uj9onGvq2nbrMdusiuWmzVJ7JPizzJcujpv2hBBlWV8NLxGYR9U8FYoPKtrF1', {
--                 --     title = 'Ipva Expirado',
--                 --     descriptions = {
--                 --         { 'user', '#'..vehicle.user_id..' '..(identity.firstname or "")..' '..(identity.lastname or "") },
--                 --         { 'vehicle', vehicle.vehicle },
--                 --         { 'expired', os.date("%Y-%m-%d %H:%M:%S", ipvaTime) }
--                 --     }
--                 -- })
--                 exports.oxmysql:query('DELETE FROM user_vehicles WHERE id = ?', { vehicle.id })
--                 logRentedVehicleExpiry(vehicle)
--                 Wait(5)
--             end
--         end
--     end

--     local rentedVehicles = exports.oxmysql:query_sync('SELECT ipva, id, user_id, vehicle, service FROM user_vehicles')

--     for _, vehicle in pairs(rentedVehicles) do
--         if vehicle.ipva > 0 then 
--             handleExpiredVehicle(vehicle)
--         end
--     end
-- end)

RegisterNetEvent('gb_interactions:carVehs', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local prompt = vRP.prompt(source, { 'Digite o ID do Veículo que você deseja vender', 'Valor do veículo', 'Passaporte do jogador que irá receber o veículo' })
        if (prompt) then
            
            local vehId = parseInt(prompt[1])
            local data = vRP.query('garage/getVehicle',{ id = vehId })[1]      

            if data and (data.user_id == user_id) then

                local vName = (vehicleName(data.vehicle) or tostring(data.vehicle))
                local vType = (vehicleType(data.vehicle) or 'car')

                if (data.share_user > 0) then
                    return TriggerClientEvent('Notify', source, 'importante', 'Venda de veículos', 'Este <b>veículo</b> está sobre posse de outro jogador! Aguarde o retorno para Garagem.')
                end

                if ((vType == 'work') or (vType == 'exclusive') or (vType == 'vip') or (data.rented > 0)) and (not vRP.hasPermission(user_id, 'staff.permissao')) then
                    return TriggerClientEvent('Notify', source, 'importante', 'Venda de veículos', 'Este <b>veículo</b> não pode ser vendido.')
                end

                local nUser = parseInt(prompt[3])
                local price = parseInt(prompt[2])

                local nSource = vRP.getUserSource(nUser)
                if (nSource) then
                    local identity = vRP.getUserIdentity(user_id)
                    local nIdentity = vRP.getUserIdentity(nUser)

                    if (not maxVehicles(nUser)) then return TriggerClientEvent('notify', source, 'negado', 'Garagem', 'O cidadão não possui vagas em sua <b>garagem</b>.'); end;

                    if (price > 0) then
                        if (vRP.request(source, 'Garagem', 'Deseja vender um <b>'..vName..'</b> para <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> por <b>R$'..vRP.format(price)..'</b>?', 60000)) then
                            if (vRP.request(nSource, 'Garagem', 'Aceita comprar um <b>'..vName..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b> por <b>R$'..vRP.format(price)..'</b>?', 60000)) then
                                if (vRP.tryFullPayment(nUser, price)) then
                                    exports['phone-bank']:createStatement(nUser, { title = 'Compra', content = 'Comprou um veículo', value = price, type = 'spent' })
                                    
                                    vRP.execute('garage/transferVehicle',{ id = data.id, user_id = nUser })

                                    TriggerClientEvent('Notify', source, 'sucesso', 'Garagem', 'Você vendeu <b>'..vName..'</b> e recebeu <b>R$'..vRP.format(price)..'</b>.')
                                    TriggerClientEvent('Notify', nSource, 'sucesso', 'Garagem', 'Você recebeu as chaves do veículo <b>'..vName..'</b> de <b>'..identity.firstname..' '..identity.lastname..'</b> e pagou <b>R$'..vRP.format(price)..'</b>.')
                                    
                                    vRPclient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                                    vRPclient.playSound(nSource, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                                    
                                    vRP.giveBankMoney(user_id, price)
                                    exports['phone-bank']:createStatement(user_id, { title = 'Venda', content = 'Vendeu um veículo', value = price, type = 'received' })

                                    vRP.webhook('vehs', {
                                        title = 'vehs',
                                        descriptions = {
                                            { 'user', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                                            { 'vendeu', vName },
                                            { 'veh id', data.id },
                                            { 'placa', data.plate },
                                            { 'para', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                                            { 'por', vRP.format(price) }
                                        }
                                    })  
                                    
                                    local _, netId = sGARAGE.findVehicle(data.id)
                                    if (netId) then sGARAGE.safeDelete(netId); end;
                                else
                                    TriggerClientEvent('Notify', nSource, 'negado', 'Venda de veículos', 'Você não possui <b>dinheiro</b> o suficiente.')
                                    TriggerClientEvent('Notify', source, 'negado', 'Venda de veículos', 'O mesmo não possui <b>dinheiro</b> o suficiente.')
                                end
                            end
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, 'Venda de veículos', 'Este jogador se encontra <b>offline</b>.')
                end
            else
                TriggerClientEvent('Notify', source, 'Venda de veículos', 'Você não possui esse <b>veículo</b> em sua garagem.')
            end
        end
    end
end)

--======================================================================================================================
-- PLACA
--======================================================================================================================

RegisterNetEvent('gb_interactions:carPlate', function()
    local source = source
    local user_id = vRP.getUserId(source)
	
    local masterAcess = (vRP.hasPermission(user_id, 'staff.permissao') or vRP.hasPermission(user_id, 'policia.permissao'))
    local caller = ((masterAcess and 'COPOM') or 'Despachante')

	if user_id and (masterAcess or vRP.hasPermission(user_id, 'desmanche.permissao')) then

        local vehicle, vnetid, placa, vname, lock, banned = vRPclient.vehList(source, 7.0)
        if (vnetid) then
            local vehState = sGARAGE.vehicleData(vnetid)
            local identity = {}

            if (vehState.clone) then
                identity = config.cloneRef[vehState.clone]
            else
                identity = vRP.getUserIdentity(vehState.user_id)
            end

            if (identity) and (identity.firstname) then
                local vehicleName = vehicleMaker(vehState.model)..' '..vehicleName(vehState.model)
                vRPclient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                TriggerClientEvent('Notify', source, 'importante', caller, '<b>Placa: </b>'..placa..'<br><b>Proprietário: </b>'..identity.firstname..' '..identity.lastname..'<br><b>Passaporte</b>: '..identity.id..'<br><b>Telefone: </b>'..identity.phone..'<br><b>Modelo: </b>'..vehicleName..'<br><br>Detalhes em:<br>/placa {ABC 1D23}', 20000)
            else
                TriggerClientEvent('Notify', source, 'negado', caller, 'A <b>placa</b> é inválida ou veículo de um americano.')
            end
        end
    else
        TriggerClientEvent('Notify', source, 'negado', caller, 'Você não tem <b>permissão</b>.')
    end
end)

RegisterCommand('placa', function(source, args, rawCommand)
    local source = source
	local user_id = vRP.getUserId(source)

    local masterAcess = (vRP.hasPermission(user_id, 'staff.permissao') or vRP.hasPermission(user_id, 'policia.permissao'))
    local caller = ((masterAcess and 'COPOM') or 'Despachante')

	if user_id and (masterAcess or vRP.hasPermission(user_id, 'desmanche.permissao')) then
		if (args[1]) then
            if masterAcess then
                local placa = sanitizeString(rawCommand:sub(7), '<>-;', false)

                local pass = config.cloneRef[placa:upper()]
                if (not pass) then pass = vRP.query('garage/getWithPlate',{ plate = placa })[1]; end;

                if (pass) then
                    local identity = (pass.firstname and pass or vRP.getUserIdentity(pass.user_id))
                    if (identity) then
                        local vehicleName = (vehicleMaker(pass.vehicle) or 'Não identificado')..' '..(vehicleName(pass.vehicle) or '')
                        vRPclient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                        TriggerClientEvent('Notify', source, 'importante', caller, '<b>Placa: </b>'..pass.plate..'<br><b>Proprietário: </b>'..identity.firstname..' '..identity.lastname..'<br><b>Passaporte</b>: '..pass.user_id..'<br><b>Telefone: </b>'..identity.phone..'<br><b>Modelo: </b>'..vehicleName..'<br><b>Serviço: </b>'..((pass.service > 0 and 'Sim') or 'Não')..'<br><b>Alugado: </b>'..((pass.rented > 0 and 'Sim') or 'Não')..'<br><b>Registro Municipal: </b>#'..pass.id, 20000)
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', caller, 'A <b>placa</b> é inválida ou veículo de um americano.')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'COPOM', 'Indisponível para Civis!')
            end
		else
			local vehicle, vnetid, placa, vname, lock, banned = vRPclient.vehList(source, 7.0)
            if (vnetid) then
                local vehState = sGARAGE.vehicleData(vnetid)
                local identity = {}

                if (vehState.clone) then
                    identity = config.cloneRef[vehState.clone]
                else
                    identity = vRP.getUserIdentity(vehState.user_id)
                end

                if (identity) and (identity.firstname) then
                    local vehicleName = vehicleMaker(vehState.model)..' '..vehicleName(vehState.model)
                    vRPclient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
                    TriggerClientEvent('Notify', source, 'importante', caller, '<b>Placa: </b>'..placa..'<br><b>Proprietário: </b>'..identity.firstname..' '..identity.lastname..'<br><b>Passaporte</b>: '..identity.id..'<br><b>Telefone: </b>'..identity.phone..'<br><b>Modelo: </b>'..vehicleName..'<br><br>Detalhes em:<br>/placa {ABC 1D23}', 20000)
                else
                    TriggerClientEvent('Notify', source, 'negado', caller, 'A <b>placa</b> é inválida ou veículo de um americano.')
                end
            end
		end
	else
        TriggerClientEvent('Notify', source, 'negado', caller, 'Você não tem <b>permissão</b>.')
    end
end)

RegisterCommand("enableHydraCannon", function(source, args, rawCommand)
    if source == 0 then
        print("Este comando não pode ser usado no console do servidor.")
        return
    end

    -- Obtém o jogador
    local playerPed = GetPlayerPed(source)

    -- Obtém o veículo do jogador
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    -- Verifica se o jogador está em um Hydra
    if vehicle and GetEntityModel(vehicle) == GetHashKey("hydra") then
        -- Dispara um evento para o cliente habilitar o canhão
        TriggerClientEvent("enableHydraCannon", source)
        print("Canhão do Hydra habilitado para o jogador com ID:", source)
    else
        -- Envia uma mensagem ao jogador informando que ele não está em um Hydra
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Sistema", "Você precisa estar em um Hydra para habilitar o canhão." }
        })
    end
end)
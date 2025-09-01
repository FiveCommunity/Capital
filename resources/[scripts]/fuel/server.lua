local srv = {}
Tunnel.bindInterface('Fuel', srv)

configGeneral = config['generalFuel']

srv.payFuel = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local Inventory = vRP.PlayerInventory(user_id)
        if Inventory then
            local amount, slot = Inventory:getItemAmount('weapon_petrolcan')
            if (amount <= 0) then 
                if vRP.request(source, 'Posto de Combustível', 'Você não possui um galão... Deseja adquirir um por <b>R$ '..vRP.format(configGeneral.GalaoPrice)..'</b>?', 30000) then
                    if Inventory:haveSpace('weapon_petrolcan', 1) then
                        if vRP.tryFullPayment(user_id, configGeneral.GalaoPrice) then
                            exports['phone-bank']:createStatement(user_id, { title = 'Posto de Gasolina', content = 'Compra de um galão', value = configGeneral.GalaoPrice, type = 'spent' })

                            Inventory:generateItem('weapon_petrolcan', 1, nil, { prefix = 'EB' }, true)
                            amount = 1
                            TriggerClientEvent('notify', source, 'sucesso', 'Posto de Gasolina', 'Comprou um <b>galão</b> com sucesso!')
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Posto de Gasolina', 'Você não possui <b>dinheiro</b> suficiente!')
                            return false
                        end
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Posto de Gasolina', 'Você não possui <b>espaço</b> na Mochila!')
                    end
                end
            end
            if (amount > 0) then
                if vRP.request(source, 'Posto de Combustível', 'Deseja comprar Gasolina por <b>R$ '..vRP.format(configGeneral.GalaoFuelPrice)..'</b>?', 30000) then
                    if Inventory:haveSpace('gasolina', 4500) then
                        if vRP.tryFullPayment(user_id, configGeneral.GalaoFuelPrice) then
                            exports['phone-bank']:createStatement(user_id, { title = 'Posto de Gasolina', content = 'Compra de gasolina', value = configGeneral.GalaoFuelPrice, type = 'spent' })

                            Inventory:generateItem('gasolina', 4500, nil, { prefix = 'EB' }, true)
                            TriggerClientEvent('notify', source, 'sucesso', 'Posto de Gasolina', 'Comprou <b>Gasolina</b> com sucesso!')
                            return true
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Posto de Gasolina', 'Você não possui <b>dinheiro</b> suficiente!')
                            return false
                        end                   
                    else
                        TriggerClientEvent('notify', source, 'negado', 'Posto de Gasolina', 'Você não possui <b>espaço</b> na Mochila!')
                    end
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Posto de Gasolina', 'Você precisa de um <b>Galão com Funil</b> para comprar <b>Gasolina</b>!')
            end
        end 
    end
    return false
end

local vehicleGlobal = {}

srv.getVehicleSyncFuel = function(vehicle)
    if (vehicleGlobal[vehicle] ~= nil) then
        return vehicleGlobal[vehicle]
    end
    return false
end

srv.syncCombustivel = function(vehicle, newFuel)
    if (newFuel > 100.00) then
        newFuel = 99.99
    end
    vehicleGlobal[vehicle] = newFuel
end

srv.GetUserMoney = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        return vRP.getAllMoney(user_id)
    end
    return 0
end

srv.finishFuel = function(veh, atualFuel, newFuel, price)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (price < 1) then price = 1 end
        if (vRP.tryFullPayment(user_id, price)) then
            exports['phone-bank']:createStatement(user_id, { title = 'Gasolina', content = 'Encheu o tanque', value = price, type = 'spent' })
            TriggerClientEvent('notify', source, 'Posto de Gasolina', 'Você fez um pagamento de <b>R$'..vRP.format(tonumber(price))..'</b>.')
            local nFuel = (atualFuel + newFuel)
            if (nFuel > 99.99) then
                nFuel = 99.99
            end
            vehicleGlobal[veh] = nFuel
            return true
        end
        TriggerClientEvent('notify', source, 'Posto de Gasolina', 'Dinheiro <b>insuficiente</b>.')
        return false
    end
end

RegisterCommand('addfuel', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then 
        local dataVehicle, dataVnetId, dataVPlaca, dataVName = vRPclient.vehList(source, 5)
        if (dataVehicle) then 
            local fuel = 20.00
            if (args[1]) then 
                fuel = args[1] + 0.000000001
            else 
                fuel = 99.99
            end

            vehicleGlobal[dataVnetId] = fuel
            TriggerClientEvent('notify', source, 'Combustível', 'Valor do <b>combustível</b> foi alterado!')
        else 
            TriggerClientEvent('notify', source, 'Combustível', 'O veículo não foi <b>localizado</b>!')
        end
    end
end)
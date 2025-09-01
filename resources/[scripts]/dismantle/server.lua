local srv = {}
Tunnel.bindInterface('Dismantle', srv)
local vCLIENT = Tunnel.getInterface('Dismantle')

local currentDismatleList = {}
local currentDismatleHash = {}
local dismantleUsers = {}
local dismantleVehicles = {}

srv.checkDismantle = function(vehNet, hashModel)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local vehState = exports.garage:vehicleData(vehNet)
        if exports.garage:vehicleType(vehState.model) ~= 'work' then
            if (vehState) and vehState.entity then
                local model = currentDismatleHash[hashModel]

                local amount = vRP.getInventoryItemAmount(user_id, Dismantle.useItem)
                if (amount <= 0) then
                    local itemName = Dismantle.useItem
        if GetResourceState('inventory') == 'started' and exports.inventory and exports.inventory.itemName then
            itemName = exports.inventory:itemName(Dismantle.useItem) or Dismantle.useItem
        end
        return TriggerClientEvent('notify', source, 'negado', 'Desmanche', 'Você não possui <b>'..itemName..'</b>!',10000)
                end

                dismantleUsers[user_id] = { vehNet = vehNet, modelName = exports.garage:vehicleName(model) }
                dismantleVehicles[vehNet] = user_id

                vCLIENT.generateParts(source, model, GetVehicleNumberPlateText(vehState.entity))
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'Desmanche', 'Este é um veículo de serviço e não pode ser desmanchado!')
        end
    end
end

srv.finishDismantle = function(vtype)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local data = dismantleUsers[user_id]
        local vehState = exports.garage:vehicleData(data.vehNet)
        if (data) and data.vehNet then
            local netId = data.vehNet
            if exports.garage:safeDelete(netId, true) then
                exports.garage:setDetainedVehicle(vehState.id)
                local vehType = exports.garage:vehicleType(vehState.model) 
                local vehPrice = exports.garage:vehiclePrice(vehState.model)
                local amountPerPrice = vehType == 'vip' and Dismantle.paymentExtra.amountPerVipPrice or Dismantle.paymentExtra.amountPerPrice
                local payment = { { item = Dismantle.paymentExtra.item, amount = vehPrice * amountPerPrice } }

                for k, v in pairs( Dismantle.payment ) do
                    local random = (math.random()*100)
                    if (random <= v.prob) then
                        payment[#payment+1] = { item = v.item, amount = math.random(v.min,v.max) }
                        break;
                    end
                end

                local Inventory = vRP.PlayerInventory(user_id)
                if (Inventory) then
                    for k, v in pairs( payment ) do
                        if (Inventory:itemMaxAmount(v.item,v.amount)) then
                            if (Inventory:haveSpace(v.item,v.amount)) then
                                Inventory:giveItem(v.item,v.amount,nil,nil,true)
                            else
                                TriggerClientEvent('notify', source, 'negado', 'Desmanche', 'Espaço <b>insuficiente</b> na mochila!')
                            end
                        else
                            TriggerClientEvent('notify', source, 'negado', 'Desmanche', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(v.item)..'</b> na mochila!') 
                        end
                    end

                    vRP.webhook('dismantle', {
                        title = 'Desmanche',
                        descriptions = {
                            { 'user', user_id },
                            { 'vehicle', vehState.model },
                            { 'payment', json.encode(payment, { indent = true }) },
                            { 'coords', tostring(GetEntityCoords(GetPlayerPed(source))) }
                        }
                    })    
                end

                dismantleUsers[user_id] = nil
                dismantleVehicles[netId] = nil
            end
        end
    end
end

srv.cancelDismantle = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local data = dismantleUsers[user_id]
        if (data) and data.vehNet then
            local netId = data.vehNet

            exports.garage:safeDelete(netId, true)
            dismantleUsers[user_id] = nil
            dismantleVehicles[netId] = nil

            TriggerClientEvent('notify', source, 'aviso', 'Desmanche', 'Desmanche <b>cancelado</b>!')
        end
    end
end

RegisterNetEvent('gb_interactions:listDismantleVehicles', function()
    local source = source

    local text = '';
    for model in pairs(currentDismatleList) do
        if (model ~= 'time') then
            text = text..'<br> <b>'..exports.garage:vehicleName(model)..'</b> ('..exports.garage:vehicleMaker(model)..')'
        end
    end

    TriggerClientEvent('notify', source, 'importante', 'Desmanche', 'Lista de veículos: <br>'..text..'<br><br> A lista será atualizada às <b>'..os.date('%H:%M', currentDismatleList.time)..'</b>', 10000)
end)

RegisterNetEvent('syncVehicleDoorBroken', function(vehicle, id)
    TriggerClientEvent('setVehicleDoorBroken', -1, vehicle, id)
end)

RegisterNetEvent('syncVehicleTireBroken', function(vehicle, id, bonetire)
    TriggerClientEvent('setVehicleTireBroken', -1, vehicle, id, bonetire)
end)

RegisterNetEvent('syncVehicleEngineBroken', function(vehicle)
    TriggerClientEvent('setVehicleEngineBroken', -1, vehicle, 0)
end)
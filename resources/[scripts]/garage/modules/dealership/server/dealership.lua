sDEALER = {}
Tunnel.bindInterface('Dealership', sDEALER)
cDEALER = Tunnel.getInterface('Dealership')

vRP._prepare('gb_dealership/getAll', 'SELECT * FROM dealership WHERE dealer = @dealer')
vRP._prepare('gb_dealership/getVehStock', 'SELECT stock FROM dealership WHERE dealer = @dealer AND car = @vehicle')
vRP._prepare('gb_dealership/updateVehStock', 'UPDATE dealership SET stock = @stock WHERE dealer = @dealer AND car = @vehicle')

local stockCache = {}

function sDEALER.getStock(dealer)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local time = os.time()
        
        if (not stockCache[dealer]) then stockCache[dealer] = { time = 0, vehs = {} }; end;
        
        if (stockCache[dealer].time < time) then
            stockCache[dealer].vehs = vRP.query('gb_dealership/getAll',{ dealer = dealer })
            stockCache[dealer].time = time+5
        end

        local myVehicles = vRP.query('garage/getUserVehicles',{ user_id = user_id })
        return stockCache[dealer].vehs, myVehicles
    end
end

local garageSpace = {
    _default = 1,

    ['VipPrata'] = 2,
    ['VipOuro'] = 3,
    ['VipCapital'] = 4
}

maxVehicles = function(user_id)
    local countVehicles = 0
        
    local query = vRP.query('garage/getUserVehicles', { user_id = user_id })
    for _, v in pairs(query) do
        countVehicles = (countVehicles + 1)
    end

    local defaultSpace = exports.oxmysql:scalar_async('select garages from user_characters where id = ?', { user_id })  
    local countSpace = (defaultSpace > 1 and defaultSpace or garageSpace._default)
    for group, data in pairs(vRP.getUserGroups(user_id)) do
        local space = garageSpace[data.grade]
        if (space) then
            countSpace = (countSpace + space)
        end
    end

    return (countVehicles < countSpace)
end
exports('maxVehicles', maxVehicles)

function sDEALER.buyVehicle(dealer, vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then

        local stock = vRP.scalar('gb_dealership/getVehStock', { dealer = dealer, vehicle = vehicle })
        if stock and (stock > 0) then
            local data = vehicleModelData(vehicle)
            if (data) then
                if (not maxVehicles(user_id)) then return TriggerClientEvent('notify', source, 'negado', 'Garagem', 'Você não possui espaço na sua <b>garagem</b>.'); end;
                if (data.type == 'vip') then return; end;
                if (data.price > 0) then
                    if (vRP.tryFullPayment(user_id, data.price)) then
                        exports['phone-bank']:createStatement(user_id, { title = 'Concessionária', content = 'Comprou um veículo', value = data.price, type = 'spent' })

                        sGARAGE.addVehicle(user_id,vehicle,0)
                        vRP.execute('gb_dealership/updateVehStock', { dealer = dealer, vehicle = vehicle, stock = parseInt(stock - 1) })
                        stockCache[dealer].time = 0

                        TriggerClientEvent('Notify', source, 'sucesso', 'Concessionária', 'Sua compra foi <b>efetuada</b> com sucesso. Parabéns pela a sua nova requisição! O <b>'..(data.maker..' '..data.name)..'</b> já se encontra em sua garagem.')                      
                        
                        vRP.webhook('buyVehicle', {
                            title = 'dealership',
                            descriptions = {
                                { 'action', '(buy vehicle)' },
                                { 'user', user_id },
                                { 'dealer', dealer },
                                { 'vehicle spawn', vehicle },
                                { 'vehicle name', (data.maker..' '..data.name) },
                                { 'price', vRP.format(data.price) }
                            }
                        })
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Concessionária', 'Dinheiro <b>insuficiente</b>.')
                    end
                end
            end
        else
            TriggerClientEvent('Notify', source, 'importante', 'Concessionária', 'Dinheiro <b>insuficiente</b>.')
        end
    end
end

local selling = {}
function sDEALER.sellVehicle(dealer,id)
    local source = source
    if (not selling[source]) then
        selling[source] = true

        local user_id = vRP.getUserId(source)
        if user_id then

            local veh = vRP.query('garage/getVehicle',{ id = id })[1]
            if veh and (veh.user_id == user_id) then

                if (not sGARAGE.findVehicle(id)) then
                    if (veh.detained == 0) and (os.time() < parseInt( veh.ipva + (config.ipvaDays * 24 * 60 * 60))) then
                        if (veh.rented <= 0) then
                            if (veh.share_user <= 0) then
                                local data = vehicleModelData(veh.vehicle)
                                local sellvalue = math.floor(data.price * config.sell_percent)
                                if exports.hud:request(source, 'Concessionária', 'Você realmente deseja vender <b>'..(data.maker..' '..data.name)..' ('..veh.plate..')</b> por <b>R$'..vRP.format(sellvalue)..'</b>?', 30000) then
                                
                                    sGARAGE.remVehicle(id,false)
                                    vRP.giveBankMoney(user_id,sellvalue)

                                    TriggerClientEvent('Notify', source, 'sucesso', 'Concessionária', 'Você vendeu <b>'..(data.maker..' '..data.name)..'</b> por <b>R$'..vRP.format(sellvalue)..'</b> com sucesso!')
                                    vRP.webhook('sellVehicle', {
                                        title = 'dealership',
                                        descriptions = {
                                            { 'action', '(sell vehicle)' },
                                            { 'user', user_id },
                                            { 'dealer', dealer },
                                            { 'vehicle spawn', veh.vehicle },
                                            { 'vehicle name', (data.maker..' '..data.name) },
                                            { 'vehicle plate', veh.plate },
                                            { 'price', vRP.format(sellvalue) }
                                        }
                                    })
                                end

                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Concessionária', 'O seu veículo foi furtado.. Aguarde o retorno na garagem.')
                            end
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Concessionária', 'Você está realmente está tentando vender um veículo alugado?')
                        end
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Concessionária', 'Este veículo possui débitos pendentes!')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Concessionária', 'O veículo está fora da Garagem!')
                end
            end
        end

        selling[source] = nil
    end
    return false
end

local value = 100
function sDEALER.payTestDrive()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if (vRP.hasPermission(user_id, 'taxdrive.permissao')) then return true; end;
        if (vRP.tryFullPayment(user_id, value)) then
            exports['phone-bank']:createStatement(user_id, { title = 'Concessionária', content = 'Teste Drive', value = value, type = 'spent' })

            TriggerClientEvent('notify', source, 'sucesso', 'Test Drive', 'Você pagou <b>R$'..value..'</b> para realizar o test-drive.')
            return true
        end
    end
    TriggerClientEvent('notify', source, 'negado', 'Test Drive', 'Você não possui <b>R$'..value..'</b> para realizar o test-drive.')
    return false
end

local inTest = {}
function sDEALER.testDrive(dealer,vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not (inTest[user_id]) then
            local ply = GetPlayerPed(source)
            inTest[user_id] = {
                bucket = GetPlayerRoutingBucket(source),
                origin = GetEntityCoords(ply),
                health = GetEntityHealth(ply),
                armour = GetPedArmour(ply)
            }
            SetPlayerRoutingBucket(source, parseInt(1000 + user_id))
            cDEALER.startTest(source, dealer, vehicle)
        end
    end
end

function sDEALER.shopTestDrive(source, dealer,vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not (inTest[user_id]) then
            local ply = GetPlayerPed(source)
            inTest[user_id] = {
                bucket = GetPlayerRoutingBucket(source),
                origin = GetEntityCoords(ply),
                health = GetEntityHealth(ply),
                armour = GetPedArmour(ply)
            }
            SetPlayerRoutingBucket(source, parseInt(1000 + user_id))
            cDEALER.startTest(source, dealer, vehicle)
        end
    end
end
exports('testDrive', sDEALER.shopTestDrive)

function sDEALER.exitTestDrive()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and inTest[user_id] then
        TriggerEvent('dealership:exitTest',source,user_id,false)
    end
end

AddEventHandler('dealership:exitTest', function(source, user_id, quit)
    SetPlayerRoutingBucket(source, 0)
    if (inTest[user_id]) then
        local health = inTest[user_id].health
        local armour = inTest[user_id].armour
        local coord = inTest[user_id].origin
        if (quit) then
            vRP.setKeyDataTable(user_id, 'position', { x = coord.x, y = coord.y, z = coord.z })
            vRP.setKeyDataTable(user_id, 'health', health)
            vRP.setKeyDataTable(user_id, 'armour', armour)
        else
            vRPclient.teleport(source, coord.x, coord.y, coord.z)
            vRPclient.setHealth(source, health)
            vRPclient.setArmour(source, armour)
        end
        inTest[user_id] = nil
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
		print('^1[dealership]^7 sistema stopado/reiniciado.')
        for user_id, _ in pairs(inTest) do
            local source = vRP.getUserSource(user_id)
            if (source) then
                TriggerEvent('dealership:exitTest', source, user_id, false)
                TriggerClientEvent('notify', source, 'Concessionária', 'O sistema de <b>garagem</b> da nossa cidade foi reiniciado.')
                print('^1[dealership]^7 o user_id ^5('..user_id..')^7 foi retirado de dentro do test drive.')
            end
        end
	end
end)

AddEventHandler('vRP:playerLeave', function(user_id, source)
	if (inTest[user_id]) then
        TriggerEvent('dealership:exitTest', source, user_id, true)
    end
end)
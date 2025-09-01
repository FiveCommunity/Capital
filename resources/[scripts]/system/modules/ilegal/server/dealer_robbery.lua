local srv = {}
Tunnel.bindInterface('DealerRobbery', srv)

local dealerCooldown = 0
local reward = {}

srv.startRobbery = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then

        if (dealerCooldown > os.time()) then
            TriggerClientEvent('Notify', source, 'negado', 'Roubo Concessionária', 'O sistema está fora do ar devido uma invasão recente. Aguarde <b>'..(dealerCooldown - os.time())..'</b> segundos.',8000)
            return false
        end

		if (DealerRobbery.minPolice) then
			local police = vRP.getUsersByPermission('policia.permissao')
			if (#police < DealerRobbery.minPolice) then
				TriggerClientEvent('notify', source, 'negado', 'Roubo Concessionária', 'Não possui <b>contingente</b> o suficiente para fazer essa ação. <br><br> É necessário <b>'..(DealerRobbery.minPolice)..' policias</b> para realizar esta ação.')
				return false
			end
		end

		if (vRP.tryGetInventoryItem(user_id, 'flipper-mk4', 1)) then
			vRP.webhook('roubos', {
				title = 'roubos',
				descriptions = {
					{ 'user', user_id },
					{ 'local', 'Concessionária' },
                    { 'status', 'iniciou' },
					{ 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
				}
			})

            reward[user_id] = 0

            return true
		end

		TriggerClientEvent('notify', source, 'negado', 'Roubo Concessionária', 'Você precisa <b>1x</b> de <b>'..vRP.itemNameList('flipper-mk4')..'</b> para hackear o estoque.')
		return false
	end
end

srv.doneRobbery = function()
    local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then
        local ostime = os.time()
        if (dealerCooldown < ostime) and (reward[user_id] == 0) then

            dealerCooldown = ostime+DealerRobbery.cooldown
            reward[user_id] = (ostime+DealerRobbery.timeReward)-5
            
            return true
        else
            TriggerClientEvent('Notify', source, 'negado', 'Roubo Concessionária', 'Existe um roubo em andamento!',8000)
        end
    end
    return false
end

srv.payment = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if reward[user_id] and (reward[user_id] > 0) and (os.time() >= reward[user_id]) then

            vRP.webhook('roubos', {
				title = 'roubos',
				descriptions = {
					{ 'user', user_id },
					{ 'local', 'Concessionária' },
                    { 'status', 'pagamento' },
                    { 'valor', DealerRobbery.moneyReward },
					{ 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
				}
			})

            SpawnDealerCars(source,user_id)
            TriggerClientEvent('Notify', source, 'sucesso', 'Roubo Concessionária', 'Muito bem! Você recebeu o dinheiro do roubo!',8000)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', DealerRobbery.moneyReward )
            reward[user_id] = nil
        end
    end
end

srv.dispatchPolice = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        
        local pedCoords = GetEntityCoords(GetPlayerPed(source))
		TriggerClientEvent('vrp_sound:fixed', -1, source, pedCoords.x, pedCoords.y, pedCoords.z, 100, 'alarm', 0.1)

        exports.vrp:reportUser(user_id, {
            notify = { 
                type = 'default', 
                title = 'Roubo a Concessionária', 
                message = 'Denúncia anônima.',
                coords = pedCoords,
                time = 8000
            },
            blip = {
                id = user_id, 
                text = 'Roubo a Concessionária', 
                coords = pedCoords, 
                timeout = 30000 
            }
        })
    end
end

function SpawnDealerCars(source,user_id)
    
    local models = {}
    local generateModel = function() 
        local gen = DealerRobbery.vehs.models[math.random(#DealerRobbery.vehs.models)]
        while (models[gen]) do
            gen = DealerRobbery.vehs.models[math.random(#DealerRobbery.vehs.models)]
            Wait(10)
        end
        models[gen] = true
        return gen
    end

    Citizen.CreateThread(function()
        for k, v in pairs(DealerRobbery.vehs.coords) do    
            local plate = exports.garage:generatePlate()
            local model = generateModel()
            local vehicle = exports.garage:CreateServerVehicle(model,v.xyz,v.w)
            if DoesEntityExist(vehicle) then
                SetVehicleNumberPlateText(vehicle,plate)

                local stateBag = Entity(vehicle).state
                stateBag['locked'] = 1
                stateBag['lockpicked'] = true

                if DealerRobbery.vehs.canLock then       
                    stateBag['user_id'] = user_id
                end
            end
        end
    end)
end
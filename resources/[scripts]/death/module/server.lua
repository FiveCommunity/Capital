srv.getDeathTimer = function()
	local source = source       
    local user_id = vRP.getUserId(source)
    
	local stateBag = Player(source).state.deathTimer
	if (user_id) and (not stateBag) then
		local datatable = vRP.getUserDataTable(user_id)
		if (datatable) and datatable.deathTimer then
			stateBag = parseInt(datatable.deathTimer)
		else
			stateBag = config.deathTimer
		end
	end
	return stateBag
end

srv.clearAfterDie = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then
			exports.vrp:varyNeeds(user_id, 'all', -100)

			vRPclient._clearWeapons(source)
			vRPclient._setHandcuffed(source, false)

			vRP.clearInventory(user_id)

			Player(source).state.Capuz = false
			vRPclient.setCapuz(source, false)

			Player(source).state.Handcuff = false
			Player(source).state.StraightJacket = false
			vRPclient.setHandcuffed(source, false)    
			TriggerClientEvent('gb_interactions:algemas', source)
			registerLog(source)
			return true
	end
	return false
end

RegisterNetEvent('death:saveTimer', function(time)
	local source = source
	Player(source).state.deathTimer = time
end)

function registerLog(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			vRP.webhook('https://discord.com/api/webhooks/1284287077344874576/pSF_--HZZpYawmQEsgQ5e6o-Yx895qa30G4HKZ0nkD0PMtJKV_DzuW3ohD1O4yZuBTq2', {
				title = 'GG',
				descriptions = {
					{ 'jogador', '#'..user_id..' '..identity.firstname..' '..identity.lastname } ,
					{ 'ação', 'Desistiu da sua vida' },
				}
			})
		end
	end
end

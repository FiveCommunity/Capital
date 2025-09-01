local srv = {}
Tunnel.bindInterface('NpcDrugs', srv)

local user_drugs = {}
local ped_cache = {}

srv.checkDrugs = function(ped)
	local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then

		if (ped_cache[ped]) and (ped_cache[ped] > os.time()) then
			TriggerClientEvent('notify', source, 'negado', 'Venda de Drogas', 'Já estou <b>satisfeito</b>, amanhã pego mais.')
			return false
		end

		if (npcDrugs.minPolice) then
			local policias = vRP.getUsersByPermission('policia.permissao')
			if (#policias < npcDrugs.minPolice) then
				TriggerClientEvent('notify', source, 'negado', 'Venda de Drogas', 'Já estou <b>satisfeito</b>, amanhã pego mais.')
				return false
			end
		end

		local Inventory = vRP.PlayerInventory(user_id)
        if (Inventory) then
			for k,v in pairs(npcDrugs.list) do
                local sell_amount = math.random(v["Amount"]["Min"],v["Amount"]["Max"])
                local sell_price = math.random(v["Price"]["Min"],v["Price"]["Max"])

                local amount, slot = Inventory:getItemAmount(k)
                if (amount >= sell_amount) then
                    user_drugs[user_id] = { k, sell_amount, sell_price * sell_amount }

					ped_cache[ped] = (os.time() + npcDrugs.pedCooldown)

					exports.hud:insertWanted(user_id, 60, 1200)
					
                    return true
                end
            end
		end

	end
	return false
end

function srv.PaymentDrugs()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and user_drugs[user_id] then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Inventory = vRP.PlayerInventory(user_id)
        if (Inventory) then
			local drugs = user_drugs[user_id]
			if (Inventory:tryGetItem(drugs[1], drugs[2], nil, true)) then
				Player(source).state.drugEvidence = true
				Inventory:generateItem('dinheirosujo', drugs[3], nil, nil, true)

				exports.vrp:reportUser(user_id, {
					percentage = 40,
                    notify = { 
                        type = 'default', 
                        title = 'Tráfico de Drogas', 
                        message = 'Denúncia de populares, tráfico de drogas na região.',
                        coords = Coords,
                        time = 8000
                    },
                    blip = {
                        id = user_id, 
                        text = 'Tráfico de Drogas', 
                        coords = Coords,
                        timeout = 30000
                    }
                })

				user_drugs[user_id] = nil
			end
		end
	end
end

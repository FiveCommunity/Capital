AddEventHandler('playerSpawn', function(user_id, source, firstSpawn, creation)
    async(function()
        -- Aguarda os dados do jogador estarem disponíveis
        local data = vRP.getUserDataTable(user_id)

        -- [ Last Position ] --
        local position = data.position

        -- [ Health ] --
        if data.health == nil then data.health = 200 end

        if vRPclient.isInComa(source) then
            vRPclient.setHealth(source, 0)
        else
            vRPclient.setHealth(source, data.health)
        end

        -- [ Armour ] --
        if data.armour == nil then data.armour = 0 end
        Citizen.SetTimeout(10000, function()
            vRPclient.setArmour(source, data.armour)
        end)

        -- [ Needs ] --
        if data.hunger == nil then data.hunger = 0 end
        if data.thirst == nil then data.thirst = 0 end
        if data.stress == nil then data.stress = 0 end
        --if data.urine == nil then data.urine = 0 end
        --if data.poop == nil then data.poop = 0 end

        -- Trigger evento para ativar o cliente com os dados do jogador
        TriggerClientEvent('Active', source, { user_id = user_id, identity = vRP.getUserIdentity(user_id) })

        if not creation then 
            TriggerClientEvent('spawn:Show', source, firstSpawn, position)
        end
    end)
end)

tvRP.updatePos = function(x, y, z)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if (data) then 
			data.position = { x = tonumber(x), y = tonumber(y), z = tonumber(z) } 
		end
	end
end

tvRP.updateArmor = function(armor)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if (data) then 
			data.armour = armor 
		end
	end
end

tvRP.updateCustomization = function(customization)
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute('appearance:saveClothes', { user_id = user_id, user_clothes = json.encode(customization) } )
	end
end

tvRP.updateHealth = function(health)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if (data) then 
			data.health = health 
		end
	end
end

RegisterNetEvent('trymala', function(nveh)
	TriggerClientEvent('syncmala', -1, nveh)
end)
local needs = { 
	['hunger'] = true, -- Fome
	['thirst'] = true, -- Sede
	['stress'] = true, -- Estresse
	--['urine'] = true, -- Mijar
	--['poop'] = true -- Cagar
}

local needConfig = config.needs

local formatResult = function(value)
	if (value < 0) then value = 0; end
	if (value > 100) then value = 100; end;
	return value
end

vRP.getNeed = function(user_id, need)
	local data = vRP.getUserDataTable(user_id)
	return (data[need] or 0)
end

vRP.varyNeeds = function(user_id, need, variation)
	local source = vRP.getUserSource(user_id)
	if Player(source).state.isPlayingEvent then 
        return 
    end 
	local data = vRP.getUserDataTable(user_id)
	if (data) then
		if (need == 'all') then
			for index, _ in pairs(needs) do
				local value = (variation and variation or needConfig.varyPerMinute[index])
				if (data[index]) then
					data[index] = formatResult(data[index] + value)
					TriggerClientEvent('hud:updateNeeds', source, index, data[index])
				end
			end
		else
			if (needs[need]) then
				data[need] = formatResult(data[need] + variation)
				TriggerClientEvent('hud:updateNeeds', source, need, data[need])
			end
		end
	end
end

task_update_needs = function()
	Citizen.SetTimeout(60000, task_update_needs)
	for _, id in pairs(cacheUsers.users) do
		if (id) then
			vRP.varyNeeds(id, 'all')
		end
	end
end
Citizen.CreateThread(task_update_needs)
RegisterNetEvent('Active', function(data)
	local ped = PlayerPedId()

	local plyState = LocalPlayer.state
	plyState:set('Passport', data.user_id, true)
	plyState:set('Identity', data.identity, true)
	plyState:set('Active', true, true)

	SetDiscordAppId(1194689856736067584)
    SetDiscordRichPresenceAsset('logo')
	SetDiscordRichPresenceAssetSmall('logo')
	SetDiscordRichPresenceAssetSmallText('Capital City')
    SetRichPresence('#'..data.user_id..' '..data.identity.firstname..' '..data.identity.lastname)
    SetDiscordRichPresenceAction(0, 'INSTAGRAM', 'https://www.instagram.com/capitalcity.gg')
    SetDiscordRichPresenceAction(1, 'DISCORD', 'https://discord.gg/capitalgg')

	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(ped, true, true)
end)

local state_cache = {
	coords = vector3(0.0,0.0,0.0),
	coords_tick = 0,
	health = 0,
	health_tick = 0,
	armor = 0,
	armor_tick = 0,
	customs = {},
	customs_tick = 0,
	weapons = {},
	weapons_tick = 0,
}

Citizen.CreateThread(function()
	while (true) do
		Citizen.Wait(1000)
		if (LocalPlayer.state.Active) and not LocalPlayer.state.blockUpdateData then
			
			-- COORDINATES SAVE
			if state_cache.coords_tick >= 5 then
				
				local coords = GetEntityCoords(PlayerPedId())			
				if ( #(coords - state_cache.coords) >= 2 ) then
					state_cache.coords = coords
					vRPserver._updatePos(coords.x,coords.y,coords.z)				
				end
				state_cache.coords_tick = 0

			else
				state_cache.coords_tick = state_cache.coords_tick + 1
			end
			-- HEALTH SAVE
			if state_cache.health_tick >= 5 then
				
				local health = vRP.getHealth()
				if (health ~= state_cache.health) then
					state_cache.health = health
					vRPserver._updateHealth(health)		
				end
				state_cache.health_tick = 0

			else
				state_cache.health_tick = state_cache.health_tick + 1
			end
			-- ARMOR SAVE
			if state_cache.armor_tick >= 5 then
				
				local armor = vRP.getArmour()
				if (armor ~= state_cache.armor) then
					state_cache.armor = armor
					vRPserver._updateArmor(armor)		
				end
				state_cache.armor_tick = 0

			else
				state_cache.armor_tick = state_cache.armor_tick + 1
			end
			-- CUSTOMIZATION SAVE
			if (not LocalPlayer.state.inAppearance) then
				if state_cache.customs_tick >= 1 then
					local customs = vRP.getCustomization()
					if (json.encode(customs) ~= json.encode(state_cache.customs)) then
						state_cache.customs = customs
						vRPserver._updateCustomization(customs)
					end	
					state_cache.customs_tick = 0
				else
					state_cache.customs_tick = state_cache.customs_tick + 1
				end
			end
		end
	end
end)

vRP.varyArmour = function(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetPedArmour(ped) + variation)
	SetPedArmour(ped, n)
end

vRP.setArmour = function(amount)
	SetPedArmour(PlayerPedId(), amount)
end

vRP.getArmour = function()
	return GetPedArmour(PlayerPedId())
end

vRP.getCustomization = function()
	local ped = PlayerPedId()
	local custom = {}
	custom.pedModel = GetEntityModel(ped)

	for i = 0, 11 do
		if (i ~= 2) then
			custom[i] = { model = GetPedDrawableVariation(ped, i), var = GetPedTextureVariation(ped, i), palette = GetPedPaletteVariation(ped, i) }
		end
	end

	for i = 0, 7 do
		if (i ~= 3 and i ~= 4 and i ~= 5) then
 			custom['p'..i] = { model = GetPedPropIndex(ped, i), var = math.max(GetPedPropTextureIndex(ped, i)), palette = 0 }
		end
	end
	return custom
end

vRP.setCustomization = function(clothes)
	local ped = PlayerPedId()

	local modelHash = clothes.pedModel
	if (modelHash) then
		local armour = vRP.getArmour()
		local health = vRP.getHealth()

		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			RequestModel(modelHash)
			Citizen.Wait(0)
		end

		SetPlayerModel(PlayerId(), modelHash)
		SetModelAsNoLongerNeeded(modelHash)
	
		vRP.setHealth(health)
		vRP.setArmour(armour)
	end

	ped = PlayerPedId()
	SetPedMaxHealth(ped, 200)

	for k, v in pairs(clothes) do
		if (k ~= 'pedModel') then
			local isProp, index = parsePart(k)
			if (isProp) then
				if (v.model < 0) then
                    ClearPedProp(ped,index)
                else
                    SetPedPropIndex(ped, index, v.model, v.var, (v.palette or 0))
                end
			else
				if (k ~= 2) then SetPedComponentVariation(ped, parseInt(k), v.model, v.var, (v.palette or 0)); end;
			end
		end
	end

	TriggerEvent('gb:barberUpdate')
	TriggerEvent('gb:tattooUpdate')
end

local tab = nil
RegisterNetEvent('gb_core:tabletAnim', function()
    Citizen.CreateThread(function()
      RequestAnimDict('amb@world_human_clipboard@male@base')
      while not HasAnimDictLoaded('amb@world_human_clipboard@male@base') do
        Citizen.Wait(0)
      end
        tab = CreateObject(GetHashKey('prop_cs_tablet'), 0, 0, 0, true, true, true)
        AttachEntityToEntity(tab, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1),60309), 0, 0, 0, 0, 0.0, 0.0, true, true, false, true, 1, true)
        TaskPlayAnim(PlayerPedId(),'amb@world_human_clipboard@male@base','base', 8.0, 8.0, 1.0, 1, 1, 0, 0, 0 )
    end)
end)

RegisterNetEvent('gb_core:stopTabletAnim', function()
    ClearPedTasks(PlayerPedId())
    DeleteEntity(tab)
end)

parsePart = function(key)
    if (type(key) == 'string' and string.sub(key, 1, 1) == 'p') then
        return true, tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end
exports('parsePart', parsePart)
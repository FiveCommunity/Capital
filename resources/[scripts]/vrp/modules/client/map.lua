vRP.getSkins = function()
    return (GetEntityModel(PlayerPedId()) == GetHashKey('mp_m_freemode_01') or GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01'))
end

vRP.getModelPlayer = function()
    local ped = PlayerPedId()
    if (GetEntityModel(ped) == GetHashKey('mp_m_freemode_01')) then
        return 'mp_m_freemode_01'
    elseif (GetEntityModel(ped) == GetHashKey('mp_f_freemode_01')) then
        return 'mp_f_freemode_01'
    end
end

vRP.getCustomPlayer = function()
    local ped = PlayerPedId()
    local custom = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1),GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5),GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7),GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3),GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4),GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8),GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6),GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11),GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9),GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10),GetPedPropIndex(ped,0),GetPedPropTextureIndex(ped,0),GetPedPropIndex(ped,1),GetPedPropTextureIndex(ped,1),GetPedPropIndex(ped,2),GetPedPropTextureIndex(ped,2),GetPedPropIndex(ped,6),GetPedPropTextureIndex(ped,6),GetPedPropIndex(ped,7),GetPedPropTextureIndex(ped,7) }
    return custom
end

vRP.addBlip = function(x, y, z, idtype, idcolor, text, scale, route)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip, idtype)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, idcolor)
	SetBlipScale(blip, scale)

	if route then
		SetBlipRoute(blip, true)
	end

	if text then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

vRP.removeBlip = function(id)
	RemoveBlip(id)
end

vRP.setGPS = function(x, y)
	SetNewWaypoint(x+0.0001, y+0.0001)
end
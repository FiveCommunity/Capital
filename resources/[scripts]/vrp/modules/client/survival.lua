vRP.varyHealth = function(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped) + variation)
	SetEntityHealth(ped, n)
end

vRP.getHealth = function() return GetEntityHealth(PlayerPedId()) end

vRP.setHealth = function(health)
	SetEntityHealth(PlayerPedId(), parseInt(health))
end

vRP.setFriendlyFire = function(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(), flag, flag)
end

vRP.isInComa = function() return exports.death:isDied() end

vRP.setDeathTime = function(time) return exports.death:setDeathTime(time) end

vRP.killGod = function() return exports.death:reviveSurvival() end

vRP.isDied = function() return exports.death:isDied() end

vRP.getSpeed = function()
	local speed = GetEntityVelocity(PlayerPedId())
	return math.sqrt(speed.x*speed.x+speed.y*speed.y+speed.z*speed.z)
end

Text2D = function(font, x, y, text, scale)
    SetTextFont(font)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end
local config = module('core','cfg/cfgBlips')

Citizen.CreateThread(function()
	for _, v in pairs(config.blips) do
		local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)

		SetBlipSprite(blip, v.sprite)
		SetBlipAsShortRange(blip, true)
		SetBlipColour(blip, v.color)
		SetBlipScale(blip, v.scale)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)

		if (v.radius) then 
			local blip_area = AddBlipForRadius(v.coords.x, v.coords.y, v.coords.z, v.radius)
			SetBlipAlpha(blip_area, 100)
			SetBlipColour(blip_area, 1)
		end
		Citizen.Wait(5)
	end
end)
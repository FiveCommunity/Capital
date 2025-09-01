local carryingBackInProgress = false

-- RegisterCommand('carregar', function(source)
-- 	local ped = PlayerPedId()
-- 	if (GetEntityHealth(ped) > 100) then
-- 		if (not carryingBackInProgress) then	
-- 			TriggerServerEvent('vrp_carry:carryStart')
-- 		else
-- 			TriggerServerEvent("vrp_carry:carryTryStop")
-- 		end
-- 	end
-- end)

RegisterNetEvent('carry', function()
	local ped = PlayerPedId()
	if (GetEntityHealth(ped) > 100) and (not IsPedInAnyVehicle(ped,true)) then
		if (not carryingBackInProgress) then	
			TriggerServerEvent('vrp_carry:carryStart')
		else
			TriggerServerEvent("vrp_carry:carryTryStop")
		end
	end
end)

RegisterNetEvent('vrp_carry:carryMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	
	if (not IsPedInAnyVehicle(playerPed,true)) then
		carryingBackInProgress = true

		RequestAnimDict(animationLib)
		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end

		if controlFlag == nil then controlFlag = 0 end
		TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

		while (carryingBackInProgress) do
			playerPed = PlayerPedId()
			
			if IsPedInAnyVehicle(playerPed,true) then
				TriggerServerEvent("vrp_carry:carryTryStop")
				return;
			end

			DisableControlAction(0,23,true)

			Citizen.Wait(1)
		end

	end
end)

RegisterNetEvent('vrp_carry:carryTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = PlayerPedId()
	carryingBackInProgress = true

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	
	if spin == nil then spin = 180.0 end
	if controlFlag == nil then controlFlag = 0 end

	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))	
	AttachEntityToEntity(playerPed, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)	
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

local piggyBackInProgress = false

-- RegisterCommand("cavalinho",function(source, args)
-- 	local ped = PlayerPedId()
-- 	if (GetEntityHealth(ped) > 100) then
-- 		if (not piggyBackInProgress) then
-- 			TriggerServerEvent('vrp_carry:piggyBackStart')
-- 		else
-- 			TriggerServerEvent("vrp_carry:piggyBackTryStop")
-- 		end
-- 	end
-- end)

RegisterNetEvent('vrp_carry:piggyBackMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	piggyBackInProgress = true

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end

	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	while (carryingBackInProgress) do
		DisableControlAction(0,23,true)
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('vrp_carry:piggyBackTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = PlayerPedId()
	piggyBackInProgress = true

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end

	if spin == nil then spin = 180.0 end
	if controlFlag == nil then controlFlag = 0 end

	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('vrp_carry:piggyBackStop', function()
	piggyBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('vrp_carry:carryStop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

AddEventHandler('gb:CancelAnimations', function()
    TriggerServerEvent("vrp_carry:carryTryStop")
	TriggerServerEvent("vrp_carry:piggyBackTryStop")
end)
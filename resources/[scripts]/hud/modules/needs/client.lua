needs = {
    ['hunger'] = 0,
	['thirst'] = 0,
	['stress'] = 0,
	['urine'] = 0,
	['poop'] = 0
}

local playerIsHungryOrThirsty = false
local fxStarted = false

local setInjuried = function(state, ped)
	if (state) then
		if (not AnimpostfxIsRunning('DrugsMichaelAliensFight')) then AnimpostfxPlay('DrugsMichaelAliensFight', 10000001, true); end;
		if (not IsGameplayCamShaking()) then ShakeGameplayCam('DRUNK_SHAKE', 3.0); end;
        
        if (not HasAnimSetLoaded('move_f@injured')) then 
            RequestAnimSet('move_f@injured')
            while (not HasAnimSetLoaded('move_f@injured')) do Citizen.Wait(10); end;
        end
        SetPedMovementClipset(ped, 'move_f@injured', 0.25)
	else
		ResetPedMovementClipset(ped)
	end
end

local startScreenFx = function(ped)
	SetTimecycleModifier('spectator5')
	SetPedMotionBlur(ped, true)
	SetPedIsDrunk(ped, true)
	SetPedMoveRateOverride(ped, 1.0)
	SetRunSprintMultiplierForPlayer(ped, 1.0)
	SetPlayerStamina(ped, 0)
	setInjuried(true, ped)
	fxStarted = true
end

local stopScreenFx = function(ped)
	if (fxStarted) then
		SetPedMoveRateOverride(ped, 1.0)
		SetRunSprintMultiplierForPlayer(ped, 1.0)
		SetPedIsDrunk(ped, false)		
		SetPedMotionBlur(ped, false)
		AnimpostfxStopAll()
		ShakeGameplayCam('DRUNK_SHAKE', 0.0)
		if (LocalPlayer.state.FPS) then SetTimecycleModifier('cinema')
        else SetTimecycleModifier('default') end
		setInjuried(false, ped)
		fxStarted = false
	end
end

local initPlayerInjuriedByNecessities = function(ped)
	if (not playerIsHungryOrThirsty) then 
		Citizen.CreateThread(function() 
			startScreenFx(ped)
			playerIsHungryOrThirsty = true
			while (needs.hunger >= 100 or needs.thirst >= 100) do 
				DisableControlAction(0, 21, true) -- disable sprint
				DisableControlAction(0, 22, true) -- disable jump
                Citizen.Wait(1)
			end
			stopScreenFx(ped)
			playerIsHungryOrThirsty = false
			return
		end)
	end
end

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(30000)
        local ped = PlayerPedId()
        if (LocalPlayer.state.Active) and GetEntityHealth(ped) > 100 and not LocalPlayer.state.isPlayingEvent then
            if (needs.hunger >= 75 and needs.hunger < 100) then
                TriggerEvent('notify', 'hunger', 'Fome', 'Você está ficando com fome....')
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.40)
                
                if (not IsPedInAnyVehicle(ped)) then
                    LocalPlayer.state.BlockTasks = true
                    TriggerEvent('gb_animations:setAnim', 'bebado6')
                    Citizen.Wait(6000)
                    LocalPlayer.state.BlockTasks = false
                end
            elseif (needs.hunger >= 100) then
                TriggerEvent('notify', 'hunger', 'Fome', 'Você está com fome....')
                initPlayerInjuriedByNecessities(ped)
            end
            
            if (needs.thirst >= 80 and needs.thirst < 100) then
                TriggerEvent('notify', 'thirst', 'Sede', 'Você está ficando com sede...')
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.40)
                
                if (not IsPedInAnyVehicle(ped)) then
                    LocalPlayer.state.BlockTasks = true
                    TriggerEvent('gb_animations:setAnim', 'bebado6')
                    Citizen.Wait(6000)
                    LocalPlayer.state.BlockTasks = false
                end
            elseif (needs.thirst >= 100) then
                TriggerEvent('notify', 'thirst', 'Sede', 'Você está com sede....')
                initPlayerInjuriedByNecessities(ped)
            end

            if (needs.stress >= 50 and needs.stress < 60) then
                TriggerEvent('notify', 'stress', 'Estresse', 'Você está ficando estressado...')
            
            elseif (needs.stress >= 60 and needs.stress < 90) then
                TriggerEvent('notify', 'stress', 'Estresse', 'Você está estressado...')

                SetFlash(0, 0, 500, 1500, 500)
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.1)
                Citizen.Wait(5000)
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.0)
            elseif (needs.stress >= 90) then
                TriggerEvent('notify', 'stress', 'Estresse', 'Você está estressado...')

                SetFlash(0, 0, 500, 1500, 500)
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.1)
                Citizen.Wait(5000)
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.0)
            end

            -- if (needs.urine >= 50) then
            --     TriggerEvent('notify', 'urine', 'Necessidade', 'Você está ficando apertado e precisa ir ao banheiro...')
            -- end

            -- if (needs.poop >= 50 and needs.poop < 90) then
            --     TriggerEvent('notify', 'poop', 'Necessidade', 'Você está ficando apertado e precisa ir ao banheiro...')
            --     TriggerServerEvent('needs:syncFartSound')   
                
            -- elseif (needs.poop >= 90) then
            --     TriggerEvent('notify', 'poop', 'Necessidade', 'Você precisa ir urgentemente ao banheiro...')

            --     LocalPlayer.state.BlockTasks = true

            --     TriggerServerEvent('needs:syncFartSound')  
            --     TriggerEvent('gb_animations:setAnim', 'cocada')
            --     Citizen.Wait(5000)
            --     ClearPedTasks(ped)

            --     LocalPlayer.state.BlockTasks = false
            -- end
        end
    end
end)
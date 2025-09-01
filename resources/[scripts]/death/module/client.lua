local data = { thread = false, timer = 0 }
local ply = 0;
local plyCooords = vec3(0,0,0)

local noDie = false;

local survivalTimer = function(time)
    Citizen.CreateThread(function()
        data.timer = time
        while (data.timer > 0) do
            Citizen.Wait(1000)
            data.timer = (data.timer - 1)

            if (data.timer > 0) then
                SendNUIMessage({ action = 'timer', value = data.timer })
                TriggerServerEvent('death:saveTimer', data.timer)
            end
        end
        SendNUIMessage({ action = 'timer', value = 0 })
    end)
end

local close = function()
    SendNUIMessage({ action = 'show', value = false })

    data.timer = 0
    data.thread = false
    
    LocalPlayer.state.Hud = true
    NetworkSetFriendlyFireOption(true)
    SetNuiFocus(false, false)
    
    SetEntityInvincible(ply, false)
    SetPedDiesInWater(ply, true)

    Citizen.Wait(500)

    TriggerServerEvent('death:saveTimer', config.deathTimer)
end

local startThread = function()
    if LocalPlayer.state.isPlayingEvent then 
        return 
    end 
    
    if (noDie) then
        plyCoords = GetEntityCoords(ply)
        NetworkResurrectLocalPlayer(plyCoords.x, plyCoords.y, plyCoords.z, true, true, false)

        ply = PlayerPedId()
        SetEntityHealth(ply, 150)

        noDie = false;
        return
    end

    if (data.thread) then return; end;
    data.thread = true
    
    local revived = false
    local getDeathTimer = vSERVER.getDeathTimer()
    survivalTimer(getDeathTimer)

    SendNUIMessage({ action = 'show', value = true })
    SendNUIMessage({ action = 'timer', value = getDeathTimer })
    LocalPlayer.state.Hud = false

    NetworkSetFriendlyFireOption(false)
    SetEntityHealth(ply, 0)
    vRPserver.updateHealth(0)

    config.extraDeath()
    
    if (getDeathTimer > 0) then
        local secs = config.waitStartThread
        while (secs > 0) do
            Citizen.Wait(1000)
            secs = (secs - 1)

            if (GetEntityHealth(ply) > 100) then
                revived = true
                break;
            end
        end
    end

    if (revived) then return close(); end;

    if (IsEntityDead(ply)) then
        plyCoords = GetEntityCoords(ply)
        NetworkResurrectLocalPlayer(plyCoords.x, plyCoords.y, plyCoords.z, true, true, false)
        
        ply = PlayerPedId()

        SetEntityInvincible(ply, true)
        SetPedDiesInWater(ply, false)
        SetEntityHealth(ply, 100)

        vRPserver.updateHealth(100)
    end 

    Citizen.CreateThread(function()
        while (GetEntityHealth(ply) <= 100) do
            SetEntityHealth(ply, 100)
            SetPedToRagdoll(ply, 5000, 5000,0, 0, 0, 0) 
            ResetPedRagdollTimer(ply)

            if (data.timer <= 0) then
                SetNuiFocus(true, true)
            end

            actions()
            Citizen.Wait(1)
        end

        close()
    end)
end

RegisterNetEvent('suricato_roubos:updateRobbery', function(bool)
    inRobbery = bool
end)

Citizen.CreateThread(function()    
    ply = PlayerPedId()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(ply, true, true)

    while (true) do
        ply = PlayerPedId()
        plyCoords = GetEntityCoords(ply)
        if LocalPlayer.state.Active and not LocalPlayer.state.disableSurvival and not inRobbery then
            if (GetEntityHealth(ply) <= 100) then
                startThread()
            end
        end
        Citizen.Wait(1000)
    end
end)

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
local clearPed = function()
    for i = 0, 5 do
        ClearPedDamageDecalByZone(ply, i, 'ALL')
    end

    ClearPedBloodDamage(ply)
    ClearPedTasks(ply)
    ClearPedSecondaryTask(ply)
end

reviveSurvival = function()
    if (IsEntityDead(ply)) then 
        plyCoords = GetEntityCoords(ply)
        NetworkResurrectLocalPlayer(plyCoords.x, plyCoords.y, plyCoords.z, true, true, false)
    end

    SetEntityHealth(ply, 200)
    SetPedArmour(ply, 0)

    vRPserver.updateHealth(200)
    vRPserver.updateArmour(0)

    SetEntityInvincible(ply, false)
    SetPedDiesInWater(ply, true)
    clearPed()
    ResetPedMovementClipset(ply, 0)
end
exports('reviveSurvival', reviveSurvival)

respawnSurvival = function()
    if (vSERVER.clearAfterDie()) then
        LocalPlayer.state.Hud = false
        Citizen.Wait(1000)
        DoScreenFadeOut(1000)
		Citizen.Wait(1000)

        FreezeEntityPosition(ply, true)
        SetEntityCoords(ply, config.spawn.xyz)
        SetEntityHeading(ply, config.spawn.w)

        Citizen.SetTimeout(5000, function()
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)

            reviveSurvival()
            FreezeEntityPosition(ply, false)
            LocalPlayer.state.Hud = true
        end)
    end
end

actions = function()
    DisableControlAction(0, 21, true)
    DisableControlAction(0, 22, true)
    DisableControlAction(0, 23, true)
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 29, true)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 47, true)
    DisableControlAction(0, 56, true)
    DisableControlAction(0, 58, true)
    DisableControlAction(0, 73, true)
    DisableControlAction(0, 75, true)
    DisableControlAction(0, 137, true)
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 141, true)
    DisableControlAction(0, 142, true)
    DisableControlAction(0, 143, true)
    DisableControlAction(0, 166, true)
    DisableControlAction(0, 167, true)
    DisableControlAction(0, 168, true)
    DisableControlAction(0, 169, true)
    DisableControlAction(0, 170, true)
    DisableControlAction(0, 177, true)
    DisableControlAction(0, 182, true)
    DisableControlAction(0, 187, true)
    DisableControlAction(0, 188, true)
    DisableControlAction(0, 189, true)
    DisableControlAction(0, 190, true)
    DisableControlAction(0, 243, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 263, true)
    DisableControlAction(0, 264, true)
    DisableControlAction(0, 268, true)
    DisableControlAction(0, 269, true)
    DisableControlAction(0, 270, true)
    DisableControlAction(0, 271, true)
    DisableControlAction(0, 288, true)
    DisableControlAction(0, 289, true)
    DisableControlAction(0, 311, true)
    DisableControlAction(0, 344, true)
end

exports('setDeathTime', function(value) data.timer = value; end)
exports('isDied', function() return (GetEntityHealth(ply) <= 100); end)

----------------------------------------------------------------
-- Extra
----------------------------------------------------------------
local weaponsFunction = {
	[GetHashKey('WEAPON_PUMPSHOTGUN')] = function(ped)
		local stunned = true;

		LocalPlayer.state.BlockTasks = true

		ShakeGameplayCam('FAMILY5_DRUG_TRIP_SHAKE', 1.0)
		SetPedToRagdollWithFall(ped, 1500, 2000, 0, GetEntityForwardVector(ped), 1.0, 0, 0, 0, 0, 0, 0)

		Citizen.Wait(500)

		Citizen.CreateThread(function()
			while (stunned) do
				SetPedToRagdoll(ped, 10000, 10000, 0, 0, 0, 0)
				Citizen.Wait(5)
			end
		end)

		Citizen.SetTimeout(10000, function()
			stunned = false
			StopGameplayCamShaking()
			LocalPlayer.state.BlockTasks = false
		end)
	end
}


AddEventHandler('gameEventTriggered', function (name, args)
    if (name == 'CEventNetworkEntityDamage')  then
        local ped = PlayerPedId()

		if (args[1] == ped) then 
			local weaponHash = args[7]
			if (weaponHash) and (weaponsFunction[weaponHash]) then

                if (GetEntityHealth(ped) <= 101) then
                    noDie = true
                end

				weaponsFunction[weaponHash](ped)
			end
        end
    end
end) 

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNUICallback('revive', function(data, cb)
    respawnSurvival()

    cb('Ok')
end)
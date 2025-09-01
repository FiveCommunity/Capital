Citizen.CreateThread(function()
	local Pid = PlayerId()
	local ped = PlayerPedId()

	modifyDamages()
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(ped, true, true)
	ReplaceHudColour(116, 9)
    AddTextEntry('FE_THDR_GTAO', 'CAPITAL CITY')
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
	SetAudioFlag('PoliceScannerDisabled', true)
	SetAudioFlag("DisableFlightMusic",true)
	SetPlayerCanUseCover(Pid, false)
	ForceAmbientSiren(false)
	DisableVehicleDistantlights(true)
	StopAudioScenes()
	SetPlayerTargetingMode(3)
	SetMaxWantedLevel(0)
	SetRandomBoats(false)
	SetRandomTrains(false)
	SetGarbageTrucks(false)
	SetRandomEventFlag(false)
	SetPoliceRadarBlips(false)
	DistantCopCarSirens(false)
	ClearPlayerWantedLevel(Pid)
	SetPoliceIgnorePlayer(ped, true)
	SetArtificialLightsState(false)
	SetPedSteersAroundPeds(ped, true)
	DisableVehicleDistantlights(true)
	SetDispatchCopsForPlayer(ped, false)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(ped,false)
	SetPedCanBeKnockedOffVehicle(ped, false)
	SetPedCanRagdollFromPlayerImpact(ped, false)
	SetPedCanLosePropsOnDamage(ped, false, 0)
	SetAudioFlag('PlayerOnDLCHeist4Island', true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
	SetDeepOceanScaler(0.0)
	RemovePickups(Pid)

	for i=0,15 do
		EnableDispatchService(i,false)
	end

	local playerState = LocalPlayer.state

	while (true) do
		local idle = 1000	
		ped = PlayerPedId()
		
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)	

		if (IsPedSwimming(ped)) then
			if (not playerState.pedSwimming) then
				playerState:set('pedSwimming', true, true)
			end
		else
			if (playerState.pedSwimming) then
				playerState:set('pedSwimming', false, true)
			end
		end

		if (IsPauseMenuActive()) then
			idle = 1

			SetRadarAsExteriorThisFrame()
			SetRadarAsInteriorThisFrame('h4_fake_islandx', vec(4700.0, -5145.0), 0, 0)
		end
		Citizen.Wait(idle)
	end
end)
--===================================================
-- WAR
--===================================================
-- local coordwar = vector3(5139.205, -5012.532, 8.116455)
-- local coordwar2 = vector3(1314.501, 4358.677, 40.87256)

-- local vSERVER = Tunnel.getInterface(GetCurrentResourceName()..':misc')

-- Citizen.CreateThread(function()
-- 	local setBucket = false
-- 	while true do
-- 		if (LocalPlayer.state.Active) then
-- 			local ped = PlayerPedId()
-- 			local pCoord = GetEntityCoords(ped)

-- 			local dist = #(pCoord - coordwar)
-- 			if (dist <= 2500) then
-- 				if (not setBucket) then
-- 					setBucket = true
-- 					vSERVER.setBucket(1000)

-- 					print('ENTROU EM OUTRO SESSÃO')
-- 				end

-- 				if (GetEntityHealth(ped) <= 100) then
-- 					vSERVER.setBucket(0)
-- 					vRP.teleport(coordwar2)
-- 				end
-- 			else
-- 				if (setBucket) then
-- 					setBucket = false
-- 					vSERVER.setBucket(0)
-- 				end
-- 			end
-- 		end
-- 		Citizen.Wait(2000)
-- 	end
-- end)

local blockStealth = true
exports('blockStealth', function(b) blockStealth = b; Wait(2) end)

Citizen.CreateThread(function()
	while (true) do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		
		RemoveVehiclesFromGeneratorsInArea(coords.x-9999.0,coords.y-9999.0,coords.z-9999.0,coords.x+9999.0,coords.y+9999.0,coords.z+9999.0)
		DisablePlayerVehicleRewards(PlayerId())
		SetPedDropsWeaponsWhenDead(ped, false)
		if blockStealth then
			SetPedStealthMovement(ped, 0, false)
		end

		if LocalPlayer.state.inRoyale or LocalPlayer.state.isPlayingEvent then
			SetPedDensityMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
			SetVehicleDensityMultiplierThisFrame(0.0)
			SetRandomVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)
		else
			SetPedDensityMultiplierThisFrame(1.0)
			SetScenarioPedDensityMultiplierThisFrame(0.1, 0.1)
			SetVehicleDensityMultiplierThisFrame(0.5)
			SetRandomVehicleDensityMultiplierThisFrame(1.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)
		end 

		Citizen.Wait(1)
	end
end)

RemovePickups = function(Pid)
	local Pickups = {
		`PICKUP_AMMO_BULLET_MP`,
		`PICKUP_AMMO_FIREWORK`,
		`PICKUP_AMMO_FLAREGUN`,
		`PICKUP_AMMO_GRENADELAUNCHER`,
		`PICKUP_AMMO_GRENADELAUNCHER_MP`,
		`PICKUP_AMMO_HOMINGLAUNCHER`,
		`PICKUP_AMMO_MG`,
		`PICKUP_AMMO_MINIGUN`,
		`PICKUP_AMMO_MISSILE_MP`,
		`PICKUP_AMMO_PISTOL`,
		`PICKUP_AMMO_RIFLE`,
		`PICKUP_AMMO_RPG`,
		`PICKUP_AMMO_SHOTGUN`,
		`PICKUP_AMMO_SMG`,
		`PICKUP_AMMO_SNIPER`,
		`PICKUP_ARMOUR_STANDARD`,
		`PICKUP_CAMERA`,
		`PICKUP_CUSTOM_SCRIPT`,
		`PICKUP_GANG_ATTACK_MONEY`,
		`PICKUP_HEALTH_SNACK`,
		`PICKUP_HEALTH_STANDARD`,
		`PICKUP_MONEY_CASE`,
		`PICKUP_MONEY_DEP_BAG`,
		`PICKUP_MONEY_MED_BAG`,
		`PICKUP_MONEY_PAPER_BAG`,
		`PICKUP_MONEY_PURSE`,
		`PICKUP_MONEY_SECURITY_CASE`,
		`PICKUP_MONEY_VARIABLE`,
		`PICKUP_MONEY_WALLET`,
		`PICKUP_PARACHUTE`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,
		`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,
		`PICKUP_PORTABLE_PACKAGE`,
		`PICKUP_SUBMARINE`,
		`PICKUP_VEHICLE_ARMOUR_STANDARD`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,
		`PICKUP_VEHICLE_HEALTH_STANDARD`,
		`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,
		`PICKUP_VEHICLE_MONEY_VARIABLE`,
		`PICKUP_VEHICLE_WEAPON_SNIPERRIFLE`,
		`PICKUP_VEHICLE_WEAPON_APPISTOL`,
		`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,
		`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,
		`PICKUP_VEHICLE_WEAPON_GRENADE`,
		`PICKUP_VEHICLE_WEAPON_MICROSMG`,
		`PICKUP_VEHICLE_WEAPON_MOLOTOV`,
		`PICKUP_VEHICLE_WEAPON_PISTOL`,
		`PICKUP_VEHICLE_WEAPON_PISTOL50`,
		`PICKUP_VEHICLE_WEAPON_SAWNOFF`,
		`PICKUP_VEHICLE_WEAPON_SMG`,
		`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,
		`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_ADVANCEDRIFLE`,
		`PICKUP_WEAPON_APPISTOL`,
		`PICKUP_WEAPON_ASSAULTRIFLE`,
		`PICKUP_WEAPON_ASSAULTSHOTGUN`,
		`PICKUP_WEAPON_ASSAULTSMG`,
		`PICKUP_WEAPON_AUTOSHOTGUN`,
		`PICKUP_WEAPON_BAT`,
		`PICKUP_WEAPON_BATTLEAXE`,
		`PICKUP_WEAPON_BOTTLE`,
		`PICKUP_WEAPON_BULLPUPRIFLE`,
		`PICKUP_WEAPON_BULLPUPSHOTGUN`,
		`PICKUP_WEAPON_CARBINERIFLE`,
		`PICKUP_WEAPON_COMBATMG`,
		`PICKUP_WEAPON_COMBATPDW`,
		`PICKUP_WEAPON_COMBATPISTOL`,
		`PICKUP_WEAPON_COMPACTLAUNCHER`,
		`PICKUP_WEAPON_COMPACTRIFLE`,
		`PICKUP_WEAPON_CROWBAR`,
		`PICKUP_WEAPON_DAGGER`,
		`PICKUP_WEAPON_DBSHOTGUN`,
		`PICKUP_WEAPON_FIREWORK`,
		`PICKUP_WEAPON_FLAREGUN`,
		`PICKUP_WEAPON_FLASHLIGHT`,
		`PICKUP_WEAPON_GRENADE`,
		`PICKUP_WEAPON_GRENADELAUNCHER`,
		`PICKUP_WEAPON_GUSENBERG`,
		`PICKUP_WEAPON_GOLFCLUB`,
		`PICKUP_WEAPON_HAMMER`,
		`PICKUP_WEAPON_HATCHET`,
		`PICKUP_WEAPON_HEAVYPISTOL`,
		`PICKUP_WEAPON_HEAVYSHOTGUN`,
		`PICKUP_WEAPON_HEAVYSNIPER`,
		`PICKUP_WEAPON_HOMINGLAUNCHER`,
		`PICKUP_WEAPON_KNIFE`,
		`PICKUP_WEAPON_KNUCKLE`,
		`PICKUP_WEAPON_MACHETE`,
		`PICKUP_WEAPON_MACHINEPISTOL`,
		`PICKUP_WEAPON_MARKSMANPISTOL`,
		`PICKUP_WEAPON_MARKSMANRIFLE`,
		`PICKUP_WEAPON_MG`,
		`PICKUP_WEAPON_MICROSMG`,
		`PICKUP_WEAPON_MINIGUN`,
		`PICKUP_WEAPON_MINISMG`,
		`PICKUP_WEAPON_MOLOTOV`,
		`PICKUP_WEAPON_MUSKET`,
		`PICKUP_WEAPON_NIGHTSTICK`,
		`PICKUP_WEAPON_PETROLCAN`,
		`PICKUP_WEAPON_PIPEBOMB`,
		`PICKUP_WEAPON_PISTOL`,
		`PICKUP_WEAPON_PISTOL50`,
		`PICKUP_WEAPON_POOLCUE`,
		`PICKUP_WEAPON_PROXMINE`,
		`PICKUP_WEAPON_PUMPSHOTGUN`,
		`PICKUP_WEAPON_RAILGUN`,
		`PICKUP_WEAPON_REVOLVER`,
		`PICKUP_WEAPON_RPG`,
		`PICKUP_WEAPON_SAWNOFFSHOTGUN`,
		`PICKUP_WEAPON_SMG`,
		`PICKUP_WEAPON_SMOKEGRENADE`,
		`PICKUP_WEAPON_SNIPERRIFLE`,
		`PICKUP_WEAPON_SNSPISTOL`,
		`PICKUP_WEAPON_SPECIALCARBINE`,
		`PICKUP_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_STUNGUN`,
		`PICKUP_WEAPON_SWITCHBLADE`,
		`PICKUP_WEAPON_VINTAGEPISTOL`,
		`PICKUP_WEAPON_WRENCH`,
		`PICKUP_WEAPON_RAYCARBINE`
	}

	for Number = 1,#Pickups do
		ToggleUsePickupsForPlayer(Pid,Pickups[Number],false)
	end
end

local Crouched = false
local CrouchedForce = false
local Aimed = false
local Cooldown = false
local CoolDownTime = 500 -- in ms
local actionTime = 0.25 -- tempo  para abaixar e levantar
NormalWalk = function() 
    local Player = PlayerPedId()
    SetPedMaxMoveBlendRatio(Player, 1.0)
    ResetPedMovementClipset(Player, actionTime)
    ResetPedStrafeClipset(Player)
    SetPedCanPlayAmbientAnims(Player, true)
    SetPedCanPlayAmbientBaseAnims(Player, true)
    ResetPedWeaponMovementClipset(Player)
    ResetPedMovementClipset(Player,0.25)

    Crouched = false
end

SetupCrouch = function()
    while not HasAnimSetLoaded('move_ped_crouched') do
        Citizen.Wait(1)
        RequestAnimSet('move_ped_crouched')
    end
end

RemoveCrouchAnim = function()
    RemoveAnimDict('move_ped_crouched')
end

CanCrouch = function()
    local PlayerPed = PlayerPedId()
    if IsPedOnFoot(PlayerPed) and not IsPedJumping(PlayerPed) and not IsPedFalling(PlayerPed) and not IsPedDeadOrDying(PlayerPed) then
        return true
    else
        return false
    end
end

CrouchPlayer = function()
    local Player = PlayerPedId()
    SetPedUsingActionMode(Player, false, -1, 'DEFAULT_ACTION')
    SetPedMovementClipset(Player, 'move_ped_crouched', actionTime)
    SetPedMovementClipset(Player,'move_ped_crouched',1.50) -- moovespeed
    SetPedStrafeClipset(Player, 'move_ped_crouched_strafing') -- it force be on third person if not player will freeze but this func make player can shoot with good anim on crouch if someone know how to fix this make request :D
    SetWeaponAnimationOverride(Player, 'Ballistic')
    Crouched = true
    Aimed = false
end

SetPlayerAimSpeed = function()
    local Player = PlayerPedId()
    SetPedMaxMoveBlendRatio(Player, 10.0)
    Aimed = true
end

IsPlayerFreeAimed = function()
    local PlayerID = GetPlayerIndex()
    if IsPlayerFreeAiming(PlayerID) or IsAimCamActive() or IsAimCamThirdPersonActive() then
        return true
    else
        return false
    end
end

CrouchLoop = function()
    SetupCrouch()
    while CrouchedForce do
        local CanDo = CanCrouch()
        if Crouched then 
            DisablePlayerFiring(PlayerPedId(), true) -- desabilita atirar
        end
        if CanDo and Crouched and IsPlayerFreeAimed() then
            SetPlayerAimSpeed()
        elseif CanDo and (not Crouched or Aimed) then
            CrouchPlayer()
        elseif not CanDo and Crouched then
            CrouchedForce = false
            NormalWalk()
        end
        local sleep = 15
        if Crouched then sleep = 1 end

        if IsPedInAnyVehicle(PlayerPedId()) then 
            CrouchedForce = false
        end

        Citizen.Wait(1)
    end
    NormalWalk()
    RemoveCrouchAnim()
end

RegisterKeyMapping('Crouch', 'Agachar', 'keyboard', 'LCONTROL')
RegisterCommand('Crouch', function()
	if (not LocalPlayer.state.Control) then
		DisableControlAction(0, 36, true) -- magic
		if IsPedInAnyVehicle(PlayerPedId()) then 
			CrouchedForce = false
			return
		end
		if not Cooldown then
			CrouchedForce = not CrouchedForce

			if CrouchedForce then
				CreateThread(CrouchLoop) -- Magic Part 2 lamo
			end

			Cooldown = true
			SetTimeout(CoolDownTime, function()
				Cooldown = false
			end)
		end
	end
end, false)

IsCrouched = function()
    return Crouched
end
exports('IsCrouched', IsCrouched)

local dispatchBlacklist = {
	[GetHashKey('WEAPON_UNARMED')] = true,
	[GetHashKey('WEAPON_DAGGER')] = true,
	[GetHashKey('WEAPON_BAT')] = true,
	[GetHashKey('WEAPON_BOTTLE')] = true,
	[GetHashKey('WEAPON_CROWBAR')] = true,
	[GetHashKey('WEAPON_FLASHLIGHT')] = true,
	[GetHashKey('WEAPON_GOLFCLUB')] = true,
	[GetHashKey('WEAPON_HAMMER')] = true,
	[GetHashKey('WEAPON_HATCHET')] = true,
	[GetHashKey('WEAPON_KNUCKLE')] = true,
	[GetHashKey('WEAPON_KNIFE')] = true,
	[GetHashKey('WEAPON_MACHETE')] = true,
	[GetHashKey('WEAPON_SWITCHBLADE')] = true,
	[GetHashKey('WEAPON_NIGHTSTICK')] = true,
	[GetHashKey('WEAPON_WRENCH')] = true,
	[GetHashKey('WEAPON_BATTLEAXE')] = true,
	[GetHashKey('WEAPON_POOLCUE')] = true,
	[GetHashKey('WEAPON_STONE_HATCHET')] = true,
	[GetHashKey('WEAPON_STUNGUN')] = true,
	[GetHashKey('WEAPON_FLARE')] = true,
	[GetHashKey('GADGET_PARACHUTE')] = true,
	[GetHashKey('WEAPON_FIREEXTINGUISHER')] = true,
	[GetHashKey('WEAPON_PETROLCAN')] = true,
	[GetHashKey('WEAPON_FIREWORK')] = true,
	[GetHashKey('WEAPON_SNOWBALL')] = true,
	[GetHashKey('WEAPON_BZGAS')] = true,
	[GetHashKey('WEAPON_MUSKET')] = true
}

local Dispatch = false

AddStateBagChangeHandler('Armed', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) or (not value) then return; end;

    Citizen.CreateThread(function()
		local playerState = LocalPlayer.state
        while (playerState.Armed) do
            local ped = PlayerPedId()

            if (IsPedArmed(ped, 6)) then

                SetPedSuffersCriticalHits(ped, false)
                DisableControlAction(0, 140 ,true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)

				if (not Dispatch) and (IsPedShooting(ped)) then
					Dispatch = true
					Citizen.SetTimeout(40000, function() Dispatch = false; end)
					
					if (not playerState.powderEvidence) then playerState:set('powderEvidence', true, true); end;
					if (not dispatchBlacklist[GetSelectedPedWeapon(ped)]) then TriggerServerEvent('gb_core:shoting', GetEntityCoords(ped)); end;
				end
            end
            Citizen.Wait(5)
        end
    end)
end)

--=======================================
-- Modify Damage
--=======================================

local weaponsDamage = {
	[GetHashKey('WEAPON_UNARMED')] = 0.2,
	[GetHashKey('WEAPON_NIGHTSTICK')] = 0.0,
	[GetHashKey('WEAPON_STUNGUN')] = 0.0,
	[GetHashKey('WEAPON_RAYPISTOL')] = 0.0,
	[GetHashKey('WEAPON_BAT')] = 0.2,
	[GetHashKey('WEAPON_SWITCHBLADE')] = 0.35,
	[GetHashKey('WEAPON_KNUCKLE')] = 0.5,
	[GetHashKey('WEAPON_POOLCUE')] = 0.15,
	[GetHashKey('WEAPON_KATANA')] = 0.8,
	[GetHashKey('WEAPON_WRENCH')] = 0.0,
	[GetHashKey('WEAPON_CROWBAR')] = 0.0,
	[GetHashKey('WEAPON_PAO')] = 0.2,
	[GetHashKey('WEAPON_PLACA')] = 0.25,
	[GetHashKey('WEAPON_PICARETA')] = 0.5,
	[GetHashKey('WEAPON_FLASHLIGHT')] = 0.0,
	[GetHashKey('WEAPON_PUMPSHOTGUN')] = 0.01,

	-- PISTOL
	[GetHashKey('WEAPON_COMBATPISTOL')] = 0.32,
	[GetHashKey('WEAPON_PISTOL_MK2')] = 0.28,
	[GetHashKey('WEAPON_PISTOL')] = 0.32,
	[GetHashKey('WEAPON_PISTOL50')] = 0.17,
	-- [GetHashKey('WEAPON_CERAMICPISTOL')] = generalDamages['pistol'],
	-- [GetHashKey('WEAPON_SNSPISTOL_MK2')] = generalDamages['pistol'],
	-- [GetHashKey('WEAPON_SNSPISTOL')] = generalDamages['pistol'],
	-- [GetHashKey('WEAPON_REVOLVER_MK2')] = generalDamages['pistol'],
	-- [GetHashKey('WEAPON_REVOLVER')] = generalDamages['pistol'],

	-- > SMG
	[GetHashKey('WEAPON_COMBATPDW')] = 0.4,
	[GetHashKey('WEAPON_SMG_MK2')] = 0.45,
	[GetHashKey('WEAPON_MINISMG')] = 0.55,
	[GetHashKey('WEAPON_MACHINEPISTOL')] = 0.38,
	[GetHashKey('WEAPON_ASSAULTSMG')] = 0.5,
	[GetHashKey('WEAPON_GUSENBERG')] = 0.4,
	[GetHashKey('WEAPON_MICROSMG')] = 0.52,
	-- [GetHashKey('WEAPON_TECPISTOL')] = generalDamages['smg'],

	-- > RIFLE
	[GetHashKey('WEAPON_CARBINERIFLE_MK2')] = 0.5,
	[GetHashKey('WEAPON_TACTICALRIFLE')] = 0.5,
	[GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = 0.5,
	[GetHashKey('WEAPON_HEAVYRIFLE')] = 0.5,
	[GetHashKey('WEAPON_ASSAULTRIFLE')] = 0.5,
	[GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = 0.5,
	[GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = 0.5,
	[GetHashKey('WEAPON_SPECIALCARBINE')] = 0.5,
	
	-- SHOTGUN	
	[GetHashKey('WEAPON_COMBATSHOTGUN')] = 0.5,
	[GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = 0.1,
	[GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = 0.1,
	[GetHashKey('WEAPON_DBSHOTGUN')] = 0.1,
	[GetHashKey('WEAPON_PUMPSHOTGUN')] = 0.1,
	

	-- box_weapon_combatshotgun
	-- box_weapon_pumpshotgun_mk2'] = { index = 'box_weapon_pumpshotgun_mk2', name = 'B. Remington', type = 'weapon_box', weight = 5.0 },
	-- box_weapon_sawnoffshotgun'] = { index = 'box_weapon_sawnoffshotgun', name = 'B. Cano Curto', type = 'weapon_box', weight = 5.0 },
	-- box_weapon_dbshotgun'] = { index = 'box_weapon_dbshotgun', name = 'B. Double Shot', type = 'weapon_box', weight = 5.0 },
	-- box_weapon_pumpshotgun'] = { index = 'box_weapon_pumpshotgun', name = 'B. Mossberg 800', type = 'weapon_box', weight = 5.0 },
}

modifyDamages = function()
	CreateThread(function()
		while true do			
			for hash, dmg in pairs(weaponsDamage) do
				SetWeaponDamageModifier(hash, dmg)
			end
			
			local ped = PlayerPedId()
			if LocalPlayer.state.inRoyale or LocalPlayer.state.inRound6 or LocalPlayer.state.isPlayingEvent then
				SetPedSuffersCriticalHits(ped, true)
			else
				SetPedSuffersCriticalHits(ped, false)
			end

			Wait(0)
		end
	end)
end

-- config.recyclePoints = {
--     ['reciclagem'] = {
--         coords = vector3(-571.4769, -1625.802, 33.00366),
--         permission = 'reciclagem.permissao'
--     }
-- }


-- Escola cidade perfeita -- 
local locs = {
	{
		label = 'Entrar na escola',
		coords = vector3(-379.978, -5304.132, 9.616089),
		to = vector3(-1637.67, 180.1978, 61.74951),
		bucket = 1,
	},
	{
		label = 'Sair da escola',
		coords = vector3(-1637.67, 180.1978, 61.74951),
		to = vector3(-379.8462, -5304.066, 9.616089),
		bucket = 0,
	}
}

perfectCityTeleport = function(location)
	local playerPed = PlayerPedId()
    DoScreenFadeOut(1000)
    Citizen.Wait(2000)
    SetEntityCoords(playerPed, location.to.x, location.to.y, location.to.z, false, false, false, true)
	TriggerServerEvent('perfectCity:Bucket', location.bucket)
    DoScreenFadeIn(1000)
end

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)  
    if onScreen then
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
        local scale = (1/dist)*2
        local fov = (1/GetGameplayCamFov())*100
        local scale = scale*fov

        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.0, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


Citizen.CreateThread(function()
    local _idle = 1000
    while true do
        local ped = PlayerPedId()
        local userCoords = GetEntityCoords(ped)
        
        for i,v in pairs(locs) do
        
            local distance = #(userCoords - v.coords)
            if distance <= 1 and not blockedRecycle then
                DrawText3D(v.coords.x, v.coords.y, v.coords.z, '~b~E~w~ - '..v.label, 255, 255, 255)
                _idle = 1

                if IsControlJustPressed(0, 38) then
                    perfectCityTeleport(v)
                end 
                break
            else 
                _idle = 1000
            end
        end
        Wait(_idle)
    end
end)

local cli = {}
Tunnel.bindInterface('Refem', cli)
local vSERVER = Tunnel.getInterface('Refem')

local foundWeapon = nil

local GetPlayers = function()
    local players = {}
	for _, i in ipairs(GetActivePlayers()) do
        table.insert(players, i)
    end
    return players
end

local GetClosestPlayer = function(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

local Weapons = {
    -- HANDGUNS
    [GetHashKey('WEAPON_SWITCHBLADE')] = 'WEAPON_SWITCHBLADE',
}

cli.takeHostage = function(targetSrc)
    local ply = PlayerPedId()

    ClearPedTasks(ply)
    DetachEntity(ply, true, false)

    if (not Weapons[GetSelectedPedWeapon(ply)]) then
        TriggerEvent('Notify', 'importante', 'Importante', 'Você não está segurando nenhuma <b>FACA</b>.')
        return false
    end

    local plyTarget = GetPlayerPed(GetPlayerFromServerId(targetSrc))
    if (plyTarget and plyTarget > 0) and (not IsEntityPlayingAnim(plyTarget, 'random@mugging3', 'handsup_standing_base', 3)) then
        TriggerEvent('Notify', 'importante', 'Importante', 'O <b>cidadão</b> não se encontra rendido.')
        return false
    end

    foundWeapon = GetHashKey(Weapons[GetSelectedPedWeapon(ply)])

    SetCurrentPedWeapon(ply, foundWeapon, true)
    vSERVER.prefemSync(targetSrc, 'anim@gangops@hostage@', 'anim@gangops@hostage@', 'perp_idle', 'victim_idle', 0.11, -0.24, 0.0, 100000, 0.0, 49, 49, 50, true)
    return true
end

RegisterNetEvent('gb_prefem:syncTarget')
AddEventHandler('gb_prefem:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag,animFlagTarget,attach)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(animationLib)
	while (not HasAnimDictLoaded(animationLib)) do Citizen.Wait(10); end;

	if (spin == nil) then spin = 180.0; end;
	if (attach) then AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false); end;
	if (controlFlag == nil) then controlFlag = 0; end;
	
	if (animation2 == 'victim_fail') then 
		SetEntityHealth(GetPlayerPed(-1), 0)
		DetachEntity(GetPlayerPed(-1), true, false)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
        LocalPlayer.state.victimHostage = false
	elseif (animation2 == 'shoved_back') then 
		DetachEntity(GetPlayerPed(-1), true, false)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
        LocalPlayer.state.victimHostage = false
	else
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)	
	end
end)

RegisterNetEvent('gb_prefem:syncMe')
AddEventHandler('gb_prefem:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	ClearPedSecondaryTask(GetPlayerPed(-1))

	RequestAnimDict(animationLib)
	while (not HasAnimDictLoaded(animationLib)) do Citizen.Wait(10); end;
	if (controlFlag == nil) then controlFlag = 0 end

	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	if (animation == 'perp_fail') then 
		SetPedShootsAtCoord(playerPed, 0.0, 0.0, 0.0, 0)
	end

	if (animation == 'shove_var_a') then 
		Citizen.Wait(900)
		ClearPedSecondaryTask(playerPed)
	end
end)

RegisterNetEvent('gb_prefem:cl_stop')
AddEventHandler('gb_prefem:cl_stop', function()
    local ply = PlayerPedId()

    LocalPlayer.state.BlockTasks = false
    LocalPlayer.state.holdingHostage = false
    LocalPlayer.state.victimHostage = false
	ClearPedTasks(ply)
	DetachEntity(ply, true, false)
end)

AddStateBagChangeHandler('holdingHostage', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            local target = vSERVER.getClosetPedSource()
            while (LocalPlayer.state.holdingHostage) do
                local ply = PlayerPedId()

                if (GetEntityHealth(ply) <= 100) then 
                    TriggerServerEvent('gb_prefem:stop', target)
                    Citizen.Wait(100)
                    releaseHostage()
                    LocalPlayer.state.holdingHostage = false
                end

                DisableControlAction(0,24,true) -- disable attack
                DisableControlAction(0,25,true) -- disable aim
                DisableControlAction(0,47,true) -- disable weapon
                DisableControlAction(0,58,true) -- disable weapon
                DisableControlAction(0, 37, true) -- Tecla Tab
                DisableControlAction(0, 21, true)
                DisablePlayerFiring(ply,true)

                local playerCoords = GetEntityCoords(ply)
			    TextHostage(playerCoords, 'Pressione ~b~[M]~w~ para soltar, ~b~[E]~w~ para matar')

                if (IsControlJustPressed(0, 301)) then
                    LocalPlayer.state.holdingHostage = false
                    TriggerServerEvent('gb_prefem:stop', target)
                    Citizen.Wait(100)
                    releaseHostage()
                elseif (IsControlJustPressed(0, 38)) then
                    LocalPlayer.state.holdingHostage = false
                    TriggerServerEvent('gb_prefem:stop', target)
                    killHostage()
                end
                Citizen.Wait(1)
            end
        end)
    end
end)

AddStateBagChangeHandler('victimHostage', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.victimHostage) do
                DisableControlAction(0,21,true) -- disable sprint
                DisableControlAction(0,24,true) -- disable attack
                DisableControlAction(0,25,true) -- disable aim
                DisableControlAction(0,47,true) -- disable weapon
                DisableControlAction(0,58,true) -- disable weapon
                DisableControlAction(0,263,true) -- disable melee
                DisableControlAction(0,264,true) -- disable melee
                DisableControlAction(0,257,true) -- disable melee
                DisableControlAction(0,140,true) -- disable melee
                DisableControlAction(0,141,true) -- disable melee
                DisableControlAction(0,142,true) -- disable melee
                DisableControlAction(0,143,true) -- disable melee
                DisableControlAction(0,75,true) -- disable exit vehicle
                DisableControlAction(27,75,true) -- disable exit vehicle  
                DisableControlAction(0,22,true) -- disable jump
                DisableControlAction(0,32,true) -- disable move up
                DisableControlAction(0,268,true)
                DisableControlAction(0,33,true) -- disable move down
                DisableControlAction(0,269,true)
                DisableControlAction(0,34,true) -- disable move left
                DisableControlAction(0,270,true)
                DisableControlAction(0,35,true) -- disable move right
                DisableControlAction(0,271,true)
                Citizen.Wait(1)
            end
        end)
    end
end)

releaseHostage = function()
	local player = PlayerPedId()	
	lib = 'reaction@shove'
	anim1 = 'shove_var_a'
	lib2 = 'reaction@shove'
	anim2 = 'shoved_back'
	distans = 0.11 --Higher = closer to camera
	distans2 = -0.24 --higher = left
	height = 0.0
	spin = 0.0		
	length = 100000
	controlFlagMe = 120
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
	local closestPlayer = GetClosestPlayer(1.5)
	if (closestPlayer ~= nil) then
		TriggerServerEvent('gb_prefem:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	end
end 

killHostage = function()
	local player = PlayerPedId()	
	lib = 'anim@gangops@hostage@'
	anim1 = 'perp_fail'
	lib2 = 'anim@gangops@hostage@'
	anim2 = 'victim_fail'
	distans = 0.11 --Higher = closer to camera
	distans2 = -0.24 --higher = left
	height = 0.0
	spin = 0.0		
	length = 0.2
	controlFlagMe = 168
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
	local closestPlayer = GetClosestPlayer(1.5)
	if (closestPlayer ~= nil) then
		TriggerServerEvent('gb_prefem:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
        TriggerServerEvent('gb_prefem:killHostage')
    end	
end

TextHostage = function(coords, text)
	SetDrawOrigin(coords.x, coords.y, coords.z, 0); 
	SetTextFont(4)     
	SetTextProportional(0)     
	SetTextScale(0.35,0.35)    
	SetTextColour(255,255,255,155)   
	SetTextDropshadow(0, 0, 0, 0, 255)     
	SetTextEdge(2, 0, 0, 0, 150)     
	SetTextDropShadow()     SetTextOutline()     
	SetTextEntry("STRING")     SetTextCentre(1)     
	AddTextComponentString(text) 
	DrawText(0.0, 0.0)     
	ClearDrawOrigin() 
end
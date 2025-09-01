--======================================================================================================================
-- BALCKIST VEHICLES
--======================================================================================================================
local inVehicle = false

local blackVehicles = {
    [GetHashKey('minitank')] = { 'Mini Tanque', true },
    [GetHashKey('oppressor2')] = { 'Oppressor 2', true },
	[GetHashKey('khanjali')] = { 'Khanjali', true },
	-- [GetHashKey('rhino')] = { 'Rhino', true },
	-- [GetHashKey('hydra')] = { 'Hydra', true },
	[GetHashKey('lazer')] = { 'Lazer', true },    
    [GetHashKey('apc')] = { 'APC', true }
}

AddEventHandler('gameEventTriggered', function(event, args)
    if (event == 'CEventNetworkPlayerEnteredVehicle') then
        local id = args[1]
        local vehicle = args[2]
        if (id == PlayerId()) then            
            if (inVehicle) then return; end;

            inVehicle = true
            -- ExecuteCommand('-drift')

            local model = GetEntityModel(vehicle)
            if (blackVehicles[model]) then 
                if (blackVehicles[model][2]) then TriggerServerEvent('gb_anticheat', 'vehicles', blackVehicles[model][1]);  end;
            end
            drivingVehicle(model)

            local class = GetVehicleClass(vehicle)
            if (class ~= 14 and class ~= 13) then damageCar(class); end;

            if (class == 15) then heliCam(); end;

            Citizen.Wait(3500)
            ClearPedTasks(PlayerPedId())
        end
    end
end)
--======================================================================================================================
-- DRIFT
--======================================================================================================================
-- local keyPressed = false
-- RegisterKeyMapping('+drift', 'Garagem - Drift', 'keyboard', 'LSHIFT')
-- RegisterCommand('+drift', function()
--     keyPressed = true
--     local ped = PlayerPedId()
-- 	if (IsPedInAnyVehicle(ped)) then
-- 		local vehicle = GetVehiclePedIsIn(ped)
-- 		local speed = (GetEntitySpeed(vehicle) * 3.6)
-- 		if (GetPedInVehicleSeat(vehicle, -1) == ped) then
-- 			if (speed <= 160.0) then
-- 				if (keyPressed) then SetVehicleReduceGrip(vehicle, true); end;
-- 			end
-- 		end
-- 	end
-- end)

-- RegisterCommand('-drift', function()
-- 	local vehicle = GetVehiclePedIsIn(PlayerPedId())
-- 	SetVehicleReduceGrip(vehicle, false)
--     keyPressed = false
-- end)
--======================================================================================================================
-- LOCK WEAPONS INSIDE
--======================================================================================================================
local weaponLock = {
    [GetHashKey('kuruma2')] = true,
    [GetHashKey('monalisa')] = true,
    [GetHashKey('foxct')] = true,
    [GetHashKey('6x6')] = true,
    [GetHashKey('p1lbwk')] = true,
    [GetHashKey('6x6ev')] = true,
    [GetHashKey('x6mf962')] = true
}

local shuffleDelay = false

drivingVehicle = function(model)
    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            local idle = 1000
            inVehicle = IsPedInAnyVehicle(ped)
            if (inVehicle) then                
                local vehicle = GetVehiclePedIsIn(ped)
                if (weaponLock[model]) then SetPlayerCanDoDriveBy(PlayerId(), false); end;
                
                if (IsPedShooting(ped)) then
                    if (not IsPedInAnyHeli(ped)) then
                        idle = 1
                        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
                    end
                end

                if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) then
                    idle = 1

                    -- P1 NÃO ATIRAR
                    -- if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                    --     DisablePlayerFiring(ped, true)
                    -- end

                    -- RETIRAR O CHUTE DA MOTO
                    if (GetVehicleClass(vehicle) == 8) then
                        DisableControlAction(0, 345, true)
                        SetPedConfigFlag(ped, 35, false) 
                    end

					if IsControlPressed(0,75) and (not shuffleDelay) then
						shuffleDelay = true
						SetTimeout(5000,function()
							shuffleDelay = false
						end)
                    end

                    -- SEAT SHUFFLE
					if GetIsTaskActive(ped, 165) then
						if (not shuffleDelay) and (not GetIsTaskActive(ped, 164)) then
							SetPedIntoVehicle(ped, vehicle, 0)
						end
					end
				end    
            end
            Citizen.Wait(idle)
        end
        SetPlayerCanDoDriveBy(PlayerId(), true)
    end)
end
--======================================================================================================================
-- DAMAGES
--======================================================================================================================
local pedInSameVehicleLast = false
local vehicle = nil
local lastVehicle = nil
local vehicleClass = nil

local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local classDamageMultiplier = { [0] = 0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.0,0.0,1.0,0.2,0.2,0.2,0.2,0.2,0.2,0.2 }

local isPedDrivingAVehicle = function()
	local ped = PlayerPedId()
	vehicle = GetVehiclePedIsIn(ped)
	if (IsPedInAnyVehicle(ped)) then
		if (GetPedInVehicleSeat(vehicle,-1) == ped) then
			local class = GetVehicleClass(vehicle)
			if (class ~= 13 and class ~= 14) then
				return true
			end
		end
	end
	return false
end

damageCar = function(class)
    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)
            
            local idle = 1000
            if (pedInSameVehicleLast) then
				idle = 1
				local factor = 1.0
				if (healthEngineNew < 900) then factor = ((healthEngineNew + 200.0) / 1100); end;
				SetVehicleEngineTorqueMultiplier(vehicle, factor)
			end

            if (class ~= 15 and class ~= 16) then
                local roll = GetEntityRoll(vehicle)
                if ((roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2) then
                    DisableControlAction(2, 59, true)
                    DisableControlAction(2, 60, true)
                end
            end
            Citizen.Wait(idle)
        end
    end)

    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)

            if (class ~= 15 and class ~= 16) then
                local roll = GetEntityRoll(vehicle)
                if (roll > 75.0 or roll < -75.0) then
                    local tyre = math.random(4)
                    if (math.random(100) <= 50) then
                        if (tyre == 1) then
                            if (not IsVehicleTyreBurst(vehicle, 0, false)) then SetVehicleTyreBurst(vehicle, 0, true, 1000.0); end;
                        elseif (tyre == 2) then
                            if (not IsVehicleTyreBurst(vehicle, 1, false)) then SetVehicleTyreBurst(vehicle, 1, true, 1000.0); end;
                        elseif (tyre == 3) then
                            if (not IsVehicleTyreBurst(vehicle, 4, false)) then SetVehicleTyreBurst(vehicle, 4, true, 1000.0); end;
                        elseif (tyre == 4) then
                            if (not IsVehicleTyreBurst(vehicle, 5, false)) then SetVehicleTyreBurst(vehicle, 5, true, 1000.0); end;
                        end
                    end
                end
            end
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while (inVehicle) do
            local ped = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(ped)

            local idle = 1000
            if (isPedDrivingAVehicle() and GetPedInVehicleSeat(vehicle, -1) == ped) then
                idle = 100

                vehicle = GetVehiclePedIsIn(ped)
                vehicleClass = GetVehicleClass(vehicle)
                healthEngineCurrent = GetVehicleEngineHealth(vehicle)

                if (healthEngineCurrent >= 1000) then healthEngineLast = 1000.0; end;

                healthEngineNew = healthEngineCurrent
				healthEngineDelta = (healthEngineLast - healthEngineCurrent)
				healthEngineDeltaScaled = (healthEngineDelta * 1.2 * classDamageMultiplier[vehicleClass])
				healthBodyCurrent = GetVehicleBodyHealth(vehicle)

                if (healthBodyCurrent == 1000) then healthBodyLast = 1000.0; end;

                healthBodyNew = healthBodyCurrent
				healthBodyDelta = (healthBodyLast - healthBodyCurrent)
				healthBodyDeltaScaled = (healthBodyDelta * 1.2 * classDamageMultiplier[vehicleClass])

                if (healthEngineCurrent > 100.0) then SetVehicleUndriveable(vehicle, false); end;
	
				if (healthEngineCurrent <= 100.0) then SetVehicleUndriveable(vehicle, true); end;
	
				if (vehicle ~= lastVehicle) then pedInSameVehicleLast = false; end;

                if (pedInSameVehicleLast) then
					if (healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0) then
						local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled,healthBodyDeltaScaled)
						if (healthEngineCombinedDelta > (healthEngineCurrent - 100.0)) then healthEngineCombinedDelta = (healthEngineCombinedDelta * 0.7); end;
	
						if (healthEngineCombinedDelta > healthEngineCurrent) then healthEngineCombinedDelta = (healthEngineCurrent - (210.0 / 5)); end;
						healthEngineNew = (healthEngineLast - healthEngineCombinedDelta)
	
						if (healthEngineNew > (210.0 + 5) and healthEngineNew < 477.0) then healthEngineNew = (healthEngineNew-(0.038 * 3.2)); end;
	
						if (healthEngineNew < 210.0) then healthEngineNew = (healthEngineNew-(0.1 * 0.9)); end;
	
						if (healthEngineNew < 100.0) then healthEngineNew = 100.0; end;
	
						if (healthBodyNew < 0) then healthBodyNew = 0.0; end;
					end
				else
					if (healthBodyCurrent < 210.0) then healthBodyNew = 210.0; end;
					pedInSameVehicleLast = true
				end

                if (healthEngineNew ~= healthEngineCurrent) then SetVehicleEngineHealth(vehicle, healthEngineNew); end;
	
				if (healthBodyNew ~= healthBodyCurrent) then SetVehicleBodyHealth(vehicle, healthBodyNew); end;
	
				healthEngineLast = healthEngineNew
				healthBodyLast = healthBodyNew
				lastVehicle = vehicle
            else
                pedInSameVehicleLast = false
            end
            Citizen.Wait(idle)
        end
    end)
end
--======================================================================================================================
-- NO CAR JACK
--======================================================================================================================
Citizen.CreateThread(
    function()
        while (true) do
            local idle = 700
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped)
            if (vehicle > 0) and not LocalPlayer.state.inEvent and not LocalPlayer.state.isPlayingEvent then
                local stateBag = Entity(vehicle).state
                if (not stateBag["id"]) and not stateBag.inAbandoned and not stateBag.inTraining then
                    if (not stateBag["lockpicked"]) then
                        idle = 1
                        SetVehicleUndriveable(vehicle, true)
                        SetVehicleEngineOn(vehicle, false, true, true)
                    end
                end
            end
            Citizen.Wait(idle)
        end
    end
)

AddStateBagChangeHandler('lockpicked', nil, function(bagName, key, value) 
	local entity = GetPlayerFromStateBagName(bagName)
	if (not DoesEntityExist(entity)) then return; end;
	if value then
		SetVehicleHasBeenOwnedByPlayer(entity, true)
		SetEntityAsMissionEntity(entity,true,true)
		SetEntityCleanupByEngine(entity,false)
	end
end)
--======================================================================================================================
-- ENTER TRUNK
--======================================================================================================================
local vehicleTrunk, vehNetTrunk = nil

local inTrunk = false


RegisterNetEvent('garage:enterTrunk', function(entity,netId)
    local ped = PlayerPedId()
	local vehicle, vehNet = vRP.vehList(5.0)
	if entity then
		vehicle, vehNet = entity, VehToNet(entity)
	end
	if netId and NetworkDoesNetworkIdExist(netId) then
		vehicle, vehNet = NetToVeh(netId), netId
	end
	if DoesEntityExist(vehicle) then
		if (not inTrunk) then
			if (DoesEntityExist(vehicle) and not IsPedInAnyVehicle(ped)) then
				if (sGARAGE.checkTrunk(vehNet)) then
					if (GetVehicleDoorLockStatus(vehicle) == 1) then
						local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
						if (trunk ~= -1) then
							
							ClearPedTasksImmediately(ped)							
							for k,v in pairs(GetActivePlayers()) do
								if IsEntityAttachedToEntity(GetPlayerPed(v),ped) then
									return
								end
							end

							if IsPedInAnyVehicle(ped,true) then
								return
							end

							if LocalPlayer.state.Prison then
								return
							end

							local coords = GetEntityCoords(ped)
							local coordsEnt = GetWorldPositionOfEntityBone(vehicle, trunk)
							local distance = #(coords - coordsEnt)
							if (distance <= 3.0) then
								if (GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 and GetVehicleDoorsLockedForPlayer(vehicle, PlayerId()) ~= 1) then
									LocalPlayer.state.disableTarget = true
									sGARAGE.insertTrunk(vehNet)
									vehicleTrunk = vehicle
									vehNetTrunk = vehNet
									SetCarBootOpen(vehicle)
									SetEntityVisible(ped, false, false)
									Citizen.Wait(750)
									AttachEntityToEntity(ped, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
									inTrunk = true
									trunkThread()
									Citizen.Wait(500)
									SetVehicleDoorShut(vehicle, 5)
								end
							end
						end
					else
						TriggerEvent('Notify', 'negado', 'Garagem', 'O <b>veículo</b> se encontra trancado.')
					end
				end
			end
		else
			sGARAGE.removeTrunk(vehNet)
		end
	end
end)

RegisterNetEvent('garage:checkTrunk', function()
	local ped = PlayerPedId()
	if (inTrunk) then
		local vehicle = GetEntityAttachedTo(ped)
		if (DoesEntityExist(vehicle)) then
			SetCarBootOpen(vehicle)
			Citizen.Wait(750)
			inTrunk = false
			sGARAGE.removeTrunk(vehNetTrunk)
			LocalPlayer.state.disableTarget = false
			vehicleTrunk, vehNetTrunk = nil
			DetachEntity(ped, false, false)
			SetEntityVisible(ped, true, false)
			SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.5, -0.75))
			Citizen.Wait(500)
			SetVehicleDoorShut(vehicle, 5)
		end
	end
end)

trunkThread = function()
	Citizen.CreateThread(function()
		while (inTrunk) do
			local idle = 100
			if (inTrunk) then
				local ped = PlayerPedId()
				local vehicle = GetEntityAttachedTo(ped)
				if (DoesEntityExist(vehicle) and (not IsPedInAnyVehicle(ped,false))) then
					idle = 1

					Text2D(0, 0.375, 0.9, 'PRESSIONE ~b~E~w~ PARA SAIR DO PORTA-MALAS', 0.4)

					DisableControlAction(1,73,true)
					DisableControlAction(1,29,true)
					DisableControlAction(1,47,true)
					DisableControlAction(1,187,true)
					DisableControlAction(1,189,true)
					DisableControlAction(1,190,true)
					DisableControlAction(1,188,true)
					DisableControlAction(1,311,true)
					DisableControlAction(1,245,true)
					DisableControlAction(1,257,true)
					DisableControlAction(1,167,true)
					DisableControlAction(1,140,true)
					DisableControlAction(1,141,true)
					DisableControlAction(1,142,true)
					DisableControlAction(1,137,true)
					DisableControlAction(1,37,true)
					DisablePlayerFiring(ped,true)

					if (IsEntityVisible(ped)) then SetEntityVisible(ped, false, false); end;

					if (IsControlJustPressed(1, 38)) then
						SetCarBootOpen(vehicle)
						Citizen.Wait(750)
						inTrunk = false
						LocalPlayer.state.disableTarget = false
						sGARAGE.removeTrunk(vehNetTrunk)
						vehicleTrunk, vehNetTrunk = nil
						DetachEntity(ped, false, false)
						SetEntityVisible(ped, true, false)
						SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.5, -0.75))
						Citizen.Wait(500)
						SetVehicleDoorShut(vehicle, 5)
					end
				else
					inTrunk = false
					LocalPlayer.state.disableTarget = false
					sGARAGE.removeTrunk(vehNetTrunk)
					vehicleTrunk, vehNetTrunk = nil
					DetachEntity(ped, false, false)
					SetEntityVisible(ped, true, false)
					SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.5, -0.75))
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end

exports('inTrunk', function() return inTrunk; end)

Citizen.CreateThread(function()
	local function GetSourceByPed(_ped)
		return GetPlayerServerId(NetworkGetPlayerIndexFromPed(_ped))
	end

	exports.target:RemoveTargetBone('boot',{ 'Entrar no Porta-Malas', 'Verificar Porta-Malas' })
    exports.target:AddTargetBone('boot',{
        options = { 
            {
                icon = 'fas fa-person-through-window',
                label = 'Entrar no Porta-Malas',
                action = function(entity)
                    TriggerEvent('garage:enterTrunk',entity)
                end,
                distance = 1.5
            },
			{
                icon = 'fas fa-search',
                label = 'Verificar Porta-Malas',
                action = function(entity)
                    TriggerServerEvent('gb_interactions:checkTrunkin')
                end,
                distance = 1.5
            },
        }
    })

	exports.target:RemoveGlobalPlayer({'Colocar no Porta-Mala'})
	exports.target:AddGlobalPlayer({
		options = {
			{
				action = function(entity)
					local vehicle = vRP.getNearestVehicle(5.0)
					if vehicle and NetworkGetEntityIsNetworked(vehicle) then
						if (GetVehicleDoorAngleRatio(vehicle, 5) < 0.9) and (GetVehicleDoorLockStatus(vehicle) == 1) then
							TriggerServerEvent('garage:putToTrunk', GetSourceByPed(entity), VehToNet(vehicle))
						end
					else
						TriggerEvent('Notify', 'importante', 'Garagem', 'Nenhum <b>veículo</b> por perto!')
					end
				end,
				canInteract = function(entity)
					local vehicle = vRP.getNearestVehicle(5.0)
					if vehicle and NetworkGetEntityIsNetworked(vehicle) then
						if (GetVehicleDoorAngleRatio(vehicle, 5) < 0.9) and (GetVehicleDoorLockStatus(vehicle) == 1) then
							if (IsEntityPlayingAnim(entity, 'mp_arresting', 'idle', 3) or IsEntityPlayingAnim(entity, 'random@arrests@busted', 'idle_a', 3)) and (GetEntityHealth(entity) > 100) then
								return true
							end
						end
					end
					return false
				end,

				icon = "fas fa-person-through-window",
				label = "Colocar no Porta-Mala",
			},
		},
		distance = 2.0
	})
end)

Text2D = function(font, x, y, text, scale)
	SetTextFont(font)
	SetTextProportional(7)
	SetTextScale(scale, scale)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(4, 0, 0, 0, 255)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end
--======================================================================================================================
-- SYNC REPAIR
--======================================================================================================================
RegisterNetEvent('syncreparar', function(index)
	if (NetworkDoesNetworkIdExist(index)) then
		local vehicle = NetToVeh(index)
		if (DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle)) then
            local fuel = GetVehicleFuelLevel(vehicle)
            SetVehicleFixed(vehicle)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleOnGroundProperly(vehicle)
            SetVehicleFuelLevel(vehicle, fuel)
            checkDeformations(vehicle)
		end
	end
end)

RegisterNetEvent('syncrepairkit', function(index, bool)
	if (NetworkDoesNetworkIdExist(index)) then
		local vehicle = NetToVeh(index)
		if (DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle)) then
            local fuel = GetVehicleFuelLevel(vehicle)
			
			SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleUndriveable(vehicle, false)
			SetVehicleOnGroundProperly(vehicle)
			SetVehicleEngineHealth(vehicle, 1000.0)

			if (bool) then
				local tyres = {}
				for i=0, 5 do
					tyres[i] = GetTyreHealth(vehicle, i)
				end

				SetVehicleBodyHealth(vehicle, 1000.0)
				SetVehicleDeformationFixed(vehicle)
				RemoveDecalsFromVehicle(vehicle)
				SetVehicleFixed(vehicle)

				for i=0, 5 do
					if (tyres[i] ~= 1000.0) then
                        SetVehicleTyreBurst(vehicle, i, true, 1000.0)
                    end
				end
			end
			
			SetVehicleFuelLevel(vehicle, fuel)
            checkDeformations(vehicle)
		end
	end
end)
--======================================================================================================================
-- ANCHOR
--======================================================================================================================
local vehAnchor = false
local boatanchor = false

function cGARAGE.getVehicleAnchor()
    return vehAnchor, (vehAnchor and 'Destravando o veículo...' or 'Travando o veículo...')
end

function cGARAGE.vehicleAnchor(vnet, bool, noNotify)
	if (NetworkDoesNetworkIdExist(vnet)) then
		local vehicle = NetToVeh(vnet)
		if (IsEntityAVehicle(vehicle)) then
			if (bool ~= nil) then
				if (not noNotify) then
					TriggerEvent('Notify', 'sucesso', 'Garagem', 'O veículo foi <b>'..((bool and 'travado') or 'destravado')..'</b>.')
				end
				FreezeEntityPosition(vehicle, (bool == true))
			else
				vehAnchor = (not vehAnchor)
				if (not noNotify) then
					TriggerEvent('Notify', 'sucesso', 'Garagem', 'O veículo foi <b>'..((vehAnchor and 'travado') or 'destravado')..'</b>.')
				end
				FreezeEntityPosition(vehicle, (vehAnchor == true))
			end
		end
	end
end

function cGARAGE.boatAnchor(vehicle)
	if (IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) == 14) then
		if (boatanchor) then
			TriggerEvent('Notify', 'sucesso', 'Garagem', 'O <b>barco</b> foi desancorado.')
			FreezeEntityPosition(vehicle, false)
			boatanchor = false
		else
			TriggerEvent('Notify', 'sucesso', 'Garagem', 'O <b>barco</b> foi ancorado.')
			FreezeEntityPosition(vehicle, true)
			boatanchor = true
		end
	end
end


-- [Bloquear tiro de dentro de blindado] --
Citizen.CreateThread(function()
    while true do
        local _idle = 1000
        local ped = PlayerPedId()
        
        if IsPedInAnyVehicle(ped, false) then
            _idle = 100

			local vehicle = GetVehiclePedIsIn(ped, false)
			local model = GetEntityModel(vehicle)
			local vehicleName = exports['garage']:vehHashData(model)

			if vehicleShootConfig(vehicleName) then
				if IsPedArmed(ped, 7) then
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				end
			
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 25, true) 
				DisableControlAction(0, 69, true) 
				DisableControlAction(0, 70, true) 
				DisableControlAction(0, 92, true) 
				DisableControlAction(0, 114, true) 
				DisableControlAction(0, 257, true) 
				DisableControlAction(0, 331, true) 
			end
        else
            EnableControlAction(0, 24, true)
            EnableControlAction(0, 25, true)
        end
        Citizen.Wait(_idle)
    end
end)

RegisterNetEvent("enableHydraCannon")
AddEventHandler("enableHydraCannon", function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle and GetEntityModel(vehicle) == GetHashKey("hydra") then
        -- Ativa o canhão
        local weaponHash = GetHashKey("VEHICLE_WEAPON_HYDRA_CANNON")
        GiveWeaponToVehicle(vehicle, weaponHash)

        -- Configura o modificador de dano (opcional)
        SetVehicleWeaponDamageModifier(vehicle, 1.0)

        -- Feedback para o jogador
        TriggerEvent("chat:addMessage", {
            args = { "Sistema", "Canhão do Hydra habilitado!" }
        })
    end
end)
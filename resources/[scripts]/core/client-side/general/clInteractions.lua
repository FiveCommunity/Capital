cacheInteractions = {}

local setPed = {
    [GetHashKey('mp_m_freemode_01')] = {
        _Handcuff = { 7, 41, 0, 2 }
    },
    [GetHashKey('mp_f_freemode_01')] = {
        _Handcuff = {  7, 25, 0, 2 }
    }
}

-- RegisterKeyMapping('+algemar', 'Interação - Algemar', 'keyboard', 'G')
-- RegisterCommand('+algemar', function() if (not IsPedInAnyVehicle(PlayerPedId())) then TriggerServerEvent('gb_interactions:handcuff') end; end)

cacheInteractions['gb:attach:src'] = nil
cacheInteractions['gb:attach:active'] = false

RegisterNetEvent('gb:attach', function(_source, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, rotationOrder, syncRot)
    cacheInteractions['gb:attach:src'] = _source
    cacheInteractions['gb:attach:active'] = (not cacheInteractions['gb:attach:active'])
    local ped = PlayerPedId()
	if (cacheInteractions['gb:attach:active']) then
		local player = GetPlayerFromServerId(cacheInteractions['gb:attach:src'])
		if (player > -1) then
			AttachEntityToEntity(ped, GetPlayerPed(player), boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, rotationOrder, syncRot)
		end
	else
		DetachEntity(ped, true, false)
	end
end)

RegisterNetEvent('gb_interactions:algemas', function(action)
    local ped = PlayerPedId()
    if (action == 'colocar') then
        local Handcuff = setPed[GetEntityModel(ped)]
        if (Handcuff) and Handcuff._Handcuff then Handcuff = Handcuff._Handcuff SetPedComponentVariation(ped, Handcuff[1], Handcuff[2], Handcuff[3], Handcuff[4]); end;
    else
        SetPedComponentVariation(ped, 7, 0, 0, 2)
    end
end)

-- RegisterKeyMapping('+carregar', 'Interação - Carregar', 'keyboard', 'H')
-- RegisterCommand('+carregar', function() if (not IsPedInAnyVehicle(PlayerPedId())) then TriggerServerEvent('gb_interactions:carregar') end; end)

cacheInteractions['carregar:src'] = nil
cacheInteractions['carregar:active'] = false

RegisterNetEvent('carregar', function(_source)
	LocalPlayer.state.BlockTasks = true
    cacheInteractions['carregar:src'] = _source
    cacheInteractions['carregar:active'] = (not cacheInteractions['carregar:active'])
    local ped = PlayerPedId()
	if (cacheInteractions['carregar:active']) then
		local player = GetPlayerFromServerId(cacheInteractions['carregar:src'])
		if (player > -1) then
			AttachEntityToEntity(ped, GetPlayerPed(player), 4103, -0.65816, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		end
	else
		LocalPlayer.state.BlockTasks = false
		DetachEntity(ped, true, false)
	end
end)

local PlayerData = {}
PlayerData['temp:wins'] = false

RegisterCommand('wins', function()
	local vehicle = vRP.getNearestVehicle(5)
	if (IsEntityAVehicle(vehicle)) then
		PlayerData['temp:wins'] = (not PlayerData['temp:wins'])
		TriggerServerEvent('trywins', VehToNet(vehicle), PlayerData['temp:wins'])
	end
end)

RegisterNetEvent('gb_interactions:carWins', function()
    local vehicle = vRP.getNearestVehicle(5)
	if (IsEntityAVehicle(vehicle)) then
		PlayerData['temp:wins'] = (not PlayerData['temp:wins'])
		TriggerServerEvent('trywins', VehToNet(vehicle), PlayerData['temp:wins'])
	end
end)

RegisterNetEvent('syncwins', function(index, open)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if open then
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				else
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				end
			end
		end
	end
end)

RegisterCommand('seat', function(source, args)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if (GetEntityHealth(ped) > 100) then
		if LocalPlayer.state.Handcuff or LocalPlayer.state.StraightJacket then TriggerEvent('notify', 'Seat', 'Você não pode trocar de assento estando algemado.') return end
		if (IsEntityAVehicle(vehicle) and IsPedInAnyVehicle(ped)) then 
			local seat = 0
			if (parseInt(args[1]) <= 1) then
				seat = -1
			else
				seat = parseInt(args[1])-2
			end
			if (IsVehicleSeatFree(vehicle, seat)) then
				SetPedIntoVehicle(ped, vehicle, seat)
			else
				TriggerEvent('notify', 'Seat', 'Este <b>assento</b> está ocupado.')
			end
		else
			TriggerEvent('notify', 'Seat', 'Você não está dentro de um <b>veículo</b>.')
		end
	end
end)


RegisterCommand('doors', function(source, args)
	local vehicle = vRP.getNearestVehicle(7.0)
	if (IsEntityAVehicle(vehicle)) then
		TriggerServerEvent('trydoors', VehToNet(vehicle), parseInt(args[1]))
	end
end)

RegisterNetEvent('gb_interactions:carDoors', function(value)
    local vehicle = vRP.getNearestVehicle(7.0)
	if (IsEntityAVehicle(vehicle)) then
		TriggerServerEvent('trydoors', VehToNet(vehicle), value)
	end
end)

RegisterNetEvent('syncdoors', function(index, door)
	if (NetworkDoesNetworkIdExist(index)) then
		local v = NetToVeh(index)
		if (DoesEntityExist(v)) then
			if (IsEntityAVehicle(v)) then
				if (door == 1) then
					if (GetVehicleDoorAngleRatio(v, 0) == 0) then
						SetVehicleDoorOpen(v, 0, 0, 0)
					else
						SetVehicleDoorShut(v, 0, 0)
					end
				elseif (door == 2) then
					if (GetVehicleDoorAngleRatio(v, 1) == 0) then
						SetVehicleDoorOpen(v, 1, 0, 0)
					else
						SetVehicleDoorShut(v, 1, 0)
					end
				elseif (door == 3) then
					if (GetVehicleDoorAngleRatio(v, 2) == 0) then
						SetVehicleDoorOpen(v, 2, 0, 0)
					else
						SetVehicleDoorShut(v, 2, 0)
					end
				elseif (door == 4) then
					if (GetVehicleDoorAngleRatio(v, 3) == 0) then
						SetVehicleDoorOpen(v, 3, 0, 0)
					else
						SetVehicleDoorShut(v, 3, 0)
					end
                elseif (door == 5) then
                    if (GetVehicleDoorAngleRatio(v,5) == 0) then
                        SetVehicleDoorOpen(v,5,0,0)
                    else
                        SetVehicleDoorShut(v,5,0)
                    end
                elseif (door == 6) then
                    if (GetVehicleDoorAngleRatio(v,4) == 0) then
                        SetVehicleDoorOpen(v,4,0,0)
                    else
                        SetVehicleDoorShut(v,4,0)
                    end
				else
                    local isopen = (GetVehicleDoorAngleRatio(v, 0) and GetVehicleDoorAngleRatio(v, 1))
					if (isopen == 0) then
						SetVehicleDoorOpen(v, 0 ,0 ,0)
						SetVehicleDoorOpen(v, 1 ,0 ,0)
						SetVehicleDoorOpen(v, 2 ,0 ,0)
						SetVehicleDoorOpen(v, 3 ,0 ,0)
                        SetVehicleDoorOpen(v, 4, 0, 0)
                        SetVehicleDoorOpen(v, 5, 0, 0)
					else
						SetVehicleDoorShut(v, 0, 0)
						SetVehicleDoorShut(v, 1, 0)
						SetVehicleDoorShut(v, 2, 0)
						SetVehicleDoorShut(v, 3, 0)
                        SetVehicleDoorShut(v, 4, 0)
                        SetVehicleDoorShut(v, 5, 0)
					end
				end
			end
		end
	end
end)

local BlipsPerimetro = {}

RegisterNetEvent('BlipPerimetro', function(id, coords, distance, open)
	if (open) then
		BlipsPerimetro[id] = {}
		if (not DoesBlipExist(BlipsPerimetro[id][1]) and not DoesBlipExist(BlipsPerimetro[id][2])) then

			BlipsPerimetro[id][1] = AddBlipForRadius(coords, (distance + 0.0))
			SetBlipColour(BlipsPerimetro[id][1], 1)
			SetBlipAlpha(BlipsPerimetro[id][1], 90)
			SetBlipDisplay(BlipsPerimetro[id][1], 8)

			BlipsPerimetro[id][2] = AddBlipForCoord(coords)
			SetBlipSprite(BlipsPerimetro[id][2], 58)
			SetBlipAsShortRange(BlipsPerimetro[id][2], true)
			SetBlipColour(BlipsPerimetro[id][2], 0)
			SetBlipScale(BlipsPerimetro[id][2], 0.5)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Perímetro Fechado') 
			EndTextCommandSetBlipName(BlipsPerimetro[id][2])
		end
	else
		if (DoesBlipExist(BlipsPerimetro[id][1]) and DoesBlipExist(BlipsPerimetro[id][2])) then
			RemoveBlip(BlipsPerimetro[id][1]) 
			RemoveBlip(BlipsPerimetro[id][2]) 
		end
	end
end)

function GetSourceByPed(_ped)
	return GetPlayerServerId(NetworkGetPlayerIndexFromPed(_ped))
end

Citizen.CreateThread(function()
	exports.target:RemoveGlobalPlayer({'Revistar','Reanimar'})
	exports.target:AddGlobalPlayer({
		options = {
			{
				action = function(entity)
					TriggerServerEvent('vrp_inventory:revistar', GetSourceByPed(entity))
				end,
				canInteract = function(entity)
					if (IsEntityPlayingAnim(entity, 'mp_arresting', 'idle', 3) or IsEntityPlayingAnim(entity, 'random@arrests@busted', 'idle_a', 3) or IsEntityPlayingAnim(entity, 'random@mugging3', 'handsup_standing_base', 3)) and (GetEntityHealth(entity) > 100) then
						return true
					end
					return false
				end,

				icon = "fas fa-search",
				label = "Revistar",
			},

			{
				action = function(entity)
					TriggerServerEvent('gb_interactions:reanimar', GetSourceByPed(entity))
				end,

				canInteract = function(entity)
					return (GetEntityHealth(entity) <= 100) or IsPedDeadOrDying(entity)
				end,

				icon = "fas fa-search",
				permissions = { 
					'hospital.permissao', 
					'+PMC.TenenteCoronel', 
					'+FT.TenenteCoronel',
					'+GCC.TenenteCoronel',
					'+Rota.TenenteCoronel',
					'@PC.DelegadoGeral',
					'@PRF.DelegadoGeral',
				},
				label = "Reanimar",
			},
		},
		distance = 2.0
	})
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) 
        InvalidateIdleCam() 
        InvalidateVehicleIdleCam()
    end
end)

RegisterNetEvent('sync:start_face', function()
    local ped = PlayerPedId()
    local features = {}

    for i = 0, 14 do 
        features[i] = GetPedFaceFeature(ped, i)
    end

    local pedNetId = NetworkGetNetworkIdFromEntity(ped)
    TriggerServerEvent("sync:faceFeatures", pedNetId, features)
end)
    
RegisterNetEvent("sync:applyFaceFeatures", function(pedNetId, features)
    local playerPed = NetworkGetEntityFromNetworkId(pedNetId)
    if DoesEntityExist(playerPed) then
        for index, value in pairs(features) do
            SetPedFaceFeature(playerPed, tonumber(index), value)
        end
    end
end)
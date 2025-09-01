local vSERVER = Tunnel.getInterface('NpcDrugs')

local npcsCache = {}

local pedCache = {};
local pedClosest = function(distance)
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	for _, npc in pairs(GetGamePool('CPed')) do
		if (npc  ~= PlayerPedId() and not IsPedAPlayer(npc)) and (not IsEntityDead(npc) and not IsPedDeadOrDying(npc) and not IsPedInAnyVehicle(npc) and GetPedArmour(npc) <= 0) and (GetPedType(npc) ~= 28) then
			local dist = #(pedCoords - GetEntityCoords(npc))
			if (dist <= distance) then
				return npc
			end
		end
	end
	return false
end	

local getLastVehicle = function(ped)
	if IsPedInAnyVehicle(ped,false) or (GetVehiclePedIsIn(ped,true) > 0) then
		TaskWanderStandard(ped,10.0,10)
		TriggerEvent('notify', 'negado', 'Venda de Drogas', 'Por favor, não faça isso comigo! Leve tudo, mas não me force a comprar <b>drogas</b>.')
		return true
	end
	return false
end

local action = false;
RegisterCommand('+pressedSellDrug', function()
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	if (not IsPedInAnyVehicle(ped)) and (GetEntityHealth(ped) > 100) then
		local pedClosest = pedClosest(2.5)
		if (pedClosest) then
			if (not Entity(pedClosest).state.scenario) and (not getLastVehicle(pedClosest)) then
				if (vSERVER.checkDrugs(pedClosest)) then
					if (action) then return; end;
					action = true;

					ClearPedSecondaryTask(pedClosest)
					ClearPedTasksImmediately(pedClosest)

					TaskSetBlockingOfNonTemporaryEvents(pedClosest, true)
					SetBlockingOfNonTemporaryEvents(pedClosest, true)
					SetEntityAsMissionEntity(pedClosest, true, true)
					TaskTurnPedToFaceEntity(pedClosest, ped, 3.0)

					LocalPlayer.state.BlockTasks = true
					LocalPlayer.state.freezeEntity = true

					if (LoadAnim('jh_1_ig_3-2')) then 
						TaskPlayAnim(pedClosest, 'jh_1_ig_3-2', 'cs_jewelass_dual-2', 8.0, 8.0, -1, 16, 0, 0, 0, 0)
					end

					loadModel('prop_anim_cash_note')

					Citizen.SetTimeout(500, function()
						local Object = CreateObject('prop_anim_cash_note',pedCoords['x'],pedCoords['y'],pedCoords['z'],false,false,false)
						AttachEntityToEntity(Object,pedClosest,GetPedBoneIndex(pedClosest,28422),0.0,0.0,0.0,90.0,0.0,0.0,false,false,false,false,2,true)
						vRP.CarregarObjeto('mp_safehouselost@','package_dropoff','prop_paper_bag_small',16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
					
						if (LoadAnim('mp_safehouselost@')) then
							TaskPlayAnim(ped,'mp_safehouselost@','package_dropoff',8.0,8.0,-1,16,0,0,0,0)
							TaskPlayAnim(pedClosest,'mp_safehouselost@','package_dropoff',8.0,8.0,-1,16,0,0,0,0)
						end

						Citizen.Wait(3000)
						if (DoesEntityExist(Object)) then DeleteEntity(Object); end;

						ClearPedSecondaryTask(pedClosest)
						ClearPedTasksImmediately(pedClosest)
						TaskWanderStandard(pedClosest,10.0,10)
						SetEntityAsNoLongerNeeded(pedClosest)

						vSERVER.PaymentDrugs()
						vRP.DeletarObjeto()

						LocalPlayer.state.BlockTasks = false
						LocalPlayer.state.freezeEntity = false

						action = false
					end)
				end
			end
		end
	end
end)

RegisterKeyMapping('+pressedSellDrug', 'Vender drogas para o NPC', 'keyboard', 'E')	
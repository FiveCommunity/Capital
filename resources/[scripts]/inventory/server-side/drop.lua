--=======================================================================================================================================
-- Drop Functions
--=======================================================================================================================================
dropItems = {}
pickupWait = {}
dropIDS = Tools.newIDGenerator()
--=========================================
function sRP.getNearestDrops()
	local source = source
	local coords = GetEntityCoords(GetPlayerPed(source))
    if coords then
		local drops, count = {}, 1
		local dropWeight = 0
		if config.modules["drop-system"] then
			for id, marker in pairs(dropItems) do
				if #(coords - marker.coord) <= 3.5 then
					local weight = sINV.itemWeight(marker.item)*marker.amount
					drops[tostring(count)] = {
						id = id,
						item = marker.item,
						name = sINV.itemName(marker.item),
						index = sINV.itemIndex(marker.item),
						amount = marker.amount,
						weight = weight,
						durability = vRP.calcDurability(marker.data),
						desc = sINV.makeDesc(marker.data)
					}
					count = count+1
					dropWeight = dropWeight + weight	
				end
			end
		end
        return drops, dropWeight, count-1
    end
end

function sRP.tryDropItem(slot,amount)
	if config.modules["drop-system"] then
		local source = source
		local user_id = vRP.getUserId(source)

		if user_id then
			if (cRP.userInVehicle(source)) then return TriggerClientEvent('notify', source, 'negado', 'Mochila', 'Você não pode fazer isso enquanto estiver dentro de um <b>veículo</b>.'); end;
			
			local identity = vRP.getUserIdentity(user_id)
			local UserInventory = vRP.PlayerInventory(user_id)

			if exports["homes"]:insideHome(source) then
				TriggerClientEvent("Notify",source,"importante",'Inventário',"Não pode dropar item dentro de casas.",8000)
				return false
			end

			if exports["system"]:inHomeRoberry(user_id) then
				TriggerClientEvent("Notify",source,"importante",'Inventário',"Não pode dropar item dentro de casas.",8000)
				return false
			end
			
			local slotData = UserInventory:getSlot(slot)
			if slotData and amount and (amount > 0) then
				
				for _,i in ipairs(config.drop.notDrop) do
                    if (slotData.item == i) or string.find(slotData.item,i) then
                        TriggerClientEvent("Notify",source,"importante",'Inventário',"Não pode dropar este item.",8000)
                        return false
                    end
                end
				
				local coord = GetEntityCoords(GetPlayerPed(source))
				if coord and sINV.itemExists(slotData.item) then
					if UserInventory:tryGetItem(slotData.item, amount, slot, true) then

						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						local id = createDrop(slotData.item,amount,coord,(config.drop.dropTime or 900),slotData)
						
						vRP.webhook(config.webhooks.dropDropping, {
                            title = 'drop item',
                            descriptions = {
                                { 'user', user_id },
                                { 'drop-id', id },
                                { 'dropou', vRP.format(amount)..' '..sINV.itemName(slotData.item) }
                            }
                        })  

						return true
					end
				end
			end
		end
	end
	return false
end

function sRP.tryPickupItem(dropId,amount,target)
	if config.modules["drop-system"] then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then	
			if (cRP.userInVehicle(source)) then return TriggerClientEvent('notify', source, 'negado', 'Mochila', 'Você não pode fazer isso enquanto estiver dentro de um <b>veículo</b>.'); end;

			local UserInventory = vRP.PlayerInventory(user_id)
			local identity = vRP.getUserIdentity(user_id)
			if dropId then				
				if (not pickupWait[dropId]) then
					pickupWait[dropId] = 2
					local pickup = dropItems[dropId]
					if pickup then			
						
						if (amount <= pickup.amount) then

							local pickupGroupable = true
							if pickup.data and (pickup.data.groupable ~= nil) then
								pickupGroupable = pickup.data.groupable
							end

							local tData = UserInventory:getSlot(target)					
							if (not tData) or ((tData.item == pickup.item) and tData.groupable and pickupGroupable) then
								
								local checkAmount = amount
								if (config.drop.pickupFull) then checkAmount = pickup.amount; end;
								
								if UserInventory:itemMaxAmount(pickup.item,checkAmount) then
									if UserInventory:haveSpace(pickup.item,checkAmount) then
										vRPclient._playAnim(source,true,{{"pickup_object","putdown_low"}},false)
										
										local getStatus = 'error'
										if (amount == pickup.amount) then
											if removeDrop(dropId) then
												getStatus = 'total'
											end
										else
											if (not config.drop.pickupFull) then
												dropItems[dropId].amount = parseInt(pickup.amount-amount)
												getStatus = 'parcial'
											end
										end
										
										if (getStatus ~= 'error') then
											UserInventory:giveItem(pickup.item,amount,target,pickup.data,true)

											vRP.webhook(config.webhooks.dropPickup, {
												title = 'drop pickup',
												descriptions = {
													{ 'user', user_id },
													{ 'drop-id', dropId..' ('..getStatus..')' },
													{ 'pegou', vRP.format(amount)..' '..sINV.itemName(pickup.item) }
												}
											})  
											return true
										else
											TriggerClientEvent("Notify",source,"importante",'Inventário',"Digite a <b>quantidade</b> total.")
										end
									else
										TriggerClientEvent("Notify",source,"importante",'Inventário',"Você não tem espaço para coletar <b>"..checkAmount.."x "..sINV.itemName(pickup.item).."</b>.")
									end
								else
									TriggerClientEvent('notify', source, 'negado', 'Inventário', 'Você atingiu a quantidade máxima de <b>'..vRP.itemNameList(pickup.item)..'</b> na mochila!')
								end
							end
						else
							TriggerClientEvent("Notify",source,"importante",'Inventário',"Quantidade <b>inválida</b>.")
						end

					else
						TriggerClientEvent("Notify",source,"importante",'Inventário',"O item <b>expirou</b>.")
					end
				end
			end
		end
	end
	return false
end

if config.modules["drop-system"] then
	function createDrop(item,amount,coord,time,data)
		local id = dropIDS:gen()
		if id then
			dropItems[id] = { item = item, amount = amount, coord = coord, time = (time or 3600), data = data }
			cRP.setDrop(-1,id,dropItems[id])
			return id
		end
	end
	exports("createDrop",createDrop)

	function removeDrop(id)
		if id and dropItems[id] then
			cRP.setDrop(-1,id,nil)
			dropItems[id] = nil
			dropIDS:free(id)
			return true
		end
	end
	exports("removeDrop",removeDrop)
end
--=======================================================================================================================================
-- Drop Threads
--=======================================================================================================================================
if config.modules["drop-system"] then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			for k,v in pairs(pickupWait) do
				if v > 0 then
					pickupWait[k] = v - 1
				else
					pickupWait[k] = nil
				end
			end
			for k,v in pairs(dropItems) do
				if v.time > 0 then
					dropItems[k].time = v.time - 1
				else
					removeDrop(k)
				end
			end
			for k, v in pairs(thrownWeapons) do
				if v.time > 0 then
					thrownWeapons[k].time = v.time - 1
				else
					DeleteEntity(NetworkGetEntityFromNetworkId(v.objectId))
					deleteThrownWeapon(k)
				end
			end
		end
	end)
	AddEventHandler("playerSpawn",function(user_id,source,first_spawn)
        if first_spawn then
			for k,v in pairs(dropItems) do
				cRP._setDrop(source,k,v)
			end
        end
    end)
end

function resetSerials()
	for k,v in pairs(dropItems) do
		if v.data and v.data.serial then
			vRP.freeSerial(v.data.serial)
			removeDrop(k)
		end
	end
end

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if (eventData.secondsRemaining == 60) then
		SetTimeout(50000,function()
            resetSerials()
        end)
    end
end)
AddEventHandler('txAdmin:events:serverShuttingDown',resetSerials)

AddEventHandler('onResourceStop', function(name)
    if (GetCurrentResourceName() == name) then resetSerials(); end;
end)
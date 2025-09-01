cacheInventories = {}

vRP.prepare('vRP/getInventory','SELECT * FROM inventory WHERE identifier = @id')
vRP.prepare('vRP/delInventory','DELETE FROM inventory WHERE identifier = @id')
vRP.prepare('vRP/createInventory','INSERT INTO inventory(identifier,items,max_slots,max_weight) VALUES(@id,@items,@slots,@weight)')
vRP.prepare('vRP/updateInventoryItems','UPDATE inventory SET items = @items WHERE identifier = @id')
vRP.prepare('vRP/updateInventoryWeight','UPDATE inventory SET max_weight = @weight WHERE identifier = @id')
vRP.prepare('vRP/updateInventorySlots','UPDATE inventory SET max_slots = @slots WHERE identifier = @id')
--==============================================================================
-- Player Inventory
--==============================================================================
AddEventHandler('vRP:playerLeave',function(user_id,source)
	local identifier = ('player:'..user_id)
	local inventory = cacheInventories[identifier]
	if inventory then
		vRP.execute('vRP/updateInventoryItems',{ id = identifier, items = json.encode(inventory.items) })
		cacheInventories[identifier] = nil
	end
end)

task_save_inventories = function()
	Citizen.SetTimeout(10000, task_save_inventories);
	for k, v in pairs(cacheInventories) do
		if v.unsaved then
			vRP.execute('vRP/updateInventoryItems',{ id = k, items = json.encode(v.items) })
			v.unsaved = nil
		end
	end
end
Citizen.CreateThread(task_save_inventories)
--==============================================================================
-- Inventory Instance
--==============================================================================
function vRP.releaseInventory(identifier,save)
	if identifier and cacheInventories[identifier] then
		local data = cacheInventories[identifier]
		if (data.unsaved or save) then
			vRP.execute('vRP/updateInventoryItems',{ id = identifier, items = json.encode(data.items) })
		end
		cacheInventories[identifier] = nil
	end
end

function vRP.deleteInventory(identifier)
	if identifier then
		local Inventory = vRP.Inventory(identifier)
		if Inventory then
			Inventory:clear()
			vRP.releaseInventory(identifier)
			vRP.execute('vRP/delInventory',{ id = identifier })
			return true
		end
	end
	return false
end

vRP.Inventory = function(identifier,defaults)
 
	if cacheInventories[identifier] then
		return cacheInventories[identifier]
	end

	local data = vRP.query('vRP/getInventory',{ id = identifier })[1]

	if (not data) then
		if defaults then
			data = { identifier = identifier, items = '{}', max_slots = defaults.slots, max_weight = defaults.weight }
			vRP.insert('vRP/createInventory',{ id = identifier, items = data.items, slots = data.max_slots, weight = data.max_weight })
		else
			return false
		end
	end

	local self = {
		identifier = identifier,
		items = json.decode(data.items),
		weight = data.max_weight,
		slots = data.max_slots
	}

	--[ INVENTORY BASICS ]======================================================

	self.getItems = function()
		return self.items
	end

	self.clear = function()
		for k, v in pairs(self.items) do
			if v.serial then vRP.freeSerial(v.serial); end;
		end
		self.items = {}
		self.unsaved = true
		TriggerEvent('inventory:event','cleaned',{ identifier = self.identifier })	
		return true
	end

	self.getWeight = function()
		local weight = 0
		local items = self:getItems()
		for slot,sdata in pairs(items) do
			local iweight = vRP.getItemWeight(sdata.item)
			weight = weight+(iweight*sdata.amount)
		end
		return weight
	end

	self.getItemAmount = function(_,idname)
		local quantity, slot = 0, -1
		local items = self:getItems()
		if items then
			for k,v in pairs(items) do
				if (v.item == idname) and (quantity < v.amount) then
					if (v.time) or (v.usages) then
						local usage = vRP.calcDurability(v)
						if (usage < 100) then
							quantity = v.amount
							slot = k
						end
					else
						quantity = v.amount
						slot = k
					end
				end
			end
		end
		return quantity, slot
	end

	self.itemMaxAmount = function(_,idname,amount)
		local max, count = vRP.maxItem(idname), amount;
		if (max) then
			local items = self:getItems()
			if items then
				for k,v in pairs(items) do
					if (v.item == idname) then
						count = (count + v.amount)
					end
				end
			end
			return (count <= max)
		end
		return true
	end

	self.haveSpace = function(_,idname,amount)
		local amount = parseInt(amount)
		local data = vRP.itemBodyList(idname)
		if data and data.weight and (amount > 0) then
			local weight = self:getWeight()+(data.weight*amount)
			if (weight <= self:getMaxWeight()) then
				local freeSlots = 0
				local groupable = true
				
				local days, usages = vRP.itemDurability(idname)
				if (days > 0) or (usages > 0) or ((data.type == 'weapon') and (not exports.inventory:isThrowable(idname))) then
					groupable = false
				end
				
				for i=1, self:getMaxSlots() do
					local slot = self:getSlot(i)
					if (not slot) or ((slot.item == idname) and ((slot.groupable == true) and groupable)) then
						if groupable then
							return true
						else
							freeSlots = freeSlots + 1
						end
					end
				end
				return (freeSlots >= amount)
			end
		end
		return false
	end

	--[ INVENTORY SLOTS ]=======================================================

	self.getSlot = function(_,slot)
		return self.items[tostring(slot)]
	end

	self.setSlotKey = function(_,slot,key,value)
		if self.items[tostring(slot)] and (key ~= 'item') and (key ~= 'amount') then
			self.items[tostring(slot)][key] = value
			self.unsaved = true
			TriggerEvent("inventory:event","key",{ identifier = self.identifier, slot = tonumber(slot), key = key, value = value })
			return true
		end
	end

	self.swapSlot = function(_,slot,target)
		local slot, target = tostring(slot), tostring(target)

		local copy = self.items[slot]
		self.items[slot] = self.items[target]
		self.items[target] = copy

		self.unsaved = true
		TriggerEvent("inventory:event","swaped",{ identifier = self.identifier, slot = tonumber(slot), target = tonumber(target) })
	end

	--[ INVENTORY FUNCS ]=======================================================

	self.checkDurability = function(_,slot)
		local slot = tostring(slot)
		local data = self.items[slot]
		if data then
			local usage = vRP.calcDurability(data)
			if usage >= 100 then
				if data.serial then 
					vRP.freeSerial(data.serial)
				end
				self.items[slot] = nil
				return false
			end
		end
		return true
	end

	self.useSlot = function(_,slot,amount)
		local slot = tostring(slot)
		local data = self.items[slot]
		if data then

			if data.usages then
				data.usages = data.usages + (amount or 1)
				return self:checkDurability(slot)
			end

			return true
		end
		return false
	end

	
	self.generateItem = function(_,idname,amount,slot,args,notify)
		local data = { groupable = true }
		
		local itemType = vRP.itemTypeList(idname)
		local days, usages = vRP.itemDurability(idname)
		local weapon = ((itemType == 'weapon') and (not exports.inventory:isThrowable(idname)))
		
		if (days > 0) then data.time = os.time(); end;
		if (usages > 0) then data.usages = 0; end;
		
		if (weapon or data.time or data.usages) then
			data.groupable = false
		end

		if args and args ~= nil and args.details then
			data.details = args.details
		end

		if data.groupable then
			return self:giveItem(idname,amount,slot,data,notify)
		else
			for i=1,amount do
				if weapon then
					local user_id = parseInt(self.identifier:sub(8))
					data.serial = vRP.genSerial(args.prefix,'DDDDDD',{ user_id = user_id, idname = idname, time = data.time })
				end
				self:giveItem(idname,1,nil,data,notify)
			end
			return true
		end
	end

	self.giveItem = function(_,idname,amount,slot,keys,notify)
		local amount = parseInt(amount)
		local items = self:getItems()
		local maxSlots = self:getMaxSlots()

		if items and vRP.itemExists(idname) and (amount > 0) then
			local success, target = false, false

			local newGroupable = true
			if keys and (keys.groupable ~= nil) then
				newGroupable = keys.groupable
			end

			if (not slot) then
				
				local attempt = '0'
				repeat
					attempt = tostring(parseInt(attempt + 1))
				until (items[attempt] == nil) or ( items[attempt] and (items[attempt].item == idname) and (items[attempt].groupable == true and newGroupable) ) or (parseInt(attempt) > maxSlots)

				if (items[attempt] == nil) then
					items[attempt] = { item = idname, amount = amount, groupable = true }
					if (type(keys) == 'table') then
						for k,v in pairs(keys) do
							if (k ~= 'item') and (k ~= 'amount') then
								items[attempt][k] = v 
							end
						end
					end
					success = true
					target = attempt

				elseif ( items[attempt] and (items[attempt].item == idname) and (items[attempt].groupable == true and newGroupable) ) then
					items[attempt].amount = items[attempt].amount + amount
					success = true
					target = attempt
				end

			else
				if (slot <= maxSlots) then
					local slot = tostring(slot)
					if items[slot] then
						if (items[slot].item == idname) and (items[slot].groupable == true and newGroupable) then
							items[slot].amount = items[slot].amount + amount
							success = true
							target = slot
						end
					else
						items[slot] = { item = idname, amount = amount, groupable = true }
						if (type(keys) == 'table') then
							for k,v in pairs(keys) do
								if (k ~= 'item') and (k ~= 'amount') then
									items[slot][k] = v 
								end
							end
						end
						success = true
						target = slot
					end
				end
			end
			if success then
				self.unsaved = true
				if notify then
					local source = vRP.getUserSource( parseInt(self.identifier:sub(8)) )
					if source and (source > 0) then
						TriggerClientEvent('NotifyItem', source, 'gived', vRP.itemNameList(idname), amount, vRP.itemIndexList(idname), 5000)
					end
				end
				TriggerEvent('inventory:event','gived',{ identifier = self.identifier, idname = idname, amount = amount, slot = tonumber(target) })
			end
			return success, target
		end
	end

	self.tryGetItem = function(_,idname,amount,slot,notify)
		local amount = parseInt(amount)
		local items = self:getItems()

		if items and vRP.itemExists(idname) and (amount > 0) then
			if (not slot) then		
				for k,v in pairs(items) do
					if (v.item == idname) and (v.amount >= amount) then
						
						v.amount = v.amount - amount
						if v.amount <= 0 then
							if v.serial then vRP.freeSerial(v.serial); end;
							items[k] = nil
						end

						self.unsaved = true

						if notify then
							local source = vRP.getUserSource( parseInt(self.identifier:sub(8)) )
							if source and (source > 0) then
								TriggerClientEvent('NotifyItem', source,'retired', vRP.itemNameList(idname), amount, vRP.itemIndexList(idname), 5000)
							end
						end

						TriggerEvent('inventory:event','losed',{ identifier = self.identifier, idname = idname, amount = amount, slot = tonumber(k) })
						return v
					end
				end
			else
				local slot = tostring(slot)
				if items[slot] and (items[slot].item == idname) and (items[slot].amount >= amount) then
					local v = items[slot]

					items[slot].amount = items[slot].amount - amount
					if items[slot].amount <= 0 then
						if items[slot].serial then vRP.freeSerial(items[slot].serial); end;
						items[slot] = nil
					end

					self.unsaved = true

					if notify then
						local source = vRP.getUserSource( parseInt(self.identifier:sub(8)) )
						if source and (source > 0) then
							TriggerClientEvent('NotifyItem', source, 'retired', vRP.itemNameList(idname), amount, vRP.itemIndexList(idname), 5000)
						end
					end

					TriggerEvent('inventory:event','losed',{ identifier = self.identifier, idname = idname, amount = amount, slot = tonumber(slot) })
					return v
				end
			end
		end
		return false
	end

	--[ MAX SLOTS ]=============================================================
	self.getMaxSlots = function()
		return self.slots
	end

	self.setMaxSlots = function(_,maxSlots)
		if maxSlots and (maxSlots > 0) then
			self.slots = maxSlots
			vRP.execute('vRP/updateInventorySlots',{ id = self.identifier, slots = maxSlots })
			return true
		end
		return false
	end

 	self.varyMaxSlots = function(_,varySlots)
		if varySlots then
			local currentMax = self:getMaxSlots()
			return self:setMaxSlots(math.floor(currentMax+varySlots))
		end
		return false
    end

	--[ MAX WEIGHT ]============================================================
	self.getMaxWeight = function()
		return self.weight
	end

	self.setMaxWeight = function(_,maxWeight)
		if maxWeight and (maxWeight > 0) then
			self.weight = maxWeight
			vRP.execute('vRP/updateInventoryWeight',{ id = self.identifier, weight = maxWeight })
			return true
		end
		return false
	end

 	self.varyMaxWeight = function(_,varyWeight)
		if varyWeight then
			local currentMax = self:getMaxWeight()
			return self:setMaxWeight(math.floor(currentMax+varyWeight))
		end
		return false
    end

	cacheInventories[identifier] = self

	return self
end

--==============================================================================
-- PLAYER INVENTORY
--==============================================================================
vRP.PlayerInventory = function(user_id)
	if user_id then
		return vRP.Inventory('player:'..user_id,config.default_inventory)
	end
end

vRP.giveInventoryItem = function(user_id,idname,amount,slot,notify)
	if user_id and idname and amount then
		local Inventory = vRP.PlayerInventory(user_id)
		return Inventory:generateItem(idname,amount,slot,{ prefix = 'EB' },notify)
	end
end

vRP.tryGetInventoryItem = function(user_id,idname,amount,slot,notify)
	if user_id and idname and amount then
		local Inventory = vRP.PlayerInventory(user_id)
		return Inventory:tryGetItem(idname,amount,slot,notify)
	end
	return false
end

vRP.getInventoryItemAmount = function(user_id,idname)
	local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:getItemAmount(idname)
end

vRP.getInventory = function(user_id)
	local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:getItems()
end

vRP.getInventoryWeight = function(user_id)
	local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:getWeight(user_id)
end

vRP.getInventoryMaxWeight = function(user_id)
    local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:getMaxWeight()
end

vRP.setInventoryMaxWeight = function(user_id,max)
   	local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:setMaxWeight(max)
end

vRP.varyInventoryMaxWeight = function(user_id,vary)
	local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:varyMaxWeight(vary)
end

vRP.getInventoryMaxSlots = function(user_id)
    local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:getMaxSlots()
end

vRP.setInventoryMaxSlots = function(user_id,max)
   	local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:setMaxSlots(max)
end

vRP.varyInventoryMaxSlots = function(user_id,vary)
	local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:varyMaxSlots(vary)
end

vRP.itemMaxAmount = function(user_id,idname)
	local Inventory = vRP.PlayerInventory(user_id)
	return Inventory:itemMaxAmount(idname)
end


--==============================================================================
-- GENERIC INVENTORY
--==============================================================================
vRP.computeItemsWeight = function(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

vRP.weightsVip = function()
	return {
		['VipBronze'] = 20,
		['VipPrata'] = 30,
		['VipOuro'] = 40,
		['VipCapital'] = 50
	}
end

local notLoose = {
	['placa-vip'] = true,
	['chip-vip'] = true,
	['nome-vip'] = true,
	['resetchar'] = true,

	['vip-bronze'] = true,
	['vip-prata'] = true,
	['vip-ouro'] = true,
	['vip-capital'] = true,

	['contrato-ilha'] = true,
	['contrato-basic'] = true,
	['contrato-modern'] = true,
	['contrato-high'] = true,
	['contrato-apartament'] = true,

	['bolso-pequeno'] = true,
	['bolso-medio'] = true,
	['bolso-grande'] = true,
}

vRP.clearInventory = function(user_id)
	local source = vRP.getUserSource(user_id)
	if source then
		local UserInventory = vRP.PlayerInventory(user_id)
		
		local items = UserInventory:getItems()

		local saveItems = {}
		for slot, data in pairs(items) do
			if (notLoose[data.item]) then
				saveItems[data.item] = (saveItems[data.item] or 0) + data.amount
			end
		end

		local alianca, aliancaSlot = UserInventory:getItemAmount('alianca-casamento')
		local aliancaData = UserInventory:getSlot(aliancaSlot)
		
		UserInventory:clear()

		for item, qtd in pairs(saveItems) do
			UserInventory:generateItem(item, qtd)
		end
		
		if (alianca > 0) and aliancaData then
			local gived, givedSlot = UserInventory:giveItem('alianca-casamento', 1)
			if gived then
				UserInventory:setSlotKey(givedSlot,'conj-name', aliancaData['conj-name'])
			end
		end
		
		if (not vRP.hasPermission(user_id, 'keepweight.permissao')) then
			UserInventory:setMaxWeight(config.default_inventory.weight)
		end
		if (not vRP.hasPermission(user_id, 'keepslot.permissao')) then
			UserInventory:setMaxSlots(config.default_inventory.slots)
		end

		local backpacks = vRP.weightsVip()
		for group, weight in pairs(backpacks) do
			if (vRP.hasGroup(user_id, group)) then
				UserInventory:varyMaxWeight(weight)
			end
		end

		vRP.webhook('clearinventory', {
			title = 'clear inventory',
			descriptions = {
				{ 'user_id', user_id },
				{ 'items', json.encode(items, { indent = true }) }
			}
		})   
	end
end
--======================================================================================================================
-- ITEM CONFIGS
--======================================================================================================================
vRP.itemBodyList = function(item)
	return exports['inventory']:itemBody(item)
end

vRP.itemExists = function(item)
	return exports['inventory']:itemExists(item)
end

vRP.itemNameList = function(item)
	return exports['inventory']:itemName(item)
end

vRP.itemIndexList = function(item)
	return exports['inventory']:itemIndex(item)
end

vRP.itemTypeList = function(item)
	return exports['inventory']:itemType(item)
end

vRP.getItemWeight = function(item)
	return exports['inventory']:itemWeight(item)
end

vRP.itemDurability = function(item)	
	return exports['inventory']:itemDurability(item)
end

vRP.maxItem = function(item)	
	return exports['inventory']:maxItem(item)
end

vRP.calcDurability = function(data)
	local percent = 0
	if data and data.item then
		local maxDays, maxUsages = vRP.itemDurability(data.item)
		if (maxDays > 0) then
			if data.time then
				local timeElapsed = os.time()-data.time
				local timePercent = math.ceil( (100 * timeElapsed) / math.floor(maxDays*86400) )
				if timePercent > percent then percent = timePercent; end;
			end
		end
		if (maxUsages > 0) then
			if data.usages then
  				local usagePercent = math.ceil( (100 * data.usages) / maxUsages )
				if usagePercent > percent then percent = usagePercent; end;
			end
		end
	end
	if (percent > 100) then percent = 100; end;
	if (percent < 0) then percent = 0; end;
	return percent
end

vRP.getItemDefinition = function(item)
    local data = vRP.itemBodyList(item)
	return data.name,(data.weight or 0)
end
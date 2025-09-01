--======================================================================================================================
-- BASE
--======================================================================================================================
function sINV.getItems()
	return config.items
end

function sINV.defInventoryItem(idname,name,weight,index,type)
	config.items[idname] = { index = (index or idname), name = (name or idname), type = (type or "usar"), weight = (weight or 0) }
end

function sINV.itemExists(idname)
	return (config.items[idname] ~= nil)
end

function sINV.itemName(idname)
	if config.items[idname] then return config.items[idname].name; end;
	print("^1[CFG] Item ["..idname.."] not found.^7")
end

function sINV.itemIndex(idname)
	if config.items[idname] then return config.items[idname].index; end;
	print("^1[CFG] Item ["..idname.."] not found.^7")
end

function sINV.itemType(idname)
	if config.items[idname] then return config.items[idname].type; end;
	print("^1[CFG] Item ["..idname.."] not found.^7")
end

function sINV.itemBody(idname)
	if config.items[idname] then return config.items[idname]; end;
	print("^1[CFG] Item ["..idname.."] not found.^7")
end

function sINV.itemWeight(idname)
	if config.items[idname] then return config.items[idname].weight; end;
	print("^1[CFG] Item ["..idname.."] not found.^7")
	return 0
end

function sINV.itemDesc(idname)
	if config.items[idname] then 
		return (config.items[idname].desc or '')
	end
	print("^1[CFG] Item ["..idname.."] not found.^7")
	return 0
end

function sINV.makeDesc(slotData)
	if slotData then
		local desc = sINV.itemDesc(slotData.item)
		local itemType = sINV.itemType(slotData.item)
		if (itemType == "weapon") then
			if config.throwables[slotData.item:upper()] then
				desc = "Arremesável<br>"..desc
			else
				--desc = "Série: "..(slotData.serial or "?").."<br>Disparos: "..(slotData.usages or 0).."<br>"..desc
				desc = "Série: "..(slotData.serial or "?").."<br>"..desc
			end
		end
		return desc
	end
	return ''
end

function sINV.itemDurability(idname)
	if config.durability[idname] then 
		return config.durability[idname].time, config.durability[idname].usages;
	end
	return -1, -1;
end

function sINV.maxItem(idname)
	if config.max[idname] then 
		return config.max[idname];
	end
	return false
end

exportTable(sINV)

local frequencys = {
    ['112'] = 'hospital.permissao',
    ['113'] = 'hospital.permissao',
    ['189'] = 'policia.permissao',
    ['190'] = 'policia.permissao',
    ['191'] = 'policia.permissao',
    ['192'] = 'policia.permissao',
    ['193'] = 'policia.permissao',
    ['194'] = 'policia.permissao',
    ['195'] = 'policia.permissao',
    ['196'] = 'policia.permissao',
    ['197'] = 'policia.permissao',
    ['198'] = 'policia.permissao',
    ['200'] = 'pcp.permissao',
    ['201'] = 'pcp.permissao',
}

srv.checkFrequency = function(mhz)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (frequencys[tostring(mhz)]) and (not vRP.checkPermissions(user_id, frequencys[tostring(mhz)])) then
            TriggerClientEvent('notify', source, 'negado', 'Rádio', 'Você não pode entrar nesta <b>frequência</b>.')
            return false
        end
    end
    return true
end

local handleInventoryEvents = { 
    ['cleaned'] = function(source,user_id,args)
        TriggerClientEvent('radio:outServers',source)
    end,
    ['losed'] = function(source,user_id,args)
        if (args.idname == 'radio') then
            local amount = vRP.getInventoryItemAmount(user_id,'radio')
            if (amount < 1) then
                TriggerClientEvent('radio:outServers',source)
            end
        end
    end
}

AddEventHandler('inventory:event', function(event, args)
    if handleInventoryEvents[event] then
		if (args.identifier) and (args.identifier:sub(1,7) == 'player:') then   
			local user_id = parseInt(args.identifier:sub(8))
			local source = vRP.getUserSource(user_id)
			if source then
                handleInventoryEvents[event](source,user_id,args)
			end		
		end
	end
end)
cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

cli.openNui = function(identity, groups, system)
	SetNuiFocus(true, true)
	SendNUIMessage({ 
		type = 'openNUI', 
		user_identity = identity, 
		usergroups = groups, 
		sysgroups = system  
	})
end

RegisterNUICallback('addGroup', function(data, cb)
	vSERVER.addGroup(data.user_id, data.group, data.grade)
end)

RegisterNUICallback('delGroup', function(data, cb)
    vSERVER.delGroup(data.user_id, data.group, data.grade)
end)

cli.updateNui = function(usergroups)
  	SendNUIMessage({ 
		type = 'attUserGroups', 
		usergroups = usergroups  
	})
end

RegisterNUICallback('close', function(data, cb)
  	SetNuiFocus(false)
end)
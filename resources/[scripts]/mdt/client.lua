vSERVER = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mdt",function(source,args)
	if vSERVER.checkPermission() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function close()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end
RegisterNUICallback("mdtClose",close)
RegisterNetEvent('mdt:close',close)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("infoUser",function(data,cb)
	local license,cacador,name,lastname,age,phone,rg,arrests,warnings,tickets = vSERVER.infoUser(data.user)
	cb({
		license = (license or '-'),
		cacador = cacador,
		name = name,
		lastname = lastname,
		age = age,
		phone = phone,
		rg = rg,
		arrests = arrests, 
		warnings = warnings,
		tickets = tickets, 
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARREST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("arrestsUser",function(data,cb)
	local arrests = vSERVER.arrestsUser(data.user)
	if arrests then
		cb({ arrests = arrests })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TICKET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ticketsUser",function(data,cb)
	local tickets = vSERVER.ticketsUser(data.user)
	if tickets then
		cb({ tickets = tickets })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("warningsUser",function(data,cb)
	local warnings = vSERVER.warningsUser(data.user)
	if warnings then
		cb({ warnings = warnings })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("warningUser",function(data,cb)
	if data.user then
		SendNUIMessage({ action = "showMenu" })
		vSERVER.warningUser(data.user,data.info)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TICKET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ticketUser",function(data,cb)
	if data.user then
		SendNUIMessage({ action = "showMenu" })
		vSERVER.ticketUser(data.user,data.value,data.info)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARREST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("arrestUser",function(data,cb)
	if data.user then
		SendNUIMessage({ action = "showMenu" })
		vSERVER.arrestUser(data.user,data.value,data.info)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteMdtId",function(data,cb)
	if data.id then
		cb({ ok = vSERVER.deleteMdtId(data.id) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLE PORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("togglePort",function(data,cb)
	if data.user_id then
		cb({ ok = vSERVER.togglePort(data.user_id) })
	end
end)

RegisterNUICallback('porte', function(data, cb)
	cb({ ok = vSERVER.togglePort(data) })
end)
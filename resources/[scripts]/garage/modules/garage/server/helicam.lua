--======================================================================================================================
-- HELICAM
--======================================================================================================================
RegisterServerEvent('heli:forward.spotlight', function(state)
	local serverID = source
	TriggerClientEvent('heli:forward.spotlight', -1, serverID, state)
end)

RegisterServerEvent('heli:tracking.spotlight', function(target_netID, target_plate, targetposx, targetposy, targetposz)
	local serverID = source
	TriggerClientEvent('heli:Tspotlight', -1, serverID, target_netID, target_plate, targetposx, targetposy, targetposz)
end)

RegisterServerEvent('heli:tracking.spotlight.toggle', function()
	local serverID = source
	TriggerClientEvent('heli:Tspotlight.toggle', -1, serverID)
end)

RegisterServerEvent('heli:pause.tracking.spotlight', function(pause_Tspotlight)
	local serverID = source
	TriggerClientEvent('heli:pause.Tspotlight', -1, serverID, pause_Tspotlight)
end)

RegisterServerEvent('heli:manual.spotlight', function()
	local serverID = source
	TriggerClientEvent('heli:Mspotlight', -1, serverID)
end)

RegisterServerEvent('heli:manual.spotlight.toggle', function()
	local serverID = source
	TriggerClientEvent('heli:Mspotlight.toggle', -1, serverID)
end)

RegisterServerEvent('heli:light.up', function()
	local serverID = source
	TriggerClientEvent('heli:light.up', -1, serverID)
end)

RegisterServerEvent('heli:light.down', function()
	local serverID = source
	TriggerClientEvent('heli:light.down', -1, serverID)
end)

RegisterServerEvent('heli:radius.up', function()
	local serverID = source
	TriggerClientEvent('heli:radius.up', -1, serverID)
end)

RegisterServerEvent('heli:radius.down',function()
	local serverID = source
	TriggerClientEvent('heli:radius.down', -1, serverID)
end)
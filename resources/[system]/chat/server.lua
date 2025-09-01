vCLIENT = Tunnel.getInterface('chat')

RegisterServerEvent('chat:messageEntered', function(message)
	local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then
		local identity = vRP.getUserIdentity(user_id)
		if (identity) then
			TriggerClientEvent('chatMessage', source, identity.firstname..' '..identity.lastname, { 3, 187, 232 }, message)
			local players = vRPClient.getNearestPlayers(source, 10.0)
			for nSource, _ in pairs(players) do
				async(function()
					TriggerClientEvent('chatMessage', nSource, identity.firstname..' '..identity.lastname, { 3, 187, 232 }, message)
				end)
			end
		end

		vRP.webhook('chatCore', {
			title = 'chat',
			descriptions = {
				{ 'action', '(chat geral)' },
				{ 'user', user_id },
				{ 'message', message },
				{ 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
			}
		})      
	end
end)

RegisterServerEvent('__cfx_internal:commandFallback')
AddEventHandler('__cfx_internal:commandFallback',function(command)
	local name = GetPlayerName(source)
	if not command or not name then
		return
	end
	CancelEvent()
end)

RegisterCommand('clearchat', function(source)
    local user_id = vRP.getUserId(source);
    if (user_id) then
        if (vRP.hasPermission(user_id, '+Staff.Administrador')) then
            TriggerClientEvent('chat:clear', -1)
        else
            TriggerClientEvent('chat:clear', source)
        end
    end
end)

disableChat = function(source, bool)
	vCLIENT.desactiveChat(source, bool)
end
exports('DisableChat', disableChat)

function statusChat(source)
	return vCLIENT.statusChat(source)
end
exports('statusChat',statusChat)
cRP = {}
Tunnel.bindInterface('chat',cRP)

local chatOpen = false
local chatActive = true
RegisterKeyMapping('+abrirchat', 'Abrir chat', 'keyboard', 't')
RegisterCommand('+abrirchat',function()
	if (chatActive and not IsPauseMenuActive()) then
		chatOpen = true
		SetNuiFocus(true)
		SendNUIMessage({ type = 'ON_OPEN' })
	end
end)

RegisterNetEvent('chat:clear')

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage',function(author,color,text)
	if chatActive then
		local args = { text }
		if author ~= '' then
			table.insert(args,1,author)
		end
		
		SendNUIMessage({ type = 'ON_MESSAGE', message = { color = color, multiline = true, args = args } })
		SendNUIMessage({ type = 'ON_SCREEN_STATE_CHANGE', shouldHide = false })
	end
end)

RegisterNetEvent('__cfx_internal:serverPrint')
AddEventHandler('__cfx_internal:serverPrint',function(msg)
	SendNUIMessage({ type = 'ON_MESSAGE', message = { templateId = 'print', multiline = true, args = { msg } } })
	chatOpen = false
end)

RegisterNetEvent('chat:addMessage')
AddEventHandler('chat:addMessage',function(message)
	SendNUIMessage({ type = 'ON_MESSAGE', message = message })
end)

RegisterNetEvent('chat:clear')
AddEventHandler('chat:clear',function(name)
	SendNUIMessage({ type = 'ON_CLEAR' })
end)

RegisterNetEvent('chat:clearSuggestions')
AddEventHandler('chat:clearSuggestions',function()
	SendNUIMessage({ type = 'ON_SUGGESTIONS_REMOVE' })
end)

RegisterNUICallback('chatResult',function(data, cb)
	SetNuiFocus(false)
	if data.message then
		if data.message:sub(1,1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			if (GetEntityHealth(PlayerPedId()) <= 100) then return; end;
			TriggerServerEvent('chat:messageEntered',data.message)
		end
	end
	cb('ok')
end)

RegisterNetEvent('chat:addSuggestion')
AddEventHandler('chat:addSuggestion',function(suggestions)
	for _,suggestion in ipairs(suggestions) do
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = suggestion
		})
	end
end)

RegisterNUICallback('loaded',function(data, cb)
	cb('ok')
end)

AddEventHandler('chat:clear', function(name)
	SendNUIMessage({
	  type = 'ON_CLEAR'
	})
end)

cRP.desactiveChat = function(bool)
	if bool then
		chatActive = true
	else
		chatActive = false
		SendNUIMessage({ type = 'ON_CLEAR' })
	end
end
exports('DisableChat', cRP.desactiveChat)

RegisterCommand('chat', function()
	cRP.desactiveChat((not chatActive))
	TriggerEvent('notify', 'importante', 'Chat', '<b>'..(chatActive and 'Ativado' or 'Desativado')..'</b>!')
end)

Citizen.CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false)
end)

function cRP.statusChat()
	return chatOpen
end

function statusChat()
	return chatOpen
end

exports('statusChat',statusChat)
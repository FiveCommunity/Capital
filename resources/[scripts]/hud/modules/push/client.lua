--[[
    { type = 'default' title = '', message = '', coords = vec3(0, 0, 0), time = 30000 }
]]

local getHours = function()
	local year, month, day, hour, minute, second = GetLocalTime()
	if hour < 10 then hour = '0'..hour end
    if minute < 10 then minute = '0'..minute end
	return hour..':'..minute
end

NotifyPush = function(data)
    data.hour = getHours()
    UpdateStats('notifyPush', data)
end
RegisterNetEvent('NotifyPush', NotifyPush)

RegisterCommand('+npush', function()
    if Dependencys(PlayerPedId()) and vSERVER.checkPermission({ 'polpar.permissao', 'mecanico.permissao' }) then
        SetNuiFocus(true, true)
        UpdateStats('notifyCenter', true)
    end
end)
RegisterKeyMapping('+npush', 'Notificação Policia', 'keyboard', 'F4')

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNUICallback('Waypoint', function(data, cb)
    SetNewWaypoint(data.x + 0.0001, data.y + 0.0001)
    TriggerEvent('notify', 'importante', 'COPOM', 'Destino marcado no <b>gps</b>.')

    cb('Ok')
end)

RegisterNUICallback('Phone', function(data, cb)
    exports['lb-phone']:CreateCall({ number = data, hideNumber = true })

    cb('Ok')
end)
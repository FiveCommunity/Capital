RegisterCommand('painel', function()
    local permissions = vSERVER.getPermissions()
    if (permissions) then
        TriggerEvent('gb_core:tabletAnim')
        
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openPanel',
            userData = permissions
        })
    else 
        TriggerEvent('Notify', 'negado', 'Você não faz parte de uma organização!')
    end 
end)

---------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNUICallback('close', function(data, cb)
	TriggerEvent('gb_core:stopTabletAnim')
    SetNuiFocus(false, false)

    cb('Ok')
end)            

RegisterNUICallback('getAllMembers', function(data, cb)
    cb(json.encode(vSERVER.getAllMembers(data.fac)))
end)

RegisterNUICallback('searchUser', function(data, cb)
    cb(json.encode(vSERVER.searchUser(data.user_id)))
end)

RegisterNUICallback('detailsUser', function(data, cb)
    cb(json.encode(vSERVER.detailsUser(data.user_id, data.fac)))
end)

RegisterNUICallback('admit', function(data, cb)
    cb(json.encode(vSERVER.admit(data.fac, data.user_id)))
end)

RegisterNUICallback('dismiss', function(data, cb)
    cb(json.encode(vSERVER.dismiss(data.fac, data.user_id)))
end)

RegisterNUICallback('updateRole', function(data, cb)
    cb(json.encode(vSERVER.updateRole(data.fac, data.user_id, data.method)))
end)

RegisterNUICallback('getMembersAmount', function(data, cb)
    cb(json.encode(vSERVER.getMembersAmount(data.fac)))
end)

RegisterNUICallback('sendMessage', function(data, cb)
    SetNuiFocus(false, false)
    cb(json.encode(vSERVER.sendMessageToFac(data.fac, 'aviso', data.message)))
end)
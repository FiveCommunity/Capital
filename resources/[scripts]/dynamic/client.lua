local cli = {}
Tunnel.bindInterface('dynamic', cli)
local vSERVER = Tunnel.getInterface('dynamic')

local userPermissions = nil;

local Verifications = function(ped)
    local playerState = LocalPlayer.state
    if (GetEntityHealth(ped) <= 100) or (playerState.Handcuff or playerState.StraightJacket) then
        return false
    end
    return true
end

RegisterCommand('openDynamic', function()
    local verify = Verifications(PlayerPedId())
    if (verify) then openUi() end;
end)
RegisterKeyMapping('openDynamic', 'Abrir ações possíveis', 'keyboard', 'F9')

local updatePermissions = function()
    if (not userPermissions) then
        userPermissions = vSERVER.checkPermissions({
            ['hospital'] = 'hospital.permissao',
            ['policia'] = 'policia.permissao',
            ['staff'] = 'staff.permissao',
            ['mecanica'] = 'mecanico.permissao',
            ['juridico'] = 'juridico.permissao'
        })
    end
    return true
end

openUi = function()
    if (updatePermissions()) then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            favorites = vSERVER.getFavorites(),
            clothes = getUserPresets(),
            animations = exports.core:getAllAnimations(),
            permissions = userPermissions
        })  
    end
end
cli.updateUi = openUi

RegisterNetEvent('dynamic:updateUserPermissions', function(data) userPermissions = data; end)

--------------------------------------------------
-- Callback's
--------------------------------------------------
RegisterNuiCallback('close', function() SetNuiFocus(false, false); end)

RegisterNuiCallback('handleAction', function(data, cb)
    if (data.side == 'client') then TriggerEvent('gb_interactions:'..data.action, data.value);
    else TriggerServerEvent('gb_interactions:'..data.action, data.value); end;

    cb('Ok')
end)

RegisterNuiCallback('setFavorite', function(data, cb)
    local action = data.action
    if (action) then vSERVER.setFavorite(action); end;

    cb('Ok')
end)

RegisterNuiCallback('deleteFavorite', function(data, cb)
    local action = data.action
    if (action) then vSERVER.deleteFavorite(action); end;

    cb('Ok')
end)
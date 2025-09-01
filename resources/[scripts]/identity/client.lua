cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local updateUi = function(infos, bool)
    if (bool) then SetNuiFocus(true, true); end;
    
    SendNUIMessage({
        action = 'open',
        userInfo = infos
    })
end 
cli.openNui = updateUi

RegisterKeyMapping('+openIdentity', 'Abrir identidade', 'keyboard', 'F11')
RegisterCommand('+openIdentity', function()
    if (GetEntityHealth(PlayerPedId()) > 100) and (not LocalPlayer.state.Handcuff) and (not LocalPlayer.state.StraightJacket) then
        local infos = vSERVER.getUserIdentity()

        SetNuiFocus(true, true)
        updateUi(infos)

        animIdentity()
    end
end)

local tablet;
animIdentity = function()
    tablet = 'p_ld_id_card_01'
    RequestAnimDict('')
    TaskPlayAnim(PlayerPedId(), '', 'enter', 8.0, 1.0, -1, 50, 0, 0, 0, 0)
    vRP._CarregarObjeto('amb@world_human_clipboard@male@base', 'base', tablet, 49, 60309)
end

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
local closeNui = function()
    SetNuiFocus(false, false)
    vRP._DeletarObjeto(tablet)
    TaskClearLookAt(PlayerPedId())
end

RegisterNuiCallback('close', function(data, cb)
    closeNui()

    cb('Ok')
end)

RegisterNuiCallback('changeImage', function(data, cb)
    vSERVER.updatePhoto(data.image)

    local infos = vSERVER.getUserIdentity()
    updateUi(infos)

    cb('Ok')
end)
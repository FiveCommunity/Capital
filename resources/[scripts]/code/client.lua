vSERVER = Tunnel.getInterface(GetCurrentResourceName())

RegisterCommand('openCodes', function()
    if (vSERVER.checkPermission()) then        
        SetNuiFocus(true, true)

        TriggerEvent('gb_core:tabletAnim')
        SendNUIMessage({ action = 'OPEN_TENCODE' })
    end
end)
RegisterKeyMapping('openCodes', '[Policia] - Códigos Q', 'keyboard', 'J')

-----------------------------------------------------
-- Callback's
-----------------------------------------------------

RegisterNUICallback('code', function(data, cb) TriggerServerEvent('code:execute', data.code); end)

local closeUi = function()
    SetNuiFocus(false, false)
    TriggerEvent('gb_core:stopTabletAnim')
end

RegisterNUICallback('close', function(data, cb) closeUi(); end)
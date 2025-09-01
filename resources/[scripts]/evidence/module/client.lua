local cache = {}

RegisterNetEvent('evidence:open', function(type, slot)
    cache = { type = type, slot = slot }
    TriggerEvent('evidence:tabletAnim')

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        hasNearest = vRP.getNearestPlayer(config.nearestRadius),
        type = type
    })
end)

RegisterNetEvent('evidence:tabletAnim', function() vRP.CarregarObjeto('amb@code_human_in_bus_passenger_idles@female@tablet@base', 'base', 'prop_cs_tablet', 49, 28422, 0.0, 0.0, -0.05, 0.0, 0.0, 0.0, true); end)

------------------------------------------------------------------------------------------
-- Callback's
------------------------------------------------------------------------------------------
RegisterNUICallback('close', function(data, cb)
    cache = {};
    SetNuiFocus(false, false)
    vRP.DeletarObjeto()

    cb('Ok')
end)

RegisterNUICallback('hasNearest', function(data, cb) cb(vSERVER.hasNearest(cache.slot, cache.type)); end)
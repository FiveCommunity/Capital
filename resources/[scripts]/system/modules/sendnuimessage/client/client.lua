SendNuiMessage = function(nui, bool)
    SendNUIMessage({
        action = nui,
        actionShow = bool
    })
end
exports('SendNuiMessage', SendNuiMessage)
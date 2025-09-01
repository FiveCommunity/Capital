RegisterNetEvent('clipboard', function(title, value)
    SetNuiFocus(true, true)
    UpdateStats('clipboard', {
        title = title,
        value = value
    })
end)
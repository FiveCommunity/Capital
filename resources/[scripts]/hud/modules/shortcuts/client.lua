local shortcuts = false

showShortcuts = function()
    if LocalPlayer.state.inRoyale or LocalPlayer.state.inRound6 or LocalPlayer.state.isPlayingEvent then
        return
    end

    if (not shortcuts) then
        shortcuts = true
        UpdateStats('shortcut', { 
            show = true, 
            hotbar = vSERVER.getUserHotbar()
        }) 
    end
end

hideShortcuts = function()
    if LocalPlayer.state.inRoyale or LocalPlayer.state.inRound6 then
        return
    end
    
    UpdateStats('shortcut', { show = false }) 
    shortcuts = false
end

RegisterCommand('+shortcuts', showShortcuts)
RegisterCommand('-shortcuts', hideShortcuts)
RegisterKeyMapping('+shortcuts', 'Visualizar atalhos.', 'keyboard', 'TAB')
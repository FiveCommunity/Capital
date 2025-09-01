local warning = {
    [1800] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Foi detectado um terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 30 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
    end,
    [1200] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 20 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
    end,
    [900] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 15 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
    end,
    [600] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 10 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
    end,
    [300] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 5 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
    end,
    [240] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 4 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
    end,
    [180] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 3 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
    end,
    [120] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 2 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
    end,
    [60] = function()
        TriggerClientEvent('announcement', -1, 'Alerta', 'Terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em 1 minutos na nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
        Citizen.Wait(30000)
        TriggerClientEvent('gb_core:terremoto', -1)
    end
}

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if (warning[eventData.secondsRemaining]) then warning[eventData.secondsRemaining](); end;
end)
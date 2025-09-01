Notify = function(type, title, message, time)
    local notifys = {
        hunger = true,
        thirst = true, 
        stress = true, 
        urine = true,
        poop = true,
        sucesso = true, 
        importante = true,
        aviso = true, 
        negado = true
    }

    -- [ Convert old notify ] --
    if (not notifys[type]) or (string.find(title,'<b>')) then 
        type = 'importante' 
        message = title
        title = capitalizeString(type)
    end

    UpdateStats('notify', {
        type = type,
        title = title,
        message = message,
        time = time
    })
end
RegisterNetEvent('notify', Notify)
RegisterNetEvent('Notify', Notify)

Announcement = function(title, message, author, playAudio, time)
    UpdateStats('announcement', {
        title = title,
        message = message,
        author = author,
        playAudio = playAudio,
        time = time
    })
end
RegisterNetEvent('announcement', Announcement)

ProgressBar = function(time)
    UpdateStats('progress', time)
end
RegisterNetEvent('ProgressBar', ProgressBar)
RegisterNetEvent('progressBar', function(text, time) UpdateStats('progress', time) end)
RegisterNetEvent('progress', function(time, text) UpdateStats('progress', time) end)

NotifyItem = function(type, item, amount, index, time)
    UpdateStats('notifyItem', {
        type = type,
        item = item,
        amount = amount,
        index = index,
        time = time
    })
end
RegisterNetEvent('NotifyItem', NotifyItem)
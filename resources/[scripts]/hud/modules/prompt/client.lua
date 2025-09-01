cli.createPrompt = function(questions)
    SetNuiFocus(true, true)
    UpdateStats('prompt', { questions = questions })
end

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
local response = false

RegisterNUICallback('promptResult', function(data, cb)
    response = true
    vSERVER.resultPrompt(data.responses)
    SetNuiFocus(false, false)

    cb('Ok')
end)

RegisterNUICallback('closePrompt', function(data, cb)
    if (not response) then
        vSERVER.resultPrompt(false)
        SetNuiFocus(false, false)
    else
        response = false
    end

    cb('Ok')
end)
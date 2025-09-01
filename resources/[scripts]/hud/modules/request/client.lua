local requests = {}

cli.createRequest = function(id, title, message, time)
    table.insert(requests, id)
    UpdateStats('request', {
        id = id, 
        title = title,
        message = message,
        time = time
    })
end

cli.resultRequest = function(result)
    local currentRequest = table.remove(requests,1)
    if currentRequest then
        UpdateStats('removeRequest', { id = currentRequest })
        vSERVER.resultRequest(currentRequest, result)
    end
end

RegisterCommand('+accept_request', function() cli.resultRequest(true) end)
RegisterCommand('+reject_request', function() cli.resultRequest(false) end)

RegisterKeyMapping('+reject_request', 'Rejeitar requisição', 'keyboard', 'u')
RegisterKeyMapping('+accept_request', 'Aceitar requisição', 'keyboard', 'y')
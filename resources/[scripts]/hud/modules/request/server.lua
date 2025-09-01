local idGenerator = Tools.newIDGenerator()

local requests = {}

srv.request = function(source, title, message, time)
    local id = idGenerator:gen()+1
    
    local async_response = async()
    requests[id] = async_response
    
    vCLIENT.createRequest(source, id, title, message, time)
    
    Citizen.SetTimeout(time, function()
        srv.resultRequest(id,false)
    end)

    return async_response:wait()
end
exports('request', srv.request)

srv.resultRequest = function(id, response)
    local currentRequest = requests[id]
    if currentRequest then
        currentRequest(response)
        requests[id] = nil
        Citizen.SetTimeout(1000,function() idGenerator:free(id-1); end)
    end
end
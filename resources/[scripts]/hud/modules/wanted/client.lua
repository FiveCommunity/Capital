local timeWanted = 0
local threadStarted = false

local startThread = function()
    if (threadStarted) then return; end;
    threadStarted = true

    Citizen.CreateThread(function()       
        while (timeWanted > 0) do
            Citizen.Wait(1000)
        
            timeWanted -= 1
            UpdateStats('updateWanted', timeWanted) 
     
        end
        threadStarted = false
    end)
end

RegisterNetEvent('update:wanted', function(time)
    timeWanted = time
    if (not threadStarted) then startThread(); end;
end)

exports('isWanted', function(notify) 
    if (notify) and (timeWanted > 0) then
        TriggerEvent('notify', 'aviso', 'Procurado', 'Você está sendo <b>procurado</b>!')
    end
    return (timeWanted > 0) 
end)
local vSERVER = Tunnel.getInterface('Washing')

Citizen.CreateThread(function()
    for _, v in pairs(Washing.locations) do
        TriggerEvent('insert:hoverfy', v.coord.xyz, 'E', 'Interagir', 2.0)
    end
end)

local checkDistance = function()
    local pCoord = GetEntityCoords(PlayerPedId())
    for index, v in pairs(Washing.locations) do
        local distance = #(pCoord - v.coord.xyz)
        if (distance <= 2.0) then return index; end;
    end
    return false
end

RegisterCommand('openWashing', function()
    local index = checkDistance()
    if (index) then vSERVER.startWashing(index); end;
end)
RegisterKeyMapping('openWashing', 'Abrir a lavagem', 'keyboard', 'E')
local vSERVER = Tunnel.getInterface('Wedding')

local coord = vector3(-550.4308, -192.4352, 38.21021)

--[[
Citizen.CreateThread(function()
    while (true) do
        local idle = 1000
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        local distance = #(pCoord - coord)
        if (distance <= 3.0) then
            idle = 1
            TextFloating('~b~E~w~ - Iniciar casamento\n~b~F~w~ - Iniciar divórcio', coord)
            if (distance <= 1.2 and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                if (IsControlJustPressed(0, 38)) then
                    vSERVER.startWedding()
                elseif (IsControlJustPressed(0, 75)) then
                    vSERVER.startDivorce()
                end
            end
        end
        Citizen.Wait(idle)
    end
end)
]]
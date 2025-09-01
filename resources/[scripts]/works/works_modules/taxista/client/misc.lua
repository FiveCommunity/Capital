
function RouteTimer()
    return GetGameTimer()+math.random(10000,15000)
end

function PedDrivingTaxi(ped)
    local vehicle = GetVehiclePedIsIn(ped,false)
    if (vehicle > 0) then
        local model = GetEntityModel(vehicle)
        if Taxista.vehicles[model] and (GetPedInVehicleSeat(vehicle,-1) == ped) then
            return vehicle
        end
    end
    return false
end
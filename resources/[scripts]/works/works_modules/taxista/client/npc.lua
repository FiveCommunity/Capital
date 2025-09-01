function CreateTaxiClient(coords)
    local model = Taxista.npcs[math.random(1,#Taxista.npcs)] 
    local hash = GetHashKey(model)

    while (not HasModelLoaded(hash)) do
        RequestModel(hash)
        Citizen.Wait(1)
    end

    local ped = CreatePed(0, hash, coords.x, coords.y, coords.z-0.97, coords.w, false, false)
    if DoesEntityExist(ped) then
        FreezeEntityPosition(ped,true)
        SetEntityInvincible(ped,true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetModelAsNoLongerNeeded(hash)
        Entity(ped).state:set('scenario', true, true)

        --TriggerServerEvent('works:taxi:managePed', PedToNet(ped), true)

        return ped
    end
end

function DeleteTaxiClient(ped)
    if ped and DoesEntityExist(ped) then
        --TriggerServerEvent('works:taxi:managePed', PedToNet(ped), false)
        SetEntityAsNoLongerNeeded(ped)
        DeleteEntity(ped)
    end
end
RegisterNUICallback('changeFilter', function(data)
    page = data.page
    search = data.search
    typeSearch = data.typeSearch

    cHospital.updateNui()
end)

RegisterNUICallback('cancelService', function()
    SetNuiFocus(false, false)
    TriggerEvent('gb_core:stopTabletAnim')
    local response = sHospital.requestCancelService()
    if response then
        sHospital.cancelLog(service)
        service = {}
        TriggerEvent('notify', 'Centro Médico', 'Você cancelou o atendimento atual!')
    end
end)

RegisterNUICallback('acceptService', function()
    service = sHospital.acceptService()
    cHospital.updateNui()
end)

RegisterNUICallback('registerService', function(data)
    sHospital.registerService(data)
    service = {}
    cHospital.updateNui()
    TriggerEvent('notify', 'Centro Médico', 'Você registrou o atendimento!')
end)

Citizen.CreateThread(function()
    local hospitalCoords = vector3(-2053.925, -472.2989, 26.28064)
    while (true) do
        for _, ped in ipairs(GetGamePool('CPed')) do
            local stateBag = Entity(ped).state
            local pedCoords = GetEntityCoords(ped)

            local dist = #(pedCoords - hospitalCoords)
            if (dist <= 80.0) and (not stateBag.scenario and not IsPedAPlayer(ped) and not IsPedInAnyVehicle(ped)) then
                DeleteEntity(ped)
            end
        end
        Citizen.Wait(1000)
    end
end)
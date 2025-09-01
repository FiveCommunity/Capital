cHospital = {} --lista vazia (table lua)
service = {}
page = 1
search = ''
typeSearch = 'patient_id'

Tunnel.bindInterface(GetCurrentResourceName(),cHospital)
sHospital = Tunnel.getInterface(GetCurrentResourceName())

cHospital.updateNui = function()
  SendNUIMessage({
    action = 'open',
    pendingServicesAmount = sHospital.getServicesPendingsAmount(),
    currentService = service,
    prices = config.prices,
    servicesAmount = sHospital.servicesAmount(page, search, typeSearch),
    services = sHospital.listServices(page, search, typeSearch),
    filter = { page = page, search = search, typeSearch = typeSearch }
  })
end

RegisterNUICallback('close', function() 
  SetNuiFocus(false, false)
  page = 1
  search = ''
  typeSearch = 'patient_id'
  TriggerEvent('gb_core:stopTabletAnim')
end)

cHospital.open = function()
  SetNuiFocus(true, true)
  TriggerEvent('gb_core:tabletAnim')
  cHospital.updateNui()
end

RegisterNetEvent('hospital:open', function()
  sHospital.requestService()
end)


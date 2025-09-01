sHospital = {} 
services = {}
servicesCount = 0
servicePosition = 0
Tunnel.bindInterface(GetCurrentResourceName(),sHospital)
cHospital = Tunnel.getInterface(GetCurrentResourceName())

RegisterCommand('ph', function(source)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'hospital.permissao') then
        cHospital.open(source)
    else 
        TriggerClientEvent('notify', source, 'Centro Médico', 'Você não possui permissão para acessar o painel!')
    end
end)

RegisterNetEvent('hospital:cirurgia', function()
    local _source = source
    local user_id = vRP.getUserId(_source)

    local request = exports.hud:request(_source, 'Cirurgia', 'Você tem certeza que deseja ir para a cirurgia?', 30000)
    if (request) then
        exports.oxmysql:update_async('update user_datatable set reset_character = 1 where user_id = ?', { user_id })
        
        if (_source) then
            Player(_source).state.resetAppearance = true
            SetPlayerRoutingBucket(_source, tonumber(1000+user_id))
            TriggerClientEvent('notify', _source, 'aviso', 'Cirurgia', 'Sua <b>cirurgia</b> está prestes a começar.')
            TriggerClientEvent('notify', _source, 'sucesso', 'Cirurgia', 'A <b>cirurgia</b> foi um sucesso!')
        end

        vRP.webhook('cirurgia', {
            title = 'cirurgia',
            descriptions = {
                { 'NPC Hospital', 'NPC Hospital' },
                { 'target', user_id },
            }
        })  
    end
end)
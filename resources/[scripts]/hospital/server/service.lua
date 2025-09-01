tableName = 'hospital'
vRP.prepare('gb_hospital:registerService','insert into '..tableName..' (doctor_id, patient_id, total_price, service_date, request, description) values (@doctor_id, @patient_id, @total_price, @service_date, @request, @description)');
vRP.prepare('gb_hospital:listServicesByPatient','select * from ' ..tableName.. ' where patient_id like @search order by service_date desc limit 7 offset @offset');
vRP.prepare('gb_hospital:listServicesByDoctor','select * from ' ..tableName.. ' where doctor_id like @search order by service_date desc limit 7 offset @offset');
vRP.prepare('gb_hospital:countServicesByPatient','select COUNT(*) from ' .. tableName ..' where patient_id like @search');
vRP.prepare('gb_hospital:countServicesByDoctor','select COUNT(*) from ' .. tableName ..' where doctor_id like @search');

sHospital.servicesAmount = function(page, search, typeSearch)
    if typeSearch == 'patient_id' then
        return vRP.query('gb_hospital:countServicesByPatient', { search = '%' .. search .. '%' })[1]['COUNT(*)']
    end
    if typeSearch == 'doctor_id' then
        return vRP.query('gb_hospital:countServicesByDoctor', { search = '%' .. search .. '%' })[1]['COUNT(*)']
    end
end

sHospital.registerService = function(data)
    local _source = source
    local doctor_id = vRP.getUserId(_source)
    local patient = vRP.getUserIdentity(data.patient_id)

    vRP.execute('gb_hospital:registerService', { 
        doctor_id = doctor_id,
        patient_id = data.patient_id,
        patient_name = patient.firstname ..' '..patient.lastname,
        total_price = data.total_price,
        service_date = os.date("%Y-%m-%d %H:%M:%S"),
        request = data.request, 
        description = data.description
    })

    vRP.webhook('requestService', {
        title = 'registrar serviço',
        descriptions = {
            { 'id Medico', doctor_id },
            { 'id Paciente', data.patient_id },
            { 'Valor total', data.total_price },
            { 'Descricao', data.description },
            { 'Solicitacao', data.request },
        }
    })  
end

--Serviços feitos no dia
sHospital.listServices = function(page, search, typeSearch) 
    local services = {}
    if typeSearch == 'patient_id' then
        services = vRP.query('gb_hospital:listServicesByPatient', { offset = (tonumber(page) - 1) * 7, search = '%' .. search .. '%' })
    end
    if typeSearch == 'doctor_id' then
        services = vRP.query('gb_hospital:listServicesByDoctor', { offset = (tonumber(page) - 1) * 7, search = '%' .. search .. '%' })
    end
    for k,v in pairs(services) do
        local patient = vRP.getUserIdentity(v.patient_id) or { firstname = '', lastname = '' }
        local doctor = vRP.getUserIdentity(v.doctor_id) or { firstname = '', lastname = '' }

        services[k].patient_name = patient.firstname..' '..patient.lastname
        services[k].doctor_name = doctor.firstname..' '..doctor.lastname
    end

    return services
end

sHospital.requestCancelService = function()
    local _source = source
    return vRP.request(_source, 'Serviço', 'Deseja realmente cancelar este atendimento?', 20000)
end

sHospital.alert = function(user_id)   
    if (user_id) then
        exports.vrp:reportUser(user_id, {
            service = 'hospital.permissao',
            notify = { 
                type = 'default', 
                title = 'Centro Médico', 
                message = 'Uma nova solicitação de atendimento foi aberta!',
                coords = vector3(299.156, -584.6241, 49.75244),
                time = 8000
            },
        })
    end
end

sHospital.requestService = function()
    local _source = source
    local user_id = vRP.getUserId(_source)
    local user_identity = vRP.getUserIdentity(user_id)
    local request = vRP.prompt(_source,{'Bem vindo(a) ao Centro Médico Capital, em que podemos te ajudar?'})[1]

    if request then
        if services['id:'..user_id] == nil then
            services['id:'..user_id] = {
                patient_name = user_identity.firstname .. ' ' .. user_identity.lastname,
                patient_id = user_id,
                request = request,
                pos = servicePosition
            }
            servicePosition = servicePosition + 1 
            servicesCount = servicesCount + 1
            TriggerClientEvent('notify', _source, 'importante', 'Centro Médico', 'Uma nova solicitação de atendimento foi aberta. Para agilizar seu atendimento, dirija-se ao 3º andar.')
            sHospital.alert(user_id)

            vRP.webhook('requestService', {
                title = 'solicitacao de atendimento',
                descriptions = {
                    { 'id', user_id },
                    { 'Solicitacao', request },
                }
            })  
        else
            TriggerClientEvent('notify', _source, 'negado', 'Centro Médico','Você já possui uma solicitação de atendimento aberta.')
        end   
    end
end

sHospital.acceptService = function() 
    local _source = source
    local user_id = vRP.getUserId(_source)
    local firstService = nil
    local firstPos = nil
    for key,value in pairs(services) do 
        if firstService == nil or value.pos < firstPos then
            firstService = value
            firstPos = value.pos
        end
    end

    if firstService then

        vRP.webhook('acceptService', {
            title = 'Aceitar solicitação',
            descriptions = {
                { 'id Medico', user_id },
                { 'id Paciente', firstService.patient_id },
                { 'Solicitacao', firstService.request },
            }
        })  

        local patient_source = vRP.getUserSource(user_id)
        local doctor = vRP.getUserIdentity(user_id)
        if patient_source then
            TriggerClientEvent('notify', patient_source, 'aviso', 'Centro Médico', 'Você será atendido por: <b>'..doctor.firstname ..' '..doctor.lastname..'</b>. Dirija-se à sala de emergência!', 'Centro Médico Capital', true)
        end

        services['id:'..firstService.patient_id] = nil
        servicesCount = servicesCount - 1
        return firstService
    end
end


sHospital.getServicesPendingsAmount = function() 
    return servicesCount
end

sHospital.cancelLog = function(service)
    local _source = source
    local user_id = vRP.getUserId(_source)
    
    local patient_source = vRP.getUserSource(service.patient_id)
    if patient_source then
        TriggerClientEvent('notify', patient_source, 'importante', 'Centro Médico', 'A sua solicitação de serviço atual foi cancelada!', 'Centro Médico Capital', true)
    end

    vRP.webhook('cancelService', {
        title = 'Cancelar serviço',
        descriptions = {
            { 'id Medico', user_id },
            { 'id Paciente', service.patient_id },
            { 'Solicitacao', service.request },
        }
    })  
end
srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

srv.checkPermission = function(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.checkPermissions(user_id, 'policia.permissao')
end

local cooldownCode = 0

RegisterNetEvent('prison:execute', function(code)
    local source = source
    local user_id = vRP.getUserId(source)

    if (user_id) and (vRP.checkPermissions(user_id, 'policia.permissao')) then

        local audios = {
            [1] = 'prison/volta-para-celas',
            [2] = 'prison/tranquem-todas-as-celas',
            [3] = 'prison/todo-mundo-no-patio',
            [4] = 'prison/hora-do-hino-nacional',
            [5] = 'prison/hora-do-almoco',
            [6] = 'prison/fila-para-revista',
            [7] = 'prison/hino',
        }

        local sound = audios[code]
        if sound then
  
            local actualTime = os.time()
            if (cooldownCode) and (cooldownCode > actualTime) then
                TriggerClientEvent('notify', source, 'negado', 'Prisão', 'Aguarde <b>'..(cooldownCode - actualTime)..' segundos</b>.')
                return false
            end

            cooldownCode = actualTime + 30

            TriggerClientEvent('vrp_sounds:variation:fixed', -1, config.warns.soundCoords, 130.0, sound, 0.10)

            TriggerClientEvent('notify', source, 'sucesso', 'Prisão', 'Mensagem acionada!')
        end
    end
end)

local prisonCycles = {}

Citizen.CreateThread(function()
    for key, values in pairs(config.cycles) do
        if (key ~= 'model') then
            local handle = exports.garage:CreateServerVehicle(config.cycles.model, values.xyz, values.w)
            prisonCycles[#prisonCycles+1] = NetworkGetNetworkIdFromEntity(handle)
        end
    end
end)

AddEventHandler('onResourceStop', function(rsc)
    if (GetCurrentResourceName() ~= rsc) then return; end;

    for _, v in pairs(prisonCycles) do
        local entity = NetworkGetEntityFromNetworkId(v)
        if (DoesEntityExist(entity)) then
            DeleteEntity(entity)
        end
        Citizen.Wait(100)
    end
end)
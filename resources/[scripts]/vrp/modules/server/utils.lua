local cooldownReport = {}

vRP.reportUser = function(user_id, data)
    local source = vRP.getUserSource(user_id)
    
    local report = false;
    if (data.percentage) and (data.percentage > 0) then
        local random = math.random(100)
        if (random <= data.percentage) then
            report = true;
        end
    else
        report = true;
    end

    if (report) then
        if (data.extra) then data.extra(source); end;

        local permission = vRP.getUsersByPermission((data.service or 'policia.permissao'))
        for _, id in pairs(permission) do   
            local nsource = vRP.getUserSource(parseInt(id))
            if (nsource) then
                local cooldownId = nsource..'-'..user_id
                if (not cooldownReport[cooldownId]) then
                    cooldownReport[cooldownId] = true
                    Citizen.SetTimeout(15000, function() cooldownReport[cooldownId] = nil; end)

                    if (data.notify) then TriggerClientEvent('NotifyPush', nsource, data.notify); end;
                    if (data.blip) then TriggerClientEvent('reportUser:blip', nsource, data.blip); end;
                end
            end
        end
    end
end
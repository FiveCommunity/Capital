--=======================================================
-- Convert App Homes (LB-PHONE)
--=======================================================
Residents = function(method, user_id, home, nUser)
    local consult = cache.homes[home]
    if (consult) then
        if (method == 'add') then
            local residents = countResidents(consult.residents)
            if (residents < consult.config.residents) and (not consult.residents[tostring(nUser)]) then
                cache.homes[home].residents[tostring(nUser)] = true
                oxmysql:update_async('update homes set residents = ? where home = ?', { json.encode(cache.homes[home].residents), home })

                vRP.webhook('addhouse', {
                    title = 'add house',
                    descriptions = {
                        { 'action', '(add resident)' },
                        { 'user', user_id },
                        { 'add', nUser },
                        { 'home', home },
                    }
                })  
                
                return consult
            end
        else
            if (consult.residents[tostring(nUser)]) then
                cache.homes[home].residents[tostring(nUser)] = nil
                oxmysql:update_async('update homes set residents = ? where home = ?', { json.encode(cache.homes[home].residents), home })
               
                vRP.webhook('remhouse', {
                    title = 'rem house',
                    descriptions = {
                        { 'action', '(rem resident)' },
                        { 'user', user_id },
                        { 'rem', nUser },
                        { 'home', home },
                    }
                })  

                return consult
            end
        end
    end
    return false
end
exports('Residents', Residents)

Doors = function(method, home)
    if (method == 'set') then
        cache.homes[home].openned = (not cache.homes[home].openned)
    end

    if cache.homes[home] and (cache.homes[home].openned ~= nil) then
        if (cache.homes[home].openned) then
            return false -- Destrancado (versão lb-phone)
        end
    end
    return true
end
exports('Doors', Doors)
config.webhooks = {
    ['weapons'] = function(source, link, arsenalName, user_id, spawn, weaponName, ammo)
        vRP.webhook(link, {
            title = 'arsenal',
            descriptions = {
                { 'action', '(pegar armamento)' },
                { 'arsenal', arsenalName },
                { 'policial', user_id..' | '..getIdentity(getUserIdentity(user_id)) },
                { 'armamento retirado', spawn },
                { 'nome', weaponName },
                { 'munição', ammo },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })     
    end,
    ['utilitaryWeapon'] = function(source, link, arsenalName, user_id, spawn, name, ammo)
        vRP.webhook(link, {
            title = 'arsenal',
            descriptions = {
                { 'action', '(pegar utilitário)' },
                { 'arsenal', arsenalName },
                { 'policial', user_id..' | '..getIdentity(getUserIdentity(user_id)) },
                { 'utilitário retirado', spawn },
                { 'nome', name },
                { 'munição', ammo },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })     
    end,
    ['utilitaryItem'] = function(source, link, arsenalName, user_id, spawn, name, quantity)
        vRP.webhook(link, {
            title = 'arsenal',
            descriptions = {
                { 'action', '(pegar utilitário)' },
                { 'arsenal', arsenalName },
                { 'policial', user_id..' | '..getIdentity(getUserIdentity(user_id)) },
                { 'utilitário retirado', spawn },
                { 'nome', name },
                { 'quantidade', quantity },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })     
    end,
    ['kits'] = function(source, link, arsenalName, user_id, name)
        vRP.webhook(link, {
            title = 'arsenal',
            descriptions = {
                { 'action', '(pegar kit)' },
                { 'arsenal', arsenalName },
                { 'policial', user_id..' | '..getIdentity(getUserIdentity(user_id)) },
                { 'kit retirado', name },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })     
    end,
    ['ammo'] = function(source, link, arsenalName, user_id, spawn, ammoExtra)
        vRP.webhook(link, {
            title = 'arsenal',
            descriptions = {
                { 'action', '(pegar munição extra)' },
                { 'arsenal', arsenalName },
                { 'policial', user_id..' | '..getIdentity(getUserIdentity(user_id)) },
                { 'munição retirada', spawn },
                { 'nome', spawn },
                { 'quantidade', ammoExtra },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })     
    end
}
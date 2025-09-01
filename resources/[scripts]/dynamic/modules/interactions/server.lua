RegisterNetEvent('gb_interactions:kiss', function()
    local source = source
    local user_id = vRP.getUserId(source)

    if (user_id) then
        local identity = vRP.getUserIdentity(user_id)
        
        local nplayer = vRPclient.getNearestPlayer(source, 2.5)
        if (not nplayer) then return; end;

        local request = exports.hud:request(nplayer, 'Relacionamento', 'Você deseja aceitar o <b>beijo</b> de <b>'..identity.firstname..'</b> '..identity.lastname..'</b>?', 30000)
        if (request) then
            TriggerClientEvent('gb_animations:setAnim', source, 'beijar', nplayer)
            TriggerClientEvent('gb_animations:setAnim', nplayer, 'beijar', source)
        else
            TriggerClientEvent('notify', source, 'negado', 'Relacionamento', 'Seu <b>beijo</b> foi recusado! 🤣🤣🤣')
        end
    end
end)
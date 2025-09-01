srv.hasNearest = function(slot, type)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local playerInventory = vRP.PlayerInventory(user_id)

        local nplayer = vRPclient.getNearestPlayer(source, config.nearestRadius)
        if (nplayer) then 
            local nuser = vRP.getUserId(nplayer)

            vRPclient.DeletarObjeto(source)

            TriggerClientEvent('gb_animations:setAnim', source, 'mexer')
            TriggerClientEvent('gb_animations:setAnim', nplayer, 'unhas')

            Citizen.Wait(800)

            ClearPedTasks(GetPlayerPed(source))
            ClearPedTasks(GetPlayerPed(nplayer))

            Citizen.Wait(500)

            TriggerClientEvent('evidence:tabletAnim', source)

            playerInventory:useSlot(slot, 1)
            
            local state = ((type == 'polvora') and 'powderEvidence' or 'drugEvidence')
            local result = (Player(nplayer).state[state] and 'error' or 'sucess')

            local identity;
            if (nuser) then
                identity = vRP.getUserIdentity(nuser);

                vRP.webhook('https://discord.com/api/webhooks/1255995203844571136/uAaVJV-XDpBaytOtjjrJJUupr4AC5KH-0gsLfRQYSgUNfuu_YaWmpx_aFGFmPgbFjNNn', {
                    title = 'Evidence',
                    descriptions = {
                        { 'action', '('..state..')' },
                        { 'officer', user_id },
                        { 'target', nuser },
                        { 'result', result }
                    }
                })
            end

            return {
                has = true,
                firstname = (identity and identity.firstname or 'Indivíduo'),
                type = result
            }
        end
    end
    return false
end
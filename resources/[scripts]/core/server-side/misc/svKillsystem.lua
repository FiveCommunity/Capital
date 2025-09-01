local srv = {}
Tunnel.bindInterface('Killsystem', srv)

local config = module('core','cfg/cfgKillsystem')

local cooldownKillSystem = {}

local AlertAdmin = function(killer_id, user_id, weaponName)
    local text = (killer_id and '[ID]: '..killer_id..' [MATOU O ID]: '..user_id..' [ARMA]: '..weaponName or '[ID]: '..user_id..' MORREU [MOTIVO]: '..weaponName)
    
    local admin = vRP.getUsersByPermission('staff.permissao')
    for l, w in pairs(admin) do
        local player = vRP.getUserSource(parseInt(w))
        if (player) then
            TriggerClientEvent('chatMessage', player, '[KILLSYSTEM]', {3, 187, 232}, text)
        end
    end
end

srv.playerDeath = function(weapon, killerSource, headShot)
    local source = source
    local user_id = vRP.getUserId(source)	
    if (user_id) then
        if cooldownKillSystem[user_id] and cooldownKillSystem[user_id] > os.time() then
            return
        end

        cooldownKillSystem[user_id] = os.time() + 5
        local weaponName = (config.weapons[weapon] and config.weapons[weapon]['name'] or 'Desconhecido')
        
        local victim_identity = vRP.getUserIdentity(user_id)
        local sPed = GetPlayerPed(source)
        local victimCoord = GetEntityCoords(sPed)
        
        if (killerSource) and source ~= killerSource then
            killerSource = parseInt(killerSource)

            local killer_id = vRP.getUserId(killerSource)
            local nPed = GetPlayerPed(killerSource)
            local killerCoord = GetEntityCoords(nPed)
            if (killer_id) then
                local killer_identity = vRP.getUserIdentity(killer_id)
                vRP.webhook('killSystem', {
                    title = 'kill system',
                    descriptions = {
                        { 'id', killer_id..' - '..killer_identity.firstname },
                        { 'matou o id', user_id..' - '..victim_identity.firstname },
                        { 'morreu por', weaponName },
                        { 'hash', weapon },
                        { 'local assasino', tostring(killerCoord) },
                        { 'local vítima', tostring(victimCoord) }
                    }
                })  
                AlertAdmin(killer_id, user_id, weaponName)
            end
        else
            vRP.webhook('killSystem', {
                title = 'kill system',
                descriptions = {
                    { 'id', user_id..' - '..victim_identity.firstname },
                    { 'morreu por', weaponName },
                    { 'hash', weapon },
                    { 'local da morte', tostring(victimCoord) }
                }
            })  
            AlertAdmin(false, user_id, weaponName)
        end
    end
end
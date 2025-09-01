local srv = {}
Tunnel.bindInterface('ATM', srv)

local cooldownATM, stealingATM = {}, {}

srv.checkRobbery = function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        -- local police = vRP.getUsersByPermission('policia.permissao')
        -- if (#police < 5) then
        --     TriggerClientEvent('notify', source, 'negado', 'ATM', 'Contigente <b>insuficiente</b>.')
        --     return false
        -- end

        if (cooldownATM[id]) and (os.time() < cooldownATM[id]) then
            TriggerClientEvent('notify', source, 'negado', 'ATM', 'O ATM tá vazio, aguarde <b>'..(cooldownATM[id] - os.time())..' segundos</b> até que tenha dinheiro novamente.')
            return false
        end

        local userInventory = vRP.PlayerInventory(user_id)
        if (userInventory) then
            if (userInventory:tryGetItem('c4', 1, nil, true)) then
                local pCoord = GetEntityCoords(GetPlayerPed(source))
                
                exports.vrp:reportUser(user_id, {
                    notify = { 
                        type = 'default', 
                        title = 'Roubo ao ATM', 
                        message = 'Acabamos de receber uma denúncia anônima, vá até o local.',
                        coords = pCoord,
                        time = 8000
                    },
                    blip = {
                        id = user_id, 
                        text = 'Roubo ao ATM', 
                        coords = pCoord,
                        timeout = 30000
                    }
                })

                exports.hud:insertWanted(user_id, 180, 1200)

                cooldownATM[id] = os.time()+1200

                stealingATM[user_id] = 0
                return true
            end
        end
    end
    return false
end

srv.getATMMoney = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (not stealingATM[user_id]) then return; end;

        stealingATM[user_id] = stealingATM[user_id] + 1
        if (stealingATM[user_id] > 10) then return; end;

        local userInventory = vRP.PlayerInventory(user_id)
        if (userInventory) then
            local quantity = math.random(ATM.general.payment.min, ATM.general.payment.max)
            userInventory:giveItem(ATM.general.payment.item, quantity, nil, nil, true)
        
            vRP.webhook('roubos', {
                title = 'roubos',
                descriptions = {
                    { 'user', user_id },
                    { 'local', 'ATM' },
                    { 'value', 'R$'..vRP.format(quantity) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            }) 
        end
    end
end

srv.cleanATM = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (stealingATM[user_id]) then stealingATM[user_id] = nil; end;
end

AddEventHandler('vRP:playerLeave', function(user_id,source)
    if (stealingATM[user_id]) then stealingATM[user_id] = nil; end;
end)
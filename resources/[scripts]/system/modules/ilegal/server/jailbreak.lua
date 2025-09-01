local sJAIL = {}
Tunnel.bindInterface('JailBreak', sJAIL)

local breaking = {}

function sJAIL.tryJailBreak()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local Inventory = vRP.PlayerInventory(user_id)
        if Inventory then
            local amount, slot = Inventory:getItemAmount('chave-prisao')
            if (amount > 0) then       
                if Inventory:tryGetItem('chave-prisao',1,slot,true) then
                    breaking[user_id] = {}
                    return true
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Prisão', 'Você não possui uma <b>Chave da Prisão</b>!',8000)
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Prisão', 'Você não possui uma <b>Chave da Prisão</b>!',8000)
            end
        end
    end
    return false
end

function sJAIL.removeJail()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if breaking[user_id] and (not breaking[user_id].run) then
            breaking[user_id].run = true

            local exitCoords = JailBreak.exitCoords[math.random(#JailBreak.exitCoords)]

            Player(source).state.Prison = false
            vRP.setUData(user_id, 'prison', json.encode(-1))
            
            SetEntityHeading(GetPlayerPed(source), exitCoords.w)
            vRPclient.teleport(source, exitCoords.x, exitCoords.y, exitCoords.z)

            TriggerClientEvent('Notify', source, 'importante', 'Prisão', 'Você fugiu da <b>Prisão</b>! Pelos próximos 15 minutos, você está exposto para a polícia!',20000)
            TrackUser(user_id,60)
            exports.hud:insertWanted(user_id, 900, 1200)

            exports.vrp:reportUser(user_id, {
                notify = { 
                    type = 'route', 
                    title = 'Fuga da Prisão', 
                    message = 'Um prisioneiro está tentando escapar!',
                    coords = exitCoords,
                    time = 30000
                },
                blip = {
                    id = user_id, 
                    text = 'Fuga da Prisão', 
                    coords = exitCoords,
                    timeout = 120000
                }
            })

            vRP.webhook('prisonbreak', {
                title = 'PrisonBreak',
                descriptions = {
                    { 'user', user_id },
                    { 'coords', tostring(exitCoords) },
                }
            })

            return true
        end
    end
    return false
end

function TrackUser(user_id, ticks)
    Citizen.CreateThread(function()
        breaking[user_id].ticks = ticks

        while (breaking[user_id].ticks > 0) do
            local src = vRP.getUserSource(user_id)
            if src then
                local ped = GetPlayerPed(src)
                local coords = GetEntityCoords(ped)

                local permission = vRP.getUsersByPermission('policia.permissao')
                for _, id in pairs(permission) do   
                    local nsource = vRP.getUserSource(parseInt(id))
                    if (nsource) then
                        TriggerClientEvent('jailbreak:blip',nsource,user_id,coords)
                    end
                end

                breaking[user_id].ticks = breaking[user_id].ticks - 1
            end
            Citizen.Wait(15000)
        end

        breaking[user_id] = nil
    end)
end

AddEventHandler('vRP:playerLeave', function(user_id, source)
    if (breaking[user_id]) then
        local tempo = parseInt( (breaking[user_id].ticks or 0)/4 )
        vRP.webhook('prisonbreak', {
            title = 'PrisonBreak - Quit',
            descriptions = {
                { 'user', user_id },
                { 'fora da prisao', ((breaking[user_id].run and 'Sim') or 'Nao') },
                { 'tempo rest. (min)', tempo }
            }
        })
    end    
end)
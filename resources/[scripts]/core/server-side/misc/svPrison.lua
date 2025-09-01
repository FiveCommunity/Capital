local prisonCoord = vector4(1775.565, 2552.031, 45.55676, 90.70866)
local exitPrisonCoords = vector4(1845.785, 2585.842, 45.65784, 272.126)

-- local prisonCoord = vector4(3895.2, 33.2044, 23.88794, 164.4095)
-- local exitPrisonCoords = vector4(3917.433, -11.31428, 10.59338, 99.21259)

local typePrender = {
    ['colocar'] = function(source, user_id)
        local prompt = exports.hud:prompt(source, {
            'Passaporte do criminoso', 'Motivo da prisão', 'Listar itens ilegais encontrados com o criminoso', 'Tempo da prisão'
        })

        if (prompt) and prompt[1] and prompt[2] and prompt[3] and prompt[4] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]
            local Itens = prompt[3]
            local Time = parseInt(prompt[4])
            
            -- if (user_id == nUser) then TriggerClientEvent('notify', source, 'Prisão', 'Você não pode se <b>prender</b>!') return; end;

            local nIdentity = vRP.getUserIdentity(nUser)
            if (nIdentity) then
                local request = exports.hud:request(source, 'Prisão', 'Você tem certeza que deseja prender o '..nIdentity.firstname..' '..nIdentity.lastname..' por '..Time..' meses?', 60000)
                if (request) then
                    local nSource = vRP.getUserSource(nUser)
                    if (nSource) then
                        vRP.setUData(nUser, 'prison', json.encode(Time))
                        vRP.setUData(nUser, 'ficha_suja', json.encode(1))

                        if (vRPclient.isHandcuffed(nSource)) then
                            Player(nSource).state.Handcuff = false
                            vRPclient.setHandcuffed(nSource, false)
                            TriggerClientEvent('gb_core:uncuff', nSource)
                        end
                        
                        local prisonCoord = vector4(1775.552, 2552.149, 45.55676, 87.87402)
                        SetEntityHeading(GetPlayerPed(nSource), prisonCoord.w)
                        vRPclient.teleport(nSource, prisonCoord.x, prisonCoord.y, prisonCoord.z)
                        -- TriggerClientEvent('gb_animations:setAnim', nSource, 'deitar3')

                        prisonLock(nSource, nUser)

                        if (vRP.hasPermission(nUser, 'cacador.permissao')) then
                            vRP.removeUserGroup(nUser, 'Cacador')
                        end

                        -- local weapons = vRPclient.replaceWeapons(nPlayer, {}, GlobalState.weaponToken)
                        -- vRP.setKeyDataTable(nUser, 'weapons', {})

                        -- for k, v in pairs(weapons) do
                        --     local weapon = k:lower()
                        --     vRP.giveInventoryItem(nUser, weapon, 1)
                        --     if (v.ammo > 0) then
                        --         vRP.giveInventoryItem(nUser, 'm_'..weapon, v.ammo)
                        --     end
                        -- end

                        -- local inventory = vRP.getInventory(nUser)
                        -- for k, v in pairs(inventory) do
                        --     local itemConfig = exports.gb_inventory:getItemInfo(k)
                        --     if (itemConfig.arrest) then
                        --         if (vRP.tryGetInventoryItem(nUser, k, v.amount)) then
                        --             vRP.giveInventoryItem(user_id, k, v.amount)
                        --         end
                        --     end
                        -- end
                        
                        TriggerClientEvent('gb_sound:source', nSource, 'jaildoor', 0.3)
                        TriggerClientEvent('gb_sound:source', source, 'jaildoor', 0.3)

                        TriggerClientEvent('notify', source, 'Prisão', 'Você prendeu o <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> por <b>'..Time..' meses</b>.')
                        TriggerClientEvent('notify', nSource, 'Prisão', 'Você foi preso por <b>'..Time..' meses</b>.')

                        Player(nSource).state.Prison = true

                        vRPclient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                        
                        vRP.webhook('prender', {
                            title = 'prender',
                            descriptions = {
                                { 'action', '(learn)' },
                                { 'officer', user_id },
                                { 'target', nUser },
                                { 'reason', Reason },
                                { 'itens', Itens },
                                { 'time', Time..' months' }
                            }
                        }) 
                    else
                        TriggerClientEvent('notify', source, 'Prisão', 'O mesmo se encontra <b>offline</b>!')
                    end
                end
            else
                TriggerClientEvent('notify', source, 'Prisão', 'Este id não possui <b>identidade</b>.')
            end
        end
    end,
    ['retirar'] = function(source, user_id)
        local prompt = exports.hud:prompt(source, {
            'Passaporte do criminoso', 'Motivo'
        })

        if (prompt) and prompt[1] and prompt[2] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]

            -- if (user_id == nUser) then TriggerClientEvent('notify', source, 'Prisão', 'Você não pode se retirar da <b>prisão</b>!') return; end;

            local nIdentity = vRP.getUserIdentity(nUser)
            if (nIdentity) then
                local request = exports.hud:request(source, 'Prisão', 'Você tem certeza que deseja soltar o '..nIdentity.firstname..' '..nIdentity.lastname..'?', 60000)
                if (request) then
                    local nSource = vRP.getUserSource(nUser)
                    if (nSource) then
                        Player(nSource).state.Prison = false
                        vRP.setUData(nUser, 'prison', json.encode(-1))
                        SetEntityHeading(GetPlayerPed(nSource), exitPrisonCoords.w)
                        vRPclient.teleport(nSource, exitPrisonCoords.x,exitPrisonCoords.y,exitPrisonCoords.z)

                        TriggerClientEvent('notify', nSource, 'Prisão', 'Você foi <b>solto</b>!')
                        TriggerClientEvent('notify', source, 'Prisão', 'Você soltou o <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')

                        vRP.webhook('retirarPrisao', {
                            title = 'retirar prisão',
                            descriptions = {
                                { 'action', '(UNFASTEN)' },
                                { 'officer', user_id },
                                { 'target', nUser },
                                { 'reason', Reason }
                            }
                        }) 
                    else
                        TriggerClientEvent('notify', source, 'Prisão', 'O mesmo se encontra <b>offline</b>!')
                    end
                end
            else
                TriggerClientEvent('notify', source, 'Prisão', 'Este id não possui <b>identidade</b>.')
            end
        end        
    end
}

RegisterCommand('prender', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.checkPermissions(user_id, { 'staff.permissao' }) then
        if (args[1]) then
            if (typePrender[args[1]]) then
                typePrender[args[1]](source, user_id)
            else
                TriggerClientEvent('notify', source, 'Prender', 'Você não especificou o que deseja fazer, tente novamente com: <br><br><b>- /prender colocar<br>- /prender retirar', 6000)
            end
        else
            TriggerClientEvent('notify', source, 'Prender', 'Você não especificou o que deseja fazer, tente novamente com: <br><br><b>- /prender colocar<br>- /prender retirar', 6000)
        end
    end
end)


RegisterNetEvent('gb_interactions:prender', function(source, user_id, user, value, info)
    local nUser = parseInt(user)
    local Reason = info
    local Time = parseInt(value)
    
    if (user_id == nUser) then TriggerClientEvent('notify', source, 'Prisão', 'Você não pode se <b>prender</b>!') return; end;

    local nIdentity = vRP.getUserIdentity(nUser)
    if (nIdentity) then
        local nSource = vRP.getUserSource(nUser)
        if (nSource) then
            vRP.setUData(nUser, 'prison', json.encode(Time))
            vRP.setUData(nUser, 'ficha_suja', json.encode(1))

            if (vRPclient.isHandcuffed(nSource)) then
                Player(nSource).state.Handcuff = false
                vRPclient.setHandcuffed(nSource, false)
                TriggerClientEvent('gb_core:uncuff', nSource)
            end
            
            SetEntityHeading(GetPlayerPed(nSource), prisonCoord.w)
            vRPclient.teleport(nSource, prisonCoord.x, prisonCoord.y, prisonCoord.z)
            -- TriggerClientEvent('gb_animations:setAnim', nSource, 'deitar3')
            TriggerClientEvent('Prison:Clothes', nSource)

            prisonLock(nSource, nUser)

            if (vRP.hasPermission(nUser, 'cacador.permissao')) then
                vRP.removeUserGroup(nUser, 'Cacador')
            end

            -- exports.inventory:cleanWeapons(nSource,true)
            -- local Inventory = vRP.PlayerInventory(nUser)
            -- if Inventory then
            --     for k,v in pairs(Inventory:getItems()) do
            --         local item = exports.inventory:itemBody(v.item)
            --         if item and item.ilegal then
            --             Inventory:tryGetItem(v.item,v.amount,k,true)
            --         end
            --     end
            -- end

            TriggerClientEvent('vrp_sounds:source', nSource, 'jaildoor', 0.3)
            TriggerClientEvent('vrp_sounds:source', source, 'jaildoor', 0.3)

            TriggerClientEvent('notify', source, 'sucesso', 'Prisão', 'Você prendeu o <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b> por <b>'..Time..' meses</b>.')
            TriggerClientEvent('notify', nSource, 'aviso', 'Prisão', 'Você foi preso por <b>'..Time..' meses</b>.')

            Player(nSource).state.Prison = true

            vRPclient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')

            vRP.webhook('prender', {
                title = 'prender',
                descriptions = {
                    { 'action', '(learn)' },
                    { 'officer', user_id },
                    { 'target', nUser },
                    { 'reason', Reason },
                    { 'time', Time..' months' }
                }
            }) 
        else
            TriggerClientEvent('notify', source, 'negado', 'Prisão', 'O mesmo se encontra <b>offline</b>!')
        end
    else
        TriggerClientEvent('notify', source, 'negado', 'Prisão', 'Este id não possui <b>identidade</b>.')
    end
end)

-- RegisterNetEvent('gb_interactions:tirarprisao', function()
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if (user_id) and vRP.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
--         typePrender['retirar'](source, user_id)
--     end
-- end)

prisonLock = function(source, user_id)
    Citizen.SetTimeout(60000, function()
        if (Player(source).state.Prison) then
            local time = (json.decode(vRP.getUData(user_id, 'prison')) or 0)
            time = parseInt(time)
            if (time > 0) then
                vRP.setUData(user_id, 'prison', json.encode(time - 1))
                TriggerClientEvent('notify',source, 'Prisão', 'Você ainda vai passar <b>'..time..' meses</b> preso.')
                prisonLock(source, user_id)
            else
                Player(source).state.Prison = false
                vRP.setUData(user_id, 'prison', json.encode(-1))    
                SetEntityHeading(GetPlayerPed(source), exitPrisonCoords.w)
                vRPclient.teleport(source, exitPrisonCoords.x,exitPrisonCoords.y,exitPrisonCoords.z)
                TriggerClientEvent('notify', source, 'Prisão', 'Sua <b>sentença</b> terminou.')
            end
            vRPclient.killGod(source)
        end
    end)
end

AddEventHandler('playerSpawn', function(user_id, source, first_spawn)
    local tempo = (json.decode(vRP.getUData(parseInt(user_id),'prison')) or -1)
    if (tempo == -1) then return; end;

    if (tempo > 0) then
        SetEntityHeading(GetPlayerPed(source), prisonCoord.w)
        vRPclient.teleport(source, prisonCoord.x, prisonCoord.y, prisonCoord.z)
        TriggerClientEvent('gb_animations:setAnim', source, 'deitar3')

        Citizen.SetTimeout(5000, function()    
            prisonLock(source, user_id)
            Player(source).state.Prison = true
        end)
    end
end)
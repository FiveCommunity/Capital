local srv = {}
Tunnel.bindInterface('Commands', srv)
local vCLIENT = Tunnel.getInterface('Commands')

---------------------------------------
-- ALLOWLIST PREMIUM
---------------------------------------
RegisterCommand('alpremium', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local whitelist_id = exports.system:getUserWhitelist(user_id)
        if (whitelist_id) and (whitelist_id > 0) then
            local result = exports.oxmysql:scalar_async('select al_premium from users where id = ?', { whitelist_id })
            if (result ~= 0) then
                vRP.giveInventoryItem(user_id, 'vip-ouro', 1)
                exports.oxmysql:update_async('update users set al_premium = 0 where id = ?', { whitelist_id })
                TriggerClientEvent('notify', source, 'sucesso', 'Allowlist Premium', 'Parabéns! Você recebeu os <b>benefícios</b> da <b>Allowlist Premium</b>.')
            end
        end
    end
end)

---------------------------------------
-- ME
---------------------------------------
srv.checkPermission = function(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.checkPermissions(user_id, perm)
end

---------------------------------------
-- ME
---------------------------------------
local meWebhook = 'https://discord.com/api/webhooks/1280576873318977557/XNRKssImn3dvKb1GMTOVOelb93ajDmzoNINtCFp0-xfKDIsbIlyKPJ7F_8SJQXixc54Z'

RegisterCommand('lb', function(source, args, raw)
    local user_id = vRP.getUserId(source)
    if (user_id) and (vRP.checkPermissions(user_id, { 'libras.permissao', 'staff.permissao' })) then
        TriggerClientEvent('DisplayMe', -1, raw:sub(3), source)
        
        vRP.webhook(meWebhook, {
            title = 'Me',
            descriptions = {
                { 'user', user_id },
                { 'message', raw:sub(3) }
            }
        })   
    end
end)

---------------------------------------
-- AFK SYSTEM
---------------------------------------
RegisterNetEvent('afk:kick', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (Player(source).state.resetAppearance) then return; end;

    local hasJornal,jornalGrade = vRP.hasGroup(user_id, 'Jornal')
    if (not hasJornal) then
        hasJornal,jornalGrade = vRP.hasGroup(user_id, 'SafadassoJornal')
    end

    if vRP.hasPermission(user_id, 'staff.permissao') or (jornalGrade == 'Camera') or (jornalGrade == 'Diretor') then
        TriggerClientEvent('afk:reset',source)
    else
        DropPlayer(source, 'Voce foi desconectado por ficar ausente.')
    end
end)

RegisterCommand("dimensao", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, 'staff.permissao') then
        local playerId = parseInt(args[1])
        if playerId then
            local playerSource = vRP.getUserSource(playerId)
            if playerSource then
                local playerDimension = GetEntityRoutingBucket(GetPlayerPed(playerSource))
                if playerDimension == 0 then
                    SetPlayerRoutingBucket(playerSource, 1)
                    TriggerClientEvent('notify', source, 'sucesso', 'Dimensão', 'O jogador foi teleportado para a dimensão privada!')
                else
                    SetPlayerRoutingBucket(playerSource, 0)
                    TriggerClientEvent('notify', source, 'sucesso', 'Dimensão', 'O jogador foi teleportado para a dimensão normal!')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Dimensão', 'O jogador não está online!')
            end
        end
    end
end, false)

RegisterCommand("setdimensao", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, 'staff.permissao') then
        local playerId = parseInt(args[1])
        if playerId then
            local playerSource = vRP.getUserSource(playerId)
            if playerSource then
                local playerDimension = GetEntityRoutingBucket(GetPlayerPed(playerSource))
                if playerDimension == 0 then
                    SetPlayerRoutingBucket(playerSource, tonumber(args[2]))
                    TriggerClientEvent('notify', source, 'sucesso', 'Dimensão', 'O jogador foi teleportado para a dimensão privada!')
                else
                    SetPlayerRoutingBucket(playerSource, 0)
                    TriggerClientEvent('notify', source, 'sucesso', 'Dimensão', 'O jogador foi teleportado para a dimensão normal!')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'Dimensão', 'O jogador não está online!')
            end
        end
    end
end, false)

RegisterCommand("heliprop", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, 'staff.permissao') then
        local coords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = table.unpack(coords)
        local helicopterProp = CreateObject(GetHashKey("p_crahsed_heli_s"), x, y, z - 1.0, true, true, false)
    end
end, false)
---------------------------------------
-- GIVE INVENTORY ITEM
---------------------------------------
srv.giveInventoryItem = function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    vRP.giveInventoryItem(user_id, item, 1)
end

---------------------------------------
-- DELETE ALL OBJECTS
---------------------------------------

local WHITELIST_MODEL = {
    [GetHashKey('p_parachute1_sp_dec')] = true,
    [GetHashKey('p_parachute1_sp_s')] = true,
    [GetHashKey('p_parachute1_mp_dec')] = true,
    [GetHashKey('p_parachute1_mp_s')] = true,
    [GetHashKey('p_parachute1_s')] = true,
    [GetHashKey('p_parachute_fallen_s')] = true,
    [1336576410] = true,
}

RegisterCommand('dobjall', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Moderador') then
        local count = 0
        for _, v in pairs(GetAllObjects()) do
            if (DoesEntityExist(v)) then
                local modelhash = GetEntityModel(v)
                if not WHITELIST_MODEL[modelhash] then
                    DeleteEntity(v)
                    count = (count + 1)
                end
            end
        end
    end
end)

local ignoredModels = {
    [GetHashKey('lb_phone_prop')] = true,
    [GetHashKey('prop_mp_cone_02')] = true,
    [GetHashKey('prop_table_03b_cs')] = true,

    [GetHashKey('p_parachute1_sp_dec')] = true,
    [GetHashKey('p_parachute1_sp_s')] = true,
    [GetHashKey('p_parachute1_mp_dec')] = true,
    [GetHashKey('p_parachute1_mp_s')] = true,
    [GetHashKey('p_parachute1_s')] = true,
    [GetHashKey('p_parachute_fallen_s')] = true,
    [1336576410] = true,

    [GetHashKey('prop_mp_barrier_02b')] = true,  
    [GetHashKey('p_crahsed_heli_s')] = true,  
    [-1056713654] = true,
    [-606683246] = true,
    [-103789861] = true,
    [273925117] = true,
    [1380588314] = true,
    [-1393014804] = true,
    [-1747543897] = true,
    [32653987] = true,
    [-746966080] = true,
    [-1288968684] = true,
    [-1598212834] = true,
    [-904678363] = true,
    [-370585943] = true,
    [-473574177] = true,
    [-580196246] = true,
    [-2094392714] = true,
    [-1325136207] = true,
    [601713565] = true,
    [2050882666] = true,
    [403140669] = true,
    [-1209868881] = true,
    [1255410010] = true,
    [1467525553] = true,
    [-1711248638] = true,
    [619715967] = true,
    [559432947] = true,
    [64104227] = true,
    [914615883] = true,
    [1931114084] = true,
    [905830540] = true,
    [-1707584974] = true,
    [-1145324273] = true,
    [-697859071] = true,
    [-331545829] = true,
    [1150762982] = true,
    [339962010] = true,
    [574348740] = true,
    [-1634978236] = true,
    [222483357] = true,
    [-1124046276] = true,
    [377247090] = true,
    [491091384] = true,
    [995074671] = true,
    [-1858300370] = true,
    [-229787679] = true,
    [346403307] = true,
    [-972823051] = true,
    [-1450059032] = true,
    [-1745643757] = true,
    [1609356763] = true,
    [1901887007] = true,
    [-1876506235] = true,
    [-2016486256] = true,
    [-1713889927] = true,
    [-500057996] = true,
    [689760839] = true,
    [-606683246] = true,
    [-218858073] = true,
    [-73050335] = true,
    [-739394447] = true,
    [1653948529] = true,
    [-2056364402] = true,
    [-1915245535] = true,
    [-1288559573] = true,
    [1415744902] = true,
    [-1523553483] = true,
    [1520780799] = true,
    [1026431720] = true,
    [1862268168] = true,
    [1762764713] = true,
    [-675841386] = true,
    [1652015642] = true,
    [422658457] = true,
    [-1100561005] = true,
    [-963831200] = true,
    [1927398017] = true,
    [-888555534] = true,
    [-178484015] = true,
    [-1982443329] = true,
    [1349014803] = true,
    [GetHashKey('ng_proc_paper_02a')] = true,
    [GetHashKey('h4_prop_bush_cocaplant_01')] = true,
    [GetHashKey('prop_am_box_wood_01')] = true,
    [GetHashKey('h4_prop_tree_umbrella_sml_01')] = true,
}

CleanObjectsRuntime = function()
	Citizen.SetTimeout(600 * 1000, CleanObjectsRuntime)
	
    local count = 0
    for _, v in ipairs(GetAllObjects()) do
        if (DoesEntityExist(v)) then
            local hash = GetEntityModel(v)
            if (not ignoredModels[hash]) then
                DeleteEntity(v)
                count = (count + 1)
            end
        end
    end
    
    if (count > 0) then print('Foi deletado '..count..' objetos da nossa cidade.'); end;
end
Citizen.CreateThread(CleanObjectsRuntime)

---------------------------------------
-- GOD
---------------------------------------
RegisterCommand('god', function(source, args)
    local _userId = vRP.getUserId(source)
    if (_userId) and (vRP.hasPermission(_userId, 'staff.permissao') or vRP.hasPermission(_userId, 'gravacao.permissao')) then
        local _identity = vRP.getUserIdentity(_userId)
        if (args[1]) then
            local other_id = parseInt(args[1])
            local nPlayer = vRP.getUserSource(other_id)
            if (nPlayer) then
                vRPclient.killGod(nPlayer)
                vRPclient.setHealth(nPlayer, 200) 

                exports.vrp:varyNeeds(other_id, 'all', -100)
			end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source, 200)

            exports.vrp:varyNeeds(_userId, 'all', -100)
        end

        vRP.webhook('god', {
            title = 'god',
            descriptions = {
                { 'staff', '#'.._userId..' '.._identity.firstname..' '.._identity.lastname },
                { 'REVIVEU', (args[1] or _userId) },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })    
    end
end)

RegisterCommand('fome', function(source, args)
    local _userId = vRP.getUserId(source)
    if (_userId) and vRP.hasPermission(_userId, 'staff.permissao') then
       
        exports.vrp:varyNeeds(_userId, 'all',parseInt(args[1]))

         
    end
end)

---------------------------------------
-- GODALL
---------------------------------------
RegisterCommand('godall', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        local users = vRP.getUsers()
        for k, v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if (id) then
            	vRPclient._killGod(id)
				vRPclient._setHealth(id, 200)
            end
        end

        vRP.webhook('godAll', {
            title = 'god All',
            descriptions = {
                { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                { 'REVIVEU', 'todos!' },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
    end
end)

---------------------------------------
-- GODALL
---------------------------------------
RegisterCommand('godarea', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        local radius = vRP.prompt(source, { 'Distancia' })[1]
        radius = parseInt(radius)
        if (radius) and radius > 0 then
            local players = vRPclient.getNearestPlayers(source, radius)
            for k, v in pairs(players) do
                vRPclient._killGod(k)
				vRPclient._setHealth(k, 200) 
            end

            vRP.webhook('godArea', {
                title = 'god área',
                descriptions = {
                    { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                    { 'área', radius },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
    end
end)

---------------------------------------
-- FREEZE
---------------------------------------
RegisterCommand('freeze', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = vRP.getUserSource(parseInt(args[1]))
            if (nSource) then
                local ped = GetPlayerPed(nSource)
                TriggerClientEvent('notify', source, 'Freeze', 'Você <b>freezou</b> o jogador!')
                TriggerClientEvent('notify', nSource, 'Freeze', 'Você foi <b>freezado</b> por um staff!')
                FreezeEntityPosition(ped, true)
            end
        else
            local ped = GetPlayerPed(source)
            TriggerClientEvent('notify', source, 'Freeze', 'Você se <b>freezou</b>!')
            FreezeEntityPosition(ped, true)
        end

        vRP.webhook('freeze', {
            title = 'freeze',
            descriptions = {
                { 'user', user_id },
                { 'target', (args[1] or user_id) }
            }
        })  
    end
end)

RegisterCommand('unfreeze', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = vRP.getUserSource(parseInt(args[1]))
            if (nSource) then
                local ped = GetPlayerPed(nSource)
                TriggerClientEvent('notify', source, 'Freeze', 'Você <b>desfreezou</b> o jogador!')
                TriggerClientEvent('notify', nSource, 'Freeze', 'Você foi <b>desfreezado</b> por um staff!')
                FreezeEntityPosition(ped, false)
            end
        else
            local ped = GetPlayerPed(source)
            TriggerClientEvent('notify', source, 'Freeze', 'Você se <b>desfreezou</b>!')
            FreezeEntityPosition(ped, false)
        end

        vRP.webhook('freeze', {
            title = 'unfreeze',
            descriptions = {
                { 'user', user_id },
                { 'target', (args[1] or user_id) }
            }
        })  
    end
end)

---------------------------------------
-- NEYMAR
---------------------------------------
RegisterCommand('ney', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = vRP.getUserSource(parseInt(args[1]))
            if (nSource) then
                TriggerClientEvent('ney', nSource)
                TriggerClientEvent('notify', source, 'Neymar', 'Você <b>derrubou</b> o jogador!')

                vRP.webhook('ney', {
                    title = 'neymar',
                    descriptions = {
                        { 'user', user_id },
                        { 'target', (args[1] or user_id) }
                    }
                })  
            end
        end
    end
end)

---------------------------------------
-- WALL
---------------------------------------
srv.getWallId = function(src)
    if src and (parseInt(src) > 0) then
        local user = vRP.getUserId(src)
        if user then
            local identity = vRP.getUserIdentity(user)
            return user, Player(src).state.Cam, (identity.firstname..' '..identity.lastname)
        end
    end
end

--RegisterCommand('ids', function(source)
--    local source = source
--    local user_id = vRP.getUserId(source)
--    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
--        if (Player(source).state.Wall) then
--            Player(source).state.Wall = false
--            TriggerClientEvent('notify', source, 'Wall', 'Você desativou o <b>wall</b>!')
--        else
--            Player(source).state.Wall = true
--            TriggerClientEvent('notify', source, 'Wall', 'Você ativou o <b>wall</b>!')
--        end
--
--        vRP.webhook('ids', {
--            title = 'wall',
--            descriptions = {
--                { 'action', '('..(Player(source).state.Wall and 'ACTIVE' or 'DISABLE')..' WALL)' },
--                { 'user', user_id },
--                { 'coord', GetEntityCoords(GetPlayerPed(source)) }
--            }
--        })  
--    end
--end)

---------------------------------------
-- KILL
---------------------------------------
RegisterCommand('kill', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Moderador') then
        if (args[1]) then
            local nPlayer = vRP.getUserSource(parseInt(args[1]))
            if (nPlayer) then
                vRPclient.killGod(nPlayer)
                vRPclient.setHealth(nPlayer, 0)
                vRPclient.setArmour(nPlayer, 0)
            end
        else
            vRPclient.killGod(source)
            vRPclient.setHealth(source, 0)
            vRPclient.setArmour(source, 0)
        end

        vRP.webhook('kill', {
            title = 'kill',
            descriptions = {
                { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                { 'matou', (args[1] or user_id) }
            }
        })  
    end
end)

---------------------------------------
-- KICK
---------------------------------------
RegisterCommand('kick', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.checkPermissions(user_id, { 'ticket.permissao', 'staff.permissao' }) then
        if (args[1]) then
            local prompt = vRP.prompt(source, { 'Motivo' })[1]
            if (prompt) then
                local nPlayer = vRP.getUserSource(parseInt(args[1]))
                if (nPlayer) then
                    DropPlayer(nPlayer, 'Você foi kikado da nossa cidade.\nSeu passaporte: #'..args[1]..'\nMotivo: '..prompt..'\nAutor: '..identity.firstname..' '..identity.lastname)
                    TriggerClientEvent('notify', source, 'Kick', 'Voce kickou o passaporte <b>'..args[1]..'</b> da cidade.')
                    
                    vRP.webhook('kick', {
                        title = 'kick',
                        descriptions = {
                            { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                            { 'kickou', args[1] },
                            { 'motivo', prompt }
                        }
                    })  
                end
            end
        end
    end
end)

---------------------------------------
-- KICKALL
---------------------------------------
RegisterCommand('kickall', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        TriggerClientEvent('announcement', -1, 'Alerta', 'Foi detectado um terremoto de <b>magnitude 8</b> na <b>Escala Richter</b> chegando em nossa cidade. Mantenha a calma e procure um abrigo.', 'Governo', true, 30000)
        Citizen.Wait(5000)
        TriggerClientEvent('gb_core:terremoto', -1)
        Citizen.Wait(15000)
        local players = vRP.getUsers()
        for k, v in pairs(players) do
            local nSource = vRP.getUserSource(parseInt(k))
            if (nSource) then
                DropPlayer(nSource, 'Você foi vítima de um terremoto.')

                vRP.webhook('kickAll', {
                    title = 'kick all',
                    descriptions = {
                        { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                        { 'kickou', 'todos!' },
                    }
                })  
            end
        end
    end
end)

---------------------------------------
-- WL
---------------------------------------
RegisterCommand('wl', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.checkPermissions(user_id, { '+Staff.COO' }) and args[1] then
        local nUser = parseInt(args[1])
        if (nUser) then
            exports.oxmysql:update_async('update users set whitelist = 1 where id = ?', { nUser })
            TriggerClientEvent('notify', source, 'Whitelist', 'Você aprovou o passaporte <b>'..nUser..'</b> na whitelist.')

            vRP.webhook('whitelist', {
                title = 'whitelist',
                descriptions = {
                    { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                    { 'aprovou wl', args[1] },
                }
            })  
        end
    end
end)
RegisterCommand('unwl', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') and args[1] then
        local nUser = parseInt(args[1])
        if (nUser) then
            exports.oxmysql:update_async('update users set whitelist = 0 where id = ?', { nUser })
            TriggerClientEvent('notify', source, 'Whitelist', 'Você retirou o passaporte <b>'..nUser..'</b> da whitelist.')

            vRP.webhook('whitelist', {
                title = 'remove whitelist',
                descriptions = {
                    { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                    { 'retirou wl', args[1] },
                }
            })  
        end
    end
end)

---------------------------------------
-- MONEY
---------------------------------------
RegisterCommand('money', function(source, args)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '@Staff.CEO') then
        if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
        local amount = parseInt(args[1])
		if (amount) then
			vRP.giveBankMoney(user_id, amount)
            exports['phone-bank']:createStatement(user_id, { title = 'Prefeitura', content = 'Governo te ajudou', value = amount, type = 'received' })
            TriggerClientEvent('notify', source, 'Money', 'Você spawnou <b>R$'..vRP.format(amount)..'</b>.')

            vRP.webhook('money', {
                title = 'money',
                descriptions = {
                    { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                    { 'money', 'R$'..vRP.format(amount) }
                }
            })  
		end
	end
end)

RegisterCommand('money2', function(source, args)
    if (#args > 0) then
        local nSource = vRP.getUserSource(parseInt(args[1]))
        local nUser = vRP.getUserId(nSource)
        local nIdentity = vRP.getUserIdentity(nUser)
        local money = parseInt(args[2])
        if (source == 0) then
            if (nUser and money) then
                vRP.giveBankMoney(nUser, money)
                exports['phone-bank']:createStatement(nUser, { title = 'Prefeitura', content = 'Governo te ajudou', value = money, type = 'received' })
                print('^1[GB MONEY]^7 Voce setou ^2R$'..vRP.format(money)..'^7 para o passaporte ^2'..nUser..'^7.')
                TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..vRP.format(money)..'</b> da <b>Prefeitura</b>.', 10000)

                vRP.webhook('money', {
                    title = 'money2',
                    descriptions = {
                        { 'staff', 'console' },
                        { 'jogador', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                        { 'recebeu', 'R$'..vRP.format(money) }
                    }
                })  
            end
        else
            local user_id = vRP.getUserId(source)
            local identity = vRP.getUserIdentity(user_id)
            if (user_id) and vRP.hasPermission(user_id, '+Staff.COO') then
                if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
                if (nUser and money) then
                    vRP.giveBankMoney(nUser, money)
                    exports['phone-bank']:createStatement(nUser, { title = 'Prefeitura', content = 'Governo te ajudou', value = money, type = 'received' })

                    TriggerClientEvent('notify', source, 'Money', 'Você spawnou <b>R$'..vRP.format(money)..'</b>, para o jogador <b>#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                    TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..vRP.format(money)..'</b> da <b>Prefeitura</b>.', 10000)
                    
                    vRP.webhook('money', {
                        title = 'money2',
                        descriptions = {
                            { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                            { 'jogador', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                            { 'recebeu', 'R$'..vRP.format(money) }
                        }
                    })  
                end
            end
        end
    end
end)

RegisterCommand('moneyall', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.COO') then
        if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
        local amount = parseInt(args[1])
		if (amount) then
            local players = vRP.getUsers()
            for k, v in pairs(players) do
                local nSource = vRP.getUserSource(parseInt(k))
                local nUser = vRP.getUserId(nSource)
                if (nSource) then
                    vRP.giveBankMoney(nUser, amount)
                    exports['phone-bank']:createStatement(nUser, { title = 'Prefeitura', content = 'Governo te ajudou', value = amount, type = 'received' })
                    TriggerClientEvent('notify', nSource, 'Money', 'Você recebeu <b>R$'..vRP.format(amount)..'</b> da <b>Prefeitura</b>.', 10000)
                end
            end

            vRP.webhook('money', {
                title = 'money all',
                descriptions = {
                    { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                    { 'money', 'R$'..vRP.format(amount) }
                }
            })  
		end
	end
end)

RegisterCommand('delmoney', function(source, args)
    if (#args > 0) then
        local nSource = vRP.getUserSource(parseInt(args[1]))
        if (nSource) then
            local nUser = vRP.getUserId(nSource)
            local nIdentity = vRP.getUserIdentity(nUser)
            local money = parseInt(args[2])
            if (source == 0) then
                if (nUser and money) then
                    if (vRP.tryFullPayment(nUser, money)) then
                        exports['phone-bank']:createStatement(nUser, { title = 'Impostos', content = 'Governo cobrou os impostos', value = money, type = 'spent' })
                        print('^1[GB MONEY]^7 Voce tirou ^2R$'..vRP.format(money)..'^7 do passaporte ^2'..nUser..'^7.')
                        TriggerClientEvent('notify', nSource, 'Money', 'Você perdeu <b>R$'..vRP.format(money)..'</b> pra <b>Prefeitura</b>.', 10000)
                        
                        vRP.webhook('money', {
                            title = 'delete money',
                            descriptions = {
                                { 'staff', 'console' },
                                { 'jogador', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                                { 'perdeu', 'R$'..vRP.format(money) }
                            }
                        })  
                    else
                        print('^1[GB MONEY]^7 este jogador não possui esta quantia de dinheiro.')
                    end
                end
            else
                local user_id = vRP.getUserId(source)
                local identity = vRP.getUserIdentity(user_id)
                if (user_id) and vRP.hasPermission(user_id, '+Staff.COO') then
                    if (not user_id == 1 and not user_id == 2 and not user_id == 3) then return; end;
                    if (nUser and money) then
                        if (vRP.tryFullPayment(nUser, money)) then
                            exports['phone-bank']:createStatement(nUser, { title = 'Impostos', content = 'Governo cobrou os impostos', value = money, type = 'spent' })
                            TriggerClientEvent('notify', source, 'Money', 'Você retirou <b>R$'..vRP.format(money)..'</b>, do jogador <b>#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                            TriggerClientEvent('notify', nSource, 'Money', 'Você perdeu <b>R$'..vRP.format(money)..'</b> pra <b>Prefeitura</b>.', 10000)

                            vRP.webhook('money', {
                                title = 'delete money',
                                descriptions = {
                                    { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                                    { 'jogador', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                                    { 'recebeu', 'R$'..vRP.format(money) }
                                }
                            })  
                        else
                            TriggerClientEvent('notify', source, 'Money', 'Este <b>jogador</b> não possui esta quantia de dinheiro!')
                        end
                    end
                end
            end
        end
    end
end)

---------------------------------------
-- NOCLIP
---------------------------------------
RegisterCommand('nc', function(source)
	local _userId = vRP.getUserId(source)
    if (_userId) and (vRP.hasPermission(_userId, 'staff.permissao') or vRP.hasPermission(_userId, 'gravacao.permissao') or vRP.hasPermission(_userId, 'noclip.permissao')) then
        local _identity = vRP.getUserIdentity(_userId)
		vRPclient.toggleNoclip(source) 

        vRP.webhook('noclip', {
            title = 'noclip',
            descriptions = {
                { 'staff', '#'.._userId..' '.._identity.firstname..' '.._identity.lastname },
                { 'noclip', tostring(vRPclient.isNoclip(source)) },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
	end
end)

-- RegisterCommand("power", function(source, args, rawCommand)
--     local source = source
--     local user_id = vRP.getUserId(source)

--     if (user_id) and not (vRP.hasPermission(user_id, 'staff.permissao')) then return end

--     TriggerClientEvent("universestore.helltartaros",source)
--     ClearPedTasks(GetPlayerPed(source))
--     Citizen.SetTimeout(5000, function()
--         ClearPedTasks(GetPlayerPed(source))
--     end)
-- end)

---------------------------------------
-- COORDS
---------------------------------------
RegisterCommand('vec', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('clipboard', source, 'Vector3', tostring(GetEntityCoords(GetPlayerPed(source))))
    end
end)

RegisterCommand('vec2', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local coords = GetEntityCoords(GetPlayerPed(source))
        TriggerClientEvent('clipboard', source, 'Vector2', tostring(vec2( coords.x,coords.y )))
    end
end)

RegisterCommand('vec4', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local ped = GetPlayerPed(source)
        TriggerClientEvent('clipboard', source, 'Vector4', tostring(vec4( GetEntityCoords(ped), GetEntityHeading(ped) )))
    end
end)

RegisterCommand('h', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('clipboard', source, 'Heading', tostring(GetEntityHeading(GetPlayerPed(source))))
    end
end)

---------------------------------------
-- USER
---------------------------------------
RegisterCommand('myid', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        TriggerClientEvent('clipboard', source, 'Seu ID', user_id)
    end
end)

RegisterCommand('mysource', function(source)
    local source = source
    if (source) then
        TriggerClientEvent('clipboard', source, 'Sua Source', source)
    end
end)

---------------------------------------
-- PON
---------------------------------------
RegisterCommand('pon', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
	if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local players = ''
        local quantidade = 0
        local users = vRP.getUsers()
        for k, v in pairs(users) do
            players = players..k..', '
            quantidade = (quantidade + 1)
        end
        TriggerClientEvent('chatMessage', source, 'TOTAL ONLINE', {3, 187, 232}, quantidade)
        TriggerClientEvent('chatMessage', source, "ID's ONLINE", {3, 187, 232}, players)
    end
end)

---------------------------------------
-- TPWAY
---------------------------------------
RegisterCommand('tpway', function(source)
	local _userId = vRP.getUserId(source)
    if (_userId) and vRP.hasPermission(_userId, 'staff.permissao') then
        local _identity = vRP.getUserIdentity(_userId)
        vCLIENT.tpToWayFunction(source)
        
        vRP.webhook('tpway', {
            title = 'tpway',
            descriptions = {
                { 'staff', '#'.._userId..' '.._identity.firstname..' '.._identity.lastname },
                { 'teleportou', 'para waypoint' },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
    end
end)

---------------------------------------
-- TPCDS
---------------------------------------
RegisterCommand('tpcds', function(source)
    local _userId = vRP.getUserId(source)
    if (_userId) and vRP.hasPermission(_userId, 'staff.permissao') then
        local _identity = vRP.getUserIdentity(_userId)
        local promptCoords = vRP.prompt(source, { 'Coordenadas' })[1]
        if (not promptCoords) then return; end;

        local coords = {}
        for coord in string.gmatch(sanitizeString(promptCoords, '0123456789,-.',true) ,'[^,]+') do
			table.insert(coords, (tonumber(coord) or 0))
		end

        SetEntityCoords(GetPlayerPed(source), (coords[1] or 0), (coords[2] or 0), (coords[3] or 0))

        vRP.webhook('teleport', {
            title = 'teleport cds',
            descriptions = {
                { 'staff', '#'.._userId..' '.._identity.firstname..' '.._identity.lastname },
                { 'teleportou', tostring(vector3((coords[1] or 0), (coords[2] or 0), (coords[3] or 0))) }
            }
        })  
    end
end)

---------------------------------------
-- TPCDS
---------------------------------------
RegisterCommand('tpto', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nPlayer = vRP.getUserSource(parseInt(args[1]))
            if (nPlayer) then
                local nUser = vRP.getUserId(nPlayer)
                local nIdentity = vRP.getUserIdentity(nUser)
                if (not nIdentity) then return; end;
                
                local nCoords = GetEntityCoords(GetPlayerPed(nPlayer))
                SetEntityCoords(source, nCoords)

                vRP.webhook('teleportTo', {
                    title = 'teleport to',
                    descriptions = {
                        { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                        { 'foi até', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                        { 'COORDENADA', tostring(nCoords) }
                    }
                })  
            end
        end
    end
end)

---------------------------------------
-- TPTOME
---------------------------------------
RegisterCommand('tptome', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and (vRP.hasPermission(user_id, 'staff.permissao') or vRP.hasPermission(user_id, 'gravacao.permissao')) then
        if (args[1]) then
            local nPlayer = vRP.getUserSource(parseInt(args[1]))
            if (nPlayer) then
                local nUser = vRP.getUserId(nPlayer)
                local nIdentity = vRP.getUserIdentity(nUser)
                local pCoords = GetEntityCoords(GetPlayerPed(source))
                vRPclient.teleport(nPlayer, pCoords.x, pCoords.y, pCoords.z)

                vRP.webhook('teleportTo', {
                    title = 'teleport to me',
                    descriptions = {
                        { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                        { 'puxou', '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname },
                        { 'COORDENADA', tostring(pCoords) }
                    }
                })  
            end
        end
    end
end)

---------------------------------------
-- ARMA
---------------------------------------
RegisterCommand('arma', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.COO') then
        if (args[1]) then
            args[1] = string.upper(args[1])
            vRPclient.giveWeapons(source, { [args[1]] = { ammo = 250 } }, false, GlobalState.weaponToken)
        end
    end
end)

---------------------------------------
-- RMASCARA
---------------------------------------
RegisterCommand('rmascara', function(source)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'polpar.permissao') then
		local nplayer = vRPclient.getNearestPlayer(source, 2)
		if (nplayer) then
            local nUser = vRP.getUserId(nplayer)
			local nIdentity = vRP.getUserIdentity(nUser)
			TriggerClientEvent('gb_commands_police:clothes', nplayer, 'rmascara')

            vRP.webhook('policeCommands', {
                title = 'remover máscara',
                descriptions = {
                    { 'staff', user_id },
                    { 'target', nUser },
                }
            })  
        else
            TriggerClientEvent('notify', source, 'Remover Máscara', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

---------------------------------------
-- RMASCARA
---------------------------------------
RegisterCommand('rchapeu', function(source)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id,'polpar.permissao') then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if (nplayer) then
            local nUser = vRP.getUserId(nplayer)
			local nIdentity = vRP.getUserIdentity(nUser)
            TriggerClientEvent('gb_commands_police:clothes', nplayer, 'rchapeu')
            vRP.webhook('policeCommands', {
                title = 'remover chápeu',
                descriptions = {
                    { 'staff', user_id },
                    { 'target', nUser },
                }
            })  
        else
            TriggerClientEvent('notify', source, 'Remover Chápeu', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
	end
end)

---------------------------------------
-- CV
---------------------------------------
RegisterCommand('cv', function(source)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    local nplayer = vRPclient.getNearestPlayer(source, 2.5)
	if (nplayer) then
       
        local state = Player(nplayer).state
        if (vRP.hasPermission(user_id, 'staaff.permissao')) then
            
            if (vRPclient.isInVehicle(source)) then
                TriggerClientEvent('notify', source, 'Colocar no veículo', 'Você não pode utilizar este comando de dentro de um <b>veículo</b>.')
                return
            end

            local nUser = vRP.getUserId(nplayer)
            local nIdentity = vRP.getUserIdentity(nUser)
            vRPclient.putInNearestVehicleAsPassenger(nplayer, 5)
            vRP.webhook('policeCommands', {
                title = 'cv',
                descriptions = {
                    { 'staff', user_id },
                    { 'target', nUser },
                }
            })  
        end
    else
        TriggerClientEvent('notify', source, 'Colocar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
    end
end)

---------------------------------------
-- RV
---------------------------------------
RegisterCommand('rv', function(source)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    
    local nplayer = vRPclient.getNearestPlayer(source, 2.5)
    if (nplayer) then

        local state = Player(nplayer).state
        if (vRP.hasPermission(user_id, 'staff.permissao')) then         
            if (vRPclient.isInVehicle(source)) then
                TriggerClientEvent('notify', source, 'Retirar do veículo', 'Você não pode utilizar este comando de dentro de um <b>veículo</b>.')
                return
            end

			local nUser = vRP.getUserId(nplayer)
			local nIdentity = vRP.getUserIdentity(nUser)
            vRPclient.ejectVehicle(nplayer)
            vRP.webhook('policeCommands', {
                title = 'rv',
                descriptions = {
                    { 'staff', user_id },
                    { 'target', nUser },
                }
            })  
        end
	else
        TriggerClientEvent('notify', source, 'Retirar Veículo', 'Você não se encontra próximo de um <b>cidadão</b>.')
    end
end)

---------------------------------------
-- TOW
---------------------------------------
RegisterServerEvent('trytow', function(vehid01, vehid02, mod)
	TriggerClientEvent('synctow', -1, vehid01, vehid02, mod)
end)

---------------------------------------
-- CHATS
---------------------------------------
RegisterCommand('mec', function(source, args, raw)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'mecanico.permissao') then
        if (args[1]) then
            TriggerClientEvent('chatMessage', -1, '[CAPITAL MECÂNICA] '..identity.firstname..' '..identity.lastname, {3, 187, 232}, raw:sub(4))

            vRP.webhook('chatCore', {
                title = 'chat mec',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', raw:sub(4) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
	end
end)

RegisterCommand('mc', function(source, args, raw)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'mecanico.permissao') then
        if (args[1]) then
            local group = vRP.getUsersByPermission('mecanico.permissao')
            for _, v in pairs(group) do
                local nSource = vRP.getUserSource(parseInt(v))
                if (nSource) then
                    async(function()
                        TriggerClientEvent('chatMessage', nSource, '[CENTRAL MEC] '..identity.firstname..' '..identity.lastname, {3, 187, 232}, raw:sub(4))
                    end)
                end
            end

            vRP.webhook('chatCore', {
                title = 'chat mec central',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', raw:sub(4) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
	end
end)

RegisterCommand('pre', function(source, args, raw)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            TriggerClientEvent('chatMessage', -1, '[PREFEITURA CAPITAL] '..identity.firstname..' '..identity.lastname, {3, 187, 232}, raw:sub(4))

            vRP.webhook('chatCore', {
                title = 'chat prefeitura',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', raw:sub(4) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
	end
end)

RegisterCommand('pc', function(source, args, raw)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local group = vRP.getUsersByPermission('staff.permissao')
            for _, v in pairs(group) do
                local nSource = vRP.getUserSource(parseInt(v))
                if (nSource) then
                    async(function()
                        TriggerClientEvent('chatMessage', nSource, '[CENTRAL PREFEITURA] '..identity.firstname..' '..identity.lastname, {3, 187, 232}, raw:sub(4))
                    end)
                end
            end

            vRP.webhook('chatCore', {
                title = 'chat prefeitura central',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', raw:sub(4) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
	end
end)

RegisterCommand('190', function(source, args, raw)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'policia.permissao') then
        if (args[1]) then
            TriggerClientEvent('chatMessage', -1, '[CAPITAL POLÍCIA] '..identity.firstname..' '..identity.lastname, {3, 187, 232}, raw:sub(4))

            vRP.webhook('chatCore', {
                title = 'chat 190',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', raw:sub(4) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
	end
end)

RegisterCommand('pd', function(source, args, raw)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'policia.permissao') then
        if (args[1]) then
            local group = vRP.getUsersByPermission('policia.permissao')
            for _, v in pairs(group) do
                local nSource = vRP.getUserSource(parseInt(v))
                if (nSource) then
                    async(function()
                        TriggerClientEvent('chatMessage', nSource, '[CENTRAL POLÍCIA] '..identity.firstname..' '..identity.lastname, {3, 187, 232}, raw:sub(4))
                    end)
                end
            end

            vRP.webhook('chatCore', {
                title = 'chat central policia',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', raw:sub(4) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
	end
end)

RegisterCommand('192', function(source, args, raw)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        if (args[1]) then
            TriggerClientEvent('chatMessage', -1, '[CAPITAL HOSPITAL] '..identity.firstname..' '..identity.lastname, {3, 187, 232}, raw:sub(4))
            vRP.webhook('chatCore', {
                title = 'chat 192',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', raw:sub(4) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
	end
end)

RegisterCommand('hp', function(source, args, raw)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, 'hospital.permissao') then
        if (args[1]) then
            local group = vRP.getUsersByPermission('hospital.permissao')
            for _, v in pairs(group) do
                local nSource = vRP.getUserSource(parseInt(v))
                if (nSource) then
                    async(function()
                        TriggerClientEvent('chatMessage', -1, '[CENTRAL HOSPITAL] '..identity.firstname..' '..identity.lastname, {3, 187, 232}, raw:sub(4))
                    end)
                end
            end
            vRP.webhook('chatCore', {
                title = 'chat hospital central',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', raw:sub(4) },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
	end
end)

---------------------------------------
-- ENVIAR
---------------------------------------
RegisterCommand('enviar', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) then
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        local nUser = vRP.getUserId(nPlayer)
        local nIdentity = vRP.getUserIdentity(nUser)
        if (nPlayer) then
            local amount = parseInt(args[1])
            if (amount > 0) then
                if (vRP.tryPayment(user_id, amount)) then
                    vRP.giveMoney(nUser, amount)

                    vRPclient._playAnim(source, true, {{ 'mp_common', 'givetake1_a' }}, false)
			        vRPclient._playAnim(nPlayer, true, {{ 'mp_common', 'givetake1_a' }}, false)
                    TriggerClientEvent('notify', source, 'Enviar', 'Você enviou <b>R$'..vRP.format(amount)..'</b>.')
                    TriggerClientEvent('notify', nPlayer, 'Enviar', 'Você recebeu <b>R$'..vRP.format(amount)..'</b>.')

                    vRP.webhook('enviar', {
                        title = 'enviar',
                        descriptions = {
                            { 'user', user_id },
                            { 'target', nUser },
                            { 'enviou', 'R$'..vRP.format(amount) }
                        }
                    })  
                else
                    TriggerClientEvent('notify', source, 'Enviar', 'Você não possui essa quantia de <b>dinheiro</b> em mãos.')
                end
            end
        else
            TriggerClientEvent('notify', source, 'Enviar', 'Você não se encontra próximo de um <b>cidadão</b>.')
        end
    end
end)

---------------------------------------
-- ANÚNCIOS
---------------------------------------
RegisterCommand('adm', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity =  vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local message = vRP.prompt(source, { 'Mensagem' })[1]
        if (message) then
            TriggerClientEvent('announcement', -1, 'Prefeitura', message, 'Prefeito', true, 30000)

            vRP.webhook('anuncio', {
                title = 'ADM',
                descriptions = {
                    { 'user', user_id },
                    { 'mensagem', message },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
    end
end)

RegisterCommand('anunciopm', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity =  vRP.getUserIdentity(user_id)
    if (user_id) and vRP.checkPermissions(user_id, { 'policia.permissao' }) then
        local message = vRP.prompt(source, { 'Título', 'Mensagem' })
        if (message[1] and message[2]) then
            TriggerClientEvent('announcement', -1, message[1], message[2], identity.firstname, true, 30000)

            vRP.webhook('anuncio', {
                title = 'Anúncio',
                descriptions = {
                    { 'title', message[1] },
                    { 'user', user_id },
                    { 'mensagem', message[2] },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
    end
end)

RegisterCommand('jornal', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity =  vRP.getUserIdentity(user_id)
    if (user_id) and vRP.checkPermissions(user_id, { '@Jornal.Diretor', '@Mptv.Diretor', '@SafadassoJornal.Diretor' }) then
        local message = vRP.prompt(source, { 'Título', 'Mensagem' })
        if (message[1] and message[2]) then
            TriggerClientEvent('announcement', -1, message[1], message[2], (identity.firstname..' '..identity.lastname), true, 12000)
            vRP.webhook('anuncio', {
                title = 'Jornal',
                descriptions = {
                    { 'title', message[1] },
                    { 'user', user_id },
                    { 'mensagem', message[2] },
                    { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                }
            })  
        end
    end
end)

-- RegisterCommand('restaurante', function(source)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     local identity =  vRP.getUserIdentity(user_id)
--     if (user_id) and vRP.checkPermissions(user_id, { 'grotorante.permissao' }) then
--         local message = vRP.prompt(source, { 'Título', 'Mensagem' })
--         if (message[1] and message[2]) then
--             TriggerClientEvent('announcement', -1, message[1], message[2], (identity.firstname..' '..identity.lastname), true, 12000)
--             vRP.webhook('anuncio', {
--                 title = 'Restaurante',
--                 descriptions = {
--                     { 'title', message[1] },
--                     { 'user', user_id },
--                     { 'mensagem', message[2] },
--                     { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
--                 }
--             })  
--         end
--     end
-- end)

---------------------------------------
-- CAR COLOR
---------------------------------------
RegisterCommand('carcolor', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        local vehicle = vRPclient.getNearestVehicle(source, 7.0)
        if (vehicle) then
            local prompt = vRP.prompt(source, { 'Primary Color RGB (255, 255, 255)', 'Secondary Color RGB (255, 255, 255)' })
            if (prompt) then
                local primary = prompt[1]
                if (primary) then
                    local rgb = sanitizeString(primary, '0123456789,', true)
                    local r, g, b = table.unpack(splitString(rgb, ','))
                    TriggerClientEvent('gb_core:carcolor', source, vehicle, parseInt(r), parseInt(g), parseInt(b), true)   
                    TriggerClientEvent('notify', source, 'Car Color','A cor primária do <b>veículo</b> foi alterada.')
                end

                local secondary = prompt[2]
                if (secondary) then
                    local rgb = sanitizeString(secondary, '0123456789,', true)
                    local r, g, b = table.unpack(splitString(rgb, ','))
                    TriggerClientEvent('gb_core:carcolor', source, vehicle, parseInt(r), parseInt(g), parseInt(b), false)   
                    TriggerClientEvent('notify', source, 'Car Color','A cor secundária do <b>veículo</b> foi alterada.')
                end

                local text, text2 = (primary and primary or '(NONE)'), (secondary and secondary or '(NONE)')
                vRP.webhook('carColor', {
                    title = 'Car Color',
                    descriptions = {
                        { 'user', user_id },
                        { 'rgb primary', text },
                        { 'rgb secondary', text2 },
                        { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                    }
                })  
            end
        end
    end
end)

---------------------------------------
-- UNCUFF
---------------------------------------
RegisterCommand('uncuff', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1]) then
            local nSource = vRP.getUserSource(parseInt(args[1]))
            if (vRPclient.isHandcuffed(nSource)) then
                Player(nSource).state.Handcuff = false
                vRPclient.setHandcuffed(nSource, false)
                TriggerClientEvent('gb_core:uncuff', nSource)
            else
                TriggerClientEvent('notify', source, 'Uncuff', 'O jogador não se encontra <b>algemado</b>.')
            end
        else
            if (vRPclient.isHandcuffed(source)) then
                Player(source).state.Handcuff = false
                vRPclient.setHandcuffed(source, false)
                TriggerClientEvent('gb_core:uncuff', source)
            else
                TriggerClientEvent('notify', source, 'Uncuff', 'Você não se encontra <b>algemado</b>.')
            end
        end

        vRP.webhook('uncuff', {
            title = 'Uncuff',
            descriptions = {
                { 'user', user_id },
                { 'target', (args[1] or user_id) },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
    end
end)

---------------------------------------
-- RCAPUZ
---------------------------------------
RegisterCommand('rcapuz', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1]) then
            local nSource = vRP.getUserSource(parseInt(args[1]))
            if (vRPclient.isCapuz(nSource)) then
                Player(nPlayer).state.Capuz = false
                vRPclient.setCapuz(nSource, false)
            else
                TriggerClientEvent('notify', source, 'Remover capuz', 'O jogador não se encontra <b>encapuzado</b>.')
            end
        else
            if (vRPclient.isCapuz(source)) then
                Player(source).state.Capuz = false
                vRPclient.setCapuz(source, false)
            else
                TriggerClientEvent('notify', source, 'Remover capuz', 'Você não se encontra <b>encapuzado</b>.')
            end
        end

        vRP.webhook('rcapuz', {
            title = 'Remove Capuz',
            descriptions = {
                { 'user', user_id },
                { 'target', (args[1] or user_id) },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
    end
end)

---------------------------------------
-- LIMPARAREA
---------------------------------------
RegisterCommand('limpararea', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local pCoord = GetEntityCoords(GetPlayerPed(source))
        TriggerClientEvent('syncarea', -1, pCoord.x, pCoord.y, pCoord.z)

        vRP.webhook('limpararea', {
            title = 'Limpar Área',
            descriptions = {
                { 'user', user_id },
                { 'coord', tostring(pCoord) }
            }
        })  
    end
end)

---------------------------------------
-- SKIN
---------------------------------------
RegisterCommand('skin', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        local text = ''
        local nPlayer = vRP.getUserSource(parseInt(args[1]))
        if (args[2]) and nPlayer then  
            local nUser = vRP.getUserId(nPlayer)
            local nIdentity = vRP.getUserIdentity(nUser)
            vCLIENT.skinModel(nPlayer, args[2])
            TriggerClientEvent('notify', source, 'Skin', 'Você setou a skin <b>'..args[2]..'</b> no passaporte <b>'..nUser..'</b>.')
            text = '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname..'\n[SKIN]: '..args[2]
        else
            vCLIENT.skinModel(source, args[1])
            TriggerClientEvent('notify', source, 'Skin', 'Você setou a skin <b>'..args[1]..'</b> em si mesmo.')
            text = '#'..user_id..' '..identity.firstname..' '..identity.lastname..'\n[SKIN]: '..args[1]
        end

        vRP.webhook('skin', {
            title = 'skin',
            descriptions = {
                { 'staff', '#'..user_id..' '..identity.firstname..' '..identity.lastname },
                { 'jogador', text },
            }
        })  
    end
end)

---------------------------------------
-- TRY DELETE OBJ
---------------------------------------
RegisterNetEvent('trydeleteobj', function(index)
    local entity = NetworkGetEntityFromNetworkId(index)
    if (entity and entity ~= 0) then DeleteEntity(entity) end
end)

---------------------------------------
-- DEL NPCS
---------------------------------------
RegisterCommand('delnpcs',function(source)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
		TriggerClientEvent('gb_core:delnpcs', source)

        vRP.webhook('delnpc', {
            title = 'Del Npcs',
            descriptions = {
                { 'user', user_id },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
	end
end)

RegisterNetEvent('trydeleteped', function(index)
	TriggerClientEvent('syncdeleteped', -1, index)
end)

---------------------------------------
-- TUNING
---------------------------------------
RegisterCommand('tuning', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        TriggerClientEvent('gb_core:tuning', source)

        vRP.webhook('tuning', {
            title = 'Tuning',
            descriptions = {
                { 'user', user_id },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
    end
end)

---------------------------------------
-- DEBUG
---------------------------------------
RegisterCommand('debug', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        TriggerClientEvent('gb_core:debug', source)
    end
end)

---------------------------------------
-- CLEAR WEAPONS
---------------------------------------
RegisterCommand('clearweapons', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        local text = ''
        if (args[1]) then
            local nSource = vRP.getUserSource(parseInt(args[1]))
            if (nSource) then
                local nUser = vRP.getUserId(nSource)
                local nIdentity = vRP.getUserIdentity(nUser)
                vRPclient.giveWeapons(nSource, {}, true, GlobalState.weaponToken)
                TriggerClientEvent('notify', source, 'Clear Weapon', 'Você limpou os <b>armamentos</b> do passaporte <b>'..nUser..'</b>.')
                text = '#'..nUser..' '..nIdentity.firstname..' '..nIdentity.lastname
            end
        else
            vRPclient.giveWeapons(source, {}, true, GlobalState.weaponToken)
            TriggerClientEvent('notify', source, 'Clear Weapon', 'Você limpou os seus <b>armamentos</b>')
            text = '#'..user_id..' '..identity.firstname..' '..identity.lastname
        end

        vRP.webhook('clearWeapons', {
            title = 'Clear Weapons',
            descriptions = {
                { 'user', user_id },
                { 'limpou as armas do', text },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
            }
        })  
    end
end)

---------------------------------------
-- VROUPAS
---------------------------------------
RegisterCommand('vroupas',function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local custom = vRPclient.getCustomization(source)
        local content = {}
        for k, v in pairs(custom) do
            if (v ~= GetEntityModel(GetPlayerPed(source))) then
                if (string.sub(k, 1, 1) == 'p') then
                    k = "['"..k.."']"
                else
                    k = '['..k..']'
                end
                table.insert(content, k..' = { model = '..v.model..', var = '..v.var..', palette = '..v.palette..' },') 
            end
        end
        content = table.concat(content, '\n ')
        TriggerClientEvent('clipboard', source, 'Código da roupa', content)
    end
end)

---------------------------------------
-- UMSG
---------------------------------------
RegisterCommand('umsg', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local message = vRP.prompt(source, { 'Mensagem' })
            if (message) then
                message = message[1]

                local nPlayer = vRP.getUserSource(parseInt(args[1]))
                if (nPlayer) then
                    local nUser = vRP.getUserId(nPlayer)
                    local nIdentity = vRP.getUserIdentity(nUser)
                    TriggerClientEvent('notify', nPlayer, 'Mensagem Privada', 'O staff <b>'..identity.firstname..' '..identity.lastname..'</b> te enviou uma mensagem: <br /><br />'..message, 10000)
                    TriggerClientEvent('notify', source, 'Mensagem Privada', 'A mensagem foi enviada com <b>sucesso</b>.')
                    vRPclient.playSound(source, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					vRPclient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					Citizen.Wait(100)
					vRPclient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')
					Citizen.Wait(100)
					vRPclient.playSound(nPlayer, 'Event_Message_Purple', 'GTAO_FM_Events_Soundset')

                    vRP.webhook('umsg', {
                        title = 'UMSG',
                        descriptions = {
                            { 'staff', user_id },
                            { 'falou com', nUser },
                            { 'mensagem', message },
                            { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) }
                        }
                    })  
                end
            end
        end
    end
end)

---------------------------------------
-- BANSRC
---------------------------------------
RegisterCommand('bansrc', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = parseInt(args[1])
            if (nSource) then
                if (GetPlayerName(nSource)) then
                    local nUser = vRP.getUserIdByIdentifiers(GetPlayerIdentifiers(nSource))
                    if (nUser ~= -1) then
                        local prompt = vRP.prompt(source, { 'Motivo' })[1]

                        if (prompt) then                            
                            local whitelist_id = exports.system:getUserWhitelist(nUser)
                            if (whitelist_id) then
                                exports.system:setUserBanned(whitelist_id, true, prompt, 0, user_id)
                            end

                            DropPlayer(nSource, 'Você foi banido da nossa cidade.\nSeu passaporte: #'..nUser..'\n Motivo: '..prompt..'\nAutor: '..identity.firstname..' '..identity.lastname)
                            TriggerClientEvent('notify', source, 'Banimento', 'Você baniu a source <b>'..nSource..'</b> da cidade.')
                            vRP.webhook('bansrc', {
                                title = 'bansrc',
                                descriptions = {
                                    { 'staff', user_id },
                                    { 'baniu source', nSource },
                                    { 'id relacionado', nUser },
                                    { 'motivo', prompt }
                                }
                            })  
                        end
                    end
                end
            end
        end
    end
end)

---------------------------------------
-- TPTO SRC
---------------------------------------
RegisterCommand('tptosrc', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            SetEntityCoords(source, GetEntityCoords(GetPlayerPed(parseInt(args[1]))))
        end
    end
end)

---------------------------------------
-- CHECK BUGADO
---------------------------------------
RegisterCommand('checkbugados', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local message = ''
        for _, v in ipairs(GetPlayers()) do 
            local pName = GetPlayerName(v)
            local uId = vRP.getUserId(tonumber(v))
            if (not uId) then 
                message = message .. string.format('</br> <b>%s</b> | Source: <b>%s</b> | Ready: %s',pName,v,((Player(v).state.ready) and 'Sim' or 'Não'))
            end
        end
        TriggerClientEvent('notify', source, 'Check Bugados', ((message ~= '') and message or 'Sem usuários bugados no momento!'))
    end
end)

---------------------------------------
-- SCREENSHOT SOURCE
---------------------------------------
RegisterCommand('screensrc', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local nSource = parseInt(args[1])
        if (nSource > 0) then
            local ids = vRP.getIdentifiers(nSource)
            exports['discord-screenshot']:requestCustomClientScreenshotUploadToDiscord(nSource, 'https://discord.com/api/webhooks/1198511224627933255/yp88h_aJVEtrckEczaRE_39Z186abbm7DRLzCGcGP61X92jq9pa4YGaV1KgquX0EZWCH', { encoding = 'jpg', quality = 0.7 },
                {
                    username = '[SCREENSHOT] Source',
                    content = '```prolog\n[SOURCE]: '..nSource..'\n[IDS]: '..json.encode(ids, { indent = true })..' \n[Admin]: '..GetPlayerName(source)..'```'
                }, 30000, function(error) end
            )
        end
    end
end)

---------------------------------------
-- KICK SOURCE
---------------------------------------
RegisterCommand('kicksrc', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nSource = parseInt(args[1])
            if (nSource) then
                if (GetPlayerName(nSource)) then
                    local prompt = vRP.prompt(source, { 'Motivo' })[1]
                    if (prompt) then
                        DropPlayer(nSource, 'Você foi kikado da nossa cidade.\nSua source: #'..nSource..'\n Motivo: '..prompt..'\nAutor: '..identity.firstname..' '..identity.lastname)
                        TriggerClientEvent('notify', source, 'Kick Source', 'Voce kickou o source <b>'..args[1]..'</b> da cidade.')
                        vRP.webhook('kicksrc', {
                            title = 'kicksrc',
                            descriptions = {
                                { 'staff', user_id },
                                { 'kickou source', nSource },
                                { 'motivo', prompt }
                            }
                        })  
                    end
                end
            end
        end
    end
end)

---------------------------------------
-- RESET PLAYER & CHANGE ID
---------------------------------------
local ResetQueries = {
    { query = 'DELETE FROM bank_pixs WHERE user_id = @user_id' },
    { query = 'DELETE FROM bank_statements WHERE user_id = @user_id' },
    { query = 'DELETE FROM blacklist WHERE user_id = @user_id' },
    { query = 'DELETE FROM business WHERE business_owner = @user_id' },
    { query = 'DELETE FROM cards WHERE business_owner = @user_id' },
    { query = 'DELETE FROM clothes WHERE user_id = @user_id' },
    { query = 'DELETE FROM courses WHERE user_id = @user_id' },
    { query = 'DELETE FROM dynamic WHERE user_id = @user_id' },
    { query = 'DELETE FROM fine WHERE user_id = @user_id' },
    { query = 'DELETE FROM hospital WHERE patient_id = @user_id' },
    { query = 'DELETE FROM identity WHERE user_id = @user_id' },
    { query = 'DELETE FROM inventory WHERE identifier = concat("player:", @user_id)' },
    { query = 'DELETE FROM mdt WHERE user_id = @user_id' },
    { query = 'DELETE FROM phone_backups WHERE id = @current_id' },
    { query = 'DELETE FROM phone_last_phone WHERE id = @current_id' },
    { query = 'DELETE FROM phone_phones WHERE owner_id = @current_id' },
    { query = 'DELETE FROM race_infos WHERE user_id = @user_id' },
    { query = 'DELETE FROM race_runners WHERE user_id = @user_id' },
    { query = 'DELETE FROM relationship WHERE user_1 = @user_id or user_2 = @user_id' },
    { query = 'DELETE FROM user_data WHERE user_id = @user_id' },
    { query = 'DELETE FROM user_datatable WHERE user_id = @user_id' },
    { query = 'DELETE FROM user_groups WHERE user_id = @user_id' },
    { query = 'DELETE FROM user_moneys WHERE user_id = @user_id' },
    { query = 'DELETE FROM user_pets WHERE user_id = @user_id' },
}

local ChangeIdQueries = {
    -- [ Criar um novo ID ] --
    { query = "INSERT IGNORE INTO user_characters (id, steam, firstname, lastname, age, registration, rh) VALUES (@newuser_id,'steam:', 'firstname', 'lastname', 'age', 'RGRGRGRG', 'A+')" },
    { query = 'UPDATE user_characters SET steam = (SELECT steam FROM user_characters WHERE id = @current_id) WHERE id = @newuser_id' },
    { query = 'UPDATE user_characters SET firstname = (SELECT firstname FROM user_characters WHERE id = @current_id) WHERE id = @newuser_id' },
    { query = 'UPDATE user_characters SET lastname = (SELECT lastname FROM user_characters WHERE id = @current_id) WHERE id = @newuser_id' },
    { query = 'UPDATE user_characters SET age = (SELECT age FROM user_characters WHERE id = @current_id) WHERE id = @newuser_id' },
    { query = 'UPDATE user_characters SET rh = (SELECT rh FROM user_characters WHERE id = @current_id) WHERE id = @newuser_id' },
    { query = 'UPDATE user_characters SET drive_license = (SELECT drive_license FROM user_characters WHERE id = @current_id) WHERE id = @newuser_id' },
    { query = 'UPDATE user_characters SET garages = (SELECT garages FROM user_characters WHERE id = @current_id) WHERE id = @newuser_id' },
    { query = 'UPDATE user_characters SET homes = (SELECT homes FROM user_characters WHERE id = @current_id) WHERE id = @newuser_id' },

    -- [ Atualizar o ID criado acima ] --
    { query = 'UPDATE bank_fines SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE bank_pixs SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE bank_statements SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE blacklist SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE box SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE business SET business_owner = @newuser_id WHERE business_owner = @current_id' },
    { query = 'UPDATE cards SET ownerId = @newuser_id WHERE ownerId = @current_id' },
    { query = 'UPDATE clothes SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE dynamic SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE homes SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE hospital SET doctor_id = @newuser_id WHERE doctor_id = @current_id' },
    { query = 'UPDATE hospital SET patient_id = @newuser_id WHERE patient_id = @current_id' },
    { query = 'UPDATE hydrus_credits SET player_id = @newuser_id WHERE player_id = @current_id' },
    { query = 'UPDATE hydrus_scheduler SET player_id = @newuser_id WHERE player_id = @current_id' },
    { query = 'UPDATE identity SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = "UPDATE inventory SET identifier = CONCAT('player:', @newuser_id) WHERE identifier = CONCAT('player:', @current_id)" },
    { query = 'UPDATE mdt SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE mdt SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE phone_backups SET id = @newuser_id WHERE id = @current_id' },
    { query = 'UPDATE phone_last_phone SET id = @newuser_id WHERE id = @current_id' },
    { query = 'UPDATE phone_phones SET owner_id = @newuser_id WHERE owner_id = @current_id' },
    { query = 'UPDATE race_infos SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE race_runners SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE relationship SET user_1 = @newuser_id WHERE user_1 = @current_id' },
    { query = 'UPDATE relationship SET user_2 = @newuser_id WHERE user_2 = @current_id' },
    { query = 'UPDATE user_data SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE user_datatable SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE user_groups SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE user_moneys SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE user_pets SET user_id = @newuser_id WHERE user_id = @current_id' },
    { query = 'UPDATE user_vehicles SET user_id = @newuser_id WHERE user_id = @current_id' },
    
    -- [ Deletar registro do ID antigo ] --
    { query = 'DELETE FROM user_characters WHERE id = @current_id' },
    { query = 'UPDATE user_characters SET registration = @registration WHERE id = @newuser_id' },
}

local ConsoleAndGameNotification = function(source, message, title)
    if (source == 0) then
        print('^1['..title..']^7: '..message)
    else
        TriggerClientEvent('notify', source, 'importante', title, message)
    end
end

local ChangeIdPlayer = function(current_id, newuser_id, old_registr)
    for index, _ in pairs(ChangeIdQueries) do
        ChangeIdQueries[index].values = { current_id = current_id, newuser_id = newuser_id, registration = old_registr }
    end
    return exports.oxmysql:transaction_async(ChangeIdQueries)
end

local ResetPlayer = function(user_id)
    exports.garage:resetUserVehicles(user_id)
    exports.homes:ResetUserHomes(user_id)
    for index, _ in pairs(ResetQueries) do
        ResetQueries[index].values = { user_id = user_id }
    end
    exports.oxmysql:transaction(ResetQueries, function() vRP.resetIdentity(user_id) end)
end

RegisterCommand('resetplayer', function(source, args)
    local user_id;
    local allow;
    
    if (source == 0) then allow = true;
    else user_id = vRP.getUserId(source); allow = vRP.hasPermission(user_id, '+Staff.COO'); end;

    if (allow) then
        if (args[1]) then
            local nUser = parseInt(args[1])
            local nSource = vRP.getUserSource(nUser)
            
            local nIdentity = vRP.getUserIdentity(nUser)
            if (nIdentity) then
                if (source == 0) or exports.hud:request(source, 'Reset', 'Você realmente deseja resetar o passaporte '..nUser..'?', 30000) then
                    if (nSource) then vRP.kick(nSource, 'Você foi resetado!'); end;
                    
                    Citizen.SetTimeout(500, function()
                        ResetPlayer(nUser)
                        ConsoleAndGameNotification(source, 'Você resetou o ID '..nUser..'!', 'Reset Player')
                        vRP.webhook('resetplayer', {
                            title = 'resetplayer',
                            descriptions = {
                                { 'staff', (source == 0 and 'CONSOLE' or user_id) },
                                { 'player', nUser }
                            }
                        })  
                    end)
                end
            else
                ConsoleAndGameNotification(source, 'Jogador inexistente!', 'Reset Player')
            end
        else
            ConsoleAndGameNotification(source, 'Você não especificou um ID!', 'Reset Player')
        end
    end
end)

vRP._prepare('changeId/getLastId', 'SELECT id FROM user_characters ORDER BY id DESC LIMIT 1;')

RegisterCommand('changeid', function(source, args)
    local user_id;
    local allow;
    
    if (source == 0) then 
        allow = true
    else 
        user_id = vRP.getUserId(source)
        allow = vRP.hasPermission(user_id, '+Staff.COO')
    end

    if (allow) then
        if (args[1] and args[2]) then
            
            local current, new_user = parseInt(args[1]), parseInt(args[2])
            
            local currentIdentity = vRP.getUserIdentity(current)

            if (currentIdentity) then
                if (source == 0) or exports.hud:request(source, 'Change Id', 'Você realmente deseja trocar o passaporte '..current..' para '..new_user..'?', 30000) then
                    
                    local last_id = vRP.scalar('changeId/getLastId')
                    if (new_user > last_id) then 
                        return ConsoleAndGameNotification(source, 'Você não pode colocar um ID que ainda não foi criado na cidade!', 'Change ID');
                    end
                    
                    local current_src = vRP.getUserSource(current)
                    if (current_src) then
                        vRP.kick(current_src, 'Seu ID foi alterado!')
                    end
                    local newuser_src = vRP.getUserSource(new_user)
                    if (newuser_src) then
                        vRP.kick(new_user_src, 'Seu ID foi alterado!')
                    end
                    
                    Citizen.SetTimeout(500, function()
                        
                        local newuser_exists = vRP.query('vRP/get_user_identity',{ user_id = new_user })[1]
                        if newuser_exists then
                        
                            if ChangeIdPlayer(new_user, last_id+1, newuser_exists.registration) then

                                ChangeIdPlayer(current, new_user, currentIdentity.registration)
                            end
                        else
                            ChangeIdPlayer(current, new_user, currentIdentity.registration)
                        end

                        ConsoleAndGameNotification(source, 'Você alterou o ID '..current..'!', 'Change ID')
                        
                        vRP.webhook('changeid', {
                            title = 'changeid',
                            descriptions = {
                                { 'staff', (source == 0 and 'CONSOLE' or user_id) },
                                { 'old id', current },
                                { 'new id', new_user }
                            }
                        })

                    end)   
                end
            else
                ConsoleAndGameNotification(source, 'Jogador inexistente!', 'Change ID')
            end
        else
            ConsoleAndGameNotification(source, 'Você não especificou um ID!', 'Change ID')
        end
    end
end)

RegisterCommand('delplayer', function(source, args)
    local allow; 
    local user_id;

    if (source == 0) then
        allow = true;
    else
        user_id = vRP.getUserId(source)
        allow = vRP.hasPermission(user_id, '+Staff.COO')
    end

    if (allow) and #args > 0 then
        local nuser_id = tonumber( args[1] )
        local nidentity = vRP.getUserIdentity(nuser_id)

        if (not nidentity) then
            return ConsoleAndGameNotification(source, 'Jogador inexistente!', 'Deletar Personagem')
        end

        local request = exports.hud:request(source, 'Deletar Personagem', 'Você tem certeza que deseja deletar o personagem <b>'..nidentity.firstname..' '..nidentity.lastname..' #'..nuser_id..'?', 30000)
        if (request) then
            
            local nSource = vRP.getUserSource(nuser_id)
            if (nSource) then vRP.kick(nSource, 'Personagem Deletado! :('); end;

            ResetPlayer(nuser_id)
            exports.oxmysql:execute_async('DELETE FROM user_characters WHERE id = ?', { nuser_id })

            ConsoleAndGameNotification(source, 'Personagem deletado com sucesso!', 'Deletar Personagem')

            vRP.webhook('https://discord.com/api/webhooks/1259918345088794706/iS1Xk0qZXZtTTAUq6Rg08gL3pW_Wytj9IgnOGx9uDz8nMkV96-FundDqjsjYgPCKonRc', {
                title = 'Delete Character',
                descriptions = {
                    { 'staff', (source == 0 and 'CONSOLE' or user_id) },
                    { 'target', nuser_id },
                }
            })
        end
    end
end)

---------------------------------------
-- SC HACK
---------------------------------------
RegisterCommand('schack',function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'player.noclip') then
        TriggerClientEvent('MQCU:getfodido', source)
    end
end)

---------------------------------------
-- ROUTING BUCKETS
---------------------------------------
RegisterCommand('gbucket', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1]) then
            local nUser = parseInt(args[1])
            local nSource = vRP.getUserSource(nUser)
            if (nSource) and GetPlayerName(nSource) then
                TriggerClientEvent('notify', source, 'Get Bucket', 'O jogador <b>'..nUser..'</b> está na Sessão <b>'..GetPlayerRoutingBucket(nSource)..'</b>.', 8000)
            else
                TriggerClientEvent('notify', source, 'Get Bucket', 'O jogador <b>'..nUser..'</b> não foi encontrado.', 8000)
            end
        else
            TriggerClientEvent('notify', source, 'Get Bucket', 'Você está na Sessão <b>'..GetPlayerRoutingBucket(source)..'</b>.', 8000)
        end
    end
end)

RegisterCommand('sbucket', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Administrador') then
        if (args[1] and args[2]) then
            local nUser = parseInt(args[1])
            local nSource = vRP.getUserSource(nUser)
            local bucket = parseInt(args[2])
            if (nSource and GetPlayerName(nSource)) and (bucket >= 0) then
                SetPlayerRoutingBucket(nSource, bucket)
                TriggerClientEvent('notify', source, 'Set Bucket', 'O jogador <b>'..nUser..'</b> foi setado na sessão <b>'..bucket..'</b>.', 8000)
                vRP.webhook('bucket', {
                    title = 'sbucket',
                    descriptions = {
                        { 'staff', user_id },
                        { 'setou', nUser },
                        { 'sessão', bucket }
                    }
                })  
            else
                TriggerClientEvent('notify', source, 'Set Bucket', 'O jogador <b>'..nUser..'</b> não foi encontrado.', 8000)
            end
        end
    end
end)

---------------------------------------
-- RG2
---------------------------------------
RegisterCommand('rg2', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) then
            local nUser = parseInt(args[1])
            local identity = vRP.getUserIdentity(nUser)
            if (identity) then
                local bankMoney = vRP.getBankMoney(nUser)
                local walletMoney = vRP.getMoney(nUser)

                local groups = ''
                for gp, i in pairs(vRP.getUserGroups(nUser)) do
                    groups = groups..'<br>'..gp..' ('..i.grade..')'
                end

                local phone = identity.phone
                if (not phone) then
                    if (GetResourceState('lb-phone') == 'started') then
                        local userHasNumber = exports.oxmysql:scalar_async('select phone_number from phone_phones where owner_id = ? and name is not null', { tostring ( user_id ) })
                        phone = (userHasNumber and exports['lb-phone']:FormatNumber(userHasNumber) or '(000) 000-000')
			        end
                end
                
                TriggerClientEvent('notify', source, 'Registro', 'Passaporte: <b>#'..nUser..'</b><br>Registro: <b>'..identity.registration..'</b><br>Nome: <b>'..identity.firstname..' '..identity.lastname..'</b><br>Idade: <b>'..identity.age..'</b><br>Telefone: <b>'..tostring(phone)..'</b><br>Carteira: <b>'..vRP.format(parseInt(walletMoney))..'</b><br>Banco: <b>'..vRP.format(parseInt(bankMoney))..'</b><br>Sets: <b>'..groups..'</b>', 25000)
            else
                TriggerClientEvent('notify', source, 'Registro', 'Este <b>ID</b> não fez personagem em nossa cidade!')
            end
        end
    end
end)

---------------------------------------
-- ID
---------------------------------------
RegisterCommand('id', function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            local nUser = vRP.getUserId(nPlayer)
            TriggerClientEvent('notify', source, 'Passaporte', 'Passaporte: <b>('..(vRP.hasPermission(nUser, 'staff.permissao') and math.random(100,1000) or nUser)..')</b>', 10000)
        end
    end
end)

---------------------------------------
-- PLAYER SPAWN
---------------------------------------
AddEventHandler('playerSpawn', function(user_id, source)
    if (user_id) then
        Citizen.SetTimeout(8000, function()
            local userTable = vRP.getUserDataTable(user_id)
            if (userTable) then
                if (userTable.Handcuff == true) then
                    Player(source).state.Handcuff = true
                    vRPclient.setHandcuffed(source, true)
                    TriggerClientEvent('gb_interactions:algemas', source, 'colocar')
                end

                if (userTable.Capuz == true) then
                    Player(source).state.Capuz = true
                    vRPclient.setCapuz(source, true)
                end

                if (userTable.GPS == true) then
                    Player(source).state.GPS = true
                    TriggerClientEvent('gb_system:gps', source)
                end
            end

            local jacket = parseInt(vRP.getUData(user_id,'StraightJacket'))
            if (jacket > 0) then
                Player(source).state.StraightJacket = true
            end

            local tornozeleira = parseInt(vRP.getUData(user_id,'tornozeleira'))
            if (tornozeleira > 0) then
                TriggerEvent("sw-blips:tracePlayer", source, "Semi Aberto", {});
            end
        end)
    end
end)

RegisterNetEvent('gb_system:gps_server', function()
    local source = source
    Player(source).state.GPS = false
end)

---------------------------------------
-- ROCKSTAR EDITOR
---------------------------------------
local rockstarCommands = {
    ['start'] = function(source)
        vCLIENT.StartEditor(source)
    end,
    ['save'] = function(source)
        vCLIENT.stopAndSave(source)
    end,
    ['discard'] = function(source)
        vCLIENT.Discard(source)
    end,
    ['open'] = function(source)
        vCLIENT.openEditor(source)
    end
}

RegisterCommand('rockstar', function(source, args) 
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        if (args[1]) and rockstarCommands[args[1]] then
            rockstarCommands[args[1]](source)
        else
            TriggerClientEvent('notify', source, 'Prefeitura', 'Você não <b>especificou</b> o que gostaria de utilizar, tente novamente:<br><br><b>- /rockstar start<br>- /rockstar save<br>- /rockstar open<br>- /rockstar discard</b>')
        end
    end
end)

---------------------------------------
-- BVIDA
---------------------------------------
srv.Bvida = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        exports.appearance:setCustomization(source, user_id)
    end
end

srv.isAdmin = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then 
        return vRP.hasPermission(user_id, '+Staff.Administrador')
    end
end

---------------------------------------
-- DETIDO
---------------------------------------
local DetidoBlacked = {
    ['wrbmwx6'] = true,
    ['ndagera'] = true,
    ['ndbmws1000'] = true,

    ['bmpolas350'] = true,
    ['bmclassx6'] = true,
    ['bmdb9'] = true,
    ['bmjaguar'] = true,
    ['bmpol1200'] = true,
    ['bmgiulia'] = true
}

RegisterNetEvent('gb_interactions:detido', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
        local vehicle, vnetid, plate, vname = vRPclient.vehList(source, 5.0)
        if (DetidoBlacked[vname]) then return TriggerClientEvent('notify', source, 'Detido', 'Você não pode dar <b>detido</b> em veículo público!'); end;
        if (vnetid) then
            local prompt = exports.hud:prompt(source, {
                'Motivo'
            })[1]
            if (not prompt) then return; end;

            local vehState = exports.garage:vehicleData(vnetid)
            if (vehState.user_id) then
    
                if (vehState.user_id == user_id) then 
                    return TriggerClientEvent('notify', source, 'Detido', 'Você não pode dar <b>detido</b> no seu próprio veículo!')
                end

                local veh = vRP.query('garage/getVehicle',{ id = vehState.id })[1]
                if (veh) then
                    
                    if (parseInt(veh.detained) > 0) then
                        TriggerClientEvent('notify', source, 'Detido', 'Este <b>veículo</b> já se encontra detido.')
                    else
                        local nplayer = vRP.getUserSource(vehState.user_id)
                        if (nplayer) then 
                            TriggerClientEvent('notify', nplayer, 'Detido', 'Seu veículo ('..vRP.vehicleName(vehState.model)..' / '..vehState.plate..') foi <b>detido</b>.', 10000)
                        end

                        vRPclient.playSound(source, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS')
                        TriggerClientEvent('notify', source, 'Detido', 'O <b>veículo</b> foi apreendido com sucesso.')
                        exports.garage:safeDelete(vnetid)
                        
                        if (not vehState.clone) then
                            vRP.execute('garage/setDetained',{ id = vehState.id, detained = 2 })
                            vRP.webhook('detido', {
                                title = 'detido',
                                descriptions = {
                                    { 'officer', user_id },
                                    { 'vehicle', vehState.model },
                                    { 'vehicle plate', vehState.plate },
                                    { 'vehicle owner', vehState.user_id },
                                    { 'reason', prompt }
                                }
                            })
                        end

                    end
                end
            end
        end
    end
end)

---------------------------------------
-- TOOGLE
---------------------------------------
Citizen.CreateThread(function()
    local day_week, date = os.date('%A'), os.date('%x')
    if (day_week == 'Monday') then
        local date_saved = vRP.getSData('reset_hours_worked')
        if (date_saved ~= date) then
            vRP.setSData('reset_hours_worked', date)
            exports.oxmysql:update_async('update user_groups set hours_worked_week = "00:00:00"')
        end        
    end
end)

local Toogle = {
    ['FT'] = { blip = { name = 'Policial', view = { ['Policial'] = true, ['Semi Aberto'] = true } }, webhook = 'https://discord.com/api/webhooks/1202718573836107876/-83MU5cfhqkJ4DJl4gFbLg8dABMkXkzsMv4aA0IjGb1J1F2xsvhBO1rMYN-qPx9g1SPM' },
    ['Rota'] = { blip = { name = 'Policial', view = { ['Policial'] = true, ['Semi Aberto'] = true } }, webhook = '' },
    ['BAEP'] = { blip = { name = 'Policial', view = { ['Policial'] = true, ['Semi Aberto'] = true } }, webhook = '' },
    ['Exercito'] = { blip = { name = 'Policial', view = { ['Policial'] = true, ['Semi Aberto'] = true } }, webhook = '' },
    ['PMC'] = { blip = { name = 'Policial', view = { ['Policial'] = true, ['Semi Aberto'] = true } }, webhook = 'https://discord.com/api/webhooks/1202718679473856614/Y-prjIo8Wy378muXkMv38uUUyyuip5wECOkDSCdf5sLG-VComAUSIRq13Lfy-87ZSnEx' },
    ['PRF'] = { blip = { name = 'Policial', view = { ['Policial'] = true, ['Semi Aberto'] = true } }, webhook = 'https://discord.com/api/webhooks/1202718488284635146/9ZF6MaJ2M-tnECz6kT-ez6mmSjqCtvHxO5ottKxMHS3c5bU47XTu8OcUCrBnE26y0b3N' },
    ['PC'] = { blip = { name = 'Policial', view = { ['Policial'] = true, ['Semi Aberto'] = true } }, webhook = 'https://discord.com/api/webhooks/1202718333204439051/nxcwdTlvdaqLgh3WuCpoVZUC1N9qtlz22B2ke9TL-nZMIYc_5KQX2BilsoGdCqi4dqjB' },
    ['GCC'] = { blip = { name = 'Policial', view = { ['Policial'] = true, ['Semi Aberto'] = true } }, webhook = 'https://discord.com/api/webhooks/1202718788173435020/bDufZZwPmajdo_Y4kDiwTqU_98gjvonGrzFZbmQd-DmSZ30XeM8nldY--0z0MXZWEhPq' },
    
    ['CUS'] = { blip = { name = 'Paramedico', view = { ['Paramedico'] = true } }, },
    ['Borracharia'] = { blip = { name = 'Mecanica', view = { ['Mecanica'] = true } }, },
    ['Bracho'] = {},
    ['Juridico'] = {},
}

local cacheJoinned = {}

local updateCacheJoinned = function(user_id, group)
    local joinned_timestamp = cacheJoinned[user_id]
    if (joinned_timestamp) then
        local exit_timestamp = os.time()
        local total_time = (exit_timestamp - joinned_timestamp)

        exports.oxmysql:update_async('update user_groups set hours_worked = addtime(coalesce(hours_worked, "00:00:00"), sec_to_time(@time)), hours_worked_week = addtime(coalesce(hours_worked_week, "00:00:00"), sec_to_time(@time)) where user_id = @user_id and group_id = @group_id', { time = total_time, user_id = user_id, group_id = group })

        cacheJoinned[user_id] = nil
    end
end

local waitToogle = {}

srv.startToogle = function(group)
    local source = source
    local user_id = vRP.getUserId(source)
    
    -- local currTime = os.time()
    -- if waitToogle[user_id] and (currTime < waitToogle[user_id]) then
    --     return TriggerClientEvent('notify', source, 'negado', 'Toogle', 'Aguarde <b>'..(waitToogle[user_id]-currTime)..'</b> segundos para realizar esta ação novamente.')
    -- end
    -- waitToogle[user_id] = currTime+60

    local identity = vRP.getUserIdentity(user_id)
    
    local toogle = Toogle[group]
    if (not toogle) then return; end;

    local inGroup, inGrade = vRP.hasGroup(user_id, group)
    if (inGroup) then
        local newState = (not vRP.hasGroupActive(user_id, group))
        local groupName = vRP.getGroupTitle(group, inGrade)

        vRP.setGroupActive(user_id, group, newState)
        local logsmg = ''
        if (newState) then
            TriggerClientEvent('notify', source, 'sucesso', 'Toogle', '<b>'..groupName..'</b> | Você entrou em serviço.')
            logmsg = 'JOIN'
            
            if (toogle.blip) then TriggerEvent("sw-blips:tracePlayer", source, toogle.blip.name, toogle.blip.view); end;
            
            cacheJoinned[user_id] = os.time()
            exports.oxmysql:update_async('update user_groups set last_service = current_timestamp() where user_id = ? and group_id = ?', { user_id, group })
        else
            TriggerClientEvent('notify', source, 'aviso', 'Toogle', '<b>'..groupName..'</b> | Você saiu de serviço.')
            logmsg = 'LEAVE'

            if (toogle.blip) then TriggerEvent('sw-blips:unTracePlayer', source); end;

            updateCacheJoinned(user_id, group)
        end

        TriggerEvent('toogle:event', user_id)

        vRP.webhook((toogle.webhook ~= '' and toogle.webhook or 'toogledefault'), {
            title = 'toogle',
            descriptions = {
                { 'job', group..' - '..inGrade },
                { 'user', user_id },
                { 'status', logmsg }
            }
        })  
    end	
end

function toogleOff(source,user_id)
    local updated = false
    for k, v in pairs(Toogle) do
		local inGroup, inGrade = vRP.hasGroup(user_id,k)
		if (inGroup) and vRP.hasGroupActive(user_id,k) then		
			
            vRP.setGroupActive(user_id, k, false)
            updateCacheJoinned(user_id, k)
            if (v.blip) then TriggerEvent('sw-blips:unTracePlayer', source); end;
            
            vRP.webhook((v.webhook ~= '' and v.webhook or 'toogledefault'), {
                title = 'toogle',
                descriptions = {
                    { 'job', k..' - '..inGrade },
                    { 'user', user_id },
                    { 'status', 'leave (forçado por outro jogador)' }
                }
            }) 
            
            updated = true
		end
	end
    if updated then TriggerEvent('toogle:event', user_id); end;
    return updated
end
exports('toogleOff',toogleOff)

AddEventHandler('vRP:playerLeave', function(user_id, source)
	for k, v in pairs(Toogle) do
		local inGroup, inGrade = vRP.hasGroup(user_id,k)
		if (inGroup) and vRP.hasGroupActive(user_id,k) then		
			vRP.setGroupActive(user_id, k, false)
            updateCacheJoinned(user_id, k)
            vRP.webhook((v.webhook ~= '' and v.webhook or 'toogledefault'), {
                title = 'toogle',
                descriptions = {
                    { 'job', k..' - '..inGrade },
                    { 'user', user_id },
                    { 'status', 'leave' }
                }
            })  
		end
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
		for user_id, _ in pairs(cacheJoinned) do
            for k, v in pairs(Toogle) do
                local inGroup, inGrade = vRP.hasGroup(user_id,k)
                if (inGroup) and vRP.hasGroupActive(user_id,k) then	updateCacheJoinned(user_id, k); end;
            end
        end  
	end
end)

RegisterCommand('staff',function(source)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local groupName, groupInfo = vRP.getUserGroupByType(user_id, 'staff')
    if (groupName) then
        vRP.setGroupActive(user_id, groupName, (not groupInfo.active))

        local logmsg = ''
        if (not groupInfo.active) then
            TriggerClientEvent('notify', source, 'Toogle', '<b>'..groupName..'</b> | Você entrou em serviço.')	
            logmsg = 'JOIN'
        else
            TriggerClientEvent('notify', source, 'Toogle', '<b>'..groupName..'</b> | Você saiu de serviço.')
            logmsg = 'LEAVE'
        end
        
        TriggerEvent('toogle:event', user_id)

        vRP.webhook('tooglestaff', {
            title = 'toogle staff',
            descriptions = {
                { 'job', groupName },
                { 'user', user_id },
                { 'status', logmsg }
            }
        })  
    end
end)

---------------------------------------
-- PTR
---------------------------------------
function serviceList(source,user_id,permission,text,viewCount) 
    local count = 0 
    local name = ''
    for k, v in pairs(vRP.getUsersByPermission(permission)) do
        local identity = vRP.getUserIdentity(v)
        if (identity) then
            name = name..'<b>'..v..'</b>: '..identity.firstname..' '..identity.lastname.. '<br>'
        end
        count = (count + 1)
    end

    local permView = vRP.checkPermissions(user_id, { 'staff.permissao', permission })

    if (permView or viewCount) then
        TriggerClientEvent('notify', source, 'Prefeitura', 'Atualmente <b>'..count..' '..text..'</b> em serviço.')
    end
    if permView and (count > 0) then
        TriggerClientEvent('notify', source, 'Prefeitura', name)
    end
end

RegisterCommand('ptr', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        serviceList(source,user_id,'policia.permissao','Oficiais',true) 
    end
end)

RegisterCommand('pmc', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        serviceList(source,user_id,'pmc.permissao','Oficiais') 
    end
end)

RegisterCommand('pc', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        serviceList(source,user_id,'civil.permissao','Civis') 
    end
end)

RegisterCommand('prfe', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        serviceList(source,user_id,'prf.permissao','Oficiais') 
    end
end)

RegisterCommand('gcc', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        serviceList(source,user_id,'gcc.permissao','Oficiais') 
    end
end)

RegisterCommand('ft', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        serviceList(source,user_id,'ft.permissao','Oficiais') 
    end
end)

---------------------------------------
-- EMS
---------------------------------------
RegisterCommand('ems', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        serviceList(source,user_id,'hospital.permissao','Paramédicos',true) 
    end
end)

---------------------------------------
-- STATUS
---------------------------------------
RegisterCommand('status', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local onlinePlayers = GetNumPlayerIndices()
        local policias = vRP.getUsersByPermission('policia.permissao')
        local ems = vRP.getUsersByPermission('hospital.permissao')
        local mec = vRP.getUsersByPermission('mecanico.permissao')
        local adv = vRP.getUsersByPermission('juridico.permissao')

        TriggerClientEvent('notify', source, 'Prefeitura', 'Status dos serviços da nossa cidade: <br><br><b>Policia</b>: '..#policias..' <br> <b>Paramédico</b>: '..#ems..' <br> <b>Mecânico</b>: '..#mec..' <br> <b>Advogado</b>: '..#adv..' <br> <b>Cidadãos</b>: '..onlinePlayers)
    end
end)

---------------------------------------
-- ADMON
---------------------------------------
RegisterCommand('admon', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id and vRP.checkPermissions(user_id, { '+Staff.Manager' })) then
        local count = 0
        local name = ''
        for k, v in pairs(vRP.getUsersByPermission('staff.permissao')) do
            local identity = vRP.getUserIdentity(v)
            if (identity) then
                name = name..'<b>'..v..'</b>: '..identity.firstname..' '..identity.lastname.. '<br>'
            end
            count = (count + 1)
        end

        TriggerClientEvent('notify', source, 'Prefeitura', 'Atualmente <b>'..count..' Staffs</b> em serviço.')
        if (count > 0) then
            TriggerClientEvent('notify', source, 'Prefeitura', name)
        end
    end
end)

---------------------------------------
-- SEQUESTRO
---------------------------------------
local function handcuffed(source)
    local state = Player(source).state
    return (state.Handcuff or state.StraightJacket)
end

RegisterCommand('sequestro', function(source)
    local nPlayer = vRPclient.getNearestPlayer(source, 5)
	if (nPlayer) then
        if (vCLIENT.checkSequestro(source) == -1) then TriggerClientEvent('notify', source, 'Drumond', 'Este <b>veículo</b> não tem porta-malas.') return; end;
        if (GetEntityHealth(GetPlayerPed(source)) <= 100) then return; end;
        if (handcuffed(source)) then return; end;
		if (handcuffed(nPlayer)) then
			if (not vRPclient.getNoCarro(source)) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if (vehicle) then
                    
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nPlayer)
					end
				end
			elseif (vRPclient.isMalas(nPlayer)) then
				vRPclient.setMalas(nPlayer)
			end
		else
			TriggerClientEvent('notify', source, 'Drumond', 'A pessoa precisa estar algemada para colocar ou retirar do <b>porta-malas</b>.')
		end
	end
end)

---------------------------------------
-- APREENDER
---------------------------------------
RegisterCommand('apreender', function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.checkPermissions(user_id, { 'policia.permissao', 'staff.permissao' }) then
        local nPlayer = vRPclient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            if (GetEntityHealth(GetPlayerPed(nPlayer)) <= 100 or vRPclient.isHandcuffed(nPlayer)) then
                if (GetEntityHealth(GetPlayerPed(source)) <= 100) then return end;
                local nUser = vRP.getUserId(nPlayer)
                if (nUser) then
                    local nIdentity = vRP.getUserIdentity(nUser)
                    local request = exports.hud:request(source, 'Apreensão', 'Você tem certeza que deseja apreender os itens ilegais do '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)
                    if (request) then
                        local itens = {}
                        local weapons = vRPclient.replaceWeapons(nPlayer, {}, GlobalState.weaponToken)
                        vRP.setKeyDataTable(nUser, 'weapons', {})
                        
                        for k, v in pairs(weapons) do
                            local weapon = k:lower()
                            vRP.giveInventoryItem(nUser, weapon, 1)
                            if (v.ammo > 0) then
                                vRP.giveInventoryItem(nUser, 'm_'..weapon, v.ammo)
                            end
                        end
                        
                        vRPclient._playAnim(source, true, {
                            { 'oddjobs@shop_robbery@rob_till', 'loop' }
                        }, true)
                        TriggerClientEvent('progressBar', source, 'Apreendendo...', 5000)
                        Wait(5000)
                        local inventory = vRP.getInventory(nUser)
                        for k, v in pairs(inventory) do
                            local itemConfig = nil
                if GetResourceState('gb_inventory') == 'started' and exports.gb_inventory and exports.gb_inventory.getItemInfo then
                    itemConfig = exports.gb_inventory:getItemInfo(k)
                end
                            if (itemConfig.arrest) then
                                if (vRP.tryGetInventoryItem(nUser, k, v.amount)) then
                                    table.insert(itens, v.amount..'x '..(vRP.itemNameList(k) or k))		
                                end
                            end
                        end
                        local ped = GetPlayerPed(source)
                        ClearPedTasks(ped)

                        TriggerClientEvent('notify', nPlayer, 'Apreensão', 'Todos os seus itens ilegais foram <b>apreendidos</b> e enviados à prefeitura!')
                        TriggerClientEvent('notify', source, 'Apreensão', 'Você <b>apreendeu</b> todos os itens ilegais do cidadão!')
                        TriggerClientEvent('radio:outServers', nPlayer)
                        
                        vRP.webhook('apreender', {
                            title = 'apreender',
                            descriptions = {
                                { 'officer', user_id },
                                { 'target', nUser },
                                { 'itens', json.encode(itens, { indent = truee }) }
                            }
                        })  
                    end
                end
            else
                TriggerClientEvent('notify', source, 'Apreensão', 'O cidadão precisa estar <b>algemado</b> ou <b>desmaiado</b>!');
            end
        end
    end
end)

---------------------------------------
-- PORTE
---------------------------------------
vRP._prepare('getUsersWithPorte', 'select user_id from user_groups where group_id = "Porte"')

local _porte = {
    ['add'] = function(source)
        local prompt = exports.hud:prompt(source, {
            'Passaporte do Jogador'
        })[1]
        if (not prompt) then return; end;

        local nUser = parseInt(prompt)
        if (nUser) then
            vRP.addUserGroup(nUser, 'Porte')
            TriggerClientEvent('notify', source, 'Porte de Arma', 'Você adicionou o <b>porte de armas</b> para o passaporte <b>'..nUser..'</b>.')
        end
    end,
    ['rem'] = function(source)
        local prompt = exports.hud:prompt(source, {
            'Passaporte do Jogador'
        })[1]
        if (not prompt) then return; end;

        local nUser = parseInt(prompt)
        if (nUser) then
            vRP.removeUserGroup(nUser, 'Porte')
            TriggerClientEvent('notify', source, 'Porte de Arma', 'Você adicionou o <b>porte de armas</b> para o passaporte <b>'..nUser..'</b>.')
        end
    end,
    ['list'] = function(source)
        local query = vRP.query('getUsersWithPorte')
        
        local text = ''
        for _, data in pairs(query) do
            local identity = vRP.getUserIdentity(data.user_id)
            text = text..'<br> <b>'..data.user_id..' | '..identity.firstname..' '..identity.lastname..'</b>'
        end
        TriggerClientEvent('notify', source, 'Porte de Arma', 'Passaportes que possuem porte de armas: <br>'..text)
    end
}

RegisterCommand('porte', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '@Juridico.Juiz') then
        if (args[1]) then
            local func = string.lower(args[1])
            if (_porte[func]) then
                _porte[func](source, user_id)
            end
        end
    end
end)

---------------------------------------
-- SPECTATOR
---------------------------------------
RegisterCommand("spec",function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,'+Staff.Suporte') then
        local nsource = vRP.getUserSource(parseInt(args[1]))
        if (nsource) then
            TriggerClientEvent("vrp_admin:spec",source,nsource)
            vRP.webhook('spec', {
                title = 'spec',
                descriptions = {
                    { 'user', user_id },
                    { 'target', vRP.getUserId(nsource) }
                }
            })  
        end
    end
end)

---------------------------------------
-- ROUPAS
---------------------------------------
--[[
srv.checkClothesPermission = function(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (vRP.getInventoryItemAmount(user_id, 'roupas') >= 1 or vRP.checkPermissions(user_id, perm)) then
            return true
        end
    end
    return false
end
]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- RENAME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rename',function(source, args)
    local user_id = vRP.getUserId(source)
    if args[1] then
        if vRP.hasPermission(user_id,"+Staff.Suporte") then
            local nuser_id = parseInt(args[1])
            local nidentity = vRP.getUserIdentity(nuser_id)
            if nidentity then
                
                local prompt = vRP.prompt(source,{
                    'Nome: ("'..tostring(nidentity.firstname)..'")',
                    'Sobrenome ("'..tostring(nidentity.lastname)..'")',
                    'Idade ("'..nidentity.age..'")'
                })
                
                local firstname, lastname, age = prompt[1], prompt[2], parseInt(prompt[3])
                if (not firstname) or (not lastname) or (age == 0) then
                    return TriggerClientEvent("Notify", source, "Renomear", "Identidade Incompleta!")
                end

                exports.oxmysql:update_async('update user_characters set firstname = ?, lastname = ?, age = ? where id = ?', { firstname, lastname, age, nuser_id })

                vRP.resetIdentity(nuser_id)

                TriggerClientEvent("Notify", source, "Renomear", "Identidade do Passaporte <b>"..nuser_id.."</b> atualizado com sucesso.")
                vRP.webhook('rename', {
                    title = 'rename',
                    descriptions = {
                        { 'user', user_id },
                        { 'target', nuser_id },
                        { 'old', json.encode(nidentity,{indent=true}) },
                        { 'new', json.encode( vRP.getUserIdentity(nuser_id) ,{indent=true}) },
                    }
                })  
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
local dispatchId = Tools.newIDGenerator()
local callBlips = {}

RegisterNetEvent('phone:services:dispatch', function(company, employees, source, message, phoneNumber)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))

    exports['lb-phone']:SendNotification(source, {
        app = "Services",
        title = 'Serviços',
        content = 'Chamado enviado com sucesso!'
    })

    local answered, answeredBy = false, '';
    for i = 1, #employees do
        local nsource = employees[i]
        if (nsource) then

            async(function() 
                local nuser_id = vRP.getUserId(nsource)
                local nidentity = vRP.getUserIdentity(nuser_id)

                local times = {
                    ['police'] = 15000,
                    ['ambulance'] = 15000,
                    ['mechanic'] = 30000
                }

                TriggerClientEvent('NotifyPush', nsource, { type = 'default', title = 'Chamado de '..nidentity.firstname, message = message, coords = coords, phone = phoneNumber, time = (times[company] or 15000) })

                local id = dispatchId:gen()
                callBlips[id] = vRPclient.addBlip(nsource, coords.x, coords.y, coords.z, 358, 71, 'Chamado ~b~'..capitalizeString(tostring(company))..'~w~', 0.6, false)
                Citizen.SetTimeout(30000, function() vRPclient.removeBlip(nsource, callBlips[id]) dispatchId:free(id) end)

                local request = exports.hud:request(nsource, 'Chamados', 'Você deseja aceitar o chamado de '..identity.firstname..' '..identity.lastname..'?', 15000)
                if (request) then
                    if (not answered) then
                        -- > Ninguém atendeu.

                        answered, answeredBy = true, (nuser_id..'# '..nidentity.firstname..' '..nidentity.lastname)

                        exports['lb-phone']:SendNotification(source, {
                            app = "Services",
                            title = 'Serviços',
                            content = 'O seu chamado foi atendido!'
                        })

                        vRPclient._setGPS(nsource, coords.x, coords.y)
                    else
                        -- > Já atenderam.

                        TriggerClientEvent('Notify', nsource, 'aviso', 'Chamados', 'Este <b>chamado</b> ja foi atendido por outra pessoa.')
                        vRPclient.playSound(nsource, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET')
                    end
                end
            end)
            
        end
    end

    Citizen.SetTimeout(30000,function()
        local text = (answeredBy == '' and 'Não' or 'por '..answeredBy)
        vRP.webhook('chamados', {
            title = 'Chamados',
            descriptions = {
                { 'user', user_id },
                { 'org', company },
                { 'mensagem', message },
                { 'coords', tostring(coords) },
                { 'membros', (#employees) },
                { 'atendido', text },
            }
        }) 
    end)
end)

RegisterCommand('tesoura', function(source, args)
    local userId = vRP.getUserId(source)
    if vRP.hasPermission(userId, 'staff.permissao') then
        local userInventory = vRP.PlayerInventory(userId)
        userInventory:giveItem('tesoura', 1, nil, nil, true)
    end
end)

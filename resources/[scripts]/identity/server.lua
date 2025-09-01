srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

local configGeneral = config.general

vRP._prepare('gb_identity/getUserPhoto', 'select url from identity where user_id = @user_id')
vRP._prepare('gb_identity/insertPhoto', 'insert into identity (user_id, url) values (@user_id, @url)')
vRP._prepare('gb_identity/updatePhoto', 'update identity set url = @url where user_id = @user_id')
vRP._prepare('gb_identity/getUserRH', 'select rh from user_characters where id = @user_id')

local getUserPhoto = function(user_id)
    local query = vRP.query('gb_identity/getUserPhoto', { user_id = user_id })[1]
    if (query) then return query.url; end;
    vRP.execute('gb_identity/insertPhoto', { user_id = user_id, url = configGeneral._defaultPhoto })
    return configGeneral._defaultPhoto
end

local getUserJob = function(user_id)
    local job, jobinfo = vRP.getUserGroupByType(user_id, 'job')
    if (job) and jobinfo then
        return vRP.getGroupTitle(job, jobinfo.grade)..((jobinfo.active and ' (ativo)') or '')
    end
    return 'Desempregado'
end

local getUserStaff = function(user_id)
    local staff, staffinfo = vRP.getUserGroupByType(user_id, 'staff')
    if (staff) then
        return vRP.getGroupTitle(staff, staffinfo.grade)..((staffinfo.active and ' (ativo)') or '')
    end
    return nil
end

local getUserVip = function(user_id)
    local staff, staffinfo = vRP.getUserGroupByType(user_id, 'vips')
    if (staff) then
        return vRP.getGroupTitle(staff, staffinfo.grade)
    end
    return nil
end

local getUserRelationship = function(user_id)
    local relation, couple, status = exports.core:CheckUser(user_id)
    return (status or 'Solteiro(a)')
end

local getUserRH = function(user_id)
    local query = vRP.query('gb_identity/getUserRH', { user_id = user_id })[1]
    if (query) then return query.rh; end;
    return 'Desconhecido'
end
exports('getUserRH', getUserRH)

srv.getUserIdentity = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local identity = vRP.getUserIdentity(user_id)
        return {
            id = user_id,
            fullname = (identity and identity.firstname..' '..identity.lastname or 'Indivíduo Indigente'),
            age = (identity and identity.age or 18),
            image = getUserPhoto(user_id),
            job = getUserJob(user_id),
            rg = (identity and identity.registration or 'AAAAAAAA'),
            wallet = vRP.getMoney(user_id),
            bank = vRP.getBankMoney(user_id),
            staff = getUserStaff(user_id),
            phone = (identity and identity.phone or '000-000'),
            vip = getUserVip(user_id),
            relationship = getUserRelationship(user_id),
            driveLicense = GetResourceState('driving_school') == 'started' and exports.driving_school and exports.driving_school.getUserLicense and exports.driving_school:getUserLicense(user_id) or '000-000',
            gunLicense = vRP.hasPermission(user_id, 'porte.permissao'),
            fines = 0,
            rh = getUserRH(user_id),
            coins = exports.shop:getUserCoins(user_id),
            oac = vRP.hasPermission(user_id, 'oac.permissao'),
            hunter = vRP.hasPermission(user_id, 'cacador.permissao')
        }
    end
end

local getUserRG = function(source, nUser, args)
    local table = {}
    local identity = vRP.getUserIdentity(nUser)
    if (args) then
        table = {
            id = nUser,
            fullname = (identity and identity.firstname..' '..identity.lastname or 'Indivíduo Indigente'),
            age = (identity and identity.age or 18),
            image = getUserPhoto(nUser),
            job = getUserJob(nUser),
            rg = (identity and identity.registration or 'AAAAAAAA'),
            wallet = vRP.getMoney(nUser),
            bank = vRP.getBankMoney(nUser),
            staff = getUserStaff(nUser),
            phone = (identity and identity.phone or '000-000'),
            vip = getUserVip(nUser),
            relationship = getUserRelationship(nUser),
            driveLicense = GetResourceState('driving_school') == 'started' and exports.driving_school and exports.driving_school.getUserLicense and exports.driving_school:getUserLicense(nUser) or '000-000',
            gunLicense = vRP.hasPermission(nUser, 'porte.permissao'),
            fines = 0,
            rh = getUserRH(nUser),
            coins = exports.shop:getUserCoins(nUser),
            oac = vRP.hasPermission(nUser, 'oac.permissao'),
            hunter = vRP.hasPermission(nUser, 'cacador.permissao')
        }
    else
        table = {
            id = nUser,
            fullname = (identity and identity.firstname..' '..identity.lastname or 'Indivíduo Indigente'),
            age = (identity and identity.age or 18),
            image = getUserPhoto(nUser),
            job = getUserJob(nUser),
            rg = (identity and identity.registration or 'AAAAAAAA'),
            wallet = vRP.getMoney(nUser),
            relationship = getUserRelationship(nUser),
            driveLicense = GetResourceState('driving_school') == 'started' and exports.driving_school and exports.driving_school.getUserLicense and exports.driving_school:getUserLicense(nUser) or '000-000',
            gunLicense = vRP.hasPermission(nUser, 'porte.permissao'),
            fines = 0,
            rh = getUserRH(nUser),
            oac = vRP.hasPermission(nUser, 'oac.permissao'),
            hunter = vRP.hasPermission(nUser, 'cacador.permissao')
        }
    end 

    vRP.webhook('verifyRg', {
        title = 'verify rg',
        descriptions = {
            { 'action', '(verify rg)' },
            { 'user', vRP.getUserId(source) },
            { 'target', nUser },
            { 'table', json.encode(table, { indent = true }) },
            { 'image', table.image }
        }
    })  

    vCLIENT.openNui(source, table, true)
end

RegisterCommand('rg', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.checkPermissions(user_id, configGeneral.perms) then
        if (args[1]) and vRP.hasPermission(user_id, 'staff.permissao') then
            getUserRG(source, parseInt(args[1]), true)
        else
            local nearestPlayer = vRPclient.getNearestPlayer(source, 2.0)
            if (not nearestPlayer) then return; end;

            local nUser = vRP.getUserId(nearestPlayer)

            local allow = false;
            if (vRPclient.isHandcuffed(nearestPlayer)) or (vRP.hasPermission(user_id, configGeneral.staffPermission)) then allow = true;
            else allow = vRP.request(nearestPlayer, 'Identidade', 'Você deseja passar o seu RG para o policial?', 60000); end;

            if (allow) then
                TriggerClientEvent('notify', source, 'aviso', 'Registro', 'Verificando o <b>RG</b> do passaporte <b>'..nUser..'<b>.')
                getUserRG(source, nUser)  
            else
                TriggerClientEvent('notify', nearestPlayer, 'negado', 'Registro', 'Você negou passar o seu <b>RG</b>')
                TriggerClientEvent('notify', source, 'negado', 'Registro', 'O mesmo negou passar o seu <b>RG</b>.')
            end
        end
    end
end)

srv.updatePhoto = function(image)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (image) then
            vRP.execute('gb_identity/updatePhoto', { user_id = user_id, url = image })
            vRP.webhook('updatePhoto', {
                title = 'update photo',
                descriptions = {
                    { 'action', '(update photo)' },
                    { 'user', user_id },
                    { 'photo', image },
                }
            })  
            return
        end
    end
    return TriggerClientEvent('notify', source, 'Identidade', 'Não foi possível atualizar a sua <b>identidade</b>.')
end

--------------------------------------------------------------------------------------
-- OAC
--------------------------------------------------------------------------------------
local listCommands = {
    ['list'] = function(source)
        local text = ''

        local getUsers = exports.oxmysql:query_async('select user_id from user_groups where group_id = "OAC"')
        for _, data in pairs(getUsers) do
            id = data.user_id
            local idt = vRP.getUserIdentity(id)
            if (idt) and (idt.firstname) then
                text = text..' <br> <b>#'..id..' '..idt.firstname..' '..idt.lastname..' ('..idt.phone..')</b>'
            end
        end

        if (#getUsers > 0) then TriggerClientEvent('notify', source, 'importante', 'OAC', 'Lista de membros da <b>OAC</b>: <br>'..text); end;
    end,

    ['add'] = function(source, user_id, args)
        local otherUser = exports.hud:prompt(source, { 'Passaporte do Jogador' })[1]
        if (not otherUser) then return; end;
        otherUser = parseInt(otherUser)

        if (otherUser > 0) then
            local idt = vRP.getUserIdentity(otherUser)
            if (idt) and (idt.firstname) then
                local request = exports.hud:request(source, 'OAC', 'Você tem certeza que deseja colocar o(a) <b>'..idt.firstname..' '..idt.lastname..'</b> no <b>OAC</b>?', 30000)
                if (request) then
                    vRP.addUserGroup(otherUser, 'OAC')
                    TriggerClientEvent('notify', source, 'sucesso', 'OAC', 'Você adicionou o(a) <b>'..idt.firstname..' '..idt.lastname..'</b> no <b>OAC</b>!')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'OAC', 'Jogador <b>inexistente</b>!')
            end
        end
    end,

    ['rem'] = function(source, user_id, args)
        local otherUser = exports.hud:prompt(source, { 'Passaporte do Jogador' })[1]
        if (not otherUser) then return; end;
        otherUser = parseInt(otherUser)

        if (otherUser > 0) then
            local idt = vRP.getUserIdentity(otherUser)
            if (idt) and (idt.firstname) then
                local request = exports.hud:request(source, 'OAC', 'Você tem certeza que deseja retirar o(a) <b>'..idt.firstname..' '..idt.lastname..'</b> no <b>OAC</b>?', 30000)
                if (request) then
                    vRP.removeUserGroup(otherUser, 'OAC')
                    TriggerClientEvent('notify', source, 'sucesso', 'OAC', 'Você retirou o(a) <b>'..idt.firstname..' '..idt.lastname..'</b> no <b>OAC</b>!')
                end
            else
                TriggerClientEvent('notify', source, 'negado', 'OAC', 'Jogador <b>inexistente</b>!')
            end
        end
    end
}

RegisterCommand('oac', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id) and (vRP.hasPermission(user_id, '@Juridico.Juiz')) then
        local text = (args[1] and string.lower(args[1]) or '')
        if (text) and (text ~= '') then
            local command = listCommands[text]
            if (command) then
                command(source, user_id, args)
            end
        else
            TriggerClientEvent('notify', source, 'negado', 'OAC', 'Você utilizou o <b>comando</b> de forma errada. Tente novamente!<br><br>- /oac list<br>- /oac add<br>- /oac rem')
        end
    end
end)

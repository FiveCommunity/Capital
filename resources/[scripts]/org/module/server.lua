vRP._prepare('org/createTable', 
    [[CREATE TABLE IF NOT EXISTS `blacklist` (
        `user_id` int(11) not null,
        `org` varchar(50) not null,
        `expires` varchar(50) not null,
        primary key (`user_id`)
    );]]
)

Citizen.CreateThread(function() vRP.execute('org/createTable'); end)

vRP._prepare('members/getAllMembers', 'select * from user_groups where group_id = @fac')
vRP._prepare('members/countAllMembers', 'select COUNT(*) from user_groups where group_id = @fac')

vRP._prepare('members/getBlacklist', 'SELECT * FROM blacklist WHERE user_id = @user_id')
vRP._prepare('members/setBlacklist', 'REPLACE INTO blacklist(user_id,org,expires) VALUES(@user_id,@org,@expires)')
vRP._prepare('members/delBlacklist', 'DELETE FROM blacklist WHERE user_id = @user_id')

local DB_GET_LAST_LOGIN <const> = 'select last_login from user_characters where id = ?'
local DB_GET_LAST_SERVICE <const> = 'select last_service from user_groups where user_id = ? and group_id = ?'
local DB_GET_HOURS_WORKED <const> = 'select hours_worked, hours_worked_week from user_groups where user_id = ? and group_id = ?'

-------------------------------------------------------'

srv.inBlacklist = function(user_id)
    local data = vRP.query('members/getBlacklist', { user_id = user_id })
    return (data[1] or false)
end

srv.setBlacklist = function(user_id,org,days)
    local identity = vRP.getUserIdentity(user_id)
    local expires = os.time() + parseInt(86400*days)
    vRP.execute('members/setBlacklist',{ user_id = user_id, org = org, expires = expires})

    vRP.webhook('enterblacklist', {
        title = 'enter blacklist',
        descriptions = {
            { 'id', user_id },
            { 'fac', org },
            { 'blacklist', days..' dias' }
        }
    })    
end
exports('setBlacklist',srv.setBlacklist)

delBlacklist = function(user_id)
    local identity = vRP.getUserIdentity(user_id)
    local blacklist = srv.inBlacklist(user_id)
    if (blacklist) then
        vRP.execute('members/delBlacklist',{ user_id = user_id })

        vRP.webhook('exitblacklist', {
            title = 'exit blacklist',
            descriptions = {
                { 'id', user_id },
                { 'fac', blacklist.org },
                { 'blacklist', 'saiu' }
            }
        })  
        return true
    end
end
exports('delBlacklist',delBlacklist)

AddEventHandler('playerSpawn',function(user_id, source)
    local identity = vRP.getUserIdentity(user_id)
    local blacklist = srv.inBlacklist(user_id)
    if (blacklist) then
        blacklist.expires = parseInt(blacklist.expires)
        if (os.time() > blacklist.expires) then
            vRP.execute('members/delBlacklist',{ user_id = user_id })
            TriggerClientEvent('Notify',source,'importante','Organizações','Seu tempo de Blacklist terminou! Você já pode se candidatar á uma nova <b>Organização</b>!',60000)
            vRP.webhook('exitblacklist', {
                title = 'exit blacklist',
                descriptions = {
                    { 'id', user_id },
                    { 'fac', blacklist.org },
                    { 'blacklist', 'saiu' }
                }
            })  
        else
            local exp_date = os.date('%d/%m/%Y às %H:%M', blacklist.expires)
            TriggerClientEvent('Notify',source,'importante','Organizações','Você está na Blacklist! Aguarde até <b>'..exp_date..'</b>!',30000)
        end
    end
end)

-------------------------------------------------------

srv.sendMessageToFac = function(fac, type_message, message)
    local allMembers = srv.getAllMembers(fac)
    local currentMember;
    for _, v in pairs(allMembers) do
        currentMember = vRP.getUserSource(v.user_id)
        if (currentMember) then
            TriggerClientEvent('Notify', currentMember, type_message, 'Organização', message, 20000)
        end
    end
    return { result = 'success', message = 'Mensagem geral enviada para a organização!' }
end

-------------------------------------------------------

srv.getMembersAmount = function(fac) return { amount = vRP.scalar('members/countAllMembers', { fac = fac }), vagas = configFacs[fac].vagas } end

srv.getPermissions = function(id)
    local source = source
    local user_id = (id or vRP.getUserId(source))

    local userGroup, groupInfo = vRP.getUserGroupByType(user_id, 'fac') 
    if (not userGroup) then
        userGroup, groupInfo = vRP.getUserGroupByType(user_id, 'job')
    end

    if (userGroup and configFacs[userGroup]) then
        return { 
            fac = userGroup, 
            role = groupInfo.grade, 
            fac_type = vRP.getGroupType(userGroup), 
            permissions_roles = configFacs[userGroup].roles, 
            has_products = (configFacs[userGroup].products ~= nil)
        }
    end
end

srv.getAllMembers = function(fac)
    local cb = {}
    local result = vRP.query('members/getAllMembers', { fac = fac })
    for _, v in pairs(result) do
        local userData = vRP.getUserIdentity(v.user_id)
        table.insert(cb, {
            user_id = v.user_id,
            fac = v.group_id, 
            role = v.grade_id,
            name = (userData and userData.firstname..' '..userData.lastname or '?'),
            rg = (userData and userData.registration or '?'),
            phone = (userData and userData.phone or '?'),
            age = 21,
            status = getServiceState(fac, v.user_id),
            isJob = (vRP.getGroupType(v.group_id) == 'job')
        })
    end
    return cb
end

srv.searchUser = function(user_id)
    local userData = vRP.getUserIdentity(user_id)
    local job = vRP.getUserGroupByType(user_id, 'job')
    return {
        user_id = (user_id or '?'),
        name = (userData and userData.firstname..' '..userData.lastname or '?'),
        rg = (userData and userData.registration or '?'),
        phone = (userData and userData.phone or '?'),
        fac = job, 
    }
end

local formatLastSeen = function(user_id, fac)
    local source = vRP.getUserSource(user_id)
    local isJob = (vRP.getGroupType(fac) == 'job')

    if (isJob) then
        local result = exports.oxmysql:query_async(DB_GET_LAST_SERVICE, { user_id, fac })[1]
        if (result) and (result.last_service ~= 0) then
            return exports.system:formatDate(result.last_service)
        end
    else
        local result = exports.oxmysql:query_async(DB_GET_LAST_LOGIN, { user_id })[1]
        if (result) and (result.last_login) then
            return (source and 'Online' or exports.system:formatDate(result.last_login))
        end
    end
    
    return 'N/A'
end

local getHoursWorked = function(user_id, fac)
    local source = vRP.getUserSource(user_id)

    local result = exports.oxmysql:query_async(DB_GET_HOURS_WORKED, { user_id, fac })[1]
    if (result) and (result.hours_worked) then
        return result.hours_worked
    end

    return 'N/A'
end

local getHoursWorkedOnWeek = function(user_id, fac)
    local source = vRP.getUserSource(user_id)

    local result = exports.oxmysql:query_async(DB_GET_HOURS_WORKED, { user_id, fac })[1]
    if (result) and (result.hours_worked_week) then
        return result.hours_worked_week
    end

    return 'N/A'
end

srv.detailsUser = function(user_id, fac)
    local lastSeen = formatLastSeen(user_id, fac)
    local hoursWorked = getHoursWorked(user_id, fac)
    local hoursWorkedOnWeek = getHoursWorkedOnWeek(user_id, fac)

    return {
        last_seen = lastSeen,
        hours_worked = hoursWorked,
        hours_worked_week = hoursWorkedOnWeek
    }
end

srv.admit = function(fac, user_id)
    user_id = parseInt(user_id)

    local leader_id = vRP.getUserId(source)
    local leader_idt = vRP.getUserIdentity(leader_id)

    local allMembers = srv.getAllMembers(fac)
    local permission = srv.getPermissions(user_id)

    local user_source = vRP.getUserSource(user_id)

    if (not user_source) then return { result = 'error', message = 'Membro fora da Cidade!' }; end;

    if (#allMembers < configFacs[fac].vagas) then 
        if (permission ~= nil) then
            return { result = 'error', message = 'Cidadão já pertence a uma organização!' }
        else
            if (not srv.inBlacklist(user_id)) then
                local response = vRP.request(user_source, 'Contratação', 'Você foi convidado para a organização '..fac..'. Deseja aceitar?',30000)
                if response then
                    local grades = configFacs[fac].grades
                    vRP.addUserGroup(user_id, fac, grades[#grades])
                    TriggerClientEvent('Notify',user_source,'sucesso','Organizações','Você acabou de ser contratado pela <b>'..fac..'</b>.')
                     
                    local identity = vRP.getUserIdentity(user_id)
                    vRP.webhook('admit', {
                        title = 'admit',
                        descriptions = {
                            { 'id', leader_id },
                            { 'fac', fac..' ('..grades[#grades]..')' },
                            { 'contratou', user_id }
                        }
                    })                      
                    return { result = 'success', message = 'Membro contratado com sucesso!' }
                else
                    TriggerClientEvent('Notify',user_source,'negado','Organizações','Você acabou de recusar uma proposta da organização <b>'..fac..'</b>.')
                    return { result = 'error', message = 'O passaporte '..user_id..' recusou a oferta!' }
                end
            else
                return { result = 'error', message = 'Cidadão na Blacklist!' }
            end
        end
    else 
        return { result = 'error', message = 'A organização já atingiu o limite máximo de membros!' }
    end
end

srv.dismiss = function(fac, user_id)
    user_id = parseInt(user_id)

    local leader_id = vRP.getUserId(source)
    local leader_idt = vRP.getUserIdentity(leader_id)

    local user_source = vRP.getUserSource(user_id)
    local hasGroup, hasGrade = vRP.hasGroup(user_id,fac)
    if hasGroup then
        if searchGradeIndex(fac, hasGrade) > 1 then 
            vRP.removeUserGroup(user_id, fac )
            srv.setBlacklist(user_id, fac, 7)
            if user_source then          
                TriggerClientEvent('Notify',user_source,'negado','Organizações','Você acabou de ser demitido da organização <b>'..fac..'</b> e entrou na Blacklist.')
            end

            local identity = vRP.getUserIdentity(user_id)
            vRP.webhook('dimiss', {
                title = 'dimiss',
                descriptions = {
                    { 'id', leader_id },
                    { 'fac', fac..' ('..tostring(hasGrade)..')' },
                    { 'demitiu', user_id }
                }
            })    
            return { result = 'success', message = 'Membro demitido com sucesso!' }
        else
            return { result = 'error', message = 'Você não pode demitir lideres da organização!' }
        end
    else 
        return { result = 'error', message = 'Você só pode demitir membros da organização!' }
    end
end

srv.updateRole = function(fac, user_id, method)
    user_id = parseInt(user_id)

    local _source = source
    local current_user_id = vRP.getUserId(_source)
    local user_source = vRP.getUserSource(user_id)
    if (user_id ~= current_user_id) then
        local hasGroup, hasGrade = vRP.hasGroup(user_id,fac)
        if (hasGroup) then
            local grades = config.facs[fac].grades
            if (method == 'promote') then
                local currIdx = searchGradeIndex(fac, hasGrade)
                local newIdx = (currIdx-1)
                if (newIdx > 1) then
                    vRP.addUserGroup(user_id, fac, grades[newIdx] )
                    if user_source then
                        TriggerClientEvent('Notify',user_source,'sucesso','Organizações','Agora você é um '..grades[newIdx]..' na organização <b>'..fac..'</b>.')
                    end
                    return { result = 'success', message = 'Cargo de membro alterado com sucesso!' }
                else
                    return { result = 'error', message = 'Cargo do membro atingiu o máximo!' }
                end        
            elseif (method == 'downgrade') then
                local currIdx = searchGradeIndex(fac, hasGrade)
                local newIdx = (currIdx+1)
                if (currIdx > 1) and (newIdx <= #grades) then
                    vRP.addUserGroup(user_id, fac, grades[newIdx] )          
                    if user_source then
                        TriggerClientEvent('Notify',user_source,'sucesso','Organizações','Agora você é um '..grades[newIdx]..' na organização <b>'..fac..'</b>.')
                    end
                    return { result = 'success', message = 'Cargo de membro alterado com sucesso!' }
                else
                    return { result = 'error', message = 'Cargo do membro atingiu o mímimo!' }
                end
            end
        else
            return { result = 'error', message = 'Não reconhecemos o membro dessa organização!' }
        end
    else 
        return { result = 'error', message = 'Você não pode alterar o cargo deste usuário!' }
    end
    return { result = 'error', message = 'Sistema Indisponivel.' }
end

searchGradeIndex = function(fac,grade) 
    for i = 1, #config.facs[fac].grades do 
        if (config.facs[fac].grades[i] == grade) then return i; end;
    end
    return 0
end

local serviceCheckers = { 
    online = function(user_id,group)
        return (vRP.getUserSource(user_id) ~= nil)
    end,
    active = function(user_id,group)
        return (vRP.getUserSource(user_id) and vRP.hasGroupActive(user_id,group))
    end,
}

getServiceState = function(fac,user_id)
    local cfg = config.facs[fac]
    if (cfg and cfg.serviceCheck) then return serviceCheckers[cfg.serviceCheck](user_id,fac); end;
    return false
end

RegisterCommand('rblacklist', function(source, args)
    local _source = source
    local userId = vRP.getUserId(_source)

    if vRP.hasPermission(userId, 'staff.permissao') then
        if args[1] then
            local blacklistUserId = tonumber(args[1])
            local blacklist = srv.inBlacklist(blacklistUserId)

            if not blacklist then
                TriggerClientEvent('notify', _source, 'negado', 'Blacklist', 'Este cidadão não está em blacklist!')
                return 
            end

            delBlacklist(blacklistUserId)

            vRP.webhook('rblacklist', {
                title = 'Retirar blacklist',
                descriptions = {
                    { 'STAFF', userId },
                    { 'id', blacklistUserId },
                    { 'fac', blacklist.org },
                    { 'blacklist', 'Retirado' }
                }
            })  

            TriggerClientEvent('notify', _source, 'sucesso', 'Blacklist', 'Blacklist removida com sucesso!')
        else
            TriggerClientEvent('notify', _source, 'negado', 'Blacklist', 'Comando com formato incorreto<br /><br />/rblacklist id')
        end
    else
        TriggerClientEvent('notify', _source, 'negado', 'Blacklist', 'Você não possui permissão para realizar este comando!')
    end
end)
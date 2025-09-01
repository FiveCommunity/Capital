srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

local baseGroups = {}

GetGroups = function()
    return config.groups
end
exports('GetGroups', GetGroups)

painelSysGroups = function()
    baseGroups = {}
    for group, groupData in pairs(config.groups) do
        if groupData.information and groupData.information.grades then
            local grades = {}
            for k,_ in pairs(groupData.information.grades) do
                table.insert(grades, k)
            end
            table.insert(baseGroups,{ group = group, grades = grades })
        else
            table.insert(baseGroups,{ group = group, grades = { group } })
        end
    end
end
Citizen.CreateThread(painelSysGroups)

painelUserGroups = function(user_id)
    local cb = {}
    for group, info in pairs(vRP.getUserGroups(user_id)) do
        table.insert(cb, { group = group, grade = info.grade })
    end
    return cb
end

RegisterCommand('group', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Manager') then
        local prompt = parseInt(vRP.prompt(source, { 'Passaporte' })[1])
        if (prompt) then
            local usergroups = painelUserGroups(prompt)
            local identity = vRP.getUserIdentity(prompt)
            if (identity) then
                vCLIENT.openNui(source, identity, usergroups, baseGroups)
            else
                TriggerClientEvent('notify', source, 'negado', 'Set Group', 'ID inexistente!')
            end
        end
    end
end)

srv.addGroup = function(id, group, grade)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Manager') then
        vRP.addUserGroup(id, group, grade)
        vCLIENT.updateNui(source, painelUserGroups(id))

        vRP.webhook('group', {
            title = 'add group',
            descriptions = {
                { 'staff', user_id },
                { 'target', id },
                { 'group', group },
                { 'grade', grade }
            }
        })    
    end
end

srv.delGroup = function(id, group, grade)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, '+Staff.Manager') then
        vRP.removeUserGroup(id, group)
        vCLIENT.updateNui(source, painelUserGroups(id))
        vRP.webhook('ungroup', {
            title = 'ungroup',
            descriptions = {
                { 'staff', user_id },
                { 'target', id },
                { 'group', group },
                { 'grade', grade }
            }
        })    
    end
end
local srv = {}
Tunnel.bindInterface('dynamic', srv)
local vCLIENT = Tunnel.getInterface('dynamic')

local favoritesList = {}

srv.getFavorites = function()
    local list = {}

    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (not favoritesList[user_id]) then            
            local result = oxmysql:query_async('select * from dynamic where user_id = ?', { user_id })
            for _, data in pairs(result) do
                table.insert(list, data.action)
            end
            favoritesList[user_id] = list 
        else
            list = favoritesList[user_id]
        end
    end

    return list
end

srv.setFavorite = function(action)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        oxmysql:insert('insert ignore into dynamic (user_id, action) values (?, ?)', { user_id, action }, function(id)
            favoritesList[user_id] = nil
            
            vCLIENT.updateUi(source)
        end)
    end
end

srv.deleteFavorite = function(action)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        oxmysql:execute('delete from dynamic where user_id = ? and action = ?', { user_id, action }, function(id)
            favoritesList[user_id] = nil
            
            vCLIENT.updateUi(source)
        end)
    end
end

local Permissions = nil;

srv.checkPermissions = function(permissions)
    if (not Permissions) then Permissions = permissions; end;

    local perms = {}

    local source = source
    local user_id = vRP.getUserId(source)

    for group, permission in pairs(permissions) do
        if (vRP.hasPermission(user_id, permission)) then
            perms[group] = true
        end
    end
    
    return perms
end

local updatePermissions = function(user_id)
    local source = vRP.getUserSource(user_id)
    if (source) then TriggerClientEvent('dynamic:updateUserPermissions', source); end;
end

AddEventHandler('toogle:event', updatePermissions)
AddEventHandler('group:event', function(type, table)
    updatePermissions(table.user_id)
end)

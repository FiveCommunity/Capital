local defaultUserAppearance = {}

AddEventHandler('playerSpawn', function(user_id, source)
    if (user_id) and (not defaultUserAppearance[user_id]) then
        local request = exports.oxmysql:query_async('select * from user_datatable where user_id = ?', { user_id })[1]
        if (request) then
            local user_character = (json.decode(request.user_character) or {})
            defaultUserAppearance[user_id] = user_character
            TriggerClientEvent('appearance:setDefaultAppearance', source, user_character)
        end
    end
end)

RegisterCommand('getapp', function(source, args)
    print("------ an4log")
    print(json.encode(defaultUserAppearance['3']))
end)
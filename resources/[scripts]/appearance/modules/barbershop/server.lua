srv.getCharacter = function()
    local custom = {}
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local value = vRP.query('appearance:getCharacter', { user_id = user_id })[1]
        if (value) and (value.user_character) then custom = json.decode(value['user_character']) end;
    end
    return custom
end
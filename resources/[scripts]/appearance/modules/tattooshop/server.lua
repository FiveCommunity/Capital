srv.getTattoos = function()
    local custom = {}
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local value = vRP.query('appearance:getTattoos', { user_id = user_id })[1]
        if (value) and (value.user_tattoo) then custom = json.decode(value.user_tattoo); end;
    end
    return custom
end
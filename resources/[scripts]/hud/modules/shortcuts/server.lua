srv.getUserHotbar = function()
    local source = source
    local user_id = vRP.getUserId(source)
    return exports.inventory:getUserHotbar(user_id)
end
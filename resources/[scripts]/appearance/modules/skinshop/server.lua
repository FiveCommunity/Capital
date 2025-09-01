setCustomization = function(source, user_id)
    local query = vRP.query('appearance:getClothes', { user_id = user_id })[1]
    if (query) and query.user_clothes then
        vRPclient.setCustomization(source, json.decode(query.user_clothes))
        return true
    end
    return false
end
exports('setCustomization', setCustomization)
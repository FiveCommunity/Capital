srv.getUserHomes = function()
    local homes = {}
    
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local _, userHomes = exports.homes:getAllUserHomes(user_id, true)
        for home, data in pairs(userHomes) do
            table.insert(homes, { type = (data.config.type == 'apartament' and 'Apartamento' or 'Residência'), name = home  })
        end
    end

    return homes
end

srv.getLastPosition = function()
    local source = source
    local coords = vector3(-1106.229, -2856.026, 13.96338)
    if (source) then
        local datatable = vRP.getUserDataTable(vRP.getUserId(source))
        if (datatable) and datatable.position then
            local position = datatable.position
            coords = vector3(position.x, position.y, position.z)
        end
    end
    return coords
end

srv.getUserId = function()
    return vRP.getUserId(source)
end
local srv = {}
Tunnel.bindInterface('Spray', srv)
local vCLIENT = Tunnel.getInterface('Spray')

local config = module('core', 'cfg/cfgSpray')
local configSpray = config.spray

vRP.prepare('gb_spray/createSpray', 'insert spray (interior, x, y, z, rx, ry, rz, scale, spray_text, font, color) values (@interior, @x, @y, @z, @rx, @ry, @rz, @scale, @spray_text, @font, @color)')
vRP.prepare('gb_spray/selectSprays', 'select * from spray')
vRP.prepare('gb_spray/deleteSpray', 'delete from spray where id = @id')
vRP.prepare('gb_spray/cleanupSpray', 'DELETE FROM spray WHERE created_at < NOW() - INTERVAL 7 DAY;')
-- FAZER FUNÇÃO PRA REMOVER NO RR

local sprays = {}

Citizen.CreateThread(function()
    vRP.execute('gb_spray/cleanupSpray')
    local result = vRP.query('gb_spray/selectSprays')
    for _, s in pairs(result) do
        table.insert(sprays, {
            id = s.id,
            location = vector3(s.x + 0.00, s.y + 0.00, s.z + 0.00),
            realRotation = vector3(s.rx + 0.00, s.ry + 0.00, s.rz + 0.00),
            scale = tonumber(s.scale) + 0.0,
            text = s.spray_text,
            font = s.font,
            originalColor = s.color,
            color = configSpray.colors[s.color]['color'].hex,
            interior = ((s.interior == 1) and true or false),
        })
    end
    Citizen.Wait(1000)
    TriggerClientEvent('gb_spray:setSprays', -1, sprays)
end)

AddEventHandler('playerSpawn', function(user_id, source)
    TriggerClientEvent('gb_spray:setSprays', source, sprays)
end)

startSpray = function(source)
    local user_id = vRP.getUserId(source)
    if (user_id) then
        local sprayText = vRP.prompt(source, { 'Texto' })[1]
        if (sprayText) then
            if (configSpray.blacklist[sprayText]) then
                TriggerClientEvent('notify', source, 'Spray', 'Este <b>texto</b> não é permitido.')
            else
                if (sprayText:len() <= 9) then
                    vCLIENT.createSpray(source, sprayText)
                else
                    TriggerClientEvent('notify', source, 'Spray', 'O <b>texto</b> pode ter até 9 caracteres')
                end
            end
        else
        end
    end
end
exports('startSpray', startSpray)

removeSpray = function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        TriggerClientEvent('gb_spray:removeClosestSpray', source)        
    end
end
exports('removeSpray', removeSpray)

srv.getItem = function(item)
    local source = source
    if (item) and (item ~= '') then 
        local user_id = vRP.getUserId(source)
        if (user_id) then
            local Inventory = vRP.PlayerInventory(user_id)
            if Inventory then
                return Inventory:tryGetItem(item, 1)
            end
        end
    else
        return true
    end
end

srv.addSpray = function(spray)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        
        local newId = vRP.insert('gb_spray/createSpray',{ 
            interior = spray.interior,
            x = spray.location.x,
            y = spray.location.y,
            z = spray.location.z,
            rx = spray.realRotation.x,
            ry = spray.realRotation.y,
            rz = spray.realRotation.z,
            scale = spray.scale,
            spray_text = spray.text,
            font = spray.font,
            color = spray.originalColor
        })

        if newId and (newId > 0) then

            vRP.webhook('spray', {
				title = 'spray-pintar',
				descriptions = {
					{ 'user', user_id },
					{ 'spray-id', newId },
                    { 'texto', tostring(spray.text) },
					{ 'coord', tostring( spray.location ) }
				}
			})

            spray.id = newId
            table.insert(sprays, spray)
            TriggerClientEvent('gb_spray:setSprays', -1, sprays)
        end
    end
end

RegisterNetEvent('gb_spray:remove', function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if id and (id > 0) then
            vRP.execute('gb_spray/deleteSpray', { id = id })
            for idx, s in pairs(sprays) do
                if (s.id == id) then

                    vRP.webhook('spray', {
                        title = 'spray-remover',
                        descriptions = {
                            { 'user', user_id },
                            { 'spray-id', s.id },
                            { 'texto', tostring(s.text) },
                            { 'coord', tostring( s.location ) }
                        }
                    })
                    
                    sprays[idx] = nil
                    break;
                end
            end
            Citizen.Wait(1000)
            TriggerClientEvent('gb_spray:setSprays', -1, sprays)
        end
    end
end)
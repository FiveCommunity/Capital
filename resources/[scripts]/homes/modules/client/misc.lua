--====================================================================================
-- Map Blip
--====================================================================================
local list = false
local blips = {}
buyeds = {}
local homes = {}

local listBlips = function()    
    if (list) then
        TriggerEvent('notify', 'importante', 'Residências', '<b>Marcações</b> desativadas.')

        for _, blip in pairs(blips) do
            if (DoesBlipExist(blip)) then
                RemoveBlip(blip)
            end
        end
    else
        TriggerEvent('notify', 'importante', 'Residências', '<b>Marcações</b> ativadas.')
    
        for key, values in pairs(configHomes) do
            local homesType = values.type
            if (homesType) and (values.type ~= 'mlo') then
                local blipConfig = config.type[values.type].blip
                if (blipConfig) and (not buyeds[key]) then
                    blips[key] = AddBlipForCoord(values.coord)

                    SetBlipSprite(blips[key], blipConfig.sprite)
                    SetBlipColour(blips[key], blipConfig.color)
                    SetBlipAsShortRange(blips[key], true)
                    SetBlipScale(blips[key], 0.5)

                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentString(homesType:upper())
                    EndTextCommandSetBlipName(blips[key])
                end
            end
            Citizen.Wait(5) 
        end
    end

    list = (not list)
end
RegisterNetEvent('gb_interactions:blips', listBlips)

RegisterNetEvent('homes:setBlip', function(table)
    homes[table[1]] = AddBlipForCoord(table[2])

    SetBlipSprite(homes[table[1]], 411)
    SetBlipAsShortRange(homes[table[1]], true)
    SetBlipColour(homes[table[1]], 4)
    SetBlipScale(homes[table[1]], 0.3)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Residência: ~b~'..table[1])
    EndTextCommandSetBlipName(homes[table[1]])
end)

RegisterNetEvent('homes:setBlipBuyed', function(home, bool) 
    buyeds[home] = bool
end)
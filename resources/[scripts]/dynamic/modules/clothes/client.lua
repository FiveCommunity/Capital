local cli = {}
Tunnel.bindInterface('clothes', cli)
local vSERVER = Tunnel.getInterface('clothes')

cli.getCurrentPreset = function()
    local ped = PlayerPedId()
    return {
        ['1'] = { model = GetPedDrawableVariation(ped, 1), var = GetPedTextureVariation(ped, 1) },
        ['3'] = { model = GetPedDrawableVariation(ped, 3), var = GetPedTextureVariation(ped, 3) },
        ['4'] = { model = GetPedDrawableVariation(ped, 4), var = GetPedTextureVariation(ped, 4) },
        ['5'] = { model = GetPedDrawableVariation(ped, 5), var = GetPedTextureVariation(ped, 5) },
        ['6'] = { model = GetPedDrawableVariation(ped, 6), var = GetPedTextureVariation(ped, 6) },
        ['7'] = { model =  GetPedDrawableVariation(ped, 7), var = GetPedTextureVariation(ped, 7) },
        ['8'] = { model = GetPedDrawableVariation(ped, 8), var = GetPedTextureVariation(ped, 8) },
        ['9'] = { model = GetPedDrawableVariation(ped, 9), var = GetPedTextureVariation(ped, 9) },
        ['11'] = { model = GetPedDrawableVariation(ped, 11), var = GetPedTextureVariation(ped, 11) },
        ['p0'] = { model = GetPedPropIndex(ped, 0), var = GetPedPropTextureIndex(ped, 0) },
        ['p1'] = { model = GetPedPropIndex(ped, 1), var = GetPedPropTextureIndex(ped, 1) },
        ['p2'] = { model = GetPedPropIndex(ped, 2), var = GetPedPropTextureIndex(ped, 2) },
        ['p6'] = { model = GetPedPropIndex(ped, 6), var = GetPedPropTextureIndex(ped, 6) },
        ['p7'] = { model = GetPedPropIndex(ped, 7), var = GetPedPropTextureIndex(ped, 7) },
    }
end
exports('getPreset', cli.getCurrentPreset)

cli.setClothes = function(clothes)
    local ped = PlayerPedId()

    vRP._playAnim(true, {{'clothingshirt','try_shirt_positive_d'}}, false)

    TriggerEvent('ProgressBar', 2000)
    Citizen.SetTimeout(2000, function()
        ClearPedTasks(ped)

        for i = 0, 7 do
            ClearPedProp(ped, i)
        end

        for k, v in pairs(clothes) do
            local isProp, index = exports.vrp:parsePart(k)
            if (isProp) then
                if (v.model < 0) then
                    ClearPedProp(ped,index)
                else
                    SetPedPropIndex(ped, index, v.model, v.var, 0)
                end
            else
                SetPedComponentVariation(ped, parseInt(k), v.model, v.var,  0)
            end
        end
        TriggerEvent('gb:barberUpdate')
        TriggerEvent('gb:tattooUpdate')

    end)
end

getUserPresets = function() return vSERVER.getAllPresets(); end;
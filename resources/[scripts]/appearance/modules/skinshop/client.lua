oldCustom = {}
lastClothes = {}

local defaultUserAppearance;
RegisterNetEvent('appearance:setDefaultAppearance', function(data)
    defaultUserAppearance = data
end)

local checkEmptyValue = function(value)
    if (value == -1) then return 15; end;
    return value
end

local getDrawables = function(general)
    local ped = PlayerPedId()
    local clothesBlocked = (((GetEntityModel(ped) == GetHashKey('mp_m_freemode_01')) or (GetEntityModel(ped) == GetHashKey('mp_f_freemode_01'))) and general.shopConfig or configExcludes.default) 
    
    return {
        { amount = GetNumberOfPedDrawableVariations(ped, 1), type = '1', model = GetPedDrawableVariation(ped, 1), var = GetPedTextureVariation(ped, 1), blocks = clothesBlocked['1'] },
        { amount = GetNumberOfPedDrawableVariations(ped, 3), type = '3', model = GetPedDrawableVariation(ped, 3), var = GetPedTextureVariation(ped, 3), blocks = clothesBlocked['3'] },
        { amount = GetNumberOfPedDrawableVariations(ped, 4), type = '4', model = GetPedDrawableVariation(ped, 4), var = GetPedTextureVariation(ped, 4), blocks = clothesBlocked['4'] },
        { amount = GetNumberOfPedDrawableVariations(ped, 5), type = '5', model = GetPedDrawableVariation(ped, 5), var = GetPedTextureVariation(ped, 5), blocks = clothesBlocked['5'] },
        { amount = GetNumberOfPedDrawableVariations(ped, 6), type = '6', model = GetPedDrawableVariation(ped, 6), var = GetPedTextureVariation(ped, 6), blocks = clothesBlocked['6'] },
        { amount = GetNumberOfPedDrawableVariations(ped, 7), type = '7', model = GetPedDrawableVariation(ped, 7), var = GetPedTextureVariation(ped, 7), blocks = clothesBlocked['7'] },
        { amount = GetNumberOfPedDrawableVariations(ped, 8), type = '8', model = GetPedDrawableVariation(ped, 8), var = GetPedTextureVariation(ped, 8), blocks = clothesBlocked['8'] },
        { amount = GetNumberOfPedDrawableVariations(ped, 9), type = '9', model = GetPedDrawableVariation(ped, 9), var = GetPedTextureVariation(ped, 9), blocks = clothesBlocked['9'] },
        { amount = GetNumberOfPedDrawableVariations(ped, 11), type = '11', model = GetPedDrawableVariation(ped, 11), var = GetPedTextureVariation(ped, 11), blocks = clothesBlocked['11'] },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 0), type = 'p0', model = GetPedPropIndex(ped, 0), var = GetPedPropTextureIndex(ped, 0), blocks = clothesBlocked['p0'] },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 1), type = 'p1', model = GetPedPropIndex(ped, 1), var = GetPedPropTextureIndex(ped, 1), blocks = clothesBlocked['p1'] },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 2), type = 'p2', model = GetPedPropIndex(ped, 2), var = GetPedPropTextureIndex(ped, 2), blocks = clothesBlocked['p2'] },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 6), type = 'p6', model = GetPedPropIndex(ped, 6), var = GetPedPropTextureIndex(ped, 6), blocks = clothesBlocked['p6'] },
        { amount = GetNumberOfPedPropDrawableVariations(ped, 7), type = 'p7', model = GetPedPropIndex(ped, 7), var = GetPedPropTextureIndex(ped, 7), blocks = clothesBlocked['p7'] }
    }
end

openSkinShop = function(locs)
    local location = configLocs[locs]
    local general = configGeneral[location.type][location.config]

    LocalPlayer.state.Hud = false
    LocalPlayer.state.inAppearance = true
    Cache.oldHeading = GetEntityHeading(ped)

    SetNuiFocus(true, true)

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    oldCustom = vRP.getCustomization()

    Citizen.Wait(500)
    
	ClearPedTasksImmediately(ped)
    setPlayersVisible(false)

    local sex;
    if (model == GetHashKey('mp_m_freemode_01')) then 
        sex = 'male'
    elseif (model == GetHashKey('mp_f_freemode_01')) then 
        sex = 'female'
    else
        local peds = general.customPeds
        if (peds) then
            local allowed = peds[model]
            if (allowed) then
                if (type(allowed) == 'string') then sex = allowed;
                else sex = 'male';
                end
            end
        end
    end

    Cams['body']()

    local drawables = getDrawables(general)
    SendNUIMessage({
        action = 'openSkinShop',
        data = {
            sex = sex,
            drawables = drawables
        }
    })
end

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
local debugAppearance = false

local appearanceFixed = function(ped,customs)
    SetPedFaceFeature(ped, 0, 0.0)
    SetPedFaceFeature(ped, 1, 0.0)
    SetPedFaceFeature(ped, 2, 0.0)
    SetPedFaceFeature(ped, 3, 0.0)
    SetPedFaceFeature(ped, 4, 0.0)
    SetPedFaceFeature(ped, 5, 0.0)

    SetPedFaceFeature(ped, 15, 0.0)
    SetPedFaceFeature(ped, 16, 0.0)
    SetPedFaceFeature(ped, 17, 0.0)
    SetPedFaceFeature(ped, 18, 0.0)     
    SetPedFaceFeature(ped, 13, 0.0)
    SetPedFaceFeature(ped, 14, 0.0)

    SetPedFaceFeature(ped, 8, 0.0)
    SetPedFaceFeature(ped, 9, 0.0)
    SetPedFaceFeature(ped, 10, 0.0)
    SetPedFaceFeature(ped, 12, 0.0)
    SetPedFaceFeature(ped, 19, 0.0)
    SetPedHeadBlendData(ped, 0, 21, 0, customs.colorFather, customs.colorMother, 0, 0.5, 0.5, 0, false)
end

-- fixAppearance = function(ped, custom)
    
--     local custom = (custom or defaultUserAppearance)
--     local mask = GetPedDrawableVariation(ped, 1)

--     if (config.debugMasks[mask]) then
--         debugAppearance = true;
--         Citizen.SetTimeout(100, function()
--             appearanceFixed(ped,custom)
--         end)
--     else
--         setPedCustom(custom)
--     end
-- end
-- exports('fixAppearance', fixAppearance)

RegisterNUICallback('changeSkinshopDemo', function(data, cb)
    local ped = PlayerPedId()
    local draw = data.drawables
    if (draw) then
        local variations = {}

        -- Mascara
        if (draw['1'].model ~= nil) then
            if (config.debugMasks[draw['1'].model]) then
                if (not debugAppearance) then
                    debugAppearance = true
                    appearanceFixed(ped)
                end
            else
                if (debugAppearance) then
                    debugAppearance = false
                    setPedCustom(defaultUserAppearance)
                end
            end

            SetPedComponentVariation(ped, 1, draw['1'].model, draw['1'].var)
            variations['1'] = GetNumberOfPedTextureVariations(ped, 1, draw['1'].model)
        end

        -- Mãos
        if (draw['3'].model ~= nil) then
            SetPedComponentVariation(ped, 3, draw['3'].model, draw['3'].var)
            variations['3'] = GetNumberOfPedTextureVariations(ped, 3, draw['3'].model)
        end

        -- Calça
        if (draw['4'].model ~= nil) then
            SetPedComponentVariation(ped, 4, draw['4'].model, draw['4'].var)
            variations['4'] = GetNumberOfPedTextureVariations(ped, 4, draw['4'].model)
        end

        -- Mochila
        if (draw['5'].model ~= nil) then
            SetPedComponentVariation(ped, 5, draw['5'].model, draw['5'].var)
            variations['5'] = GetNumberOfPedTextureVariations(ped, 5, draw['5'].model)
        end

        -- Sapatos
        if (draw['6'].model ~= nil) then
            SetPedComponentVariation(ped, 6, draw['6'].model, draw['6'].var)
            variations['6'] = GetNumberOfPedTextureVariations(ped, 6, draw['6'].model)
        end

        -- Colar
        if (draw['7'].model ~= nil) then
            SetPedComponentVariation(ped, 7, draw['7'].model, draw['7'].var)
            variations['7'] = GetNumberOfPedTextureVariations(ped, 7, draw['7'].model)
        end

        -- Camisa
        if (draw['8'].model ~= nil) then
            SetPedComponentVariation(ped, 8, checkEmptyValue(draw['8'].model), draw['8'].var)
            variations['8'] = GetNumberOfPedTextureVariations(ped, 8, draw['8'].model)
        end

        -- Colete
        if (draw['9'].model ~= nil) then
            SetPedComponentVariation(ped, 9, draw['9'].model, draw['9'].var)
            variations['9'] = GetNumberOfPedTextureVariations(ped, 9, draw['9'].model)
        end

        -- Jaqueta
        if (draw['11'].model ~= nil) then
            SetPedComponentVariation(ped, 11, checkEmptyValue(draw['11'].model), draw['11'].var)
            variations['11'] = GetNumberOfPedTextureVariations(ped, 11, draw['11'].model)
        end

        -- Chapeu
        if (draw['p0'].model < 0) then 
            ClearPedProp(ped, 0)
        else
            if (draw['p0'].model ~= nil) then
                SetPedPropIndex(ped, 0, draw['p0'].model, draw['p0'].var)
                variations['p0'] = GetNumberOfPedPropTextureVariations(ped, 0, draw['p0'].model)
            end
        end

        -- Oculos
        if (draw['p1'].model < 0) then 
            ClearPedProp(ped, 1)
        else
            if (draw['p1'].model ~= nil) then
                SetPedPropIndex(ped, 1, draw['p1'].model, draw['p1'].var)
                variations['p1'] = GetNumberOfPedPropTextureVariations(ped, 1, draw['p1'].model)
            end
        end
        
        -- Brincos
        if (draw['p2'].model < 0) then 
            ClearPedProp(ped, 2)
        else
            if (draw['p2'].model ~= nil) then
                SetPedPropIndex(ped, 2, draw['p2'].model, draw['p2'].var)
                variations['p2'] = GetNumberOfPedPropTextureVariations(ped, 2, draw['p2'].model)
            end
        end

        -- Relogio
        if (draw['p6'].model < 0) then 
            ClearPedProp(ped, 6)
        else
            if (draw['p6'].model ~= nil) then
                SetPedPropIndex(ped, 6, draw['p6'].model, draw['p6'].var)
                variations['p6'] = GetNumberOfPedPropTextureVariations(ped, 6, draw['p6'].model)
            end
        end

        -- Bracelete
        if (draw['p7'].model < 0) then 
            ClearPedProp(ped, 7)
        else
            if (draw['p7'].model ~= nil) then
                SetPedPropIndex(ped, 7, draw['p7'].model, draw['p7'].var)
                variations['p7'] = GetNumberOfPedPropTextureVariations(ped, 7, draw['p7'].model)
            end
        end

        SendNUIMessage({
            action = 'setVariations',
            data = variations
        })
    end

    cb('Ok')
end)

RegisterNUICallback('buySkinshopCustomizations', function(data, cb)
    if (data.drawables and data.total > 0) then
        data.drawables.pedModel = GetEntityModel(PlayerPedId())
        if (vSERVER.tryPayment(data.total, data.drawables, 'skinshop')) then oldCustom = {}; end;
    end
    closeUi()
    
    cb('Ok')
end)
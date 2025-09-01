local getDrawables = function(playerModel)
    local ped = PlayerPedId()
    local custom = LocalPlayer.state.pedCustom
    local pedDrawables = {
        { eyes = 31, model = custom.eyesColor },
        { blemishes = GetNumHeadOverlayValues(0), model = custom.blemishesModel, opacity = custom.blemishesOpacity },
        { beard = GetNumHeadOverlayValues(1), model = custom.beardModel, main_color = custom.beardColor, opacity = custom.beardOpacity },
        { eyebrows = GetNumHeadOverlayValues(2), model = custom.eyebrowsModel, main_color = custom.eyebrowsColor, opacity = custom.eyebrowsOpacity },
        { hair = GetNumberOfPedDrawableVariations(ped, 2), model = custom.hairModel, main_color = custom.firstHairColor, secondary_color = custom.secondHairColor },
        { ageing = GetNumHeadOverlayValues(3), model = custom.ageingModel, opacity = custom.ageingOpacity },
        { makeup = GetNumHeadOverlayValues(4), model = custom.makeupModel, main_color = (custom.makeupColor or 0), color_type = (custom.makeupColorType or 0), opacity = custom.makeupOpacity },
        { blush = GetNumHeadOverlayValues(5), model = custom.blushModel, main_color = custom.blushColor, opacity = custom.blushOpacity },
        { complexion = GetNumHeadOverlayValues(6), model = custom.complexionModel, opacity = custom.complexionOpacity },
        { sundamage = GetNumHeadOverlayValues(7), model = custom.sundamageModel, opacity = custom.sundamageOpacity },
        { lipstick = GetNumHeadOverlayValues(8), model = custom.lipstickModel, main_color = custom.lipstickColor, opacity = custom.lipstickOpacity },
        { freckles = GetNumHeadOverlayValues(9), model = custom.frecklesModel, opacity = custom.frecklesOpacity },
        { chestModel = GetNumHeadOverlayValues(10), model = custom.chestModel, main_color = custom.chestColor, opacity = custom.chestOpacity },
    }
    return pedDrawables
end

openBarberShop = function(locs)
    local location = configLocs[locs]
    local general = configGeneral[location.type][location.config]

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    if (model ~= GetHashKey('mp_m_freemode_01') and model ~= GetHashKey('mp_f_freemode_01')) then return; end;

    LocalPlayer.state.Hud = false
    LocalPlayer.state.inAppearance = true
    LocalPlayer.state.pedCustom = vSERVER.getCharacter()
    Cache.oldHeading = GetEntityHeading(ped)
    oldCustom = vRP.getCustomization()

    SetNuiFocus(true, true)

    Citizen.Wait(500)
    
	ClearPedTasksImmediately(ped)
    setPlayersVisible(false)

    if (general.clothes) then Utils.Skinshop:SetClothes(ped, general.clothes[model]); end;

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

    local drawables = getDrawables()
    SendNUIMessage({
        action = 'openBarberShop',
        data = {
            type = general.shopType,
            config = general.shopConfig,
            sex = sex,
            drawables = drawables
        }
    })
end

setPedCustom = function(data)
    Citizen.Wait(100)
    local ped = PlayerPedId()
    local data = (data == nil and LocalPlayer.state.pedCustom or data)

    -- [ Genética ] --

    SetPedHeadBlendData(ped, data.fatherId, data.motherId, 0, data.colorMother, data.colorFather, 0, Utils.Barbershop:Float(data.shapeMix), Utils.Barbershop:Float(data.skinMix), 0, false)

    -- [ Pele ] --

    SetPedHeadOverlay(ped, 12, data.addBodyBlemishes, Utils.Barbershop:Float(data.bodyBlemishesOpacity))
    SetPedHeadOverlay(ped, 11, data.bodyBlemishes, Utils.Barbershop:Float(data.bodyBlemishesOpacity))

    -- [ Olhos ] --

    SetPedEyeColor(ped, data.eyesColor)
    SetPedFaceFeature(ped, 11, Utils.Barbershop:Float(data.eyesOpening))
    SetPedFaceFeature(ped, 6, Utils.Barbershop:Float(data.eyebrowsHeight))
	SetPedFaceFeature(ped, 7, Utils.Barbershop:Float(data.eyebrowsWidth))
    SetPedHeadOverlay(ped, 2, data.eyebrowsModel, Utils.Barbershop:Float(data.eyebrowsOpacity))
    SetPedHeadOverlayColor(ped, 2, 1, data.eyebrowsColor, data.eyebrowsColor)

    -- [ Nariz ] --

    SetPedFaceFeature(ped, 0, Utils.Barbershop:Float(data.noseWidth))
    SetPedFaceFeature(ped, 1, Utils.Barbershop:Float(data.noseHeight))
    SetPedFaceFeature(ped, 2, Utils.Barbershop:Float(data.noseLength))
    SetPedFaceFeature(ped, 3, Utils.Barbershop:Float(data.noseBridge))
    SetPedFaceFeature(ped, 4, Utils.Barbershop:Float(data.noseTip))
    SetPedFaceFeature(ped, 5, Utils.Barbershop:Float(data.noseShift))

    -- [ Queixo ] --

    SetPedFaceFeature(ped, 15, Utils.Barbershop:Float(data.chinLength))
    SetPedFaceFeature(ped, 16, Utils.Barbershop:Float(data.chinPosition))
    SetPedFaceFeature(ped, 17, Utils.Barbershop:Float(data.chinWidth))
    SetPedFaceFeature(ped, 18, Utils.Barbershop:Float(data.chinShape))     
    SetPedFaceFeature(ped, 13, Utils.Barbershop:Float(data.jawWidth))
    SetPedFaceFeature(ped, 14, Utils.Barbershop:Float(data.jawHeight))

    -- [ Bochecha ] --

    SetPedFaceFeature(ped, 8, Utils.Barbershop:Float(data.cheekboneHeight))
    SetPedFaceFeature(ped, 9, Utils.Barbershop:Float(data.cheekboneWidth))
    SetPedFaceFeature(ped, 10, Utils.Barbershop:Float(data.cheeksWidth))
    SetPedFaceFeature(ped, 12, Utils.Barbershop:Float(data.lips))
    SetPedFaceFeature(ped, 19, Utils.Barbershop:Float(data.neckWidth))

    -- [ Aspecto ] --

    SetPedHeadOverlay(ped, 6, data.complexionModel, Utils.Barbershop:Float(data.complexionOpacity))
    SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

    SetPedHeadOverlay(ped, 7, data.sundamageModel, Utils.Barbershop:Float(data.sundamageOpacity))
    SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

    SetPedHeadOverlay(ped, 9, data.frecklesModel, Utils.Barbershop:Float(data.frecklesOpacity))
    SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

    SetPedHeadOverlay(ped, 3, data.ageingModel, Utils.Barbershop:Float(data.ageingOpacity))
    SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

    SetPedHeadOverlay(ped, 0, data.blemishesModel, Utils.Barbershop:Float(data.blemishesOpacity))
    SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

    -- [ Barbearia ] --

    SetPedComponentVariation(ped, 2, data.hairModel, 0, 0)
    SetPedHairColor(ped, data.firstHairColor, data.secondHairColor)

    SetPedHeadOverlay(ped, 1, data.beardModel, Utils.Barbershop:Float(data.beardOpacity))
    SetPedHeadOverlayColor(ped, 1, 1, data.beardColor, data.beardColor)

    SetPedHeadOverlay(ped, 10, data.chestModel, Utils.Barbershop:Float(data.chestOpacity))
    SetPedHeadOverlayColor(ped, 10, 1, data.chestColor, data.chestColor)

    SetPedHeadOverlay(ped, 5, data.blushModel, Utils.Barbershop:Float(data.blushOpacity))
    SetPedHeadOverlayColor(ped, 5, 2, data.blushColor, data.blushColor)

    SetPedHeadOverlay(ped, 8, data.lipstickModel, Utils.Barbershop:Float(data.lipstickOpacity))
    SetPedHeadOverlayColor(ped, 8, 2, data.lipstickColor, data.lipstickColor)

    SetPedHeadOverlay(ped, 4, data.makeupModel, Utils.Barbershop:Float(data.makeupOpacity))
    SetPedHeadOverlayColor(ped, 4, data.makeupColorType, data.makeupColor, data.makeupColor)
end
exports('setPedCustom', setPedCustom)

RegisterNetEvent('gb:barberUpdate', function()
    if (LocalPlayer.state.pedCustom == nil or countTable(LocalPlayer.state.pedCustom) <= 0) then 
        LocalPlayer.state.pedCustom = vSERVER.getCharacter()           
        Citizen.Wait(1500)
        setPedCustom()
    else 
        setPedCustom()
    end
end)

RegisterNetEvent('barbershop:init', function(custom) LocalPlayer.state.pedCustom = custom setPedCustom() end)
RegisterNetEvent('gb:refreshBarber', setPedCustom)

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNUICallback('changeBarbershopDemo', function(data, cb)
    local ped = PlayerPedId()
    if (data.drawables) then
        -- OLHOS
        SetPedEyeColor(ped, data.drawables.eyes.model)

        -- SOBRANCELHA
        SetPedHeadOverlay(ped, 2, data.drawables.eyebrows.model, Utils.Barbershop:Float(data.drawables.eyebrows.opacity))
        SetPedHeadOverlayColor(ped, 2, 1, data.drawables.eyebrows.main_color, data.drawables.eyebrows.main_color)

        -- CABELO
        SetPedComponentVariation(ped, 2, data.drawables.hair.model, 0, 0)
        SetPedHairColor(ped, data.drawables.hair.main_color, data.drawables.hair.secondary_color)
        
        -- BARBA
        SetPedHeadOverlay(ped, 1, data.drawables.beard.model, Utils.Barbershop:Float(data.drawables.beard.opacity))
        SetPedHeadOverlayColor(ped, 1, 1, data.drawables.beard.main_color, data.drawables.beard.main_color)

        -- PELO CORPORAL
        SetPedHeadOverlay(ped, 10, data.drawables.chestModel.model, Utils.Barbershop:Float(data.drawables.chestModel.opacity))
        SetPedHeadOverlayColor(ped, 10, 1, data.drawables.chestModel.main_color, data.drawables.chestModel.main_color)

        -- BLUSH
        SetPedHeadOverlay(ped, 5, data.drawables.blush.model, Utils.Barbershop:Float(data.drawables.blush.opacity))
        SetPedHeadOverlayColor(ped, 5, 2, data.drawables.blush.main_color, data.drawables.blush.main_color)

        -- BATOM
        SetPedHeadOverlay(ped, 8, data.drawables.lipstick.model, Utils.Barbershop:Float(data.drawables.lipstick.opacity))
        SetPedHeadOverlayColor(ped, 8, 2, data.drawables.lipstick.main_color, data.drawables.lipstick.main_color)

        -- MANCHAS
        SetPedHeadOverlay(ped, 0, data.drawables.blemishes.model, Utils.Barbershop:Float(data.drawables.blemishes.opacity))
        SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

        -- ENVELHECIMENTO
        SetPedHeadOverlay(ped, 3, data.drawables.ageing.model, Utils.Barbershop:Float(data.drawables.ageing.opacity))
        SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

        -- ASPECTO
        SetPedHeadOverlay(ped, 6, data.drawables.complexion.model, Utils.Barbershop:Float(data.drawables.complexion.opacity))
        SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

        -- PELE
        SetPedHeadOverlay(ped, 7, data.drawables.sundamage.model, Utils.Barbershop:Float(data.drawables.sundamage.opacity))
        SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

        -- SARDAS
        SetPedHeadOverlay(ped, 9, data.drawables.freckles.model, Utils.Barbershop:Float(data.drawables.freckles.opacity))
        SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

        -- MAQUIAGEM
        SetPedHeadOverlay(ped, 4, data.drawables.makeup.model, Utils.Barbershop:Float(data.drawables.makeup.opacity))
        SetPedHeadOverlayColor(ped, 4, data.drawables.makeup.color_type, data.drawables.makeup.main_color, data.drawables.makeup.main_color)
    end

    cb('Ok')
end)

RegisterNUICallback('buyBarbershopCustomizations', function(data, cb)
    local ped = PlayerPedId()
    if (data.drawables) then
        -- OLHOS
        SetPedEyeColor(ped, data.drawables.eyes.model)

        -- SOBRANCELHA
        SetPedHeadOverlay(ped, 2, data.drawables.eyebrows.model, Utils.Barbershop:Float(data.drawables.eyebrows.opacity))
        SetPedHeadOverlayColor(ped, 2, 1, data.drawables.eyebrows.main_color, data.drawables.eyebrows.main_color)

        -- CABELO
        SetPedComponentVariation(ped, 2, data.drawables.hair.model, 0, 0)
        SetPedHairColor(ped, data.drawables.hair.main_color, data.drawables.hair.secondary_color)
        
        -- BARBA
        SetPedHeadOverlay(ped, 1, data.drawables.beard.model, Utils.Barbershop:Float(data.drawables.beard.opacity))
        SetPedHeadOverlayColor(ped, 1, 1, data.drawables.beard.main_color, data.drawables.beard.main_color)

        -- PELO CORPORAL
        SetPedHeadOverlay(ped, 10, data.drawables.chestModel.model, Utils.Barbershop:Float(data.drawables.chestModel.opacity))
        SetPedHeadOverlayColor(ped, 10, 1, data.drawables.chestModel.main_color, data.drawables.chestModel.main_color)

        -- BLUSH
        SetPedHeadOverlay(ped, 5, data.drawables.blush.model, Utils.Barbershop:Float(data.drawables.blush.opacity))
        SetPedHeadOverlayColor(ped, 5, 2, data.drawables.blush.main_color, data.drawables.blush.main_color)

        -- BATOM
        SetPedHeadOverlay(ped, 8, data.drawables.lipstick.model, Utils.Barbershop:Float(data.drawables.lipstick.opacity))
        SetPedHeadOverlayColor(ped, 8, 2, data.drawables.lipstick.main_color, data.drawables.lipstick.main_color)

        -- MANCHAS
        SetPedHeadOverlay(ped, 0, data.drawables.blemishes.model, Utils.Barbershop:Float(data.drawables.blemishes.opacity))
        SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

        -- ENVELHECIMENTO
        SetPedHeadOverlay(ped, 3, data.drawables.ageing.model, Utils.Barbershop:Float(data.drawables.ageing.opacity))
        SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

        -- ASPECTO
        SetPedHeadOverlay(ped, 6, data.drawables.complexion.model, Utils.Barbershop:Float(data.drawables.complexion.opacity))
        SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

        -- PELE
        SetPedHeadOverlay(ped, 7, data.drawables.sundamage.model, Utils.Barbershop:Float(data.drawables.sundamage.opacity))
        SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

        -- SARDAS
        SetPedHeadOverlay(ped, 9, data.drawables.freckles.model, Utils.Barbershop:Float(data.drawables.freckles.opacity))
        SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

        -- MAQUIAGEM
        SetPedHeadOverlay(ped, 4, data.drawables.makeup.model, Utils.Barbershop:Float(data.drawables.makeup.opacity))
        SetPedHeadOverlayColor(ped, 4, data.drawables.makeup.color_type, data.drawables.makeup.main_color, data.drawables.makeup.main_color)
    end

    cb('Ok')
end)

RegisterNUICallback('buyBarbershopCustomizations', function(data, cb)
    local ped = PlayerPedId()
    local oldCustom = LocalPlayer.state.pedCustom
    if (data.drawables and data.total > 0) then
        oldCustom.eyesColor = data.drawables.eyes.model
        oldCustom.eyebrowsModel = data.drawables.eyebrows.model
        oldCustom.eyebrowsColor = data.drawables.eyebrows.main_color
        oldCustom.eyebrowsOpacity = data.drawables.eyebrows.opacity
        oldCustom.hairModel = data.drawables.hair.model
        oldCustom.firstHairColor = data.drawables.hair.main_color
        oldCustom.secondHairColor = data.drawables.hair.secondary_color
        oldCustom.beardModel = data.drawables.beard.model
        oldCustom.beardColor = data.drawables.beard.main_color
        oldCustom.beardOpacity = data.drawables.beard.opacity
        oldCustom.chestModel = data.drawables.chestModel.model
        oldCustom.chestColor = data.drawables.chestModel.main_color
        oldCustom.chestOpacity = data.drawables.chestModel.opacity
        oldCustom.blushModel = data.drawables.blush.model
        oldCustom.blushColor = data.drawables.blush.main_color
        oldCustom.blushOpacity = data.drawables.blush.opacity
        oldCustom.lipstickModel = data.drawables.lipstick.model
        oldCustom.lipstickColor = data.drawables.lipstick.main_color
        oldCustom.lipstickOpacity = data.drawables.lipstick.opacity
        oldCustom.blemishesModel = data.drawables.blemishes.model
        oldCustom.blemishesOpacity = data.drawables.blemishes.opacity
        oldCustom.ageingModel = data.drawables.ageing.model
        oldCustom.ageingOpacity = data.drawables.ageing.opacity
        oldCustom.complexionModel = data.drawables.complexion.model
        oldCustom.complexionOpacity = data.drawables.complexion.opacity
        oldCustom.sundamageModel = data.drawables.sundamage.model
        oldCustom.sundamageOpacity = data.drawables.sundamage.opacity
        oldCustom.frecklesModel = data.drawables.freckles.model
        oldCustom.frecklesOpacity = data.drawables.freckles.opacity
        oldCustom.makeupModel = data.drawables.makeup.model
        oldCustom.makeupOpacity = data.drawables.makeup.opacity
        oldCustom.makeupColor = data.drawables.makeup.main_color
        oldCustom.makeupColorType = data.drawables.makeup.color_type

        if (vSERVER.tryPayment(data.total, oldCustom, 'barbershop')) then
            LocalPlayer.state.pedCustom = oldCustom
            setPedCustom()
        end
    end
    closeUi()
    setPedCustom() 

    cb('Ok')
end)
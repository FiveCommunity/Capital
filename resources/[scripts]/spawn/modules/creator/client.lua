local CurrentCharacter = Cache.Character
local CurrentIdentity = Cache.Identity

startCreation = function()
    setGender('male')
    local ped = PlayerPedId()
    
    Citizen.Wait(1500)
    Utils.Creator:Teleport(ConfigCreator.coords.creation.xyz)
    SetEntityHeading(ped, ConfigCreator.coords.creation.w)
    FreezeEntityPosition(ped, true)
    Citizen.Wait(1000)

    Citizen.Wait(1000)
    DoScreenFadeIn(500)
        
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'creator',
        data = {
            show = true,
            drawables = {
                bodyBlemishes = Utils.Creator:Decrease(GetNumHeadOverlayValues(11), 1),
                addBodyBlemishes = Utils.Creator:Decrease(GetNumHeadOverlayValues(12), 1),
                eyes = 31,
                eyebrows = Utils.Creator:Decrease(GetNumHeadOverlayValues(2), 1),
                complexion = Utils.Creator:Decrease(GetNumHeadOverlayValues(6), 1),
                sundamage = Utils.Creator:Decrease(GetNumHeadOverlayValues(7), 1),
                freckles = Utils.Creator:Decrease(GetNumHeadOverlayValues(9), 1),
                ageing = Utils.Creator:Decrease(GetNumHeadOverlayValues(3), 1),
                blemishes = Utils.Creator:Decrease(GetNumHeadOverlayValues(0), 1),
                hair = Utils.Creator:Decrease(GetNumberOfPedDrawableVariations(ped, 2), 1),
                beard = Utils.Creator:Decrease(GetNumHeadOverlayValues(1), 1),
                chestModel = Utils.Creator:Decrease(GetNumHeadOverlayValues(10), 1),
                blush = Utils.Creator:Decrease(GetNumHeadOverlayValues(5), 1),
                lipstick = Utils.Creator:Decrease(GetNumHeadOverlayValues(8), 1),
                makeup = Utils.Creator:Decrease(GetNumHeadOverlayValues(4), 1),
            }
        }
    })
end

setGender = function(gender)
    local ped = PlayerPedId()
    local model = (gender == 'female' and GetHashKey('mp_f_freemode_01') or GetHashKey('mp_m_freemode_01')) 
    
    if (Utils.Creator:RequestModel(model)) then
        ped = PlayerPedId()

        SetPedMaxHealth(ped, 200)
        SetEntityHealth(ped, GetEntityHealth(ped))
        SetPedArmour(ped, GetPedArmour(ped))

        SetPedHeadBlendData(ped, CurrentCharacter.fatherId, CurrentCharacter.motherId, 0, CurrentCharacter.colorMother, CurrentCharacter.colorFather, 0, CurrentCharacter.shapeMix, CurrentCharacter.skinMix, 0, false)
        Utils.Creator:SetClothes(ped, ConfigCreator.clothes[GetEntityModel(ped)])
    end
    
end

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNUICallback('ChangeCharacter', function(data, cb)
    local ped = PlayerPedId()

    -- [ Genética ] --

    CurrentIdentity.firstname = data.firstname
    CurrentIdentity.lastname = data.lastname
    CurrentIdentity.age = data.age

    if (CurrentCharacter.gender ~= data.gender) then
        CurrentCharacter.gender = data.gender
        setGender(CurrentCharacter.gender)
    end

    CurrentCharacter.fatherId = data.fatherId 
    CurrentCharacter.motherId = data.motherId
    CurrentCharacter.colorMother = data.colorMother
    CurrentCharacter.colorFather = data.colorFather
    CurrentCharacter.shapeMix = data.shapeMix 
    CurrentCharacter.skinMix = data.skinMix
    SetPedHeadBlendData(ped, CurrentCharacter.fatherId, CurrentCharacter.motherId, 0, CurrentCharacter.colorMother, CurrentCharacter.colorFather, 0, Utils.Creator:Float(CurrentCharacter.shapeMix), Utils.Creator:Float(CurrentCharacter.skinMix), 0, false)

    -- [ Pele ] --

    CurrentCharacter.addBodyBlemishes = data.addBodyBlemishes
    CurrentCharacter.bodyBlemishes = data.bodyBlemishes
    CurrentCharacter.bodyBlemishesOpacity = data.bodyBlemishesOpacity
    SetPedHeadOverlay(ped, 12, CurrentCharacter.addBodyBlemishes, Utils.Creator:Float(CurrentCharacter.bodyBlemishesOpacity))
    SetPedHeadOverlay(ped, 11, CurrentCharacter.bodyBlemishes, Utils.Creator:Float(CurrentCharacter.bodyBlemishesOpacity))

    -- [ Olhos ] --

    CurrentCharacter.eyesColor = data.eyesColor
    CurrentCharacter.eyesOpening = data.eyesOpening
    CurrentCharacter.eyebrowsHeight = data.eyebrowsHeight
    CurrentCharacter.eyebrowsWidth = data.eyebrowsWidth
    CurrentCharacter.eyebrowsModel = data.eyebrowsModel
    CurrentCharacter.eyebrowsOpacity = data.eyebrowsOpacity
    CurrentCharacter.eyebrowsColor = data.eyebrowsColor
    SetPedEyeColor(ped, CurrentCharacter.eyesColor)
    SetPedFaceFeature(ped, 11, Utils.Creator:Float(CurrentCharacter.eyesOpening))
    SetPedFaceFeature(ped, 6, Utils.Creator:Float(CurrentCharacter.eyebrowsHeight))
	SetPedFaceFeature(ped, 7, Utils.Creator:Float(CurrentCharacter.eyebrowsWidth))
    SetPedHeadOverlay(ped, 2, CurrentCharacter.eyebrowsModel, Utils.Creator:Float(CurrentCharacter.eyebrowsOpacity))
    SetPedHeadOverlayColor(ped, 2, 1, CurrentCharacter.eyebrowsColor, CurrentCharacter.eyebrowsColor)

    -- [ Nariz ] --

    CurrentCharacter.noseWidth = data.noseWidth 
    CurrentCharacter.noseHeight = data.noseHeight  
    CurrentCharacter.noseLength = data.noseLength  
    CurrentCharacter.noseBridge = data.noseBridge  
    CurrentCharacter.noseTip = data.noseTip  
    CurrentCharacter.noseShift = data.noseShift 
    SetPedFaceFeature(ped, 0, Utils.Creator:Float(CurrentCharacter.noseWidth))
    SetPedFaceFeature(ped, 1, Utils.Creator:Float(CurrentCharacter.noseHeight))
    SetPedFaceFeature(ped, 2, Utils.Creator:Float(CurrentCharacter.noseLength))
    SetPedFaceFeature(ped, 3, Utils.Creator:Float(CurrentCharacter.noseBridge))
    SetPedFaceFeature(ped, 4, Utils.Creator:Float(CurrentCharacter.noseTip))
    SetPedFaceFeature(ped, 5, Utils.Creator:Float(CurrentCharacter.noseShift))

    -- [ Queixo ] --

    CurrentCharacter.chinLength = data.chinLength
    CurrentCharacter.chinPosition = data.chinPosition
    CurrentCharacter.chinWidth = data.chinWidth
    CurrentCharacter.chinShape = data.chinShape
    CurrentCharacter.jawWidth = data.jawWidth
    CurrentCharacter.jawHeight = data.jawHeight
    SetPedFaceFeature(ped, 15, Utils.Creator:Float(CurrentCharacter.chinLength))
    SetPedFaceFeature(ped, 16, Utils.Creator:Float(CurrentCharacter.chinPosition))
    SetPedFaceFeature(ped, 17, Utils.Creator:Float(CurrentCharacter.chinWidth))
    SetPedFaceFeature(ped, 18, Utils.Creator:Float(CurrentCharacter.chinShape))     
    SetPedFaceFeature(ped, 13, Utils.Creator:Float(CurrentCharacter.jawWidth))
    SetPedFaceFeature(ped, 14, Utils.Creator:Float(CurrentCharacter.jawHeight))

    -- [ Bochecha ] --

    CurrentCharacter.cheekboneHeight = data.cheekboneHeight
    CurrentCharacter.cheekboneWidth = data.cheekboneWidth
    CurrentCharacter.cheeksWidth = data.cheeksWidth
    CurrentCharacter.lips = data.lips
    CurrentCharacter.neckWidth = data.neckWidth
    SetPedFaceFeature(ped, 8, Utils.Creator:Float(CurrentCharacter.cheekboneHeight))
    SetPedFaceFeature(ped, 9, Utils.Creator:Float(CurrentCharacter.cheekboneWidth))
    SetPedFaceFeature(ped, 10, Utils.Creator:Float(CurrentCharacter.cheeksWidth))
    SetPedFaceFeature(ped, 12, Utils.Creator:Float(CurrentCharacter.lips))
    SetPedFaceFeature(ped, 19, Utils.Creator:Float(CurrentCharacter.neckWidth))

    -- [ Aspecto ] --

    CurrentCharacter.complexionModel = data.complexionModel
    CurrentCharacter.complexionOpacity = data.complexionOpacity
    SetPedHeadOverlay(ped, 6, CurrentCharacter.complexionModel, Utils.Creator:Float(CurrentCharacter.complexionOpacity))
    SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

    CurrentCharacter.sundamageModel = data.sundamageModel
    CurrentCharacter.sundamageOpacity = data.sundamageOpacity
    SetPedHeadOverlay(ped, 7, CurrentCharacter.sundamageModel, Utils.Creator:Float(CurrentCharacter.sundamageOpacity))
    SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

    CurrentCharacter.frecklesModel = data.frecklesModel
    CurrentCharacter.frecklesOpacity = data.frecklesOpacity
    SetPedHeadOverlay(ped, 9, CurrentCharacter.frecklesModel, Utils.Creator:Float(CurrentCharacter.frecklesOpacity))
    SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

    CurrentCharacter.ageingModel = data.ageingModel
    CurrentCharacter.ageingOpacity = data.ageingOpacity
    SetPedHeadOverlay(ped, 3, CurrentCharacter.ageingModel, Utils.Creator:Float(CurrentCharacter.ageingOpacity))
    SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

    CurrentCharacter.blemishesModel = data.blemishesModel
    CurrentCharacter.blemishesOpacity = data.blemishesOpacity
    SetPedHeadOverlay(ped, 0, CurrentCharacter.blemishesModel, Utils.Creator:Float(CurrentCharacter.blemishesOpacity))
    SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

    -- [ Barbearia ] --

    CurrentCharacter.hairModel = data.hairModel
    CurrentCharacter.firstHairColor = data.firstHairColor
    CurrentCharacter.secondHairColor = data.secondHairColor
    SetPedComponentVariation(ped, 2, data.hairModel, 0, 0)
    SetPedHairColor(ped, CurrentCharacter.firstHairColor, CurrentCharacter.secondHairColor)

    CurrentCharacter.beardModel = data.beardModel
    CurrentCharacter.beardColor = data.beardColor
    CurrentCharacter.beardOpacity = data.beardOpacity
    SetPedHeadOverlay(ped, 1, CurrentCharacter.beardModel, Utils.Creator:Float(CurrentCharacter.beardOpacity))
    SetPedHeadOverlayColor(ped, 1, 1, CurrentCharacter.beardColor, CurrentCharacter.beardColor)

    CurrentCharacter.chestModel = data.chestModel
    CurrentCharacter.chestColor = data.chestColor
    CurrentCharacter.chestOpacity = data.chestOpacity
    SetPedHeadOverlay(ped, 10, CurrentCharacter.chestModel, Utils.Creator:Float(CurrentCharacter.chestOpacity))
    SetPedHeadOverlayColor(ped, 10, 1, CurrentCharacter.chestColor, CurrentCharacter.chestColor)

    CurrentCharacter.blushModel = data.blushModel
    CurrentCharacter.blushColor = data.blushColor
    CurrentCharacter.blushOpacity = data.blushOpacity
    SetPedHeadOverlay(ped, 5, CurrentCharacter.blushModel, Utils.Creator:Float(CurrentCharacter.blushOpacity))
    SetPedHeadOverlayColor(ped, 5, 2, CurrentCharacter.blushColor, CurrentCharacter.blushColor)

    CurrentCharacter.lipstickModel = data.lipstickModel
    CurrentCharacter.lipstickColor = data.lipstickColor
    CurrentCharacter.lipstickOpacity = data.lipstickOpacity
    SetPedHeadOverlay(ped, 8, CurrentCharacter.lipstickModel, Utils.Creator:Float(CurrentCharacter.lipstickOpacity))
    SetPedHeadOverlayColor(ped, 8, 2, CurrentCharacter.lipstickColor, CurrentCharacter.lipstickColor)

    CurrentCharacter.makeupModel = data.makeupModel
    CurrentCharacter.makeupOpacity = data.makeupOpacity
    CurrentCharacter.makeupColor = data.makeupColor
    CurrentCharacter.makeupColorType = data.makeupColorType
    SetPedHeadOverlay(ped, 4, CurrentCharacter.makeupModel, Utils.Creator:Float(CurrentCharacter.makeupOpacity))
    SetPedHeadOverlayColor(ped, 4, CurrentCharacter.makeupColorType, CurrentCharacter.makeupColor, CurrentCharacter.makeupColor)

    cb('Ok')
end)

RegisterNUICallback('Finish', function(data, cb)
    local ped = PlayerPedId()

    DoScreenFadeOut(500)
    Citizen.Wait(1000)

    SetNuiFocus(false, false)
    Utils.Cam:Destroy()
    vSERVER.finishCreation({ identity = CurrentIdentity, character = CurrentCharacter })
    Utils.Creator:Teleport(ConfigCreator.coords.finish.xyz)
    SetEntityHeading(ped, ConfigCreator.coords.finish.w)
    FreezeEntityPosition(ped, false)
    vSERVER.changeSession(0)
    Utils.Creator:SetClothes(ped, ConfigCreator.clothesFinish[GetEntityModel(ped)])

    Citizen.Wait(2000)
    DoScreenFadeIn(500)

    LocalPlayer.state.Hud = true

    cb('Ok')
end)

local Rotations = {
    left = function(ped)
        SetEntityHeading(ped, (GetEntityHeading(ped) - 10.0))
    end,
    right = function(ped)
        SetEntityHeading(ped, (GetEntityHeading(ped) + 10.0))
    end,
    up = function(ped)
        if (IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3)) then
            vRP.stopAnim(false)
        else
            vRP.playAnim(true, {
                { 'random@mugging3', 'handsup_standing_base' }
            }, true)
        end
    end
}

RegisterNUICallback('Rotation', function(data, cb)
    local ped = PlayerPedId()
    if (Rotations[data]) then Rotations[data](ped); end;

    cb('Ok')
end)

local Cams = {
    body = function()
        Utils.Cam:Create({ x = 0.0, y = 2.8, z = 1.2, fov = 35.0 }, { index = 21 }, false)
    end,
    head = function()
        Utils.Cam:Create({ x = 0.0, y = 2.0, z = 0.5, fov = 10.0 }, { index = 31086 }, false)
    end,
    eyes = function()
        Utils.Cam:Create({ x = 0.0, y = 1.0, z = 0.75, fov = 10.0 }, { index = 31086 }, false)
    end,
    mouth = function()
        Utils.Cam:Create({ x = 0.0, y = 0.8, z = 0.5, fov = 10.0 }, { index = 12844 }, false)
    end
}

RegisterNUICallback('Cam', function(data, cb)
    if (Cams[data]) and (Cache.Cam ~= data) then 
        Cache.Cam = data
        Cams[data]()
    end

    cb('Ok')
end)
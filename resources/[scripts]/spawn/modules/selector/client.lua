function selectorLoad()       
    Citizen.Wait(2000)
    vSERVER.changeSession()
    local getCharacters = vSERVER.getCharacters()
    if (#getCharacters.characters > 0) then
        startSelector(getCharacters)
    else
        startCreation()
    end
end

startSelector = function(table)
    Cache.Characters = table.characters

    Citizen.Wait(1500)
    Utils.Creator:Teleport(ConfigSelector.coords.selector.xyz)
    SetEntityHeading(PlayerPedId(), ConfigSelector.coords.selector.w)
    Citizen.Wait(1000)
    Utils.Cam:Create({ x = 0.0, y = 3.0, z = 0.3, fov = 50.0 }, { index = 21 }, false)


    Citizen.Wait(1000)
    DoScreenFadeIn(500)

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'selector',
        data = {
            show = true,
            maxChars = table.maxChars,
            characters = table.characters
        }
    })
end

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNUICallback('NewCharacter', function(data, cb)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)

    SetNuiFocus(false, false)
    Utils.Cam:Destroy()
    startCreation()

    cb('Ok')
end)

local SetCustomization = function(characterId)    
    local ped = PlayerPedId()

    local randomAnim = ConfigSelector.anims[math.random(#ConfigSelector.anims)]
    if (randomAnim) then
        vRP.playAnim(false, {
            { randomAnim.dict, randomAnim.idle }
        }, true)
    end

    local character = Cache.Characters[characterId]
    if (Utils.Creator:RequestModel(character.clothes.pedModel)) then
        ped = PlayerPedId()
        
        Utils.Creator:SetClothes(ped, character.clothes)
        exports.appearance:setPedCustom(character.customization)
        exports.appearance:setPedTattoos(character.tattoos)
    end
    
    -- exports.appearance:fixAppearance(ped,character.customization)
end

RegisterNUICallback('SwitchCharacter', function(data, cb)
    SetCustomization(data)
    
    cb('Ok')
end)

RegisterNUICallback('Play', function(data, cb)
    vSERVER.chooseCharacter(data)

    cb('Ok')
end)

----------------------------------------------------------------
-- State Bag's
----------------------------------------------------------------
AddStateBagChangeHandler('resetAppearance', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) or (not value) then return; end;

    LocalPlayer.state.Hud = false
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    startCreation()
end)
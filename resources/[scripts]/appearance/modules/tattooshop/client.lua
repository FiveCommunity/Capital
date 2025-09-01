local getTattoos = function(_tattoos, model)
    local ped = PlayerPedId()
    local custom = LocalPlayer.state.pedTattoo
    local pedTattoos = {
        [GetHashKey('mp_m_freemode_01')] = {
            { part = _tattoos.male.torso.tattoo, model = (custom['0'] or {}), type = 'torso' },
            { part = _tattoos.male.head.tattoo, model = (custom['1'] or {}), type = 'head' },
            { part = _tattoos.male.leftarm.tattoo, model = (custom['2'] or {}), type = 'leftarm' },
            { part = _tattoos.male.rightarm.tattoo, model = (custom['3'] or {}), type = 'rightarm' },
            { part = _tattoos.male.leftleg.tattoo, model = (custom['4'] or {}), type = 'leftleg' },
            { part = _tattoos.male.rightleg.tattoo, model = (custom['5'] or {}), type = 'rightleg' },
            { part = _tattoos.male.overlay.tattoo, model = (custom['6'] or {}), type = 'overlay' },
        },
        [GetHashKey('mp_f_freemode_01')] = {
            { part = _tattoos.female.torso.tattoo, model = (custom['0'] or {}), type = 'torso' },
            { part = _tattoos.female.head.tattoo, model = (custom['1'] or {}), type = 'head' },
            { part = _tattoos.female.leftarm.tattoo, model = (custom['2'] or {}), type = 'leftarm' },
            { part = _tattoos.female.rightarm.tattoo, model = (custom['3'] or {}), type = 'rightarm' },
            { part = _tattoos.female.leftleg.tattoo, model = (custom['4'] or {}), type = 'leftleg' },
            { part = _tattoos.female.rightleg.tattoo, model = (custom['5'] or {}), type = 'rightleg' },
            { part = _tattoos.female.overlay.tattoo, model = (custom['6'] or {}), type = 'overlay' },
        }
    }
    return pedTattoos[model]
end

openTattooShop = function(locs)
    local location = configLocs[locs]
    local general = configGeneral[location.type][location.config]

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    if (model ~= GetHashKey('mp_m_freemode_01') and model ~= GetHashKey('mp_f_freemode_01')) then return; end;

    LocalPlayer.state.Hud = false
    LocalPlayer.state.inAppearance = true
    LocalPlayer.state.pedTattoo = vSERVER.getTattoos()
    Cache.oldHeading = GetEntityHeading(ped)
    oldCustom = vRP.getCustomization()

    SetNuiFocus(true, true)

    Citizen.Wait(500)
    
	ClearPedTasksImmediately(ped)
    setPlayersVisible(false)

    if (general.clothes) then Utils.Skinshop:SetClothes(ped, general.clothes[model]); end;

    Cams['body']()

    local tattoos = getTattoos(general.shopConfig, model)
    SendNUIMessage({ 
        action = 'openTattooShop', 
        data = {
            drawables = tattoos, 
            sex = (model == GetHashKey('mp_m_freemode_01') and 'male' or 'female'), 
        }
    })
end

setPedTattoos = function(data)
    Citizen.Wait(100)
    local ped = PlayerPedId()
    local data = (data and data or LocalPlayer.state.pedTattoo)

    if (data) then
        ClearPedDecorations(ped)
        for _, table in pairs(data) do
            for _, v in pairs(table) do
                AddPedDecorationFromHashes(ped, GetHashKey(v.part), GetHashKey(v.name))
            end
        end
    end
end
exports('setPedTattoos', setPedTattoos)

RegisterNetEvent('gb:tattooUpdate', function()
    if (LocalPlayer.state.pedTattoo == nil) then 
        LocalPlayer.state.pedTattoo = vSERVER.getTattoos()      
        setPedTattoos()
    else 
        setPedTattoos()
    end
end)

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNUICallback('changeTattooDemo', function(data, cb)
    local ped = PlayerPedId()
    if (data.drawables) then
        ClearPedDecorations(ped)
        for _, table in pairs(data.drawables) do
            for _, v in pairs(table) do
                AddPedDecorationFromHashes(ped, GetHashKey(v.part), GetHashKey(v.name))
            end
        end
    end

    cb('Ok')
end)

RegisterNUICallback('buyTattooshopCustomizations', function(data, cb)
    local ped = PlayerPedId()
    local Drawables = data.drawables
    if (Drawables) then
        if (vSERVER.tryPayment(data.total, Drawables, 'tattooshop')) then
            LocalPlayer.state.pedTattoo = Drawables
            setPedTattoos()
        end
    end
    closeUi()
    setPedTattoos() 

    cb('Ok')
end)
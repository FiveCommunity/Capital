--====================================================================================
-- Variaveis
--====================================================================================

isReady = false;
ply, plyCoords = nil, vec3(0,0,0)
currentHome = { inside = false }
lastHome = nil
presets = {}

--====================================================================================

RegisterNetEvent('homes:ready', function() print('^1[Homes]^7 ready.'); isReady = true; end)

Citizen.CreateThread(function()
    while (not isReady) do Citizen.Wait(100); end;

    local nearestHomes = {}

    local threadStarted;
    local startThread = function()
        if (threadStarted) then return; end;
        threadStarted = true

        Citizen.CreateThread(function()
            while (#nearestHomes > 0) do
                for _, data in pairs(nearestHomes) do
                    local coord = configHomes[data.key].coord
                    local type = configHomes[data.key].type
                    DrawMarker3D(coord, '~b~['..data.key:upper()..']~w~\n~b~E~w~ - ENTRAR'..((not buyeds[data.key] or type == 'apartament') and '\n~b~G~w~ - VISITAR' or ''))

                    if (data.dist <= 0.5) then
                        if (IsControlJustPressed(0, 38)) and interactionVerification(ply) then
                            lastHome = data.key
                            vSERVER.tryEnterInHome(data.key, (type == 'apartament' and 'apartament' or 'home'))
                        elseif (IsControlJustPressed(0, 47) and not buyeds[data.key]) and interactionVerification(ply) then
                            vSERVER.visitHome(data.key)
                        end
                    end
                end
                Citizen.Wait(5)
            end
            threadStarted = false
        end)
    end 
    
    while (true) do
        ply = PlayerPedId()
        plyCoords = GetEntityCoords(ply)
        
        nearestHomes = {}
        for key, values in pairs(configHomes) do
            local dist = #(plyCoords - values.coord)
            if (dist <= 2) and (values.type ~= 'mlo') then 
                nearestHomes[#nearestHomes+1] = { key = key, dist = dist }
            end
        end

        if (#nearestHomes > 0) then
            startThread()
        end 

        Citizen.Wait(500)
    end
end)

local loadInterior = function(data, decoration)
    if (data.interiorId) and data.interiorId > 0 then
        currentHome.interiorId = data.interiorId
        SetInteriorActive(currentHome.interiorId, true)
    end

    if (decoration) and decoration ~= 0 then
        local dataDecorations = data.decorations[decoration]

        if (dataDecorations.interiorId) and dataDecorations.interiorId > 0 then
            currentHome.decorationId = dataDecorations.interiorId
            SetInteriorActive(currentHome.decorationId, true)
        end

        if (dataDecorations.ipls) then
            currentHome.ipls = dataDecorations.ipls
            for _, ipl in ipairs(dataDecorations.ipls) do
                if (ipl:sub(1, 1) == '-') then
                    RemoveIpl(ipl:sub(2))
                else    
                    RequestIpl(ipl)
                end
            end
        end
    end
end

local unloadInterior = function()
    if (currentHome.interiorId) then SetInteriorActive(currentHome.interiorId, false); end;
    if (currentHome.decorationId) then SetInteriorActive(currentHome.decorationId, false); end;

    if (currentHome.ipls) then
        for _, ipl in ipairs(currentHome.ipls) do
            if (ipl:sub(1, 1) == '-') then
                RemoveIpl(ipl:sub(2))
            else    
                RemoveIpl(ipl)
            end
        end
        RequestIpl('apa_v_mp_h_01_a')
    end
end

local insideThread = function(dataInterior, view)
    if (dataInterior.action) then dataInterior.action(); end;

    if (not view) then
        local methods = {
            ['exit'] = function()
                exitTheHouse()
            end,

            ['vault'] = function()
                vSERVER.openVault(currentHome.name)
            end,

            ['fridge'] = function()
                vSERVER.openFridge(currentHome.name)
            end,

            ['wardrobe'] = function()
                presets = vSERVER.Outfit(lastHome, 'get_outfit')

                SetNuiFocus(true, true)
                SendNUIMessage({
                    action = 'wardrobe',
                    data = { presets = presets }
                }) 
            end
        }

        Citizen.CreateThread(function()
            while (currentHome.inside) do
                for method, coords in pairs(currentHome.internLocates) do
                    local dist = #(plyCoords - coords)
                    if (dist <= 10.0) then
                        DrawMarker(0, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 3, 187, 232, 155, 1, 0, 0, 1)

                        if (dist <= 1.2 and IsControlJustPressed(0, 38)) and (GetEntityHealth(ply) > 100) then
                            if (methods[method]) then methods[method](); end;
                        end
                    end
                end
                Citizen.Wait(5)
            end
        end) 
    end   
end

cli.enterInHome = function(name, interior, decoration, visit)
    local dataInterior = configInterior[interior]
    if (dataInterior) then
        currentHome.inside = true
        currentHome.name = name

        loadInterior(dataInterior, decoration)
        currentHome.internLocates = {
            ['exit'] = dataInterior.door.xyz,
            ['vault'] = (not visit and dataInterior.vault or vector3(0,0,0)),
            ['fridge'] = (not visit and dataInterior.fridge or vector3(0,0,0)),
            ['wardrobe'] = (not visit and dataInterior.wardrobe or vector3(0,0,0))
        }

        vRP.playAnim(true, { 'anim@heists@keycard@', 'exit' }, false)
        TriggerEvent('vrp_sounds:source', 'enterexithouse', 0.7)
        vSERVER.setBucket(currentHome.name, true)

        Citizen.Wait(400)
        LocalPlayer.state.Hud = false
        DoScreenFadeOut(500)
        Citizen.Wait(500)

        StartPlayerTeleport(PlayerId(), dataInterior.door.x, dataInterior.door.y, dataInterior.door.z, dataInterior.door.w, false, true, true)
        while (IsPlayerTeleportActive()) do Citizen.Wait(100); end;

        DoScreenFadeIn(500)
        LocalPlayer.state.Hud = true

        insideThread(dataInterior)
    end
end

cli.previewInterior = function(interior, decoration)
    local dataInterior = configInterior[interior]
    if (dataInterior) then
        currentHome.inside = true
        currentHome.name = 'VIEWER'

        loadInterior(dataInterior, decoration)
        vSERVER.setBucket(currentHome.name, true)

        Citizen.Wait(400)
        LocalPlayer.state.Hud = false
        DoScreenFadeOut(500)
        Citizen.Wait(500)

        StartPlayerTeleport(PlayerId(), dataInterior.door.x, dataInterior.door.y, dataInterior.door.z, dataInterior.door.w, false, true, true)
        while (IsPlayerTeleportActive()) do Citizen.Wait(100); end;

        DoScreenFadeIn(500)
        LocalPlayer.state.Hud = true

        insideThread(dataInterior, true)

        -- [ Exit ] --

        local secs = config.previewInterior
        TriggerEvent('notify', 'aviso', 'Residências', 'Pré-visualização do interior ativada por <b>'..secs..' segundos</b>.')
        TriggerEvent('ProgressBar', (secs*1000))
        
        Citizen.Wait((secs*1000))

        LocalPlayer.state.Hud = false
        DoScreenFadeOut(100)
        Citizen.Wait(500)

        unloadInterior()
        vSERVER.setBucket()
        vSERVER.resetCache()
        
        currentHome = { inside = false }

        DoScreenFadeIn(500)
        LocalPlayer.state.Hud = true
    end
end

cli.openNui = function(ownerConsult, name)
    if (not ownerConsult) then ownerConsult = { false, false }
    else ownerConsult = { true, ownerConsult.home } end

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        data = {
            haveApartament = ownerConsult,
            apartament = name
        }
    })
end

exitTheHouse = function()
    vRP.playAnim(true, { 'anim@heists@keycard@', 'exit' }, false)
    TriggerEvent('vrp_sounds:source', 'enterexithouse', 0.7)

    Citizen.Wait(400)
    LocalPlayer.state.Hud = false
    DoScreenFadeOut(100)
    Citizen.Wait(500)

    unloadInterior()
    vSERVER.setBucket()
    vSERVER.resetCache()
    
    currentHome = { inside = false }

    DoScreenFadeIn(500)
    LocalPlayer.state.Hud = true
end
cli.exitTheHouse = exitTheHouse

cli.insideHome = insideHome

cli.createGarage = function(homeCoords)
    local creation = { finished = false, step = 1, blip = vector3(0.0,0.0,0.0), spawn = vector4(0.0,0.0,0.0,0.0) }

    local steps = {
        [1] = function()
            drawTxt('PRESSIONE ~b~E~w~ PARA REGISTRAR O ~b~TABLET~w~', 2, 0.5, 0.9, 0.5, 255, 255, 255, 255)
            DrawMarker(36, plyCoords.x, plyCoords.y, plyCoords.z, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 3, 187, 232, 155, 1, 0, 0, 1)
            DrawMarker(27, plyCoords.x, plyCoords.y, plyCoords.z-0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 3, 187, 232, 155, 0, 0, 0, 1)
        
            if (IsControlJustPressed(0, 38)) then
                creation.step = 2
                creation.blip = plyCoords
            end
        end,
        [2] = function()
            local pRotation = GetEntityRotation(ply)
            drawTxt('PRESSIONE ~b~E~w~ PARA REGISTRAR O ~b~SPAWN DO VEICULO~w~', 2, 0.5, 0.9, 0.5, 255, 255, 255, 255)
            DrawMarker(26, plyCoords.x, plyCoords.y, plyCoords.z, 0, 0, 0, pRotation.x, pRotation.y, pRotation.z, 1.0, 1.0, 1.0, 3, 187, 232, 155, 0 , 0, 0, 0)

            if (IsControlJustPressed(0, 38)) then
                creation.step = 0
                creation.finished = true
                creation.spawn = vector4(plyCoords, GetEntityHeading(ply))
            end
        end
    }

    while (creation.step > 0) do
        ply = PlayerPedId()
        plyCoords = GetEntityCoords(ply)

        local dist = #(plyCoords - homeCoords)
        if (dist <= 50) then
            steps[creation.step]()
        else
            creation.step = 0
            TriggerEvent('notify', 'Residências', 'Você saiu do raio máximo permitido de sua <b>residência</b>.')
        end

        if (GetEntityHealth(ply) <= 100) then break; end;
        Citizen.Wait(4)
    end

    return creation.finished, { blip = creation.blip, spawn = creation.spawn }
end

cli.previewGarage = function(spawn)
    local secs = config.previewGarage
    
    TriggerEvent('notify', 'aviso', 'Residências', 'Pré-visualização da garagem ativada por <b>'..secs..' segundos</b>.')
    TriggerEvent('ProgressBar', (secs*1000))

    local model = GetHashKey('dilettante')

    RequestModel(model)
    while (not HasModelLoaded(model)) do Citizen.Wait(50); end;

    veh = CreateVehicle(model, spawn)
    SetModelAsNoLongerNeeded(model)
    FreezeEntityPosition(veh, true)
    SetVehicleDoorsLocked(veh, 2)
    SetEntityAlpha(veh, 180)

    Citizen.Wait((secs*1000))

    DeleteEntity(veh)
    return true
end

cli.getPreset = function() return exports.dynamic:getPreset(); end;

--====================================================================================
-- Callback's
--====================================================================================
local closeUi = function()
    SetNuiFocus(false, false)
end

RegisterNUICallback('myApartament', function(data, cb)
    closeUi()
    vSERVER.tryEnterInHome(data, 'join_apartament')

    cb('Ok')
end)

RegisterNUICallback('buyApartament', function(data, cb)
    closeUi()
    vSERVER.tryEnterInHome(data, 'buy_apartament')

    cb('Ok')
end)

RegisterNUICallback('otherApartament', function(data, cb)
    closeUi()
    vSERVER.tryEnterInHome(lastHome, 'intercom')

    cb('Ok')
end)

RegisterNUICallback('outfit', function(data, cb)
    closeUi()
    vSERVER.Outfit(lastHome, data)

    cb('Ok')
end)

RegisterNUICallback('setOutfit', function(data, cb)
    closeUi()

    local data = presets[data]
    if (data) and data.preset then
        for i = 0, 7 do
            ClearPedProp(ply, i)
        end

        SetPedComponentVariation(ply, 10, -1, 0, 0)

        for k, v in pairs(data.preset) do
            local isProp, index = exports.vrp:parsePart(k)
            if (isProp) then
                if (v.model < 0) then
                    ClearPedProp(ped,index)
                else
                    SetPedPropIndex(ply, index, v.model, v.var, 0)
                end
            else
                SetPedComponentVariation(ply, parseInt(k), v.model, v.var,  0)
            end
        end
        TriggerEvent('gb:barberUpdate')
        TriggerEvent('gb:tattooUpdate')
    end

    cb('Ok')
end)

RegisterNUICallback('close', function(data, cb)
    closeUi()

    cb('Ok')
end)
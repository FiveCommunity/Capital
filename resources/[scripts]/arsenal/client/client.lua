vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local arsenalConfig = config.arsenal
local locsConfig = config.locs
local attachsConfig = config.attachs
local trainingConfig = config.training

local GetIntFromBlob = function(b, s, o)
	r = 0
	for i = 1, s, 1 do
		r = r | (string.byte(b, o + i) << (i - 1) * 8)
	end
	return r
end

GetWeaponHudStats = function(weaponHash)
	blob = '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'
    local weaponInfos = {
        retval = Citizen.InvokeNative(0xD92C739EE34C9EBA, weaponHash, blob, Citizen.ReturnResultAnyway()),
        damage = GetIntFromBlob(blob, 8, 0),
        hudSpeed = GetIntFromBlob(blob, 8, 8),
        capacity = GetIntFromBlob(blob, 8, 16),
        accuracy = GetIntFromBlob(blob, 8, 24),
        range = GetIntFromBlob(blob, 8, 32)
    }
	return weaponInfos
end

local camCoords = nil
local camRotation = nil
local cam = nil

local pedList = {}

local createNPC = function()
    local pedInfo = {}
    for index, value in pairs(locsConfig) do
        entityHash = GetHashKey(value['ped']['skin'])

        RequestModel(entityHash)
		while not HasModelLoaded(entityHash) do Citizen.Wait(1) end

        entity = CreatePed(4, value['ped']['skin'], value['ped']['coord']['x'], value['ped']['coord']['y'], value['ped']['coord']['z']-1, value['ped']['coord']['w'], false, false)
        FreezeEntityPosition(entity, true)
        SetEntityInvincible(entity, true)
        SetBlockingOfNonTemporaryEvents(entity, true)
        SetModelAsNoLongerNeeded(entityHash)
        Entity(entity).state:set('scenario', true, true)

        local entityCoords = GetEntityCoords(entity)
        local x, y, z = (entityCoords['x'] + GetEntityForwardX(entity) * 1.2), (entityCoords['y'] + GetEntityForwardY(entity) * 1.2), (entityCoords['z'] + 0.52)
        
        camCoords = vector3(x, y, z)
        camRotation = (GetEntityRotation(entity, 2) + vector3(0.0, 0.0, 181))

        pedInfo = {
            model = value['ped']['skin'],
            entityCoords = value['ped']['coord']['xyz'],
            entity = entity,
            camCoords = camCoords,
			camRotation = camRotation,
        }

        table.insert(pedList, pedInfo)
    end
end

local hidden = false
local startCam = function(coords, model)
    ClearFocus()

    hidden = true
    hidePlayer()
    
    for index, value in pairs(pedList) do
        if (value['entityCoords'] == coords) then
            if (value['model'] == model) then
                rotation = value['camRotation']
                coords = value['camCoords']
            end
        end
    end

    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords, rotation, GetGameplayCamFov())

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, false)
end

local endCam = function()
    ClearFocus()
    RenderScriptCams(false, true, 1000, true, false)
	DestroyCam(cam, false)
    hidden = false

	cam = nil
end

hidePlayer = function()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        while (hidden) do
            SetEntityLocallyInvisible(ped)
            Citizen.Wait(1)
        end
        SetEntityLocallyVisible(ped)
    end)
end

local gunList = {}
local utilitaryList = {}
local kitList = {}

local inArsenal = false
local nui = false
local nearestBlip = {}

local needLoadScript = true

local checkNui = function(coords)
	Citizen.CreateThread(function()
		while (nui) do
			if #(GetEntityCoords(PlayerPedId()) - coords) > 1.5 then
                SendNUIMessage({ action = 'close' })
			end
			Citizen.Wait(1000)
		end
	end)
end



local renderWeapons = function(config)
    print('[ARSENAL] Loading weapons...')
    local configuration = config

    local permCache = {}
    
    gunList[configuration] = {}
    utilitaryList[configuration] = {}
    kitList[configuration] = {}

    local weapons = arsenalConfig[configuration]['weapons']
    for _, value in ipairs(weapons) do
        local perm = (value['perm'] or false)
        local permEntry = permCache[perm]
        if (not permEntry) then
            permEntry = { perm = { vSERVER.checkPermissions(perm), vSERVER.getGroupTitle(perm) } }
            permCache[perm] = permEntry
        end

        local weaponEntry = {
            spawn = value['spawn'],
            name = value['name'],
            infos = GetWeaponHudStats(GetHashKey(value['spawn'])),
            ammo = value['ammo'],
            perm = permEntry.perm,
            price = value['price']
        }
        table.insert(gunList[configuration], weaponEntry)
    end

    local utilitarys = arsenalConfig[configuration]['utilitarys']
    for _, value in ipairs(utilitarys) do
        local perm = (value['perm'] or false)
        local permEntry = permCache[perm]
        if (not permEntry) then
            permEntry = { perm = { vSERVER.checkPermissions(perm), vSERVER.getGroupTitle(perm) } }
            permCache[perm] = permEntry
        end

        local utilitaryEntry = {
            type = value['type'],
            spawn = value['spawn'],
            name = value['name'],
            quantity = value['quantity'],
            ammo = value['ammo'],
            perm = permEntry.perm,
            price = value['price'],
            infinityBuy = value.infinityBuy,
            noCooldown = value.noCooldown
        }
        table.insert(utilitaryList[configuration], utilitaryEntry)
    end

    local kits = arsenalConfig[configuration]['kits']
    for index, value in ipairs(kits) do
        local perm = (value['perm'] or false)
        local permEntry = permCache[perm]
        if (not permEntry) then
            permEntry = { perm = { vSERVER.checkPermissions(perm), vSERVER.getGroupTitle(perm) } }
            permCache[perm] = permEntry
        end

        local kitsEntry = {
            index = index,
            name = value['name'],
            itens = value['itens'],
            perm = permEntry.perm,
            price = value['price']
        }
        table.insert(kitList[configuration], kitsEntry)
    end
end

local setAttachs = function()
    local attachs = attachsConfig[nearestBlip['config']]['weapons']
    for k, v in pairs(getWeapons()) do
        local weapon = k
        if (attachs[weapon]) then
            for i = 1, #attachs[weapon]['components'] do
                GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(weapon), GetHashKey(attachs[weapon]['components'][i]))
                i = i + 1
            end
        end
    end
    clientNotify(config.texts['setAttachs'])
end

Citizen.CreateThread(function()
    print('[ARSENAL] Creating npcs...')
    createNPC()

    print('[ARSENAL] Creating thread...')
    while true do
        if not (inArsenal and not nui) then
            local pedCoord = GetEntityCoords(PlayerPedId())
            if (nearestBlip) and nearestBlip['coord'] then
                local distance = #(pedCoord - nearestBlip['coord'])
                if (distance >= 6.0) then
                    nearestBlip = false
                elseif (distance <= 1.2) then
                    nearestBlip['close'] = true
                else
                    nearestBlip['close'] = false
                end
            else
                for k, v in pairs(locsConfig) do
                    local distance = #(pedCoord - v['coord'])
                    if (distance <= 5.0) then
                        nearestBlip = locsConfig[k]
                    end
                end
            end
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        local idle = 500
        local ped = PlayerPedId()
        if not (inArsenal and not nui) then
            if (nearestBlip) and nearestBlip['coord'] then
                idle = 4
                threadMarker(nearestBlip)
                if (nearestBlip['close'] and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped) and vSERVER.checkPermissions(nearestBlip.perm)) then
                    openArsenal()
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

openArsenal = function()
    nui = true
    inArsenal = true
    
    openFunction()
    
    --vSERVER.changeSession(PlayerPedId())

    startCam(nearestBlip['ped']['coord']['xyz'], nearestBlip['ped']['skin'])
    SetNuiFocus(true, true)
    if (needLoadScript) then SendNUIMessage({ action = 'loading', user = vSERVER.getIdentity() }) needLoadScript = false end
    renderWeapons(nearestBlip['config'])

    local arsenalConfiguration = arsenalConfig[nearestBlip['config']]
    local attachsConfiguration = attachsConfig[nearestBlip['config']]
    local trainingConfiguration = trainingConfig[nearestBlip['config']]
    
    SendNUIMessage({
        action = 'open',
        attachs = { attachsConfiguration['active'], vSERVER.checkPermissions(attachsConfiguration['perm']) },
        training = { trainingConfiguration['active'], vSERVER.checkPermissions(trainingConfiguration['perm']) },
        title = { arsenalConfiguration['name'], arsenalConfiguration['description'] },
        weapons = { gunList[nearestBlip['config']], arsenalConfiguration['weapons']['cooldownWeapons'] },
        utilitary = { utilitaryList[nearestBlip['config']], arsenalConfiguration['utilitarys']['cooldownUtilitarys'] },
        kit = { kitList[nearestBlip['config']], arsenalConfiguration['kits']['cooldownKits'] },
        extraAmmo = { arsenalConfiguration['canExtraAmmo']['active'], vSERVER.checkPermissions(arsenalConfiguration['canExtraAmmo']['perm']), arsenalConfiguration['canExtraAmmo']['quantity']['min'], arsenalConfiguration['canExtraAmmo']['quantity']['max'] }
    })

    checkNui(GetEntityCoords(PlayerPedId()))
end

closeArsenal = function()
    nui = false
    inArsenal = false
    endCam()
	SetNuiFocus(false, false)
    closeFunction()
    vSERVER.changeSession(0)
end

RegisterNetEvent('notifyArsenal', function(message, delay)
    SendNUIMessage({
        action = 'notifyArsenal',
        message = message,
        delay = (delay or 5000)
    })
end)

RegisterNUICallback('equipar-arma', function(data, cb)
    vSERVER.giveWeapon(data['selectWeapon'], arsenalConfig[nearestBlip['config']])
end)

RegisterNUICallback('equipar-utilitario', function(data, cb)
    vSERVER.giveUtilitary(data['selectUtilitary'], arsenalConfig[nearestBlip['config']])
end)

RegisterNUICallback('equipar-kit', function(data, cb)
    vSERVER.giveKits(data['selectKits'], arsenalConfig[nearestBlip['config']])
end)

RegisterNUICallback('municao', function(data, cb)
    vSERVER.giveAmmo(data['extraAmmo'], data['selectWeapon'], arsenalConfig[nearestBlip['config']])
end)

RegisterNUICallback('clear', function()
    vSERVER.clearWeapons()
end)

RegisterNUICallback('attachs', function()
    setAttachs()
end)

RegisterNUICallback('close', function()
    closeArsenal()
end)

RegisterNUICallback('treino', function()
    closeArsenal()
    startTraining()
end)
---------------------------------------------------------------------------------------------------------
-- TREINO
---------------------------------------------------------------------------------------------------------

local inTraining = false
local object = nil

local targetSpawn = function(coords)
    local x, y, z = coords['x'], coords['y'], coords['z']
    local model = GetHashKey('prop_range_target_01')

    RequestModel(model)
    while (not HasModelLoaded(model)) do Citizen.Wait(1) end

    object = CreateObject(model, x, y, z, false, false, true)
    local rotation = -90

    SetEntityProofs(object, false, true, false, false, false, false, 0, false)
    SetEntityRotation(object, (GetEntityRotation(object) + vector3(-90, 0.0, 0)))
    PlaySoundFrontend(-1, 'SHOOTING_RANGE_ROUND_OVER', 'HUD_AWARDS', 1)
    
    while (rotation ~= 0) do
        SetEntityRotation(object, (GetEntityRotation(object) + vector3(9, 0.0, 0)))
        rotation = rotation + 9
        Citizen.Wait(1)
    end

    DeleteEntity(object)

    object = CreateObject(model, x, y, z, false, false, true)
end

local trainingCoords = vector4(821.71, -2163.77, 29.66, 172.91339111328)

local targetsCoord = {
    -- FRENTE
    vector2(827.5693, -2171.331),
    vector2(826.5693, -2171.331),
    vector2(825.5693, -2171.331),
    vector2(824.5693, -2171.331),
    vector2(823.5693, -2171.331),
    vector2(822.5693, -2171.331),
    vector2(821.5693, -2171.331),
    vector2(820.5693, -2171.331),
    vector2(819.5693, -2171.331),
    vector2(818.5693, -2171.331),
    vector2(817.5693, -2171.331),
    vector2(816.5693, -2171.331),
    vector2(815.5693, -2171.331),

    -- MEIO
    vector2(827.5693, -2180.5),
    vector2(826.5693, -2180.5),
    vector2(825.5693, -2180.5),
    vector2(824.5693, -2180.5),
    vector2(823.5693, -2180.5),
    vector2(822.5693, -2180.5),
    vector2(821.5693, -2180.5),
    vector2(820.5693, -2180.5),
    vector2(819.5693, -2180.5),
    vector2(818.5693, -2180.5),
    vector2(817.5693, -2180.5),
    vector2(816.5693, -2180.5),
    vector2(815.5693, -2180.5),

    -- FIM
    vector2(827.5693, -2191.6),
    vector2(826.5693, -2191.6),
    vector2(825.5693, -2191.6),
    vector2(824.5693, -2191.6),
    vector2(823.5693, -2191.6),
    vector2(822.5693, -2191.6),
    vector2(821.5693, -2191.6),
    vector2(820.5693, -2191.6),
    vector2(819.5693, -2191.6),
    vector2(818.5693, -2191.6),
    vector2(817.5693, -2191.6),
    vector2(816.5693, -2191.6),
    vector2(815.5693, -2191.6),
}

isMale = function(ped)
    if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
        return true
    elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
        return false
    end
end

startTraining = function()
    local ped = PlayerPedId()
    local score = 0
    local shot = 0

    inTraining = true

    DoScreenFadeOut(2000)
    Citizen.Wait(4000)

    if isMale(ped) then
        SetPedPropIndex(ped, 0, 0, 0, true)
        SetPedPropIndex(ped, 1, 15, 0, true)
    else
        SetPedPropIndex(ped, 0, 0, 0, true)
        SetPedPropIndex(ped, 1, 25, 0, true)
    end

    vSERVER.changeSession(ped)
    vSERVER.saveCoords()
    SetEntityHeading(ped, trainingCoords['w'])
    SetEntityCoordsNoOffset(ped, trainingCoords['x'], trainingCoords['y'], trainingCoords['z'], 0)
    TriggerEvent('cancelando', true)
    FreezeEntityPosition(ped, true)
    RequestAnimDict('anim@deathmatch_intros@1hmale')
    while (not HasAnimDictLoaded('anim@deathmatch_intros@1hmale')) do Citizen.Wait(0) end
    TaskPlayAnim(ped, 'anim@deathmatch_intros@1hmale', 'intro_male_1h_d_trevor', 8.0, 5.0, -1, true, 1, 0, 0, 0)
    DoScreenFadeIn(2000)
    
    Citizen.Wait(8000)

    TriggerEvent('cancelando', false)
    ClearPedTasks(ped)
    RemoveAnimDict('anim@deathmatch_intros@1hmale')

    while (not IsControlJustPressed(0, 38)) do
        SendNUIMessage({ action = 'training', start = true })
        Citizen.Wait(1)
    end
    
    targetSpawn(vector3(821.5693, -2171.331, 29.45))
    SetPedInfiniteAmmo(ped, true)
    while (shot < 30 and not IsControlJustPressed(0, 303)) do
        local pCoord = GetEntityCoords(ped)
        local spawnRandom = targetsCoord[math.random(#targetsCoord)]

        RefillAmmoInstantly(ped)
        
        if (IsPedShooting(ped)) then
            Citizen.Wait(100)
            if (HasEntityBeenDamagedByWeapon(object, 0, 2)) then
                PlaySoundFrontend(-1, 'HACKING_SUCCESS', 0, 1)
                DeleteObject(object)
                targetSpawn(vector3(spawnRandom['x'], spawnRandom['y'], 29.45))
                ClearEntityLastDamageEntity(object)
                score = parseInt(score + 1)
                shot = shot + 1
            elseif (not HasEntityBeenDamagedByWeapon(object, 0, 2)) then
                PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 1)
                shot = shot + 1
            end
        end
        SendNUIMessage({ action = 'training', shots = true, score = score, shot = shot })
        Citizen.Wait(1)
    end
    DeleteObject(object)
    SetPedInfiniteAmmo(ped, false)
    SendNUIMessage({ action = 'training', close = true })

    DoScreenFadeOut(2000)
    Citizen.Wait(4000)
    FreezeEntityPosition(ped, false)
    vSERVER.setOldCoords()
    DoScreenFadeIn(2000)
    Citizen.Wait(4000)
end
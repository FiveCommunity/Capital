local vSERVER = Tunnel.getInterface('NpcWeapons')

local function isPedValid(npc)
    return npc ~= PlayerPedId() and
           not IsPedAPlayer(npc) and
           not IsEntityDead(npc) and
           not IsPedDeadOrDying(npc) and
           not IsPedInAnyVehicle(npc) and
           GetPedArmour(npc) <= 0 and
           GetPedType(npc) ~= 28
end

local function findClosestPed(distance)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    for _, npc in pairs(GetGamePool('CPed')) do
        if isPedValid(npc) then
            local dist = #(playerCoords - GetEntityCoords(npc))
            if dist <= distance then
                return npc
            end
        end
    end
    return nil
end

local function isInVehicle(ped)
    if IsPedInAnyVehicle(ped, false) or GetVehiclePedIsIn(ped, true) > 0 then
        TaskWanderStandard(ped, 10.0, 10)
        TriggerEvent('notify', 'negado', 'Venda de peças de armas', 'Por favor, não faça isso comigo! Leve tudo, mas não me force a comprar <b>peças de armas</b>.')
        return true
    end
    return false
end

local function preparePedForInteraction(ped, playerPed)
    ClearPedSecondaryTask(ped)
    ClearPedTasksImmediately(ped)
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityAsMissionEntity(ped, true, true)
    TaskTurnPedToFaceEntity(ped, playerPed, 3.0)
end

local function playAnimations(ped, playerPed)
    if LoadAnim('jh_1_ig_3-2') then 
        TaskPlayAnim(ped, 'jh_1_ig_3-2', 'cs_jewelass_dual-2', 8.0, 8.0, -1, 16, 0, 0, 0, 0)
    end

    loadModel('prop_anim_cash_note')
    local pedCoords = GetEntityCoords(playerPed)
    local cashObject = CreateObject('prop_anim_cash_note', pedCoords.x, pedCoords.y, pedCoords.z, false, false, false)
    AttachEntityToEntity(cashObject, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, false, false, false, false, 2, true)
    
    vRP.CarregarObjeto('mp_safehouselost@', 'package_dropoff', 'prop_paper_bag_small', 16, 28422, 0.0, -0.05, 0.05, 180.0, 0.0, 0.0)

    if LoadAnim('mp_safehouselost@') then
        TaskPlayAnim(playerPed, 'mp_safehouselost@', 'package_dropoff', 8.0, 8.0, -1, 16, 0, 0, 0, 0)
        TaskPlayAnim(ped, 'mp_safehouselost@', 'package_dropoff', 8.0, 8.0, -1, 16, 0, 0, 0, 0)
    end

    return cashObject
end

local function finishInteraction(ped, cashObject)
    if DoesEntityExist(cashObject) then DeleteEntity(cashObject) end

    ClearPedSecondaryTask(ped)
    ClearPedTasksImmediately(ped)
    TaskWanderStandard(ped, 10.0, 10)
    SetEntityAsNoLongerNeeded(ped)

    vSERVER.PaymentWeapons()
    vRP.DeletarObjeto()

    LocalPlayer.state.BlockTasks = false
    LocalPlayer.state.freezeEntity = false
end

local isActionInProgress = false

RegisterCommand('+pressedSellWeapon', function()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed) or GetEntityHealth(playerPed) <= 100 then return end

    local closestPed = findClosestPed(2.5)
    if not closestPed or Entity(closestPed).state.scenario or isInVehicle(closestPed) then return end
    if not vSERVER.checkWeapons(closestPed) then return end
    if isActionInProgress then return end

    isActionInProgress = true
    LocalPlayer.state.BlockTasks = true
    LocalPlayer.state.freezeEntity = true

    preparePedForInteraction(closestPed, playerPed)
    local cashObject = playAnimations(closestPed, playerPed)

    Citizen.SetTimeout(3000, function()
        finishInteraction(closestPed, cashObject)
        isActionInProgress = false
    end)
end)

RegisterKeyMapping('+pressedSellWeapon', 'Vender peças de arma para o NPC', 'keyboard', 'E')
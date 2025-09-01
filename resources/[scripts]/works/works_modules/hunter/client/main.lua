sHUN = Tunnel.getInterface(GetCurrentResourceName()..':hunter')

Citizen.CreateThread(function()
    if GetResourceState('target') == 'started' and exports.target then
    exports.target:RemoveTargetModel(Hunter.animals, 'Esfolar')
    exports.target:AddTargetModel(Hunter.animals, {
        options = {
            {
                icon = 'fas fa-utensils',
                label = 'Esfolar',
                canInteract = function(entity)
                    return (Entity(entity).state.hunter and not Entity(entity).state['hunter:skinned'] and IsEntityDead(entity) and Hunter.weapons[GetSelectedPedWeapon(PlayerPedId())])
                end,
                action = function(entity)
                    vRP.playAnim(true, { 'anim@gangops@facility@servers@bodysearch@', 'player_search' }, true)
					vRP.playAnim(false, { 'amb@medic@standing@kneel@base', 'base' }, true)

                    Entity(entity).state['hunter:skinned'] = true

                    sHUN.payment(GetEntityArchetypeName(entity), PedToNet(entity))                    
                end
            }
        },
        distance = 2.0
    })
    end
end)

AddStateBagChangeHandler('Armed', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) or (not value) then return; end;

    Citizen.CreateThread(function()
        local blockPeds = {
            [2] = true, --PED_TYPE_NETWORK_PLAYER
            [4] = true, --PED_TYPE_CIVMALE
            [5] = true, --PED_TYPE_CIVFEMALE
        }

        local musketHash = GetHashKey('WEAPON_MUSKET')
        while (LocalPlayer.state.Armed) do
            local idle = 1000
            local ped = PlayerPedId()
            if (GetSelectedPedWeapon(ped) == musketHash) then
                idle = 1

                local aiming, target = GetEntityPlayerIsFreeAimingAt(entity)
                if (aiming) and (DoesEntityExist(target) and IsEntityAPed(target)) then                    
                    if (blockPeds[GetPedType(target)]) then DisablePlayerFiring(entity, true); end;
                end
            end
            Citizen.Wait(idle)
        end
    end)
end)


Citizen.CreateThread(function()
    local playerHash = 1862763509
    local _, hateHash = AddRelationshipGroup('HUNTER_HATES')
    SetRelationshipBetweenGroups(5, hateHash, playerHash)
    SetRelationshipBetweenGroups(5, playerHash, hateHash)
    while (true) do
        for _, ped in ipairs(GetGamePool('CPed')) do
            local stateBag = Entity(ped).state
            if (stateBag.hunter) then
                
                if (not stateBag.HunterWander) then
                    TaskWanderStandard(ped, 10.0, 10)
                    stateBag:set('HunterWander',true,false) -- no sync
                end

                if (not stateBag.HunterAttributes) then
                    SetPedCombatMovement(ped, 3)
                    SetPedCombatAbility(ped, 100)             
                    SetPedCombatAttributes(ped, 46, true)
                    if Hunter.aggressive[GetEntityModel(ped)] then
                        SetPedCombatAttributes(ped, 17, false)
                        SetPedCombatAttributes(ped, 58, true)
                        SetPedRelationshipGroupHash(ped,hateHash)
                    end
                    stateBag:set('HunterAttributes',true,false) -- no sync
                end

                if (IsEntityInWater(ped)) then
                    TriggerServerEvent('hunter:delete_animal', PedToNet(ped))
                end
            end
            Citizen.Wait(1)
        end
        Citizen.Wait(5000)
    end
end)

AddEventHandler('onClientResourceStart', function(rsc)
    if (GetCurrentResourceName() ~= rsc) then return; end;
    for _, ped in pairs(GetGamePool('CPed')) do
        local stateBag = Entity(ped).state
        if (stateBag.hunter) then
            DeleteEntity(ped)
        end
    end
end)
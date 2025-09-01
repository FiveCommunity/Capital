local vSERVER = Tunnel.getInterface('State')

LocalPlayer.state:set('BlockTasks', false, true)
LocalPlayer.state:set('inVehicle', false, true)
LocalPlayer.state:set('patrolHospital', false, true)
LocalPlayer.state:set('holdingHostage', false, true)
LocalPlayer.state:set('victimHostage', false, true)
LocalPlayer.state:set('FPS', false, true)
LocalPlayer.state:set('Handcuff', false, true)
LocalPlayer.state:set('StraightJacket', false, true)
LocalPlayer.state:set('Capuz', false, true)
LocalPlayer.state:set('SafeZone', false, true)
LocalPlayer.state:set('Energetico', false, true)
LocalPlayer.state:set('Cam', false, true)
LocalPlayer.state:set('Control', false, true)
LocalPlayer.state:set('Armed', false, true)
LocalPlayer.state:set('Prison', false, true)
LocalPlayer.state:set('Asylum', false, true)
LocalPlayer.state:set('GPS', false, true)
LocalPlayer.state:set('Revistar', false, true)
LocalPlayer.state:set('Appearance', false, true)
LocalPlayer.state:set('PlayAnim', false, true)
LocalPlayer.state:set('freezeEntity', false, true)
LocalPlayer.state:set('pedSwimming', false, true)

local disableActions = function(ply)
    DisablePlayerFiring(ply, true)
    BlockWeaponWheelThisFrame()
    DisableControlAction(0, 29, true)
    DisableControlAction(0, 47, true)
    DisableControlAction(0, 56, true)
    DisableControlAction(0, 57, true)
    DisableControlAction(0, 73, true)
    DisableControlAction(0, 137, true)
    DisableControlAction(0, 166, true)
    DisableControlAction(0, 167, true)
    DisableControlAction(0, 169, true)
    DisableControlAction(0, 170, true)
    DisableControlAction(0, 182, true)
    DisableControlAction(0, 187, true)
    DisableControlAction(0, 188, true)
    DisableControlAction(0, 189, true)
    DisableControlAction(0, 190, true)
    DisableControlAction(0, 243, true)
    DisableControlAction(0, 245, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 288, true)
    DisableControlAction(0, 289, true)
    DisableControlAction(0, 311, true)
    DisableControlAction(0, 344, true)	
    DisableControlAction(0, 75, true)	
    DisableControlAction(0, 23, true)	  
    DisableControlAction(0,24,true) -- disable attack
    DisableControlAction(0,140,true) -- ATTACK_LIGHT
    DisableControlAction(0,25,true) -- disable aim
    DisableControlAction(0,47,true) -- disable weapon
    DisableControlAction(0,58,true) -- disable weapon
    DisableControlAction(0, 37, true) -- Tecla Tab
    DisableControlAction(0, 21, true)
    DisableControlAction(0, 22, true)
end

AddStateBagChangeHandler('PlayAnim', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.PlayAnim) do
                DisableControlAction(0,24,true) -- disable attack
                DisableControlAction(0,25,true) -- disable aim
                DisableControlAction(0,47,true) -- disable weapon
                DisableControlAction(0,58,true) -- disable weapon
                DisableControlAction(0, 37, true) -- Tecla Tab
                BlockWeaponWheelThisFrame()
                DisableControlAction(0, 29, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 56, true)
                DisableControlAction(0, 57, true)
                DisableControlAction(0, 73, true)
                DisableControlAction(0, 137, true)
                DisableControlAction(0, 166, true)
                DisableControlAction(0, 169, true)
                DisableControlAction(0, 170, true)
                DisableControlAction(0, 182, true)
                DisableControlAction(0, 187, true)
                DisableControlAction(0, 188, true)
                DisableControlAction(0, 189, true)
                DisableControlAction(0, 190, true)
                DisableControlAction(0, 243, true)
                DisableControlAction(0, 245, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 288, true)
                DisableControlAction(0, 289, true)
                DisableControlAction(0, 311, true)
                DisableControlAction(0, 344, true)		
                DisablePlayerFiring(PlayerPedId(), true)
                Citizen.Wait(1)
            end
        end)
    end
end)

AddStateBagChangeHandler('BlockTasks', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.BlockTasks) do
                BlockWeaponWheelThisFrame()
                -- DisableControlAction(0, 23, true) -- ENTRAR CARRO
                -- DisableControlAction(0, 75, true) -- SAIR CARRO
                DisableControlAction(0, 29, true)
                DisableControlAction(0, 22, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 56, true)
                DisableControlAction(0, 57, true)
                DisableControlAction(0, 73, true)
                DisableControlAction(0, 137, true)
                DisableControlAction(0, 166, true)
                DisableControlAction(0, 167, true)
                DisableControlAction(0, 169, true)
                DisableControlAction(0, 170, true)
                DisableControlAction(0, 182, true)
                DisableControlAction(0, 187, true)
                DisableControlAction(0, 188, true)
                DisableControlAction(0, 189, true)
                DisableControlAction(0, 190, true)
                DisableControlAction(0, 243, true)
                DisableControlAction(0, 245, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 288, true)
                DisableControlAction(0, 289, true)
                DisableControlAction(0, 311, true)
                DisableControlAction(0, 344, true)		
                DisablePlayerFiring(PlayerPedId(), true)
                Citizen.Wait(1)
            end
        end)
    end
end)

AddStateBagChangeHandler('Handcuff', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        if (LocalPlayer.state.Handcuff) then
            local ped = PlayerPedId()
            Citizen.CreateThread(function()
                --SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                while (LocalPlayer.state.Handcuff) do
                    ped = PlayerPedId()
                    if (GetEntityHealth(ped) > 100) then
                        if (not IsEntityPlayingAnim(ped, "mp_arresting", "idle",3 )) then
                            if (LoadAnim('mp_arresting')) then
                                TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
                            end          
                        end
                        disableActions(ped)
                    end
                    Citizen.Wait(1)
                end
                ClearPedTasks(ped)
            end)

            Citizen.CreateThread(function()
                local lastRagdoll = IsPedRunningRagdollTask(ped)
                while (LocalPlayer.state.Handcuff) do
                    if (not IsPedRunningRagdollTask(ped)) then 
                        if (lastRagdoll ~= IsPedRunningRagdollTask(ped)) then
                            ClearPedTasks(ped)
                        end
                    end
                    lastRagdoll = IsPedRunningRagdollTask(ped)
                    Citizen.Wait(1000)
                end
            end)
        end
    end
end)


local StraightJacket = {
    [GetHashKey('mp_m_freemode_01')] = {
        add = {
            [3] = { model = 3, var = 0, palette = 0 }, -- maos
            [8] = { model = 15, var = 0, palette = 0 }, -- camisa
            [11] = { model = 536, var = 0, palette = 0 }, -- jaqueta
        },
        remove = {
            [3] = { model = 15, var = 0, palette = 0 }, -- maos
            [8] = { model = 15, var = 0, palette = 0 }, -- camisa
            [11] = { model = 15, var = 0, palette = 0 }, -- jaqueta
        }
    },
    [GetHashKey('mp_f_freemode_01')] = {
        add = {
            [3] = { model = 8, var = 0, palette = 0 }, -- maos
            [8] = { model = 15, var = 0, palette = 0 }, -- camisa
            [11] = { model = 573, var = 0, palette = 0 }, -- jaqueta
        },
        remove = {
            [3] = { model = 15, var = 0, palette = 0 }, -- maos
            [8] = { model = 15, var = 0, palette = 0 }, -- camisa
            [11] = { model = 15, var = 0, palette = 0 }, -- jaqueta
        }
    },
}

AddStateBagChangeHandler('StraightJacket', nil, function(bagName, key, value) 
    local player = GetPlayerFromStateBagName(bagName)
    if (player == 0) or (PlayerId() ~= player) then return; end;

    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    if (value) then
        if StraightJacket[model] then
            vRP.setCustomization( StraightJacket[model].add )
        end
        
        Citizen.CreateThread(function()
            SetEnableHandcuffs(ped, true)
            while (LocalPlayer.state.StraightJacket) do
                ped = PlayerPedId()
                if (GetEntityHealth(ped) > 100) then
                    disableActions(ped)
                end
                Citizen.Wait(1)
            end
            SetEnableHandcuffs(ped, false)
            ClearPedTasks(ped)
        end)

        Citizen.CreateThread(function()
            local lastRagdoll = IsPedRunningRagdollTask(ped)
            while (LocalPlayer.state.StraightJacket) do
                if (not IsPedRunningRagdollTask(ped)) then 
                    if (lastRagdoll ~= IsPedRunningRagdollTask(ped)) then
                        ClearPedTasks(ped)
                    end
                end
                lastRagdoll = IsPedRunningRagdollTask(ped)
                Citizen.Wait(1000)
            end
        end)
    else
        if StraightJacket[model] then
            vRP.setCustomization( StraightJacket[model].remove )
        end
    end
end)

AddStateBagChangeHandler('Capuz', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        local ped = PlayerPedId()
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Capuz) do
                local idle = 1000
                if (GetEntityHealth(ped) > 100 and not LocalPlayer.state.Handcuff) then
                    idle = 4
                    disableActions(ped)
                end
                Citizen.Wait(idle)
            end
        end)
    end
end)

AddStateBagChangeHandler('Energetico', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        local ped = PlayerPedId()
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Energetico) do
                SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)
                RestorePlayerStamina(PlayerId(), 1.0)
                Citizen.Wait(1)
            end
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        end)
    end
end)

AddStateBagChangeHandler('Stamina', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        local ped = PlayerPedId()
        Citizen.CreateThread(function()
            local stamina = LocalPlayer.state.Stamina
            while (stamina) do
                stamina = LocalPlayer.state.Stamina
                SetRunSprintMultiplierForPlayer(PlayerId(), stamina)
                RestorePlayerStamina(PlayerId(), 1.0)
                Citizen.Wait(1)
            end
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        end)
    end
end)

local isFueling = false
local totalFuel = 0
local currentFuel = 0

AddStateBagChangeHandler('Armed', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) or (not value) then return; end;

    Citizen.CreateThread(function()
        local gallonHash = GetHashKey('WEAPON_PETROLCAN')

        while (LocalPlayer.state.Armed) do
            local idle = 1000
            local ped = PlayerPedId()
            
            if (GetSelectedPedWeapon(ped) == gallonHash) then
                idle = 4

                local vehicle = GetPlayersLastVehicle()
                if (DoesEntityExist(vehicle)) then
                    local vehicleFuel = GetVehicleFuelLevel(vehicle)
                    local vehCoords = GetEntityCoords(vehicle)
                    
                    if not DoesEntityExist(GetPedInVehicleSeat(vehicle,-1)) and (#(vehCoords - GetEntityCoords(ped)) < 2.0) then
                        
                        if (vehicleFuel >= 100) then
                            DrawText3D(vehCoords, 'Tanque ~b~Cheio~w~')    
                        elseif (not isFueling) then
                            DrawText3D(vehCoords, '~b~E~w~ - Abastecer')
                        else
                            DrawText3D(vehCoords, '~b~'..math.floor(currentFuel)..'.0%~w~ - Abastecendo')
                        end

                        if (not isFueling) and (vehicleFuel < 100) and IsControlJustPressed(0, 38) then
                                
                            TaskTurnPedToFaceEntity(ped, vehicle, 5000)
                            isFueling = true
                            totalFuel = 0
                            currentFuel = vehicleFuel

                            LocalPlayer.state.BlockTasks = true
                            FreezeEntityPosition(ped, true)
                            FreezeEntityPosition(vehicle, true)
                            Citizen.CreateThread(function()
                                if (not HasAnimDictLoaded("timetable@gardener@filling_can")) then
                                    RequestAnimDict("timetable@gardener@filling_can")
                                    while (not HasAnimDictLoaded("timetable@gardener@filling_can")) do
                                        Citizen.Wait(10)
                                    end
                                end
                                TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)

                                while (isFueling) do
                                    local saveFuel = false
                                    local gallonAmount = GetAmmoInPedWeapon(ped,gallonHash)
                                    local fuelAdd = 10 / 100.0

                                    if gallonAmount - fuelAdd * 100 >= 0 then

                                        totalFuel = (totalFuel + fuelAdd * 1.12)
                                        currentFuel = (vehicleFuel + totalFuel) + 0.0000001

                                        SetPedAmmo(ped,gallonHash,math.floor(gallonAmount - fuelAdd * 100))

                                        if (currentFuel >= 100) then
                                            saveFuel = true
                                            currentFuel = 100.0
                                            TriggerEvent('notify', 'Combustível', 'Você encheu o <b>tanque</b>!')
                                        end
                                    else
                                        saveFuel = true
                                        SetPedAmmo(ped,gallonHash,0)
                                    end

                                    if saveFuel then
                                        exports.fuel:SetFuel(VehToNet(vehicle), currentFuel)
                                        SetVehicleFuelLevel(vehicle, currentFuel)

                                        LocalPlayer.state.BlockTasks = false
                                        FreezeEntityPosition(ped, false)
                                        FreezeEntityPosition(vehicle, false)
                                        ClearPedTasks(ped)
                                        RemoveAnimDict("timetable@gardener@filling_can")
                                        isFueling = false
                                    end
                                    Citizen.Wait(100)
                                end
                            end)
                        end
                    end
                end
            end
            Citizen.Wait(idle)
        end
    end)
end)

local prison = PolyZone:Create(
    {
        vector2(1692.42, 2756.06),
        vector2(1651.52, 2756.82),
        vector2(1629.55, 2746.21),
        vector2(1557.58, 2675.76),
        vector2(1519.70, 2573.48),
        vector2(1528.03, 2453.79),
        vector2(1642.42, 2379.55),
        vector2(1765.91, 2393.18),
        vector2(1842.42, 2477.27),
        vector2(1852.27, 2569.70),
        vector2(1848.48, 2694.70),
        vector2(1771.21, 2760.61),
        vector2(1701.52, 2759.85)

        -- vector2(3766.325, 101.8945),
        -- vector2(3748.826, -46.82637),
        -- vector2(4117.055, -45.82417),
        -- vector2(4101.389, 99.37582),
    }, 
    {
        name = 'Prisão',
        -- debugPoly = true,
        minZ = -70.0,
        maxZ = 100.0
    }
)

-- Native prison
local lose_prison = PolyZone:Create(
    {
        vector2(1692.42, 2756.06),
        vector2(1651.52, 2756.82),
        vector2(1629.55, 2746.21),
        vector2(1557.58, 2675.76),
        vector2(1519.70, 2573.48),
        vector2(1528.03, 2453.79),
        vector2(1642.42, 2379.55),
        vector2(1765.91, 2393.18),
        vector2(1842.42, 2477.27),
        vector2(1852.27, 2569.70),
        vector2(1848.48, 2694.70),
        vector2(1771.21, 2760.61),
        vector2(1701.52, 2759.85)
    }, 
    {
        -- debugPoly = true,
        minZ = 40.0,
        maxZ = 70.0
    }
)

-- Alcatraz
-- local lose_prison = PolyZone:Create(
-- {
--     vector2(3958.681, 42.76484),
--     vector2(3960.224, 57.82418),
--     vector2(3941.815, 59.26154),
--     vector2(3940.615, 44.21539)
-- }, 
-- {
--     -- debugPoly = true,
--     minZ = -70.0,
--     maxZ = 100.0
-- })



local workout = false

AddStateBagChangeHandler('Prison', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Prison) do
                local inside = prison:isPointInside(GetEntityCoords(PlayerPedId()))
                if (not inside) then
                    TriggerEvent('notify', 'Prisão', 'O <b> agente penitenciário</b> encontrou você tentando escapar.')
                    vRP.teleport(1775.736, 2552.176, 45.55676)
                    -- vRP.teleport(3895.2, 33.2044, 23.88794, 164.4095)
                end
                Citizen.Wait(1500)
            end
        end)

        Citizen.CreateThread(function()
            while (LocalPlayer.state.Prison) do
                local idle = 1500

                local ped = PlayerPedId()
                local pCoord = GetEntityCoords(ped)
                
                local inside = lose_prison:isPointInside(pCoord)
                if (inside) then
                    idle = 1
                    if (IsControlJustPressed(0, 38) and not workout) then
                        workout = true
                        LocalPlayer.state.BlockTasks = true
                        -- FreezeEntityPosition(ped, true)
                        TriggerEvent('gb_animations:setAnim', 'malhar')
                        TriggerEvent('progressBar', 'Malhando...', 30000)

                        Citizen.Wait(30000)
 
                        LocalPlayer.state.BlockTasks = false
                        -- FreezeEntityPosition(ped, false)
                        ClearPedTasks(ped)
                        vRP.DeletarObjeto()
                        vSERVER.diminuirPena()
                        workout = false
                    end
                end
                Citizen.Wait(idle)
            end
        end)
    end
end)

AddStateBagChangeHandler('Armed', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) or (not value) then return; end;

    Citizen.CreateThread(function()
        while (LocalPlayer.state.Armed) do
            local ped = PlayerPedId()
            if (GetSelectedPedWeapon(ped) == GetHashKey('weapon_stungun')) or (GetSelectedPedWeapon(ped) == GetHashKey('weapon_pumpshotgun')) then
                local inside = prison:isPointInside(GetEntityCoords(ped))
                if (not inside) then
                    exports.inventory:cleanWeapons()
                end
            end
            Citizen.Wait(1000)
        end
    end)
end)

local PrisonClothes = {
    [GetHashKey('mp_m_freemode_01')] = {
        [1] = { model = 0, var = 0, palette = 0 },
        [2] = { model = 0, var = 0, palette = 0 },
        [3] = { model = 2, var = 0, palette = 0 },
        [4] = { model = 64, var = 6, palette = 0 },
        [5] = { model = -1, var = 0, palette = 0 },
        [6] = { model = 34, var = 0, palette = 0 },
        [7] = { model = 0, var = 0, palette = 0 },
        [8] = { model = 15, var = 0, palette = 0 },
        [9] = { model = 0, var = 0, palette = 0 },
        [10] = { model = 0, var = 0, palette = 2 },
        [11] = { model = 238, var = 0, palette = 0 },
        [12] = { model = 0, var = 2, palette = 0 },
        [0] = { model = 0, var = 0, palette = 2 },
        ['p7'] = { model = -1, var = -1, palette = 0 },
        ['p1'] = { model = -1, var = -1, palette = 0 },
        ['p6'] = { model = -1, var = -1, palette = 0 },
        ['p2'] = { model = -1, var = -1, palette = 0 },
        ['p0'] = { model = -1, var = -1, palette = 0 },
    },
    [GetHashKey('mp_f_freemode_01')] = {
        [1] = { model = -1, var = 0, palette = 0 },
        [2] = { model = 0, var = 0, palette = 0 },
        [3] = { model = 12, var = 0, palette = 0 },
        [4] = { model = 66, var = 6, palette = 0 },
        [5] = { model = 0, var = 0, palette = 0 },
        [6] = { model = 35, var = 0, palette = 0 },
        [7] = { model = 0, var = 0, palette = 0 },
        [8] = { model = 15, var = 0, palette = 0 },
        [9] = { model = 0, var = 0, palette = 0 },
        [10] = { model = 0, var = 0, palette = 0 },
        [11] = { model = 118, var = 0, palette = 0 },
        [12] = { model = 0, var = 0, palette = 0 },
        [0] = { model = 0, var = 0, palette = 0 },
        ['p7'] = { model = -1, var = -1, palette = 0 },
        ['p1'] = { model = -1, var = -1, palette = 0 },
        ['p6'] = { model = -1, var = -1, palette = 0 },
        ['p2'] = { model = -1, var = -1, palette = 0 },
        ['p0'] = { model = -1, var = -1, palette = 0 },
    }
}

RegisterNetEvent('Prison:Clothes', function()
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    exports.cloakroom:setClothes(ped,PrisonClothes[model])
end)

local asylum = PolyZone:Create({
    vector2(-23.48, 7681.82),
    vector2(-121.97, 7643.94),
    vector2(-143.94, 7554.55),
    vector2(-141.67, 7418.94),
    vector2(-197.73, 7236.36),
    vector2(-145.45, 7160.61),
    vector2(-1.52, 7206.82),
    vector2(50.00, 7250.76),
    vector2(96.21, 7227.27),
    vector2(126.52, 7197.73),
    vector2(191.67, 7200.76),
    vector2(237.12, 7225.00),
    vector2(271.97, 7275.00),
    vector2(307.58, 7339.39),
    vector2(327.27, 7425.76),
    vector2(326.52, 7495.45),
    vector2(311.36, 7546.21),
    vector2(260.61, 7568.94),
    vector2(181.06, 7610.61),
    vector2(96.21, 7677.27),
    vector2(33.33, 7707.58)
}, {
    name = 'Asylum'
})

AddStateBagChangeHandler('Asylum', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.Asylum) do
                local inside = asylum:isPointInside(GetEntityCoords(PlayerPedId()))
                if (not inside) then
                    TriggerEvent('notify', 'Manicômio', 'O <b>Guaxinim</b> encontrou você tentando escapar.')
                    vRP.teleport(-110.6769, 7488.092, 5.808105)
                end
                Citizen.Wait(1500)
            end
            NetworkSetFriendlyFireOption(true)
            SetLocalPlayerAsGhost(false)	
            ResetGhostedEntityAlpha()
        end)
    end
end)

RegisterNetEvent('SetAsylum', function()
    NetworkSetFriendlyFireOption(false)
    SetLocalPlayerAsGhost(true)
    SetGhostedEntityAlpha(254)
end)

AddStateBagChangeHandler('freezeEntity', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value) then
        Citizen.CreateThread(function()
            while (LocalPlayer.state.freezeEntity) do
                DisableControlAction(0, 30, true) -- disable left/right
                DisableControlAction(0, 31, true) -- disable forward/back
                DisableControlAction(0, 36, true) -- Left Control
                DisableControlAction(0, 22, true) -- Jump
                Citizen.Wait(1)
            end
        end)
    end
end)

AddStateBagChangeHandler('pedSwimming', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) or (not value) then return; end;

    exports.hud:outServers()
    vSERVER.looseItensInWater()
end)
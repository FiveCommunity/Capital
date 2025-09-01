local vSERVER = Tunnel.getInterface('ATM')

local getNearestATM = function()
    for index, coord in pairs(ATM.locations) do
        local distance = #(GetEntityCoords(PlayerPedId()) - coord.xyz)
        if (distance <= 1.5) then
            return index
        end
    end
    return false
end

local inRobbery = false

RegisterNetEvent('robbery:atm', function()
    local nearestATM = getNearestATM()
    local coord = ATM.locations[nearestATM]

    if (nearestATM and coord) then
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        if (GetEntityHealth(ped) > 100) and (not IsPedInAnyVehicle(ped)) then
            if (GetSelectedPedWeapon(ped) ~= GetHashKey('WEAPON_UNARMED')) then
                return TriggerEvent('notify', 'negado', 'ATM', 'Você não pode roubar o <b>ATM</b> com uma arma na mão, guarde ela.') 
            end

            if (inRobbery) then 
                return TriggerEvent('notify', 'negado', 'ATM', 'Você não <b>finalizou</b> o último caixinha.') 
            end
            inRobbery = true

            if (vSERVER.checkRobbery(nearestATM)) then
                LocalPlayer.state.BlockTasks = true
                TaskGoStraightToCoord(ped, coord.x, coord.y, coord.z, 1.0, 100000, coord.w, 2.0)
                
                while (inRobbery) do
                    ped = PlayerPedId()
                    local distance = #(pCoord - coord.xyz)
                    if (distance <= 1.5) then
                        ClearPedTasks(ped)
                        SetEntityHeading(ped, coord.w)
                        break
                    end
                    Citizen.Wait(1)
                end

                robberyAnim(coord, ped, pCoord)
            else
                inRobbery = false
            end
        end
    end
end)

robberyAnim = function(coord, ped, pCoord)

    SetPedComponentVariation(ped, 5, 0, 0, 0)
    
    local thermal_hash = GetHashKey('hei_prop_heist_thermite_flash')
    local bag_hash = GetHashKey('p_ld_heist_bag_s_pro_o')

    loadModel(thermal_hash)
    Citizen.Wait(10)
    loadModel(bag_hash)
    Citizen.Wait(10)

    local thermal_entity = CreateObject(thermal_hash, (coord.x+coord.y+coord.z)-20, true, true)
    local bag_prop = CreateObject(bag_hash, (pCoord-20), true, false)

    SetEntityAsMissionEntity(thermal_entity, true, true)
    SetEntityAsMissionEntity(bag_prop, true, true)

    local boneIndexf1 = GetPedBoneIndex(ped, 28422)
	local bagIndex1 = GetPedBoneIndex(ped, 57005)

    Citizen.Wait(500)

    AttachEntityToEntity(thermal_entity, ped, boneIndexf1, 0.0, 0.0, 0.0, 180.0, 180.0, 0, 1, 1, 0, 1, 1, 1)
    AttachEntityToEntity(bag_prop, ped, bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
    
    RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
    while (not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge')) do
        Citizen.Wait(100)
    end
    vRP._playAnim(false,{{'anim@heists@ornate_bank@thermal_charge','thermal_charge'}},false)

    Citizen.Wait(2500)
    DetachEntity(bag_prop, 1, 1)
	FreezeEntityPosition(bag_prop, true)
    Citizen.Wait(2500)
    FreezeEntityPosition(bag_prop, false)
	AttachEntityToEntity(bag_prop, ped, bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
    Citizen.Wait(1000)
    DeleteEntity(bag_prop)
    DeleteEntity(thermal_entity)
	ClearPedTasks(ped)

    SetPedComponentVariation(ped, 5, 40, 0, 0)
    LocalPlayer.state.BlockTasks = false

    TriggerEvent('Notify', 'importante', 'ATM', 'Você <b>plantou</b> a c4, cuidado...')
    TriggerEvent('vrp_sounds:distance', coord.xyz, 0.8, 'bomb_25', 0.5)

    TriggerEvent('ProgressBar', 25000)
    Citizen.Wait(25000)
    AddExplosion(coord.x, coord.y, coord.z, 2, 5.0, true, false, true)
    
    local money_prop, money_object, money_table = GetHashKey('prop_anim_cash_pile_02'), nil, {}
    for i = 1, 10 do
        money_object = CreateObjectNoOffset(money_prop, coord.x, coord.y, coord.z, 0, 0, 0)
        table.insert(money_table, { obj = money_object })
        Citizen.Wait(100)
    end

    Citizen.CreateThread(function()
        local action = false
        local countdownRobbery = (GetGameTimer() + 60000)
        
        local deleteObjects = function()
            for k,v in pairs(money_table) do
                if v and v.obj then
                    DeleteEntity(v.obj)
                end
            end
            money_table = {}
        end

        while (countTable(money_table) > 0) and (inRobbery) do
            ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)

            if (GetGameTimer() >= countdownRobbery) then deleteObjects() break; end;

            for index, data in pairs(money_table) do
             
                local coords = GetEntityCoords(data.obj)
                local distance = #(pCoord - coords)

                if (distance <= 5.0) and (not IsPedInAnyVehicle(ped)) then

                    DrawMarker(0,coords.x,coords.y,coords.z+0.3,0,0,0,0,0,130.0,0.15,0.15,0.15,3, 187, 232,200,1,0,0,0)
                    if (distance <= 1.2 and IsControlJustPressed(0, 38)) and (GetEntityHealth(ped) > 100) then
                        if (not action) then
                            action = true

                            TriggerEvent('gb_animations:setAnim', 'pegar')
                            LocalPlayer.state.BlockTasks = true
                            TriggerEvent('ProgressBar', 1700)
                            Citizen.SetTimeout(1700, function()
                                LocalPlayer.state.BlockTasks = false
                                ClearPedTasks(ped)
                                DeleteEntity(data.obj)
                                vSERVER.getATMMoney()
                                table.remove(money_table, index)
                                action = false
                            end)
                        end
                    end

                elseif (GetEntityHealth(ped) <= 100) then
                    deleteObjects();
                    break;
                end
            end
            Citizen.Wait(1)
        end
        inRobbery = false
        vSERVER.cleanATM()
    end)
end
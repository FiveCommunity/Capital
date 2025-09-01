_RegisterCommand = RegisterCommand
function RegisterCommand(command, callback)
    _RegisterCommand(command, function(...)
        if not LocalPlayer.state.inRoyale and not LocalPlayer.state.isPlayingEvent then
            return callback(...)
        end
    end)
end

_IsControlJustPressed = IsControlJustPressed
function IsControlJustPressed(...)
    if LocalPlayer.state.inRoyale or LocalPlayer.state.isPlayingEvent then
        return false
    else
        return _IsControlJustPressed(...)
    end
end

LocalPlayer.state:set('gadgetParachute', false, true)
--=======================================================================================================================================
-- OTHERS
--=======================================================================================================================================
function cRP.conflictWeapon(weapon)
    local ped = PlayerPedId()
    local weaponType = GetPedAmmoTypeFromWeapon(ped,GetHashKey(weapon))
    if (weaponType > 0) then
        local weapons = vRP.getWeapons()
        for k,v in pairs(weapons) do
            local kType = GetPedAmmoTypeFromWeapon(ped,GetHashKey(k))
            if (kType == weaponType) then
                return true
            end
        end
    end
    return false
end

function cRP.getWaterHeight()
    local ped = PlayerPedId()
	local pos = GetEntityCoords(ped, true)
	return GetWaterHeight(pos.x, pos.y, pos.z) or IsEntityInWater(ped)
end

function cRP.pedSwimming()
    local ped = PlayerPedId()
	local pos = GetEntityCoords(ped, true)
	return IsPedSwimming(ped)
end

function cRP.getVehicleDamage(vehicle)
    if DoesEntityExist(vehicle) then
        return GetVehicleEngineHealth(vehicle)
    end
    return 0.0
end

function cRP.GetVehicleClass(vehicle)
    if DoesEntityExist(vehicle) then
        return GetVehicleClass(vehicle)
    end
end

local function verifyParachute()
    local ped = PlayerPedId()
    if (GetPedParachuteState(ped) == 1) or (GetPedParachuteState(ped) == 2) then return true; end;
    return false
end
cRP.verifyParachute = verifyParachute
exports('verifyParachute', verifyParachute)

function cRP.userInVehicle()
    local ped = PlayerPedId()
    return IsPedInAnyVehicle(ped)
end

function cRP.setBattery(value)
    local timeout = 5000

    exports['lb-phone']:SendNotification({ app = 'Settings', title = 'Bateria', content = 'Carregando o celular' })
    exports['lb-phone']:ToggleCharging(true)

    Citizen.SetTimeout(timeout, function()
        exports['lb-phone']:ToggleCharging(false)
        exports['lb-phone']:SetBattery(value)
        
        exports['lb-phone']:SendNotification({ app = 'Settings', title = 'Bateria', content = 'Celular carregado' })
    end)
end

function cRP.getCurrentPhone()
    return exports['lb-phone']:getCurrentPhone()
end

function cRP.setPhone(number)
    return exports['lb-phone']:setPhone(number)
end

local typeClothes = {
    ['mask'] = function(ped, data)
        LocalPlayer.state.BlockTasks = true
        vRP.playAnim(true, { 'missfbi4', 'takeoff_mask' }, true)
        
        Citizen.Wait(1000)

        if (GetPedDrawableVariation(ped, 1) == 0) then
            SetPedComponentVariation(ped, 1, data.model, data.var, data.palette)
        else
            SetPedComponentVariation(ped, 1, 0, 0, 1)
        end

        ClearPedTasks(ped)
        LocalPlayer.state.BlockTasks = false

        -- exports.appearance:fixAppearance(ped)
    end,

    ['glasses'] = function(ped, data)
        LocalPlayer.state.BlockTasks = true
        vRP.playAnim(true, { 'clothingspecs', 'take_off' }, true)
        
        Citizen.Wait(1000)

        if (GetPedPropIndex(ped, 1) == -1) then
            SetPedPropIndex(ped, 1, data.model, data.var)
        else
            ClearPedProp(ped, 1)
        end

        ClearPedTasks(ped)
        LocalPlayer.state.BlockTasks = false
    end,

    ['hat'] = function(ped, data)
        LocalPlayer.state.BlockTasks = true
        vRP.playAnim(true, { 'veh@common@fp_helmet@', 'put_on_helmet' }, true)
        
        Citizen.Wait(1000)

        if (GetPedPropIndex(ped, 0) == -1) then
            SetPedPropIndex(ped, 0, data.model, data.var)
        else
            ClearPedProp(ped, 0)
        end

        ClearPedTasks(ped)
        LocalPlayer.state.BlockTasks = false
    end,

    ['shoes'] = function(ped, data)
        LocalPlayer.state.BlockTasks = true
        vRP.playAnim(false, { 'clothingshoes', 'try_shoes_positive_d' }, false)
        
        Citizen.Wait(2300)
        
        local models = {
            [GetHashKey('mp_m_freemode_01')] = 34,
            [GetHashKey('mp_f_freemode_01')] = 35
        }

        local model = models[GetEntityModel(ped)]
        if (model) then
            if (GetPedDrawableVariation(ped, 6) == model) then
                SetPedComponentVariation(ped, 6, data.model, data.var, data.palette)
            else
                SetPedComponentVariation(ped, 6, model, 0, 1)
            end
        end

        ClearPedTasks(ped)
        LocalPlayer.state.BlockTasks = false
    end,
}

RegisterNetEvent('inventory:clothes', function(type, data)
    local ped = PlayerPedId()

    if (typeClothes[type]) then typeClothes[type](ped, data); end;
end)
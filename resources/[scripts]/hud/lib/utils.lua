isServer = IsDuplicityVersion()
if (isServer) then
    srv.checkPermission = function(perm)
        local source = source
        local user_id = vRP.getUserId(source)
        if (user_id) then
            return vRP.checkPermissions(user_id, perm)
        end
    end
else
    -- [ General ] --
    Ready = false

    RegisterNUICallback('NuiReady', function(data, cb)
        Ready = true
        print('NuiReady')
        cb('Ok')
    end)

    RegisterNUICallback('Close', function(data, cb)
        SetNuiFocus(false, false)
        vRP.DeletarObjeto()

        cb('Ok')
    end)

    -- [ Main Hud ] --
    
    local VariableStats = {
        health = function(value)
            if (value == -100) then value = 0; end;
            SendNUIMessage({
                method = 'updateHealth',
                data = value
            })
        end,
        armour = function(value)
            SendNUIMessage({
                method = 'updateArmour',
                data = value
            })
        end,
        hunger = function(value)
            SendNUIMessage({
                method = 'updateHunger',
                data = value
            })
        end,
        thirst = function(value)
            SendNUIMessage({
                method = 'updateThirst',
                data = value
            })
        end,
        oxygen = function(value)
            SendNUIMessage({
                method = 'updateOxygen',
                data = value
            })
        end,
        stress = function(value)
            SendNUIMessage({
                method = 'updateStress',
                data = value
            })
        end,
        urine = function(value)
            SendNUIMessage({
                method = 'updateUrine',
                data = value
            })
        end,
        poop = function(value)
            SendNUIMessage({
                method = 'updatePoop',
                data = value
            })
        end,
        vehicle = function(value)
            SendNUIMessage({
                method = 'updateHudVehicle',
                data = value
            })
        end,
        speed = function(value)
            SendNUIMessage({
                method = 'updateSpeed',
                data = value
            })
        end,
        fuel = function(value)
            SendNUIMessage({
                method = 'updateFuel',
                data = value
            })
        end,
        engine = function(value)
            SendNUIMessage({
                method = 'updateEngineHealth',
                data = value
            })
        end,
        locked = function(value)
            SendNUIMessage({
                method = 'updateLocked',
                data = value
            })
        end,
        seatbelt = function(value)
            SendNUIMessage({
                method = 'updateSeatbelt',
                data = value
            })
        end,
        hud = function(value)
            SendNUIMessage({
                method = 'updateHud',
                data = value
            })
        end,
        street = function(value)
            SendNUIMessage({
                method = 'updateStreet',
                data = value
            })
        end,
        direction = function(value)
            SendNUIMessage({
                method = 'updateDirection',
                data = value
            })
        end,
        radio = function(value)          
            SendNUIMessage({
                method = 'updateRadioChannel',
                data = value
            })
        end,
        talkingMode = function(value)
            SendNUIMessage({
                method = 'updateVoice',
                data = value
            })
        end,
        talking = function(value)
            SendNUIMessage({
                method = 'updateTalking',
                data = value
            })
        end,
        weapon = function(value)
            SendNUIMessage({
                method = 'updateWeapon',
                data = value
            })
        end,
        radar = function(value)
            SendNUIMessage({
                method = 'updateRadar',
                data = value
            })
        end,
        pmaRadio = function(value)
            SendNUIMessage({
                method = 'updateRadio',
                data = value
            })
        end,
        notify = function(value)
            SendNUIMessage({
                method = 'notify',
                data = value
            })
        end,
        announcement = function(value)
            SendNUIMessage({
                method = 'announcement',
                data = value
            })
        end,
        progress = function(value)
            SendNUIMessage({
                method = 'progress',
                data = value
            })
        end,
        notifyPush = function(value)
            SendNUIMessage({
                method = 'updateNotifyPush',
                data = value
            })
        end,
        notifyCenter = function(value)
            SendNUIMessage({
                method = 'notifyCenter',
                data = value
            })
        end,
        notifyItem = function(value)
            SendNUIMessage({
                method = 'notifyItem',
                data = value
            })
        end,
        hoverfy = function(value)
            SendNUIMessage({
                method = 'hoverfy',
                data = value
            })
        end,
        updateWanted = function(value)
            SendNUIMessage({
                method = 'updateWanted',
                data = value
            })
        end,
        prompt = function(value)
            SendNUIMessage({
                method = 'prompt',
                data = value
            })
        end,
        request = function(value)
            SendNUIMessage({
                method = 'request',
                data = value
            })
        end,
        removeRequest = function(value)
            SendNUIMessage({
                method = 'removeRequest',
                data = value
            })
        end,
        clipboard = function(value)
            SendNUIMessage({
                method = 'clipboard',
                data = value
            })
        end,
        shortcut = function(value)
            SendNUIMessage({
                method = 'shortcut',
                data = value
            })
        end,
        time = function(value)
            SendNUIMessage({
                method = 'updateTime',
                data = value
            })
        end,
        light = function(value)
            SendNUIMessage({
                method = 'updateLight',
                data = value
            })
        end,
        nitro = function(value)
            SendNUIMessage({
                method = 'updateNitro',
                data = value
            })
        end,
        purge = function(value)
            SendNUIMessage({
                method = 'updatePurge',
                data = value
            })
        end
    }

    UpdateStats = function(stats, value)
        if (VariableStats[stats]) then 
            VariableStats[stats](value) 
        end
    end
    exports('UpdateStats', UpdateStats)

    -- [ Client Functions ] --
    Dependencys = function(ped)
        if (IsPauseMenuActive()) then return false; end;
        if (GetEntityHealth(ped) <= 100) then return false; end;
        if (LocalPlayer.state.Handcuff) then return false; end;
        if (LocalPlayer.state.StraightJacket) then return false; end;
        return true
    end

    GetDirection = function(heading)
        local direction = '';
        if (heading >= 315 or heading < 45) then
            direction = 'Norte'
        elseif (heading >= 45 and heading < 135) then
            direction = 'Oeste'
        elseif (heading >= 135 and heading < 225) then
            direction = 'Sul'
        elseif (heading >= 225 and heading < 315) then
            direction = 'Leste'
        end
        return direction
    end

    GetHealth = function(ped) 
        return math.floor((100 * (GetEntityHealth(ped) - 100) / 100) )
    end

    GetOxygen = function(ped, multiply)
        if (IsEntityInWater(ped)) then
            local remain = GetPlayerUnderwaterTimeRemaining(PlayerId())*multiply
            return ((remain > 0) and remain) or 0
        end
        return -1
    end

    GetSpeed = function(veh)
        return math.floor(GetEntitySpeed(veh) * 3.6)
    end

    GetVehEngine = function(veh)
        return math.floor(GetVehicleEngineHealth(veh) / 10)
    end

    doesVehicleHasSeatbelt = function(veh)
        local vehClass = GetVehicleClass(veh or vehicle)
        return (vehClass >= 0 and vehClass <= 7) or (vehClass >= 9 and vehClass <= 12) or (vehClass >= 17 and vehClass <= 20)
    end

    getTime = function()
        local hours = GetClockHours()
        local minutes = GetClockMinutes()
        if (hours <= 9) then hours = '0'..hours end
        if (minutes <= 9) then minutes = '0'..minutes end
        return hours..':'..minutes
    end
end
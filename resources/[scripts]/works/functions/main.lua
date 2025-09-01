Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

list = config.list
works = config.works
lang = config.lang
productions = config.locProduction
product = config.production

if IsDuplicityVersion() then
    vRPclient = Tunnel.getInterface('vRP')
    
    onPayment = function(user_id, givedMoney, blip_coord, payment_config, job_name, blip_step)
       
        -- if exports['gb_gamepass']:checkPass(user_id) then 
        --     exports['gb_gamepass']:GivePassXP(user_id, 20) 
        -- end

        if (job_name == 'Costureira da Marlinha') then   
            
            local costReward = {
                { item = 'tecido', prob = 1.0, min = 1, max = 1 },
                { item = 'tesoura', prob = 1.0, min = 1, max = 1 },
                { item = 'seda', prob = 30.0, min = 1, max = 2 },
                { item = 'agulha', prob = 30.0, min = 1, max = 2 },
            }
            
            for i=1, #costReward do
                local value = costReward[i]
                local random = (math.random() * 100)
                if (random <= value.prob) then
                    vRP.giveInventoryItem(user_id, value.item, math.random(value.min, value.max), nil, true)
                    break;
                end
            end

        end        
    end
else
    checkVehicleFunctions = function(ped, config)
        if (config['blipWithCar']) then
            return IsPedInAnyVehicle(ped)
        end
        return not IsPedInAnyVehicle(ped)
    end

    lastVehicleModel = function(_lastVehicle, vehicle)
        if (vehicle) then
            if (IsVehicleModel(_lastVehicle, GetHashKey(vehicle))) then
                return true
            end
            return false
        end
        return true
    end

    blips = false
    createBlip = function(routes, selection, route, msg)    -- Tirar isso daq dps 
        local text = msg or (route and 'Entregar a encomenda' or 'Empresa')
        blips = AddBlipForCoord((selection and routes[selection] or routes))
        SetBlipSprite(blips, 1)
        SetBlipColour(blips, 48)
        SetBlipScale(blips, 0.5)
        SetBlipAsShortRange(blips, false)
        SetBlipRoute(blips, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(text)
        EndTextCommandSetBlipName(blips)
    end

    blipRoute = function(coords, text)
        blip = AddBlipForCoord(coords)
        
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 48)
        SetBlipScale(blip, 0.5)
        SetBlipAsShortRange(blip, true)
        SetBlipRoute(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(text)
        EndTextCommandSetBlipName(blip)
    end

    stopWork = function(text)
        if (DoesBlipExist(blips)) then 
            RemoveBlip(blips) 
        end
        selection = 0
        inWork = false
        task = false
        _stage = 0
        _work = ''
        TriggerEvent('notify', 'Emprego', text) 
    end

    Text3D = function(x,y,z,text,size)
        local onScreen,_x,_y = World3dToScreen2d(x,y,z)
        if onScreen then
            SetTextFont(4)
            SetTextScale(0.35,0.35)
            SetTextColour(255,255,255,155)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
            local factor = (string.len(text))/size
            DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
        end
    end

    Text2D = function(font, x, y, text, scale)
        SetTextFont(font)
        SetTextProportional(7)
        SetTextScale(scale, scale)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end

    TextFloating = function(text, coord)
        AddTextEntry('FloatingHelpText', text)
        SetFloatingHelpTextWorldPosition(0, coord)
        SetFloatingHelpTextStyle(0, true, 2, -1, 3, 0)
        BeginTextCommandDisplayHelp('FloatingHelpText')
        EndTextCommandDisplayHelp(1, false, false, -1)
    end
end
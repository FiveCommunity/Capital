vSERVER = Tunnel.getInterface(GetCurrentResourceName())

RegisterNetEvent('production:open', function(arg)
    print(arg)
    local config = configProductions[arg]
    print(json.encode(configProductions[arg], { indent = true }))
    if (config) then
        if (vSERVER.hasPermission(config.permission)) then
            print(json.encode(config.products, { indent = true}))
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'open',
                title = config.label,
                org = arg,
                products = config.products,
            })
        end
    end
end)

local withBlip = {}
Citizen.CreateThread(function()
    for k,v in pairs(configProductions) do
        if v.coords then
            TriggerEvent('insert:hoverfy', v.coords.xyz, 'E', 'Produção', 1.2)
            withBlip[k] = v
        end
    end
end)

RegisterCommand('+openProduction', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for k, v in pairs(withBlip) do
        if (#(v.coords.xyz - coords) < 1.2) then
            if (vSERVER.hasPermission(v.permission)) then
                SetEntityCoords(ped,v.coords.x,v.coords.y,v.coords.z-0.97)
                SetEntityHeading(ped,v.coords.w)  
                SetNuiFocus(true, true)
                SendNUIMessage({
                    action = 'open',
                    title = v.label,
                    org = k,
                    products = v.products,
                })
            end
            break;        
        end
    end
end)
RegisterKeyMapping('+openProduction', 'Abrir Produção', 'keyboard', 'E')
----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNuiCallback('close', function(data, cb)
    SetNuiFocus(false, false)

    cb('Ok')
end)

RegisterNuiCallback('production', function(data, cb)
    local delay, anim = vSERVER.craftItem(data.org, data.index, data.amount)
    if (delay) then 
        LocalPlayer.state.BlockTasks = true
        LocalPlayer.state.freezeEntity = true

        TriggerEvent('gb_animations:setAnim', (anim or 'mexer') )
        TriggerEvent('ProgressBar', delay)
        
        Citizen.Wait(delay)
        
        ClearPedTasks(PlayerPedId())
        LocalPlayer.state.BlockTasks = false
        LocalPlayer.state.freezeEntity = false
    end

    cb('Ok')
end)
local vSERVER = Tunnel.getInterface('Routes')

RegisterNetEvent('routes:start', function(arg)
    if (not arg) then return; end;
    local config = Routes.locations[arg]
    if (config) then
        if (vSERVER.checkRoutes(arg)) then
            startRoute(arg)
        end
    end
end)

local inRoute = false
local selected = 0
local blip = nil
local action = false

startRoute = function(index)
    local _config = Routes.general[Routes.locations[index].config]

    inRoute = true
    selected = 1
    vSERVER.startUpdateRoute()

    CreateBlip(_config.coords, selected)
    TriggerEvent('notify', 'sucesso', 'Rotas', 'Você iniciou a sua rota de <b>'.._config.name..'</b>.<br>Todas as localizações já se encontram em seu <b>GPS</b>.')
    Citizen.CreateThread(function()
        while (inRoute) do
            local idle = 1000
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)

            local coords = _config.coords[selected]
            local distance = #(pCoord - coords)
            if (distance <= 20 and not action) then
                idle = 1
                DrawMarker(21, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 3, 187, 232, 155, 1, 0, 0, 1, 0, 0, 0)
                if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                    action = true
                    if (vSERVER.checkBackpack(_config.itens, _config.extras.drug, _config.extras.randomFixed)) then
                        RemoveBlip(blip)

                        if (_config.extras.police) then vSERVER.callPolice(_config.extras.police, _config.name) end;
                        if (_config.extras.anim) then ExecuteCommand('e '.._config.extras.anim) end;

                        TriggerEvent('ProgressBar', _config.extras.timeout)

                        LocalPlayer.state.BlockTasks = true
                        FreezeEntityPosition(ped, true)
                        Citizen.SetTimeout(_config.extras.timeout, function()
                            LocalPlayer.state.BlockTasks = false
                            FreezeEntityPosition(ped, false)
                            vRP.DeletarObjeto()
                            vSERVER.routePayment(_config.coords, _config, _config.extras.drug, _config.name)

                            if (_config.extras.random) then 
                                local newSelect = selected
                                while (newSelect == selected) do
                                    newSelect = math.random(#_config.coords)
                                    Citizen.Wait(10)
                                end
                                selected = newSelect
                            else
                                selected = (selected + 1)
                                if (selected > #_config.coords) then selected = 1; end;
                            end

                            TriggerEvent('notify', 'aviso', 'Rotas', 'Olá, foi adicionada uma nova <b>localização</b> em seu <b>GPS</b>.')
                            CreateBlip(_config.coords, selected)
                            action = false
                        end)
                    else
                        -- RemoveBlip(blip)
                        
                        if (_config.extras.police) then vSERVER.callPolice(_config.extras.police, _config.name) end;

                        -- if (_config.extras.random) then 
                        --     local newSelect = selected
                        --     while (newSelect == selected) do
                        --         newSelect = math.random(#_config.coords)
                        --         Citizen.Wait(10)
                        --     end
                        --     selected = newSelect
                        -- else
                        --     selected = (selected + 1)
                        --     if (selected > #_config.coords) then selected = 1; end;
                        -- end
                    
                        -- TriggerEvent('notify', 'Rotas', 'Olá, foi adicionada uma nova <b>localização</b> em seu <b>GPS</b>.')
                        -- CreateBlip(_config.coords, selected)
                        action = false
                    end
                end
            end
            Citizen.Wait(idle)
        end
    end)

    Citizen.CreateThread(function()
        while (inRoute) do
            Text2D(0, 0.42, 0.95, '~b~F7~w~ PARA CANCELAR A ~b~ROTA~w~', 0.4)
            if (IsControlJustPressed(0, 168) or GetEntityHealth(PlayerPedId()) < 100) then
                inRoute = false
                RemoveBlip(blip)
                vSERVER.resetUpdateRoute()
                TriggerEvent('notify', 'aviso', 'Rotas', 'Você finalizou a sua rota de <b>'.._config.name..'</b>. Todas as localizações marcadas foram retiradas de seu <b>GPS</b>.')
            end
            Citizen.Wait(1)
        end
        selected = 0
        blip = nil
    end)
end

CreateBlip = function(coord, selected)
    blip = AddBlipForCoord(coord[selected].x, coord[selected].y, coord[selected].z)
    SetBlipSprite(blip, 478)
    SetBlipColour(blip, 48)
    SetBlipScale(blip, 0.5)
    SetBlipAsShortRange(blip, true)
    SetBlipRoute(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Entrega')
    EndTextCommandSetBlipName(blip)
end
sColeta = Tunnel.getInterface(GetCurrentResourceName()..':coleta')

local currentZone = 0
local coletaZones = {}
local coletaThread = false

local coletaZone = function(coords)  
    for idx, zone in pairs(coletaZones) do
        local inside = zone:isPointInside(coords)
        if (inside) then return idx; end;
    end
    return 0
end

Citizen.CreateThread(function()

    for index, data in pairs(Coleta.zones) do
        coletaZones[index] = PolyZone:Create(data.area, { name = ('collect:'..index), debugGrid = false })
    end

    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        currentZone = coletaZone(coords)

        if (not coletaThread) and (currentZone > 0) then
            ColetaThread()
        end

        Citizen.Wait(2000)
    end
end)


function ColetaThread()
    if (not coletaThread) then
        coletaThread = true

        Citizen.CreateThread(function()
            while (currentZone > 0) do
                local _sleep = 500
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)

                local blips = Coleta.zones[currentZone].trees
                for k,v in pairs(blips) do

                    local dist = #(v.xyz - coords)
                    if (dist < 5.0) then
                        _sleep = 1
                        DrawMarker(0,v.x,v.y,v.z, 0,0,0,0,0,130.0,0.5,0.5,0.5, 249,55,99,200, 0,0,0,0)
                        if (dist < 1.5) and IsControlJustPressed(0,38) then                      
                            --print('[E]','zone',currentZone,'tree',k)
                            local time = sColeta.collect(currentZone,k)
                            if (not time) then 
                                LocalPlayer.state.BlockTasks = true
                                LocalPlayer.state.freezeEntity = true

                                SetEntityCoords(ped, v.x, v.y, v.z-0.97)
                                SetEntityHeading(ped,v.w)
                                vRP.playAnim(true,{ 'amb@prop_human_movie_bulb@base', 'base' }, true)

                                TriggerEvent('ProgressBar',5000)
                                Wait(5000)
                                    
                                sColeta.receiveItem()
                                ClearPedTasks(ped)
                                LocalPlayer.state.BlockTasks = false
                                LocalPlayer.state.freezeEntity = false
                            else
                                TriggerEvent('notify','importante','Coleta','Aguarde <b>'..time..'</b> segundos para coletar nesta árvore.')
                            end                        
                        end
                    end

                end
                
                Citizen.Wait(_sleep)
            end
            coletaThread = false
        end)

    end
end
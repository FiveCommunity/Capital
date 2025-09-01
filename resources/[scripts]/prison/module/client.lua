vSERVER = Tunnel.getInterface(GetCurrentResourceName())

--==============================================================================
-- Policia Avisos
--==============================================================================
RegisterNUICallback('execute', function(data, cb)
    TriggerServerEvent('prison:execute', data.code);
end)

local closeUi = function()
    SetNuiFocus(false, false)
    TriggerEvent('gb_core:stopTabletAnim')
end

RegisterNUICallback('close', function(data, cb) closeUi(); end)

--==============================================================================
-- Radio
--==============================================================================
local inRadio = false

local joinRadio = function(id)
    inRadio = true
    
    LocalPlayer.state.BlockTasks = true
    exports['pma-voice']:setRadioChannel(config.radio.frequency)
    exports['pma-voice']:setVoiceProperty('radioEnabled', true)
    TriggerEvent('hud:setFrequency', config.radio.frequency)

    Citizen.CreateThread(function()
        while (inRadio) do
            local dist = #(GetEntityCoords(PlayerPedId()) - config.radio.coords[id])
            if (dist > config.radio.limit) then exitRadio(); end;
            Text2D(0, 0.47, 0.94, 'RÁDIO: ~b~ON', 0.35)
            Citizen.Wait(1)
        end
    end)
end

local exitRadio = function()
    inRadio = false
    LocalPlayer.state.BlockTasks = false
    ExecuteCommand("-radiotalk")
    exports['pma-voice']:removePlayerFromRadio()
    exports['pma-voice']:setVoiceProperty('radioEnabled', false)
    TriggerEvent('hud:setFrequency', nil)
end

--==============================================================================
-- General
--==============================================================================
Citizen.CreateThread(function()
    for _, v in pairs(config.radio.coords) do
        TriggerEvent('insert:hoverfy', v, 'E', 'Rádio', 1.0)
    end
        
    TriggerEvent('insert:hoverfy', config.warns.menuCoords, 'E', 'Painel Avisos', 1.5)
end)

local nearest = function(ply)
    local plyCoords = GetEntityCoords(ply)

    for k, v in pairs(config.radio.coords) do
        local dist = #(plyCoords - v)
        if (dist <= 1.0) then
            return k, 'radio'
        end
    end

    local dist = #(plyCoords - config.warns.menuCoords)
    if (dist <= 1.5) then
        return true, 'warn'
    end

    return false
end 

RegisterCommand('prisonKeyboards', function()
    local ply = PlayerPedId()
    local near, _type = nearest(ply)
    if (near) and (_type) then
        local types = {
            ['radio'] = function()
                if inRadio then
                    exitRadio()
                else
                    joinRadio(near)
                end
            end,
            ['warn'] = function()
                if (vSERVER.checkPermission()) then        
                    SetNuiFocus(true, true)
                    TriggerEvent('gb_core:tabletAnim')
                    SendNUIMessage({ action = 'OPEN_PANEL' })
                end
            end
        }

        if (types[_type]) then
            types[_type]()
        end
    end
end)
RegisterKeyMapping('prisonKeyboards', 'Interação com a prisão', 'keyboard', 'E')

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
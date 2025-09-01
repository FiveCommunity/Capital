local inRadio = false

local outServers = function()
    inRadio = false
    exports['pma-voice']:removePlayerFromRadio()
	exports['pma-voice']:setVoiceProperty('radioEnabled', false)
	TriggerEvent('hud:setFrequency', 0)
end
exports('outServers', outServers)
RegisterNetEvent('radio:outServers',outServers)

showRadio = function()
    local ped = PlayerPedId()
    if (Dependencys(ped)) then
        if (IsPedSwimming(ped)) then return; end;
        if (GetSelectedPedWeapon(ped) ~= -1569615261) then return TriggerEvent('Notify', 'negado', 'Você esta com as <b>mãos</b> ocupadas!'); end;
        
        vRP._CarregarObjeto('cellphone@', 'cellphone_text_in', 'prop_cs_hand_radio', 50, 28422)
        SetNuiFocus(true, true)
        UpdateStats('pmaRadio', true)
    end
end
RegisterNetEvent('radio:open', showRadio)
--------------------------------------------------------------------------------
-- Modulation
--------------------------------------------------------------------------------
local cooldown = false
RegisterCommand('+upRadioFrequency', function()
    if (inRadio) then
        if (not cooldown) then
            cooldown = true
            SetTimeout(800,function() cooldown = false; end)

            local ped = PlayerPedId()
            if (IsPedSwimming(ped)) then return; end;

            local newFrequency = parseInt(inRadio + 1)
            if vSERVER.checkFrequency(newFrequency) then
                inRadio = newFrequency

                exports['pma-voice']:setRadioChannel(parseInt(inRadio))
                exports['pma-voice']:setVoiceProperty('radioEnabled', true)
                TriggerEvent('hud:setFrequency', inRadio)
                TriggerEvent('Notify', 'sucesso', 'Rádio', 'Você entrou na frequência <b>'..inRadio..' Mhz</b>.')
            end
        end
    end
end)

RegisterCommand('+downRadioFrequency', function()
    if (inRadio) then
        if (not cooldown) then
            cooldown = true
            SetTimeout(800,function() cooldown = false; end)

            local ped = PlayerPedId()
            if (IsPedSwimming(ped)) then return; end;

            local newFrequency = parseInt(inRadio - 1)
            if vSERVER.checkFrequency(newFrequency) then
                inRadio = newFrequency

                exports['pma-voice']:setRadioChannel(parseInt(inRadio))
                exports['pma-voice']:setVoiceProperty('radioEnabled', true)
                TriggerEvent('hud:setFrequency', inRadio)
                TriggerEvent('Notify', 'sucesso', 'Rádio', 'Você entrou na frequência <b>'..inRadio..' Mhz</b>.')
            end
        end
    end
end)

RegisterKeyMapping('+upRadioFrequency', 'Subir uma frequência', 'KEYBOARD', 'PLUS')
RegisterKeyMapping('+downRadioFrequency', 'Descer uma frequência', 'KEYBOARD', 'MINUS')
--------------------------------------------------------------------------------
-- Callback's
--------------------------------------------------------------------------------
local checkWater = false
function checkWaterThread()
    if (not checkWater) then
        checkWater = true
        Citizen.CreateThread(function()
            while inRadio do
                local ped = PlayerPedId()
                if (IsPedSwimming(ped)) then outServers(); end;
                Citizen.Wait(2000)
            end
            checkWater = false
        end)
    end
end

RegisterNUICallback('Frequency', function(data, cb)
    if (data.join) then
        local frequency = data.mhz
        if (vSERVER.checkFrequency(frequency)) and (inRadio ~= frequency) then
            inRadio = frequency

            exports['pma-voice']:setRadioChannel(parseInt(frequency))
            exports['pma-voice']:setVoiceProperty('radioEnabled', true)
            TriggerEvent('hud:setFrequency', frequency)
            TriggerEvent('Notify', 'sucesso', 'Rádio', 'Você entrou na frequência <b>'..inRadio..' Mhz</b>.')
            checkWaterThread()
        end
    else
        if (inRadio) then
            TriggerEvent('Notify', 'aviso', 'Rádio', 'Você saiu da frequência <b>'..inRadio..' Mhz</b>.')
            outServers()
        end
    end

    cb('Ok')
end)

RegisterNUICallback('Volume', function(data, cb)
    exports['pma-voice']:setRadioVolume(data)

    cb('Ok')
end)
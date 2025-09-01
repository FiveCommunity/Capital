mhackingCallback = {}
showHelp = false
helpTimer = 0
helpCycle = 4000

local showText = function()
    showHelp = true
    Citizen.CreateThread(function()
        while (showHelp) do
            if (GetEntityHealth(PlayerPedId()) > 101) then
                if (helpTimer > GetGameTimer()) then
                Text2D(0, 0.235, 0.90, 'NAVEGUE COM (~b~W, A, S, D~w~) E CONFIRME COM ~b~ESPAÇO~w~ PARA O BLOCO DE CÓDIGO DA ESQUERDA', 0.4)
                elseif (helpTimer > (GetGameTimer() - helpCycle)) then
                    Text2D(0, 0.235, 0.90, 'NAVEGUE COM AS (~b~SETAS~w~) E CONFIRME COM ~b~ENTER~w~ PARA O BLOCO DE CÓDIGO DA DIREITA', 0.4)
                else
                    helpTimer = (GetGameTimer() + helpCycle)
                end
            else
                SendNUIMessage({
                    fail = true
                })
            end
            Citizen.Wait(1)
        end
    end)
end

mhackingShow = function()
    SetNuiFocus(true, false)
    SendNUIMessage({
        show = true
    })
end
exports('mhackingShow', mhackingShow)
AddEventHandler('mhacking:show', mhackingShow)

mhackingHide = function()
    showHelp = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        show = false
    })
end
exports('mhackingHide', mhackingHide)
AddEventHandler('mhacking:hide', mhackingHide)

mhackingStart = function(length, duration, cb)
    mhackingCallback = cb
    SendNUIMessage({    
        s = length,
        d = duration,
        start = true
    })
    showText()
end
exports('mhackingStart', mhackingStart)
AddEventHandler('mhacking:start', mhackingStart)

mhackingMessage = function(msg)
    SendNUIMessage({
        displayMsg = msg
    })
end
exports('mhackingMessage', mhackingMessage)
AddEventHandler('mhacking:setmessage', mhackingMessage)


RegisterNUICallback('callback', function(data, cb)
	mhackingCallback(data.success, data.remainingtime)
    cb('ok')
end)

seqSwitch = nil
seqRemaingingTime = 0

mhackingSeqCallback = function(success, remainingtime)
	seqSwitch = success
	seqRemaingingTime = math.floor((remainingtime / 1000.0 + 0.5))
end
local vSERVER = Tunnel.getInterface('DealerRobbery')

Citizen.CreateThread(function()
    TriggerEvent('insert:hoverfy', DealerRobbery.start.xyz, 'E', 'Iniciar Roubo', 2.0)
end)

RegisterCommand('dealerRobbery',function()
    local ped = PlayerPedId()
    local coord = GetEntityCoords(ped)
    if (#(coord - DealerRobbery.start.xyz) < 2.0) then
        if (GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
            if vSERVER.startRobbery() then
                vSERVER.dispatchPolice()

                ClearPedTasks(ped)
                SetEntityCoords(ped, DealerRobbery.start.x, DealerRobbery.start.y, DealerRobbery.start.z-0.97)
                SetEntityHeading(ped, DealerRobbery.start.w)

                LocalPlayer.state.BlockTasks = true
                LocalPlayer.state.freezeEntity = true

                exports.inventory:cleanWeapons()

                Citizen.Wait(750)

                TriggerEvent('gb_animations:setAnim', DealerRobbery.Anim)
                TriggerEvent('ProgressBar', 10000)
                Citizen.SetTimeout(10000, function()
                    ClearPedTasks(ped)
                    HackingDealer()
                end)

            end
        end
    end
end)
RegisterKeyMapping('dealerRobbery', 'Roubo a Concessionaria', 'KEYBOARD', 'E')
--==============================================================================
-- HACK
--==============================================================================
local BruteForce = false
local HackConnect = false
local Hacking = false
local blockKeys = false
local UsingComputer = false

local generalConfig = {
    ['passwordRobbery'] = {
        'OKLSNXZW',
        'OWIFDNSZ',
        'DANWODLZ',
        'RONWIEDZ',
        'LUWSFPLC'
    },
    ['hackChance'] = 5,
}

HackingDealer = function()
    UsingComputer = true
    LocalPlayer.state.Hud = false

    Citizen.CreateThread(function()
        local Initialize = function(scaleform)
            local scaleform = RequestScaleformMovieInteractive(scaleform)
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(0)
            end

            PushScaleformMovieFunction(scaleform, 'SET_LABELS')
            PushScaleformMovieFunctionParameterString("Disco Local (C:)")
            PushScaleformMovieFunctionParameterString("Internet")
            PushScaleformMovieFunctionParameterString("HD Externo (D:)")
            PushScaleformMovieFunctionParameterString("HackConnect.exe")
            PushScaleformMovieFunctionParameterString("BruteForce.exe")
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_BACKGROUND')
            PushScaleformMovieFunctionParameterInt(1)
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'ADD_PROGRAM')
            PushScaleformMovieFunctionParameterFloat(1.0)
            PushScaleformMovieFunctionParameterFloat(4.0)
            PushScaleformMovieFunctionParameterString('Meu Computador')
            PopScaleformMovieFunctionVoid()
            
            PushScaleformMovieFunction(scaleform, 'ADD_PROGRAM')
            PushScaleformMovieFunctionParameterFloat(6.0)
            PushScaleformMovieFunctionParameterFloat(6.0)
            PushScaleformMovieFunctionParameterString('Desligar')
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_COLUMN_SPEED')
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_COLUMN_SPEED')
            PushScaleformMovieFunctionParameterInt(1)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_COLUMN_SPEED')
            PushScaleformMovieFunctionParameterInt(2)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_COLUMN_SPEED')
            PushScaleformMovieFunctionParameterInt(3)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_COLUMN_SPEED')
            PushScaleformMovieFunctionParameterInt(4)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_COLUMN_SPEED')
            PushScaleformMovieFunctionParameterInt(5)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_COLUMN_SPEED')
            PushScaleformMovieFunctionParameterInt(6)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, 'SET_COLUMN_SPEED')
            PushScaleformMovieFunctionParameterInt(7)
            PushScaleformMovieFunctionParameterInt(math.random(150,255))
            PopScaleformMovieFunctionVoid()
            return scaleform
        end

        scaleform = Initialize('HACKING_PC')
        while (UsingComputer) do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            PushScaleformMovieFunction(scaleform, 'SET_CURSOR')
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
            PopScaleformMovieFunctionVoid()
            if IsDisabledControlJustPressed(0,24) then
                PushScaleformMovieFunction(scaleform, 'SET_INPUT_EVENT_SELECT')
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, 'HACKING_CLICK', '', true)
            elseif IsDisabledControlJustPressed(0, 176) and Hacking then
                PushScaleformMovieFunction(scaleform, 'SET_INPUT_EVENT_SELECT')
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, 'HACKING_CLICK', '', true)
            elseif IsDisabledControlJustPressed(0, 25) and not Hacking then
                PushScaleformMovieFunction(scaleform, 'SET_INPUT_EVENT_BACK')
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, 'HACKING_CLICK', '', true)
            elseif IsDisabledControlJustPressed(0, 172) and Hacking then
                PushScaleformMovieFunction(scaleform, 'SET_INPUT_EVENT')
                PushScaleformMovieFunctionParameterInt(8)
                PlaySoundFrontend(-1, 'HACKING_CLICK', '', true)
            elseif IsDisabledControlJustPressed(0, 173) and Hacking then
                PushScaleformMovieFunction(scaleform, 'SET_INPUT_EVENT')
                PushScaleformMovieFunctionParameterInt(9)
                PlaySoundFrontend(-1, 'HACKING_CLICK', '', true)
            elseif IsDisabledControlJustPressed(0, 174) and Hacking then
                PushScaleformMovieFunction(scaleform, 'SET_INPUT_EVENT')
                PushScaleformMovieFunctionParameterInt(10)
                PlaySoundFrontend(-1, 'HACKING_CLICK', '', true)
            elseif IsDisabledControlJustPressed(0, 175) and Hacking then
                PushScaleformMovieFunction(scaleform, 'SET_INPUT_EVENT')
                PushScaleformMovieFunctionParameterInt(11)
                PlaySoundFrontend(-1, 'HACKING_CLICK', '', true)
            end
            Citizen.Wait(1)
        end
    end)

    Citizen.CreateThread(function()
        while (UsingComputer) do
            if (HasScaleformMovieLoaded(scaleform)) then
                if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                    ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)
                    if ProgramID == 83 and not Hacking and not BruteForce and HackConnect then
                        chanceshack = generalConfig['hackChance']

                        PushScaleformMovieFunction(scaleform, 'SET_LIVES')
                        PushScaleformMovieFunctionParameterInt(chanceshack)
                        PopScaleformMovieFunctionVoid()

                        PushScaleformMovieFunction(scaleform, 'OPEN_APP')
                        PushScaleformMovieFunctionParameterFloat(1.0)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, 'SET_ROULETTE_WORD')
                        PushScaleformMovieFunctionParameterString(generalConfig['passwordRobbery'][math.random(#generalConfig['passwordRobbery'])])
                        PopScaleformMovieFunctionVoid()

                        BruteForce = true
                        Hacking = true
                    elseif ProgramID == 82 and not Hacking and not BruteForce and not HackConnect then
                        chanceshack = generalConfig['hackChance']
                        
                        PushScaleformMovieFunction(scaleform, 'SET_LIVES')
                        PushScaleformMovieFunctionParameterInt(chanceshack)
                        PopScaleformMovieFunctionVoid()

                        PushScaleformMovieFunction(scaleform, 'OPEN_APP')
                        PushScaleformMovieFunctionParameterFloat(0.0)
                        PopScaleformMovieFunctionVoid()

                        Hacking = true
                    elseif Hacking and ProgramID == 87 then
                        chanceshack = chanceshack - 1

                        PushScaleformMovieFunction(scaleform, 'SET_LIVES')
                        PushScaleformMovieFunctionParameterInt(chanceshack)
                        PopScaleformMovieFunctionVoid()
                        PlaySoundFrontend(-1, 'HACKING_CLICK_BAD', '', false)
                    elseif Hacking and ProgramID == 84 then
                        HackConnect = true

                        PlaySoundFrontend(-1, 'HACKING_CLICK_GOOD', '', false)
                        PushScaleformMovieFunction(scaleform, 'SET_IP_OUTCOME')
                        PushScaleformMovieFunctionParameterBool(true)
                        ScaleformLabel(0x18EBB648)
                        PopScaleformMovieFunctionVoid()
                        PushScaleformMovieFunction(scaleform, 'CLOSE_APP')
                        PopScaleformMovieFunctionVoid()

                        Hacking = false
                    elseif Hacking and ProgramID == 85 then
                        PlaySoundFrontend(-1, 'HACKING_CLICK_BAD', '', false)
                        PushScaleformMovieFunction(scaleform, 'CLOSE_APP')
                        PopScaleformMovieFunctionVoid()

                        Hacking = false

                    elseif Hacking and ProgramID == 92 then
                        PlaySoundFrontend(-1, 'HACKING_CLICK_GOOD', '', false)
                    
                    elseif Hacking and ProgramID == 86 then
                        PlaySoundFrontend(-1, 'HACKING_SUCCESS', '', true)
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(true)
                        PushScaleformMovieFunctionParameterString("SISTEMA HACKEADO COM SUCESSO!")
                        PopScaleformMovieFunctionVoid()

                        Wait(2800)
                        PushScaleformMovieFunction(scaleform, 'CLOSE_APP')
                        PopScaleformMovieFunctionVoid()

                        PushScaleformMovieFunction(scaleform, "OPEN_LOADING_PROGRESS")
                        PushScaleformMovieFunctionParameterBool(true)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_PROGRESS")
                        PushScaleformMovieFunctionParameterInt(35)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_TIME")
                        PushScaleformMovieFunctionParameterInt(35)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_MESSAGE")
                        PushScaleformMovieFunctionParameterString("Gravando dados no buffer..")
                        PushScaleformMovieFunctionParameterFloat(2.0)
                        PopScaleformMovieFunctionVoid()
                        Wait(1500)
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_MESSAGE")
                        PushScaleformMovieFunctionParameterString("Executando código malicioso..")
                        PushScaleformMovieFunctionParameterFloat(2.0)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_TIME")
                        PushScaleformMovieFunctionParameterInt(15)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "SET_LOADING_PROGRESS")
                        PushScaleformMovieFunctionParameterInt(75)
                        PopScaleformMovieFunctionVoid()
                        
                        Wait(1500)
                        PushScaleformMovieFunction(scaleform, "OPEN_LOADING_PROGRESS")
                        PushScaleformMovieFunctionParameterBool(false)
                        PopScaleformMovieFunctionVoid()
                        
                        PushScaleformMovieFunction(scaleform, "OPEN_ERROR_POPUP")
                        PushScaleformMovieFunctionParameterBool(true)
                        PushScaleformMovieFunctionParameterString("VAZAMENTO DE MEMÓRIA DETECTADO, DISPOSITIVO DESLIGANDO")
                        PopScaleformMovieFunctionVoid()

                        Hacking = false
                        HackConnect = false
                        BruteForce = false
                        blockKeys = false
                        UsingComputer = false

                        LocalPlayer.state.BlockTasks = false
                        LocalPlayer.state.freezeEntity = false
                        LocalPlayer.state.Hud = true

                        ClearPedTasks(ped)

                        SetScaleformMovieAsNoLongerNeeded(scaleform) --EXIT SCALEFORM
                        PopScaleformMovieFunctionVoid()

                        if vSERVER.doneRobbery() then
                            DealerCountdown()
                        end
                        --@ TERMINOUUU
                      
                    elseif ProgramID == 6 then
                        UsingComputer = false
                        SetScaleformMovieAsNoLongerNeeded(scaleform)
                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)

                        LocalPlayer.state.BlockTasks = false
                        LocalPlayer.state.freezeEntity = false
                        LocalPlayer.state.Hud = true
                        ClearPedTasks(ped)

                        HackConnect = false
                        Hacking = false
                        BruteForce = false
                        blockKeys = false
                    end
                    
                    if Hacking then
                        PushScaleformMovieFunction(scaleform, 'SHOW_LIVES')
                        PushScaleformMovieFunctionParameterBool(true)
                        PopScaleformMovieFunctionVoid()
                        if chanceshack <= 0 then
                            PlaySoundFrontend(-1, 'HACKING_FAILURE', '', true)
                            PushScaleformMovieFunction(scaleform, 'SET_ROULETTE_OUTCOME')
                            PushScaleformMovieFunctionParameterBool(false)
                            ScaleformLabel('LOSEBRUTE')
                            PopScaleformMovieFunctionVoid()
                            Wait(3000)
                            ClearPedTasks(ped)
                            PushScaleformMovieFunction(scaleform, 'CLOSE_APP')
                            PopScaleformMovieFunctionVoid()
                            SetScaleformMovieAsNoLongerNeeded(scaleform)

                            Hacking = false
                            HackConnect = false
                            BruteForce = false
                            blockKeys = false
                            UsingComputer = false
                            startJewerly = false

                            LocalPlayer.state.BlockTasks = false
                            LocalPlayer.state.freezeEntity = false
                            LocalPlayer.state.Hud = true
                            ClearPedTasks(ped)

                            TriggerEvent('notify','importante','Roubo Concessionária','Você falhou!',10000)
                            --@ ERROUUU    
                          
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)
end

function DealerCountdown()
    local timer = DealerRobbery.timeReward
   
    Citizen.CreateThread(function()
        while (timer > 0) do
            timer = timer - 1
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        local cancel = false

        while (timer > 0) do
            local ped = PlayerPedId()       
                
            if (IsPedInAnyVehicle(ped)) or IsControlJustPressed(0, 244) or (GetEntityHealth(ped) <= 100) then
                cancel = true 
            end

            local coords = GetEntityCoords(ped)
            local dist = #(DealerRobbery.start.xyz - coords)
            
            if (dist < 5.0) then
                local text = (timer > 1 and 'AGUARDE ~b~'..timer..'~w~ SEGUNDOS [~b~M~w~ - PARA CANCELAR]' or 'FINALIZANDO O ~b~ROUBO~w~')
                Text3D(DealerRobbery.start.x, DealerRobbery.start.y, DealerRobbery.start.z, text, 400)
            end

            if (dist > 40.0) then
                Text2D(0, 0.42, 0.95, 'VOCÊ ESTÁ LONGE DO ~b~ROUBO~w~!', 0.3)
                if (dist > 50.00) then
                    TriggerEvent('notify', 'negado', 'Roubo Concessionária', 'Você se distanciou muito do <b>roubo</b>!')
                    cancel = true 
                end
            end
        
            if (cancel) then          
                timer = 0
            end
            Citizen.Wait(1)
        end

        if (not cancel) then            
            vSERVER.payment()
        end
    end)

end
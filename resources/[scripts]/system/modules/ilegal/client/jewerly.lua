local cli = {}
Tunnel.bindInterface('Jewerly', cli)
local vSERVER = Tunnel.getInterface('Jewerly')

local locais = {
	{ coord = vec3(-626.3253,-239.0511,37.64523), prop2 = 'des_jewel_cab2_end', prop1 = 'des_jewel_cab2_start', coord2 = vec3(-626.80908203125,-238.34339904785,38.057006835938), heading = 221.73 },
	{ coord = vec3(-625.2751,-238.2881,37.64523), prop2 = 'des_jewel_cab3_end', prop1 = 'des_jewel_cab3_start', coord2 = vec3(-625.80285644531,-237.60856628418,38.056999206543), heading = 221.73 },
	{ coord = vec3(-626.5439,-233.6047,37.64523), prop2 = 'des_jewel_cab_end', prop1 = 'des_jewel_cab_start', coord2 = vec3(-627.08929443359,-232.89517211914,38.057006835938), heading = 221.73 }, 
	{ coord = vec3(-626.1613,-234.1315,37.64523), prop2 = 'des_jewel_cab4_end', prop1 = 'des_jewel_cab4_start', coord2 = vec3(-625.57720947266,-234.80921936035,38.057010650635), heading = 31.56 },
	{ coord = vec3(-627.2115,-234.8942,37.64523), prop2 = 'des_jewel_cab3_end', prop1 = 'des_jewel_cab3_start', coord2 = vec3(-626.64904785156,-235.61465454102,38.05700302124), heading = 31.56 },
	{ coord = vec3(-619.8483,-234.9137,37.64523), prop2 = 'des_jewel_cab_end', prop1 = 'des_jewel_cab_start', coord2 = vec3(-620.44061279297,-234.19891357422,38.056999206543), heading = 221.73 },
	{ coord = vec3(-617.0856,-230.1627,37.64523), prop2 = 'des_jewel_cab2_end', prop1 = 'des_jewel_cab2_start', coord2 = vec3(-617.83697509766,-230.68539428711,38.057006835938), heading = 306.23 },
	{ coord = vec3(-617.8492,-229.1128,37.64523), prop2 = 'des_jewel_cab3_end', prop1 = 'des_jewel_cab3_start', coord2 = vec3(-618.51141357422,-229.69427490234,38.056999206543), heading = 306.23 },
	{ coord = vec3(-621.5175,-228.9474,37.64523), prop2 = 'des_jewel_cab3_end', prop1 = 'des_jewel_cab3_start', coord2 = vec3(-620.89727783203,-228.3892364502,38.057006835938), heading = 127.12 },
	{ coord = vec3(-619.9662,-226.198,37.64523), prop2 = 'des_jewel_cab_end', prop1 = 'des_jewel_cab_start', coord2 = vec3(-620.61871337891,-226.81732177734,38.057006835938), heading = 306.23 },
	{ coord = vec3(-625.3300,-227.3697,37.64523), prop2 = 'des_jewel_cab3_end', prop1 = 'des_jewel_cab3_start', coord2 = vec3(-624.95703125,-228.04200744629,38.057010650635), heading = 31.56 },
	{ coord = vec3(-623.6147,-228.6247,37.64523), prop2 = 'des_jewel_cab2_end', prop1 = 'des_jewel_cab2_start', coord2 = vec3(-624.16003417969,-227.90766906738,38.057006835938), heading = 221.73 },
	{ coord = vec3(-623.9558,-230.7263,37.64523), prop2 = 'des_jewel_cab4_end', prop1 = 'des_jewel_cab4_start', coord2 = vec3(-624.64788818359,-231.24926757813,38.057006835938), heading = 306.23 },
	{ coord = vec3(-624.2796,-226.6066,37.64523), prop2 = 'des_jewel_cab4_end', prop1 = 'des_jewel_cab4_start', coord2 = vec3(-623.79742431641,-227.30368041992,38.05700302124), heading = 31.56 },
	{ coord = vec3(-619.2031,-227.2482,37.64523), prop2 = 'des_jewel_cab2_end', prop1 = 'des_jewel_cab2_start', coord2 = vec3(-619.91357421875,-227.81005859375,38.057006835938), heading = 306.23 },
	{ coord = vec3(-620.1764,-230.7865,37.64523), prop2 = 'des_jewel_cab_end', prop1 = 'des_jewel_cab_start', coord2 = vec3(-619.44543457031,-230.30876159668,38.057022094727), heading = 127.12 },
	{ coord = vec3(-620.5214,-232.8823,37.64523), prop2 = 'des_jewel_cab4_end', prop1 = 'des_jewel_cab4_start', coord2 = vec3(-620.04870605469,-233.48422241211,38.057006835938), heading = 31.56 },
	{ coord = vec3(-622.6159,-232.5636,37.64523), prop2 = 'des_jewel_cab_end', prop1 = 'des_jewel_cab_start', coord2 = vec3(-623.3056640625,-233.11682128906,38.057010650635), heading = 306.23 },
	{ coord = vec3(-627.5945,-234.3678,37.64523), prop2 = 'des_jewel_cab_end', prop1 = 'des_jewel_cab_start', coord2 = vec3(-628.11602783203,-233.64642333984,38.057010650635), heading = 221.73 },
	{ coord = vec3(-618.7984,-234.1509,37.64523), prop2 = 'des_jewel_cab3_end', prop1 = 'des_jewel_cab3_start', coord2 = vec3(-619.36053466797,-233.41262817383,38.057014465332), heading = 221.73 }
}

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

-- local coordJewerly, centerRobbery = vector4(-631.4769, -230.2154, 38.04175, 212.5984), vector3(-622.18, -230.92, 38.05)
-- local ped, pCoord = PlayerPedId(), vector3(0,0,0)
-- local seconds = 0
-- local startedJewerly = false

-- Citizen.CreateThread(function()
--     while (true) do
--         local idle = 1000
--         ped = PlayerPedId()
--         pCoord = GetEntityCoords(ped)

--         if (not startedJewerly) and (not UsingComputer) then
--             local distance = #(pCoord - coordJewerly.xyz)
--             if (distance <= 3.0) then
--                 idle = 1

--                 Text3D(coordJewerly.x, coordJewerly.y, coordJewerly.z, '~b~E~w~ - HACKEAR', 400)
--                 if (distance <= 1.2 and IsControlJustPressed(0, 38)) and (GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
--                     vSERVER.checkJewerly()
--                 end
--             end
--         end

--         Citizen.Wait(idle)
--     end
-- end)

local miniGameHacking = function()
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

                        TriggerEvent('Notify','sucesso','Joalheria','A proteção das <b>câmeras de <b>segurança</b> foi comprometida, você ganhará <b>90</b> segundos de vantagem até que a <b>policia</b> seja acionada.')
                        Citizen.SetTimeout(90 * 1000,function()
                            vSERVER.callPolice()
                        end)

                        SetScaleformMovieAsNoLongerNeeded(scaleform) --EXIT SCALEFORM
                        PopScaleformMovieFunctionVoid()
                        Wait(1000)
                        jewerlyRobberyStage()
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
                            Wait(5000)
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

                            TriggerEvent('Notify','aviso','Joalheria','Voce falhou em <b>hackear</b> as cameras de segurança, sua conexão foi <b>bloqueada</b> e chamou a <b>polícia</b>.')                   
                            vSERVER.callPolice()
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)
end

cli.startJewerly = function()
    startedJewerly = true;

    ClearPedTasks(ped)
    SetEntityHeading(ped, coordJewerly.w)
    exports.inventory:cleanWeapons()

    Citizen.Wait(750)

    ExecuteCommand('e digitar')

    LocalPlayer.state.BlockTasks = true
    LocalPlayer.state.freezeEntity = true

    TriggerEvent('ProgressBar', 10000)
    Citizen.SetTimeout(10000, function()
        ClearPedTasks(ped)

        miniGameHacking()
    end)
end

local float = function(number)
    return (number+0.0001)
end

local createCam = function()
    if (not DoesCamExist(cam)) then cam = CreateCam('DEFAULT_SCRIPTED_CAMERA',false); end;

    SetTimecycleModifier('scanline_cam_cheap')
    SetTimecycleModifierStrength(2.0)
    SetCamCoord(cam, vector3(-618.18, -232.54, 38.06+3))
    SetCamRot(cam, float(0), float(0), float(100), 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 0, 0, 0, 0)
end

local destroyCam = function()
    ClearTimecycleModifier("scanline_cam_cheap")
    SetCamActive(cam, false)
    StopCamPointing(cam)
    RenderScriptCams(0, 0, 0, 0, 0, 0)
    SetFocusEntity(ped)
end

local robberyJewels = function()
    local brokes = {}

    local checkWeapon = function()
        local passGroups = {
            [970310034] = true, -- Rifle Group
            [3337201093] = true, -- SMG Group
            [-957766203] = true, -- SMG Unsigned
        }

        if (passGroups[GetWeapontypeGroup(GetSelectedPedWeapon(ped))]) then
            return true
        end
        return false
    end

    Citizen.CreateThread(function()
        while (startedJewerly) do
            local idle = 1000

            for index, data in pairs(locais) do
                local distance = #(pCoord - data.coord)
                if (distance <= 5.0) and (not brokes[index]) then
                    idle = 5

                    Text3D(data.coord.x, data.coord.y, (data.coord.z + 0.55), '~b~E~w~ - ROUBAR', 400)
                    if (distance <= 1.2 and IsControlJustPressed(0, 38)) then
                        if (checkWeapon()) then
                            vSERVER.checkJewels(index, data.coord, data.coord2, data.heading, data.prop1, data.prop2)
                            
                            brokes[index] = true
                        else
                            TriggerEvent('Notify', 'negado', 'Joalheria', 'Você precisa ter um armamento <b>pesado</b> em suas mãos.')
                        end
                    end
                end
            end

            Citizen.Wait(idle)
        end
    end)
end

jewerlyRobberyStage = function()
    vSERVER.setCooldownJewerly()

    LocalPlayer.state.Hud = false
    LocalPlayer.state.BlockTasks = true
    LocalPlayer.state.freezeEntity = true

    createCam()

    PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', false)
    ShowAdvancedNotification('CHAR_LESTER', 'Hugo', 'Roubo a Joalheria', 'Utilize um armamento <b>Pesado</b> para quebrar os vidros e roubar as joias!')

    Citizen.SetTimeout(10000, function()
        destroyCam()

        ClearPedTasks(ped)

        LocalPlayer.state.Hud = true
        LocalPlayer.state.BlockTasks = false
        LocalPlayer.state.freezeEntity = false

        robberyJewels()
    end)
end

cli.jewelryRoubbery = function(prop_1, prop_2, id)
    if (not HasNamedPtfxAssetLoaded('scr_jewelheist')) then RequestNamedPtfxAsset('scr_jewelheist'); end;
    while (not HasNamedPtfxAssetLoaded('scr_jewelheist')) do Citizen.Wait(0); end;

    Citizen.Wait(300)

    ClearPedTasks(ped)

    LocalPlayer.state.BlockTasks = true

    SetPtfxAssetNextCall('scr_jewelheist')
    StartParticleFxLoopedAtCoord('scr_jewel_cab_smash', pCoord.x,pCoord.y,pCoord.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    LoadAnim('missheist_jewel') 

    TriggerEvent('vrp_sounds:source', 'vidroquebrado', 0.25)

    local random = math.random(1, 2)
    if (random == 1) then
        TaskPlayAnim(ped, 'missheist_jewel', 'smash_case_b', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        
        TriggerEvent('ProgressBar', 4000)
        Citizen.SetTimeout(4000, function()
            StopAnimTask(ped,'missheist_jewel','smash_case_b',1.0)
            LocalPlayer.state.BlockTasks = false
        end)

        Citizen.SetTimeout(3200, function()
            PlaySound(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 0, 0, 1)
        end)
    else
        TaskPlayAnim(ped, 'missheist_jewel', 'smash_case_f', 8.0, 1.0, -1, 2, 0, 0, 0, 0)

        TriggerEvent('ProgressBar', 3000)
        Citizen.SetTimeout(3000, function()
            StopAnimTask(ped,'missheist_jewel','smash_case_f',1.0)
            LocalPlayer.state.BlockTasks = false
        end)
        
        Citizen.SetTimeout(1800, function()
            PlaySound(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 0, 0, 1)
        end)
    end

    Citizen.Wait(300)
    TriggerServerEvent('jewerly:setModels',pCoord.x,pCoord.y,pCoord.z,prop_1,prop_2)
end

RegisterNetEvent('jewerly:setModels', function(x,y,z,prop1,prop2)
    CreateModelSwap(x,y,z,0.2,GetHashKey(prop1),GetHashKey(prop2),false)
end)

ScaleformLabel = function(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end

ShowAdvancedNotification = function(icon, sender, title, text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end

cli.finishRobbery = function()
    startJewerly = false
    BruteForce = false
    HackConnect = false
    Hacking = false
    blockKeys = false
    UsingComputer = false
    TriggerEvent('Notify', 'aviso', 'Joalheria', 'Você roubou todas as <b>bancadas</b>.')
end
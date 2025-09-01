local config = {}

local cancelKeyMapping = false

config.animations = {
    ['keyMapping'] = {
        ['cruzarBraco'] = {
            key = 'f1',
            text = 'Animação - Cruzar o Braço',
            action = function()
                local ped = PlayerPedId()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not cancelKeyMapping) then
                    if (IsEntityPlayingAnim(ped, 'anim@heists@heist_corona@single_team', 'single_team_loop_boss', 3)) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{ 'anim@heists@heist_corona@single_team', 'single_team_loop_boss' }}, true)
                    end
                end
            end
        },
        ['aguardar'] = {
            key = 'f2',
            text = 'Animação - Aguardar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if (IsEntityPlayingAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 3)) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{ 'mini@strip_club@idles@bouncer@base', 'base' }}, true)
                    end
                end
            end
        },
        ['dedoMeio'] = {
            key = 'f3',
            text = 'Animação - Dedo do meio',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if (IsEntityPlayingAnim(ped, 'anim@mp_player_intselfiethe_bird', 'idle_a', 3)) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{ 'anim@mp_player_intselfiethe_bird', 'idle_a' }}, true)
                    end
                end
            end
        },
        ['render'] = {
            key = 'f5',
            text = 'Animação - Se render',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if IsEntityPlayingAnim(ped, 'random@arrests@busted', 'idle_a', 3) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.CarregarAnim('random@arrests')
                        vRP.CarregarAnim('random@arrests@busted')
                        TaskPlayAnim(ped, 'random@arrests', 'idle_2_hands_up', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                        Wait(4000)
                        TaskPlayAnim(ped, 'random@arrests', 'kneeling_arrest_idle', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                        Wait(500)
                        TaskPlayAnim(ped, 'random@arrests@busted', 'enter', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                        Wait(1000)
                        TaskPlayAnim(ped, 'random@arrests@busted', 'idle_a', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
                        Wait(100)
                    end 
                end
            end
        },
        ['cancelar'] = {
            key = 'f6',
            text = 'Animação - Cancelar',
            action = function()
                if not LocalPlayer.state.conjuring then
                    local ped = PlayerPedId()
                    local menuCelular = vRP.getMenuCelular()
                    TriggerEvent('gb_animations:cancelSharedAnimation')
                    TriggerEvent('gb:CancelAnimations')
                    TriggerEvent('binoculos')
                    TriggerServerEvent('inventory:cancelItem')
                    cancelKeyMapping = false
                    if (GetEntityHealth(ped) > 100 and not menuCelular) then
                        disableActions(false)
                        vRP.DeletarObjeto()
                        ClearPedTasks(ped)
                    end
                end
            end
        },
        ['maoCabeca'] = {
            key = 'f10',
            text = 'Animação - Mãos na cabeça',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    if IsEntityPlayingAnim(ped, 'random@arrests@busted', 'idle_a', 3) then
                        vRP.DeletarObjeto()
                    else
                        vRP.DeletarObjeto()
                        vRP.playAnim(true, {{'random@arrests@busted', 'idle_a'}}, true)    
                    end            
                end
            end
        },
        ['levantarMaos'] = {
            key = 'x',
            text = 'Animação - Levantar as mãos',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not exports.inventory:verifyParachute(ped) and GetEntityHealth(ped) > 100) then
                    if (not IsPedInAnyVehicle(ped) and not menuCelular and not cancelKeyMapping) then
                        if IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3) then
                            vRP.DeletarObjeto()
                            LocalPlayer.state:set('Handsup',nil,true)
                        else
                            vRP.DeletarObjeto()
                            vRP.playAnim(true, {{'random@mugging3', 'handsup_standing_base'}}, true)
                            LocalPlayer.state:set('Handsup',true,true)
                        end
                    end
                end
            end
        },
        ['delete'] = {
            key = 'delete',
            text = 'Animação - Joia duplo',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    vRP.playAnim(true, {{ 'anim@mp_player_intincarthumbs_upbodhi@ps@', 'enter' }}, false)
                end
            end
        },
        ['assobiar'] = {
            key = 'down',
            text = 'Animação - Assobiar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    vRP.playAnim(true, {{ 'rcmnigel1c', 'hailing_whistle_waive_a' }}, false)
                end
            end
        },
        ['saudacao'] = {
            key = 'up',
            text = 'Animação - Saudação',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    vRP.playAnim(true, {{ 'anim@mp_player_intcelebrationmale@salute', 'salute' }}, false)
                end
            end
        },
        ['joia'] = {
            key = 'left',
            text = 'Animação - Joia',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    vRP.playAnim(true, {{ 'anim@mp_player_intselfiethumbs_up', 'idle_a' }}, false)
                end
            end
        },
        ['facepalm'] = {
            key = 'right',
            text = 'Animação - Facepalm',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()
                if (not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    vRP.playAnim(true, {{ 'anim@mp_player_intupperface_palm', 'idle_a' }}, false)
                end
            end
        },
        ['apontar'] = {
            key = 'b',
            text = 'Animação - Apontar',
            action = function()
                local ped = PlayerPedId()
                local menuCelular = vRP.getMenuCelular()

                if (IsPedArmed(ped, 4)) then return; end;

                if (GetEntityHealth(ped) > 100 and not menuCelular and not cancelKeyMapping) then
                    vRP.CarregarAnim('anim@mp_point')
                    if (not LocalPlayer.state.animApontar) then
                        SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                        SetPedConfigFlag(ped, 36, 1)
                        Citizen.InvokeNative(0x2D537BA194896636, ped, 'task_mp_pointing', 0.5, 0, 'anim@mp_point', 24)
                        LocalPlayer.state.animApontar = true
                        apontarThread(true)
                    else
                        Citizen.InvokeNative(0xD01015C7316AE176, ped, 'Stop')
                        if (not IsPedInjured(ped)) then ClearPedSecondaryTask(ped); end;
                        if (not IsPedInAnyVehicle(ped)) then SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1); end;
                        SetPedConfigFlag(ped, 36, 0)
                        ClearPedSecondaryTask(ped)
                        LocalPlayer.state.animApontar = false
                        apontarThread(false)
                    end
                end
            end
        },
        ['motor'] = {
            key = 'z',
            text = 'Ligar veículo',
            action = function()
                local ped = PlayerPedId()
                if (IsPedInAnyVehicle(ped)) then
                    local vehicle = GetVehiclePedIsIn(ped,false)
                    if (GetPedInVehicleSeat(vehicle,-1) == ped) then
                        if (Entity(vehicle).state['id']) or (Entity(vehicle).state['lockpicked']) then
                            vRP.DeletarObjeto()
                            local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E,vehicle)
                            SetVehicleEngineOn(vehicle,not running,true,true)
                            if (running) then
                                SetVehicleUndriveable(vehicle,true)
                            else
                                SetVehicleUndriveable(vehicle,false)
                            end
                        end
                    end
                end
            end
        },
    },
    ['shared'] = {
        ['otoscopio'] = {
            dict = 'gndostopiomedic@animations',
            anim = 'gndostopiomedic_clip',
            prop = 'gnd_ostopio_medic_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.06, 0.07, 0.01, -104.0, 182.0, 24.4 },
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
                RequestAnimDict('gndostopiomedic@animations')
                while (not HasAnimDictLoaded('gndostopiomedic@animations')) do Citizen.Wait(0); end;
                TaskPlayAnim(PlayerPedId(), 'gndostopiomedic@animations', 'gndostopiomedic_clip', 4.0, 4.0, -1, 50, 0.0)
            end,
            syncOption = {
                attachTo = true,
                xPos = -0.45,
                yPos = -0.05,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 280.0
            },
            otherAnim = 'otoscopio2',
            perm = 'hospital.permissao'
        },
        ['otoscopio2'] = {
            dict = 'gndostopiopacient@animations',
            anim = 'gndostopiopacient_clip',
            andar = false,
            loop = true,
            otherAnim = 'otoscopio',
        },
        ['otoscopio3'] = {
            dict = 'gndkidotoscopiomedic@animations',
            anim = 'gndkidotoscopiomedic_clip',
            prop = 'gnd_ostopio_medic_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.07, 0.1, -0.01, -93.73, -189.5, 30.0 },
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
                RequestAnimDict('gndkidotoscopiomedic@animations')
                while (not HasAnimDictLoaded('gndkidotoscopiomedic@animations')) do Citizen.Wait(0); end;
                TaskPlayAnim(PlayerPedId(), 'gndkidotoscopiomedic@animations', 'gndkidotoscopiomedic_clip', 4.0, 4.0, -1, 10, 0.0)
            end,
            syncOption = {
                attachTo = true,
                xPos = -0.18,
                yPos = -0.01,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 280.0
            },
            otherAnim = 'otoscopio4',
            perm = 'hospital.permissao'
        },
        ['otoscopio4'] = {
            dict = 'gndkidotoscopiopacient@animations',
            anim = 'gndkidotoscopiopacient_clip',
            andar = false,
            loop = true,
            otherAnim = 'otoscopio3',
        },
        ['cadeiraderodas'] = {
            dict = 'gndempurrandochairwhell@animations',
            anim = 'gndempurrandochairwhell_clip',
            prop = 'gnd_cadeira_de_rodas_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.81, 0.09, -0.24, 51.64, -91.5, 160.97 },
            andar = true,
            loop = true,
            extra = function()
                cancelKeyMapping = true
                RequestAnimDict('gndempurrandochairwhell@animations')
                while (not HasAnimDictLoaded('gndempurrandochairwhell@animations')) do Citizen.Wait(0); end;
                TaskPlayAnim(PlayerPedId(), 'gndempurrandochairwhell@animations', 'gndempurrandochairwhell_clip', 4.0, 4.0, -1, 50, 0.0)
                disableActions(true)
            end,
            syncOption = {
                attachTo = false,
                bone = 28442,
                xPos = 0.81,
                yPos = 0.09,
                zPos = -0.24,
                xRot = 51.64,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'cadeiraderodas2',
            perm = 'hospital.permissao'  
        },
        ['cadeiraderodas2'] = {
            dict = 'gndcadeirantepernaquebrada@animations',
            anim = 'gndcadeirantepernaquebrada_clip',
            andar = false,
            loop = true,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = 0.8,
                zPos = 0.0,
                xRot = -49.31,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'cadeiraderodas',
        },
        ['maca'] = {
            dict = 'gndempurrandomacasospackhospital@animations',
            anim = 'gndempurrandomacasospackhospital_clip',
            prop = 'gnd_maca_socorros',
            flag = 50,
            hand = 26614,
            pos = { 1.17, -0.23, -0.05, -101.17, -258.46, 5.43 },
            andar = true,
            loop = true,
            extra = function()
                cancelKeyMapping = true
                RequestAnimDict('gndempurrandomacasospackhospital@animations')
                while (not HasAnimDictLoaded('gndempurrandomacasospackhospital@animations')) do Citizen.Wait(0); end;
                TaskPlayAnim(PlayerPedId(), 'gndempurrandomacasospackhospital@animations', 'gndempurrandomacasospackhospital_clip', 4.0, 4.0, -1, 50, 0.0)
                disableActions(true)
            end,
            syncOption = {
                attachTo = false,
                bone = 28442,
                xPos = 0.81,
                yPos = 0.09,
                zPos = -0.24,
                xRot = 51.64,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'maca2',
            perm = 'hospital.permissao'  
        },
        ['maca2'] = {
            dict = 'anim@gangops@morgue@table@', 
            anim = 'body_search', 
            andar = false, 
            loop = true,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.05,
                yPos = 1.2,
                zPos = 1.05,
                xRot = -49.31,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'maca',
        },
        ['reanimar'] = {
            perm = 'hospital.permissao',
            dict = 'gndmedicdesfribilador@animations',
            anim = 'gndmedicdesfribilador_clip', 
            prop = { 'gnd_desfribilador_prop', 'gnd_desfribilador_prop' },
            flag = 50,
            hand = { 60309, 28422 },
            pos = { 0.07, 0.08, 0.02, -102.78, -70.6, 13.84 },
            pos2 = { 0.07, 0.07, -0.03, -85.36, -304.17, 13.84 },
            andar = false, 
            loop = true,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.2,
                yPos = -0.05,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'reanimar2'
        },
        ['reanimar2'] = {
            perm = 'hospital.permissao',
            dict = 'gndpacientdesfribilador@animations',
            anim = 'gndpacientdesfribilador_clip', 
            andar = false, 
            loop = true 
        },
        ['casal'] = {
            dict = 'genesismods@bmv_holdfacef',
            anim = 'holdfacef',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = 0.37,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal2',
        },
        ['casal2'] = {
            dict = 'genesismods@bmv_holdfacem',
            anim = 'holdfacem',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal',
        },
        ['casal3'] = {
            dict = 'genesismods@bmv_holdhandsf',
            anim = 'holdhandsf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = 0.61,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal4',
        },
        ['casal4'] = {
            dict = 'genesismods@bmv_holdhandsm',
            anim = 'holdhandsm',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal3',
        },
        ['casal5'] = {
            dict = 'genesismods@bmv_hugf',
            anim = 'hugf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.22,
                yPos = -0.15,
                zPos = -0.01,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'casal6',
        },
        ['casal6'] = {
            dict = 'genesismods@bmv_hugm',
            anim = 'hugm',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal5',
        },
        ['casal7'] = {
            dict = 'genesismods@bmv_hug2f',
            anim = 'hug2f',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.075,
                yPos = 0.35,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal8',
        },
        ['casal8'] = {
            dict = 'genesismods@bmv_hug2m',
            anim = 'hug2m',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal7',
        },
        ['casal9'] = {
            dict = 'genesismods@bmv_kissinghandf',
            anim = 'kissinghandf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.3,
                yPos = 0.4,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal10',
        },
        ['casal10'] = {
            dict = 'genesismods@bmv_kissinghandm',
            anim = 'kissinghandm',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal9',
        },
        ['casal11'] = {
            dict = 'genesismods@bmv_layingf',
            anim = 'layingf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 1.4,
                yPos = -0.005,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'casal12',
        },
        ['casal12'] = {
            dict = 'genesismods@bmv_layingm',
            anim = 'layingm',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal11',
        },
        ['casal13'] = {
            dict = 'genesismods@bmv_staref',
            anim = 'staref',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.05,
                yPos = -0.4,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal14',
        },
        ['casal14'] = {
            dict = 'genesismods@bmv_starem',
            anim = 'starem',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal13',
        },
        ['casal15'] = {
            dict = 'genesismods@bmv_proposalf',
            anim = 'proposalf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.2,
                yPos = 1.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 180.0
            },
            otherAnim = 'casal16',
        },
        ['casal16'] = {
            dict = 'genesismods@bmv_proposalm',
            anim = 'proposalm',
            prop = 'love_anel_genesis',
            flag = 50,
            hand = 28422,
            pos = { 0.08, 0.03, -0.08, 220.0, 11.51, 280.0 },
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'casal15',
        },
        ['sexo'] = {
            dict = 'genesismods@oralfixation_69f',
            anim = '69f',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = -0.6,
                yPos = 0.0,
                zPos = 0.1,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'sexo2',
        },
        ['sexo2'] = {
            dict = 'genesismods@oralfixation_69m',
            anim = '69m',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            otherAnim = 'sexo',
        },
        ['sexo3'] = {
            dict = 'genesismods@oralfixation_blowjobf',
            anim = 'blowjobf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = -0.6,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'sexo4',
        },
        ['sexo4'] = {
            dict = 'genesismods@oralfixation_blowjobm',
            anim = 'blowjobm',
            andar = false,
            loop = true,
            otherAnim = 'sexo3',
        },
        ['sexo5'] = {
            dict = 'genesismods@oralfixation_deepthroatf',
            anim = 'deepthroatf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = -0.6,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'sexo6',
        },
        ['sexo6'] = {
            dict = 'genesismods@oralfixation_deepthroatm',
            anim = 'deepthroatm',
            andar = false,
            loop = true,
            otherAnim = 'sexo5',
        },
        ['sexo7'] = {
            dict = 'genesismods@oralfixation_lickingf',
            anim = 'lickingf',
            andar = false,
            loop = true,
            extra = function()
                cancelKeyMapping = true
            end,
            syncOption = {
                attachTo = true,
                bone = 28442,
                xPos = 0.0,
                yPos = -0.8,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
            otherAnim = 'sexo8',
        },
        ['sexo8'] = {
            dict = 'genesismods@oralfixation_lickingm',
            anim = 'lickingm',
            andar = false,
            loop = true,
            otherAnim = 'sexo7',
        },
    },
    ['animations'] = {
        ['beijar'] = {
            noCommand = true, noDynamic = true,
            dict = 'mp_ped_interaction',
            anim = 'kisses_guy_a'
        },

        ['malhar'] = {
            dict = 'amb@world_human_muscle_free_weights@male@barbell@base', 
            anim = 'base', 
            prop = 'prop_curl_bar_01', 
            flag = 49, 
            hand = 28422 
        },
    
        ['malhar2'] = {
            dict = 'amb@prop_human_muscle_chin_ups@male@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },

        ['dormir'] = {
            dict = 'anim@heists@ornate_bank@hostages@hit', 
            anim = 'hit_react_die_loop_ped_a', 
            andar = false, 
            loop = true 
        },
        ['dormir2'] = {
            dict = 'anim@heists@ornate_bank@hostages@hit', 
            anim = 'hit_react_die_loop_ped_e', 
            andar = false, 
            loop = true 
        },
        ['dormir3'] = {
            dict = 'anim@heists@ornate_bank@hostages@hit', 
            anim = 'hit_react_die_loop_ped_h', 
            andar = false, 
            loop = true 
        },
        ['dormir4'] = {
            dict = 'mp_sleep', 
            anim = 'sleep_loop', 
            andar = false, 
            loop = true 
        },
        ['dormir5'] = {
            dict = 'missarmenian2', 
            anim = 'drunk_loop', 
            andar = false, 
            loop = true 
        },

        ['consertar'] = {
            title = 'Consertar',
            anim = 'WORLD_HUMAN_WELDING'
        },

        ['continencia'] = {
            title = 'Continência vibrante',
            dict = 'genesismodssalute',
            anim = 'salute',
            andar = false,
            loop = false,
        },
        ['continencia2'] = {
            title = 'Continência',
            dict = 'mp_player_int_uppersalute',
            anim = 'mp_player_int_salute',
            andar = true,
            loop = true,
        },
        ['raiox'] = {
            title = 'Raio X',
            dict = 'gndraioxavaliando@animations',
            anim = 'gndraioxavaliando_clip',
            prop = 'gnd_raio_x_paper',
            flag = 50,
            hand = 28422,
            pos = { 0.07, 0.09, -0.16, -54.53, 89.82, 11.75 },
            extra = function()
                print('teste raiox')
                RequestAnimDict('gndraioxavaliando@animations')
                while not HasAnimDictLoaded('gndraioxavaliando@animations') do Citizen.Wait(0); end;
	            TaskPlayAnim(PlayerPedId(), 'gndraioxavaliando@animations', 'gndraioxavaliando_clip', 4.0, 4.0, -1, 50, 0.0)
            end,
            andar = false,
            loop = true,
        },
        ['testededo'] = {
            title = 'Teste de dedo',
            prop = 'gnd_test_dedo_prop',
            flag = 50,
            hand = 28422,
            pos = { 0.14, 0.03, -0.03, -34.12, 11.51, -108.09 },
            andar = false,
            loop = true,
        },
        ['soro'] = {
            title = 'Soro',
            dict = 'gndpacientecarregandosoro@animations',
            anim = 'gndpacientecarregandosoro_clip',
            prop = 'gnd_prop_soro',
            flag = 50,
            hand = 60309,
            pos = { 0.0, -0.28, 0.04, -97.4, -98.66, 10.89 },
            extra = function()
                RequestAnimDict('gndpacientecarregandosoro@animations')
                while not HasAnimDictLoaded('gndpacientecarregandosoro@animations') do Citizen.Wait(0); end;
	            TaskPlayAnim(PlayerPedId(), 'gndpacientecarregandosoro@animations', 'gndpacientecarregandosoro_clip', 4.0, 4.0, -1, 49, 0.0)
                disableActions(true)
            end,
            andar = true,
            loop = true,
        },
        ['inalacao'] = {
            title = 'Inalação',
            dict = 'gndinalacaopacientepackhospital@animations',
            anim = 'gndinalacaopacientepackhospital_clip',
            prop = 'gnd_inalacao_prop',
            flag = 50,
            hand = 60309,
            pos = { 0.09, 0.01, 0.04, -191.18, -2.42, 113.74 },
            extra = function()
                RequestAnimDict('gndinalacaopacientepackhospital@animations')
                while not HasAnimDictLoaded('gndinalacaopacientepackhospital@animations') do Citizen.Wait(0); end;
	            TaskPlayAnim(PlayerPedId(), 'gndinalacaopacientepackhospital@animations', 'gndinalacaopacientepackhospital_clip', 4.0, 4.0, -1, 15, 0.0)
            end,
            andar = true,
            loop = true,
        },
        ['medico'] = {
            title = 'Maleta de utensílios',
            prop = 'gnd_bag_paramedic',
            flag = 50,
            hand = 28422,
            pos = { 0.19, -0.01, 0.03, 6.04, -87.58, -124.32 },
            extra = function()
                RequestModel(GetHashKey('gnd_bag_paramedic'))
                while not HasModelLoaded(GetHashKey('gnd_bag_paramedic')) do Citizen.Wait(10); end;
            end,
            andar = true,
            loop = true,
            perm = 'hospital.permissao'
        },
        ['medico2'] = {
            title = 'Maleta do desfribilador',
            prop = 'gnd_desfribilador_maleta',
            flag = 50,
            hand = 28422,
            pos = { 0.2, 0.0, 0.04, -14.52, -84.7, 68.97 },
            extra = function()
                RequestModel(GetHashKey('gnd_desfribilador_maleta'))
                while not HasModelLoaded(GetHashKey('gnd_desfribilador_maleta')) do Citizen.Wait(10); end;
            end,
            andar = true,
            loop = true,
        },

        ['mexer'] = {
            dict = 'amb@prop_human_parking_meter@female@idle_a',
            anim = 'idle_a_female',
            andar = true,
            loop = true
        },

        ['comer'] = {
            dict = 'mp_player_inteat@burger',
            anim = 'mp_player_int_eat_burger',
            prop = 'prop_peyote_chunk_01',
            flag = 49,
            hand = 60309,
            andar = true,
            loop = false
        },

        ['deitar'] = {
            dict = 'amb@world_human_sunbathe@female@back@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
        ['deitar2'] = {
            dict = 'amb@world_human_sunbathe@female@front@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
        ['deitar3'] = {
            dict = 'amb@world_human_sunbathe@male@back@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
        ['deitar4'] = {
            dict = 'amb@world_human_sunbathe@male@front@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
        ['deitar5'] = {
            dict = 'mini@cpr@char_b@cpr_str', 
            anim = 'cpr_kol_idle', 
            andar = false, 
            loop = true 
        },
        ['deitar6'] = {
            dict = 'switch@trevor@scares_tramp', 
            anim = 'trev_scares_tramp_idle_tramp', 
            andar = false, 
            loop = true 
        },
        ['deitar7'] = {
            dict = 'switch@trevor@annoys_sunbathers',
            anim = 'trev_annoys_sunbathers_loop_girl',
            andar = false, 
            loop = true 
        },
        ['deitar8'] = {
            dict = 'switch@trevor@annoys_sunbathers',
            anim = 'trev_annoys_sunbathers_loop_guy', 
            andar = false, 
            loop = true 
        },
        ['deitar9'] = {
            dict = 'anim@gangops@morgue@table@', 
            anim = 'body_search', 
            andar = false, 
            loop = true 
        },
        ['bilie'] = {
            dict = 'biliejean@santorostore', 
            anim = 'jean_sant',
            loop = true,
            andar = false, 
        },
        ['desenrola'] = {
            dict = 'desenroladeladinho@santorostore', 
            anim = 'desenroladeladinho',
            loop = true,
            andar = false, 
        },
        ['pose1'] = { 
            dict = 'genesismods@stepback', 
            anim = 'pose1',
            loop = true,
            andar = false, 
        },
        ['pose2'] = { 
            dict = 'genesismods@stepbackp2', 
            anim = 'pose2',
            loop = true,
            andar = false, 
        },
        ['pose3'] = { 
            dict = 'genesismods@stepbackp3', 
            anim = 'pose3',
            loop = true,
            andar = false, 
        },
        ['pose4'] = { 
            dict = 'genesismods@stepbackp4', 
            anim = 'pose4',
            loop = true,
            andar = false, 
        },
        ['pose5'] = { 
            dict = 'genesismods@stepbackp5', 
            anim = 'pose5',
            loop = true,
            andar = false, 
        },
        ['pose6'] = { 
            dict = 'genesismods@stepbackp6', 
            anim = 'pose6',
            loop = true,
            andar = false, 
        },
        ['pose7'] = { 
            dict = 'genesismods@stepbackp7', 
            anim = 'pose7',
            loop = true,
            andar = false, 
        },
        ['pegar'] = { 
            dict = 'pickup_object', 
            anim = 'pickup_low',
            loop = true,
            andar = false, 
        },
        ['radio2'] = {
            prop = 'prop_boombox_01',
            flag = 50,
            hand = 57005,
            pos = {0.30,0,0,0,260.0,60.0}   
        },
        ['bolsa'] = {
            perm = 'policia.permissao',
            prop = 'prop_boombox_01',
            flag = 50,
            hand = 57005,
            pos = {0.16,0,0,0,260.0,60.0}
        },
        ['bolsa2'] = {
            prop = 'prop_ld_case_01_s',
            flag = 50,
            hand = 57005,
            pos = {0.16,0,0,0,260.0,60.0}
        },
        ['bolsa3'] = {
            prop = 'prop_security_case_01',
            flag = 50,
            hand = 57005,
            pos = {0.16,0,-0.01,0,260.0,60.0}
        
        },
        ['bolsa4'] = {
            prop = 'w_am_case', 
            flag = 50, 
            hand = 57005, 
            pos = {0.08,0,0,0,260.0,60.0}
        
        },
        ['bolsa5'] = {
            prop = 'prop_ld_suitcase_01',
            flag = 50,
            hand = 57005,
            pos = {0.39,0,0,0,260.0,60.0}
        },
        ['bolsa6'] = {
            prop = 'xm_prop_x17_bag_med_01a',
            flag = 50,
            hand = 57005,
            pos = {0.43,0,0.04,0,260.0,60.0}
        },
        ['bolsa7'] = { 
            dict = 'move_weapon@jerrycan@generic', 
            anim = 'idle',
            prop = 'prop_ld_suitcase_01',
            hand = 57005,
            flag = 50,
            pos = {0.35, 0.0, 0.0, 0.0, 266.0, 90.0},
            loop = true,
            andar = true,
        },
        ['bolsa8'] = { 
            dict = 'move_weapon@jerrycan@generic', 
            anim = 'idle',
            prop = 'prop_security_case_01',
            hand = 57005,
            flag = 50,
            pos = {0.13, 0.0, -0.01, 0.0, 280.0, 90.0},
            loop = true,
            andar = true,
        },
        ['caixa2'] = {
            prop = 'prop_tool_box_04', 
            flag = 50, 
            hand = 57005, 
            pos = {0.45,0,0.05,0,260.0,60.0}   
        },
        ['caixa3'] = {
            dict = 'anim@heists@box_carry@', 
            anim = 'idle',
            prop = 'xm_prop_smug_crate_s_medical',
            flag = 50,
            hand = 28422
        },
        ['bandeja'] = {
            andar = true,
            dict = 'anim@heists@box_carry@', 
            anim = 'idle',
            prop = 'sanhje_Prison_Cafeteria_Tray',
            flag = 50,
            hand = 28422,
            pos = {0.0,-0.1,-0.15, 0.0,0.0,0.0}   
        },
        ['lixo'] = {
            prop = 'prop_cs_rub_binbag_01', 
            flag = 50, 
            hand = 57005, 
            pos = {0.11, 0, 0.0, 0, 260.0, 60.0}
        },
        ['mic'] = { 
            prop = 'prop_microphone_02', 
            flag = 50, 
            hand = 60309, 
            pos = {0.08, 0.03, 0.0, 240.0, 0.0, 0.0}
        },
        ['mic2'] = { 
            prop = 'p_ing_microphonel_01', 
            flag = 50, 
            hand = 60309, 
            pos = {0.08, 0.03, 0.0, 240.0, 0.0, 0.0}
        },
        ['mic3'] = { 
            dict = 'missfra1', 
            anim = 'mcs2_crew_idle_m_boom', 
            prop = 'prop_v_bmike_01', 
            flag = 50, 
            hand = 28422
        },
        ['mic4'] = {
            dict = 'missmic4premiere', 
            anim = 'interview_short_lazlow',
            prop = 'p_ing_microphonel_01',
            flag = 50,
            hand = 28422
        },
        ['mic5'] = {
            dict = 'anim@random@shop_clothes@watches', 
            anim = 'base',
            prop = 'p_ing_microphonel_01', 
            andar = true, 
            loop = true,
            flag = 49,
            hand = 60309,
            pos = {0.10,0.04,0.012,-60.0,60.0,-30.0}, 
            propAnim = true
        },
        ['buque'] = { 
            prop = 'prop_snow_flower_02', 
            flag = 50, 
            hand = 60309, 
            pos = {0.0,0.0,0.0,300.0,0.0,0.0},
        },
        ['rosa'] = {
            prop = 'prop_single_rose', 
            flag = 50, 
            hand = 60309, 
            pos = {0.055, 0.05, 0.0, 240.0, 0.0, 0.0}
        },
        ['rosa2'] = { 
            dict = 'anim@heists@humane_labs@finale@keycards', 
            anim = 'ped_a_enter_loop', 
            prop = 'prop_single_rose',
            hand = 18905,
            pos = {0.055, 0.05, 0.0, 240.0, 0.0, 0.0},
            flag = 50,
            loop = true,
                andar = true,
        },
        ['prebeber'] = { 
            dict = 'amb@code_human_wander_drinking@beer@male@base', 
            anim = 'static', 
            prop = 'prop_fib_coffee', 
            flag = 49, 
            hand = 28422
        },
        ['prebeber2'] = { 
            dict = 'amb@code_human_wander_drinking@beer@male@base',
            anim = 'static', 
            prop = 'prop_ld_flow_bottle', 
            flag = 49, 
            hand = 28422
        },
        ['prebeber3'] = { 
            dict = 'amb@code_human_wander_drinking@beer@male@base', 
            anim = 'static', 
            prop = 'prop_cs_bs_cup', 
            flag = 49, 
            hand = 28422 
        },
        ['verificar'] ={ 
            dict = 'amb@medic@standing@tendtodead@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
        ['cuidar'] = { 
            dict = 'mini@cpr@char_a@cpr_str', 
            anim = 'cpr_pumpchest', 
            andar = true, 
            loop = true 
        },
        ['cuidar2'] = { 
            dict = 'mini@cpr@char_a@cpr_str', 
            anim = 'cpr_kol', 
            andar = true, 
            loop = true 
        },
        ['cuidar3'] = { 
            dict = 'mini@cpr@char_a@cpr_str', 
            anim = 'cpr_kol_idle', 
            andar = true, 
            loop = true 
        },
        ['cansado'] = { 
            dict = 'rcmbarry', 
            anim = 'idle_d', 
            andar = false, 
            loop = true 
        },
        ['alongar2'] = { 
            dict = 'mini@triathlon', 
            anim = 'idle_e', 
            andar = false, 
            loop = true 
        },
        ['alongar6'] = {
            dict = 'rcmfanatic1maryann_stretchidle_b', 
            anim = 'idle_e', 
            andar = false, 
            loop = true
        },
        ['alongar7'] = {
            dict = 'timetable@reunited@ig_2', 
            anim = 'jimmy_getknocked', 
            andar = false, 
            loop = true
        },
        ['meleca'] = { 
            dict = 'anim@mp_player_intuppernose_pick', 
            anim = 'idle_a', 
            andar = true, 
            loop = true 
        },
        ['bora'] = { 
            dict = 'missfam4', 
            anim = 'say_hurry_up_a_trevor', 
            andar = true, 
            loop = false 
        },
        ['limpar'] = {
            dict = 'missfbi3_camcrew', 
            anim = 'final_loop_guy', 
            andar = true, 
            loop = false 
        },
        ['galinha'] = { 
            dict = 'random@peyote@chicken', 
            anim = 'wakeup', 
            andar = true, 
            loop = true 
        },
        ['amem'] = { 
            dict = 'rcmepsilonism8', 
            anim = 'worship_base', 
            andar = true, 
            loop = true 
        },
        ['nervoso'] = { 
            dict = 'rcmme_tracey1', 
            anim = 'nervous_loop', 
            andar = true, 
            loop = true 
        },
        ['ajoelhar'] = { 
            dict = 'amb@medic@standing@kneel@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
        ['sinalizar'] = { 
            dict = 'amb@world_human_car_park_attendant@male@base', 
            anim = 'base', 
            prop = 'prop_parking_wand_01', 
            flag = 49, 
            hand = 28422 
        },
        ['placa'] = { 
            dict = 'amb@world_human_bum_freeway@male@base', 
            anim = 'base', 
            prop = 'prop_beggers_sign_01', 
            flag = 49, 
            hand = 28422 
        },
        ['placa2'] = { 
            dict = 'amb@world_human_bum_freeway@male@base', 
            anim = 'base', 
            prop = 'prop_beggers_sign_03', 
            flag = 49, 
            hand = 28422 
        },
        ['placa3'] = { 
            dict = 'amb@world_human_bum_freeway@male@base', 
            anim = 'base', 
            prop = 'prop_beggers_sign_04', 
            flag = 49, 
            hand = 28422 
        },
        ['placa4'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_sign_road_01a',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['placa5'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_sign_road_02a',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['placa6'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_sign_road_03d',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['placa7'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_sign_road_04a',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['placa8'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_sign_road_04w',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['placa9'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_sign_road_05a',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['placa10'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_sign_road_05t',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['placa11'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_sign_freewayentrance',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['placa12'] = { 
            dict = 'rcmnigel1d', 
            anim = 'base_club_shoulder',
            prop = 'prop_snow_sign_road_01a',
            hand = 60309,
            flag = 50,
            pos = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
            loop = true,
            andar = true
        },
        ['abanar'] = { 
            dict = 'timetable@amanda@facemask@base', 
            anim = 'base', 
            andar = true, 
            loop = true 
        },
        ['cocada'] = { 
            dict = 'mp_player_int_upperarse_pick', 
            anim = 'mp_player_int_arse_pick', 
            andar = true, 
            loop = true 
        },
        ['cocada2'] = { 
            dict = 'mp_player_int_uppergrab_crotch', 
            anim = 'mp_player_int_grab_crotch', 
            andar = true, 
            loop = true 
        },
        ['lero'] = { 
            dict = 'anim@mp_player_intselfiejazz_hands', 
            anim = 'idle_a', 
            andar = true, 
            loop = false 
        },
        ['lero2'] = {
            dict = 'anim@mp_player_intcelebrationfemale@thumb_on_ears', 
            anim = 'thumb_on_ears', 
            andar = false, 
            loop = false
        },
        ['lero3'] = {
            dict = 'anim@mp_player_intcelebrationfemale@cry_baby', 
            anim = 'cry_baby', 
            andar = false, 
            loop = false
        },
        ['dj2'] = { 
            dict = 'anim@mp_player_intupperair_synth', 
            anim = 'idle_a_fp', 
            andar = false, 
            loop = true 
        },
        ['dj3'] = {
            dict = 'anim@mp_player_intcelebrationfemale@air_synth', 
            anim = 'air_synth', 
            andar = false, 
            loop = false
        },
        ['dj4'] = {
            dict = 'anim@amb@nightclub@djs@dixon@', 
            anim = 'dixn_dance_cntr_open_dix',
            loop = true,
            andar = true,
        },
        ['dj5'] = { 
            dict = 'anim@amb@nightclub@djs@solomun@', 
            anim = 'sol_idle_ctr_mid_a_sol',
            loop = true,
            andar = false,
        },
        ['dj6'] = {
            dict = 'anim@amb@nightclub@djs@solomun@', 
            anim = 'sol_dance_l_sol',
            loop = true,
            andar = false,
        },
        ['dj7'] = {
            dict = 'anim@amb@nightclub@djs@black_madonna@', 
            anim = 'dance_b_idle_a_blamadon',
            loop = true,
            andar = false,
        },
        ['dj8'] = {
            dict = 'anim@amb@nightclub@djs@dixon@', 
            anim = 'dixn_end_dix',
            loop = true,
            andar = false,
        },
        ['dj9'] = {
            dict = 'anim@amb@nightclub@djs@dixon@', 
            anim = 'dixn_idle_cntr_a_dix',
            loop = true,
            andar = false,
        },
        ['dj10'] = {
            dict = 'anim@amb@nightclub@djs@dixon@', 
            anim = 'dixn_idle_cntr_b_dix',
            loop = true,
            andar = false,
        },
        ['dj11'] = {
            dict = 'anim@amb@nightclub@djs@dixon@', 
            anim = 'dixn_idle_cntr_g_dix',
            loop = true,
            andar = false,
        },
        ['dj12'] = {
            dict = 'anim@amb@nightclub@djs@dixon@', 
            anim = 'dixn_idle_cntr_gb_dix',
            loop = true,
            andar = false,
        },
        ['dj13'] = {
            dict = 'anim@amb@nightclub@djs@dixon@', 
            anim = 'dixn_sync_cntr_j_dix',
            loop = true,
            andar = false,
        },
        ['beijo2'] = {
            dict = 'anim@mp_player_intcelebrationfemale@blow_kiss', 
            anim = 'blow_kiss', 
            andar = true, 
            loop = false
        },
        ['malicia'] = { 
            dict = 'anim@mp_player_intupperdock', 
            anim = 'idle_a', 
            andar = true, 
            loop = false 
        },
        ['ligar'] = { 
            dict = 'cellphone@', 
            anim = 'cellphone_call_in', 
            prop = 'prop_amb_phone', 
            flag = 50, 
            hand = 28422 
        },
        ['radio'] = { 
            dict = 'cellphone@', 
            anim = 'cellphone_call_in', 
            prop = 'prop_cs_hand_radio', 
            flag = 50, 
            hand = 28422 
        },
        ['cafe'] = { 
            dict = 'amb@world_human_aa_coffee@base', 
            anim = 'base', 
            prop = 'prop_fib_coffee', 
            flag = 50, 
            hand = 28422 
        },
        ['cafe2'] = { 
            dict = 'amb@world_human_aa_coffee@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_fib_coffee', 
            flag = 49, 
            hand = 28422 
        },
        ['caixa'] = { 
            dict = 'anim@heists@box_carry@', 
            anim = 'idle', 
            prop = 'hei_prop_heist_box', 
            flag = 50, 
            hand = 28422 
        },
        ['chuva'] = { 
            dict = 'amb@world_human_drinking@coffee@male@base', 
            anim = 'base', 
            prop = 'p_amb_brolly_01', 
            flag = 50, 
            hand = 28422 
        },
        ['chuva2'] = {
            dict = 'amb@world_human_drinking@coffee@male@base', 
            anim = 'base', 
            prop = 'p_amb_brolly_01_s', 
            flag = 50, 
            hand = 28422 
        },
        ['comer2'] = { 
            dict = 'amb@code_human_wander_eating_donut@male@idle_a', 
            anim = 'idle_c', 
            prop = 'prop_cs_hotdog_01', 
            flag = 49, 
            hand = 28422
        },
        ['comer3'] = { 
            dict = 'amb@code_human_wander_eating_donut@male@idle_a', 
            anim = 'idle_c', 
            prop = 'prop_amb_donut', 
            flag = 49,
            hand = 28422 
        },
        ['comer4'] = {
            dict = 'mp_player_inteat@burger', 
            anim = 'mp_player_int_eat_burger',
            prop = 'prop_sandwich_01',
            flag = 49,
            hand = 60309
        },
        ['comer5'] = {
            dict = 'mp_player_inteat@burger', 
            anim = 'mp_player_int_eat_burger',
            prop = 'prop_choc_ego',
            flag = 49,
            hand = 60309
        },
        ['beber'] = { 
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'p_cs_bottle_01', 
            flag = 49, 
            hand = 28422 
        },
        ['beber2'] = { 
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_energy_drink', 
            flag = 49, 
            hand = 28422 
        },
        ['beber3'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_amb_beer_bottle', 
            flag = 49, 
            hand = 28422 
        },
        ['beber4'] = { 
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'p_whiskey_notop', 
            flag = 49, 
            hand = 28422 
        },
        ['beber5'] = { 
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_beer_logopen', 
            flag = 49, 
            hand = 28422 
        },
        ['beber6'] = { 
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_beer_blr', 
            flag = 49, 
            hand = 28422 
        },
        ['beber7'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_ld_flow_bottle', 
            flag = 49, 
            hand = 28422 
        },
        ['coca'] = {
            dict = 'anim@amb@business@coc@coc_packing_hi@', 
            anim = 'full_cycle_v3_pressoperator', 
            andar = false, 
            loop = true
        },
        ['beijo'] = { 
            dict = 'anim@mp_player_intselfieblow_kiss', 
            anim = 'exit', 
            andar = true, 
            loop = false 
        },
        ['digitar'] = { 
            dict = 'anim@heists@prison_heistig1_p1_guard_checks_bus', 
            anim = 'loop', 
            andar = false, 
            loop = true 
        },
        ['digitar2'] = {
            dict = 'mp_fbi_heist', 
            anim = 'loop', 
            andar = false, 
            loop = true
        },
        ['atm'] = { 
            dict = 'amb@prop_human_atm@male@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = false 
        },
        ['no'] = {
            dict = 'mp_player_int_upper_nod', 
            anim = 'mp_player_int_nod_no', 
            andar = true, 
            loop = true 
        },
        ['palmas'] = { 
            dict = 'anim@mp_player_intcelebrationfemale@slow_clap', 
            anim = 'slow_clap', 
            andar = true, 
            loop = false 
        },
        ['palmas2'] = { 
            dict = 'amb@world_human_cheering@male_b', 
            anim = 'base', 
            andar = true, 
            loop = true 
        },
        ['palmas3'] = { 
            dict = 'amb@world_human_cheering@male_d', 
            anim = 'base', 
            andar = true, 
            loop = true 
        },
        ['palmas4'] = { 
            dict = 'amb@world_human_cheering@male_e', 
            anim = 'base', 
            andar = true, 
            loop = true 
        },
        ['palmas5'] = { 
            dict = 'anim@arena@celeb@flat@solo@no_props@', 
            anim = 'angry_clap_a_player_a', 
            andar = false, 
            loop = true 
        },
        ['palmas6'] = { 
            dict = 'anim@mp_player_intupperslow_clap', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
        ['postura'] = { 
            dict = 'anim@heists@prison_heiststation@cop_reactions', 
            anim = 'cop_a_idle', 
            andar = true, 
            loop = true 
        },
        ['postura2'] = { 
            dict = 'amb@world_human_cop_idles@female@base', 
            anim = 'base', 
            andar = true, 
            loop = true 
        },
        ['varrer'] = { 
            dict = 'amb@world_human_janitor@male@idle_a', 
            anim = 'idle_a',
            prop = 'prop_tool_broom', 
            flag = 49, 
            hand = 28422 
        },
        ['musica'] = { 
            dict = 'amb@world_human_musician@guitar@male@base', 
            anim = 'base', 
            prop = 'prop_el_guitar_01', 
            flag = 49, 
            hand = 60309 
        },
        ['musica2'] = { 
            dict = 'amb@world_human_musician@guitar@male@base', 
            anim = 'base', 
            prop = 'prop_el_guitar_02', 
            flag = 49, 
            hand = 60309 
        },
        ['musica3'] = { 
            dict = 'amb@world_human_musician@guitar@male@base', 
            anim = 'base', 
            prop = 'prop_el_guitar_03', 
            flag = 49, 
            hand = 60309 
        },
        ['musica4'] = { 
            dict = 'amb@world_human_musician@guitar@male@base', 
            anim = 'base', 
            prop = 'prop_acc_guitar_01', 
            flag = 49, 
            hand = 60309
        },
        ['camera'] = { 
            dict = 'amb@world_human_paparazzi@male@base', 
            anim = 'base', 
            prop = 'prop_pap_camera_01', 
            flag = 49, 
            hand = 28422
        },
        ['camera2'] = { 
            dict = 'missfinale_c2mcs_1', 
            anim = 'fin_c2_mcs_1_camman', 
            prop = 'prop_v_cam_01', 
            flag = 49, 
            hand = 28422,
            extra = function()
                TriggerEvent('inventory:camera', true)
            end
        },
        ['camera3'] = { 
            dict = 'missfinale_c2mcs_1', 
            anim = 'fin_c2_mcs_1_camman', 
            prop = 'prop_film_cam_01', 
            flag = 49, 
            hand = 28422,
            extra = function()
                TriggerEvent('inventory:camera', true)
            end
        },
        ['gift'] = { 
            dict = 'genesismods@gift', 
            anim = 'gift',
            loop = false,
            andar = false, 
            extra = function()
                vRP._CarregarObjeto('', '', 'genesisxmasgift', 49, 57005, 0.10, 0.0, -0.02, 180.0, 0.0, 0.0)
            end
        },
        ['gift2'] = { 
            dict = 'genesismods@gift', 
            anim = 'gift',
            loop = false,
            andar = false, 
            extra = function()
                vRP._CarregarObjeto('', '', 'genesisxmasgift2', 49, 57005, 0.10, 0.0, -0.02, 180.0, 0.0, 0.0)
            end
        },
        ['prancheta'] = { 
            dict = 'amb@world_human_clipboard@male@base', 
            anim = 'base', 
            prop = 'p_amb_clipboard_01', 
            flag = 50, 
            hand = 60309 
        },
        ['mapa'] = { 
            dict = 'amb@world_human_clipboard@male@base', 
            anim = 'base', 
            prop = 'prop_tourist_map_01', 
            flag = 50, 
            hand = 60309 
        },
        ['anotar'] = { 
            dict = 'amb@medic@standing@timeofdeath@base', 
            anim = 'base', 
            prop = 'prop_notepad_01', 
            flag = 49, 
            hand = 60309 
        },
        ['peace'] = { 
            dict = 'mp_player_int_upperpeace_sign', 
            anim = 'mp_player_int_peace_sign', 
            andar = true, 
            loop = true 
        },
        ['peace2'] = { 
            dict = 'anim@mp_player_intupperpeace', 
            anim = 'idle_a', 
            andar = true, 
            loop = true 
        },
        ['debrucar'] = { 
            dict = 'amb@prop_human_bum_shopping_cart@male@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
        ['dancar'] = { 
            dict = 'rcmnigel1bnmt_1b', 
            anim = 'dance_loop_tyler', 
            andar = false, 
            loop = true 
        },
        ['dancar2'] = { 
            dict = 'mp_safehouse', 
            anim = 'lap_dance_girl', 
            andar = false, 
            loop = true 
        },
        ['dancar3'] = { 
            dict = 'misschinese2_crystalmazemcs1_cs', 
            anim = 'dance_loop_tao', 
            andar = false, 
            loop = true 
        },
        ['dancar4'] = { 
            dict = 'mini@strip_club@private_dance@part1', 
            anim = 'priv_dance_p1', 
            andar = false, 
            loop = true 
        },
        ['dancar5'] = { 
            dict = 'mini@strip_club@private_dance@part2', 
            anim = 'priv_dance_p2', 
            andar = false, 
            loop = true 
        },
        ['dancar6'] = { 
            dict = 'mini@strip_club@private_dance@part3', 
            anim = 'priv_dance_p3', 
            andar = false, 
            loop = true 
        },
        ['dancar7'] = { 
            dict = 'special_ped@mountain_dancer@monologue_2@monologue_2a', 
            anim = 'mnt_dnc_angel', 
            andar = false, 
            loop = true 
        },
        ['dancar8'] = { 
            dict = 'special_ped@mountain_dancer@monologue_3@monologue_3a', 
            anim = 'mnt_dnc_buttwag', 
            andar = false, 
            loop = true 
        },
        ['dancar9'] = { 
            dict = 'missfbi3_sniping', 
            anim = 'dance_m_default', 
            andar = false, 
            loop = true 
        },
        ['dancar10'] =	{ 
            dict = 'anim@amb@nightclub@dancers@black_madonna_entourage@', 
            anim = 'hi_dance_facedj_09_v2_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar11'] =	{ 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar12'] =	{ 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_female^2', 
            andar = false,
            loop = true 
        },
        ['dancar13'] =	{ 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar14'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar15'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar16'] =	{ 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar17'] = {
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar18'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar19'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar20'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar21'] =	{ 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar22'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v1_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar23'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar24'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar25'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar26'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar27'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar28'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar29'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar30'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar31'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar32'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar33'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar34'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar35'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar36'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar37'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar38'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar39'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar40'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar41'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar42'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar43'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar44'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar45'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar46'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v1_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar47'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar48'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar49'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_female^3', 
            andar = false,
            loop = true 
        },
        ['dancar50'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar51'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar52'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar53'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar54'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar55'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar56'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar57'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar58'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_11_v2_male^6', 
            andar = false, 
            loop = true
        },
        ['dancar59'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar60'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar61'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar62'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar63'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar64'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar65'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar66'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar67'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar68'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar69'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar70'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v1_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar71'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar72'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar73'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar74'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar75'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar76'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_female^6', 
            andar = false, 
            loop = true
        },
        ['dancar77'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar78'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar79'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar80'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar81'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar82'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_13_v2_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar83'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar84'] =	{ 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar85'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_female^3', 
            andar = false, 
            loop = true
        },
        ['dancar86'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar87'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar88'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar89'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar90'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar91'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar92'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar93'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar94'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v1_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar95'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar96'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar97'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar98'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar99'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar100'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar101'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar102'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar103'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar104'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar105'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar106'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_15_v2_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar107'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar108'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar109'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar110'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar111'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar112'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar113'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar114'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar115'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar116'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar117'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar118'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v1_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar119'] = {
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar120'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar121'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar122'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar123'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar124'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar125'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar126'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar127'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar128'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar129'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar130'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_17_v2_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar131'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar132'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar133'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar134'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar135'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar136'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar137'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar138'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar139'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar140'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar141'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar142'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v1_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar143'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar144'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar145'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar146'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar147'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar148'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar149'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar150'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar151'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar152'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar153'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar154'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_09_v2_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar155'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar156'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar157'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_female^3', 
            andar = false, 
            loop = true 
        },
    
        ['dancar158'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_female^4', 
            andar = false, 
            loop = true 
        },
    
        ['dancar159'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_female^5', 
            andar = false, 
            loop = true 
        },
    
        ['dancar160'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_female^6', 
            andar = false, 
            loop = true 
        },
    
        ['dancar161'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_male^1', 
            andar = false, 
            loop = true 
        },
    
        ['dancar162'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_male^2', 
            andar = false, 
            loop = true 
        },
    
        ['dancar163'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_male^3', 
            andar = false, 
            loop = true 
        },
    
        ['dancar164'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_male^4', 
            andar = false, 
            loop = true 
        },
    
        ['dancar165'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_male^5', 
            andar = false, 
            loop = true 
        },
    
        ['dancar166'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_11_v1_male^6', 
            andar = false, 
            loop = true 
        },
    
        ['dancar167'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_female^1', 
            andar = false, 
            loop = true 
        },
    
        ['dancar168'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_female^2', 
            andar = false, 
            loop = true 
        },
    
        ['dancar169'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_female^3', 
            andar = false, 
            loop = true 
        },
    
        ['dancar170'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_female^4', 
            andar = false, 
            loop = true 
        },
    
        ['dancar171'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_female^5', 
            andar = false, 
            loop = true 
        },
    
        ['dancar172'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_female^6', 
            andar = false, 
            loop = true 
        },
    
        ['dancar173'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_male^1', 
            andar = false, 
            loop = true 
        },
    
        ['dancar174'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_male^2', 
            andar = false, 
            loop = true 
        },
    
        ['dancar175'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_male^3', 
            andar = false, 
            loop = true 
        },
    
        ['dancar176'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_male^4', 
            andar = false, 
            loop = true 
        },
    
        ['dancar177'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_male^5', 
            andar = false, 
            loop = true 
        },
    
        ['dancar178'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_13_v2_male^6', 
            andar = false, 
            loop = true 
        },
    
        ['dancar179'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_female^1', 
            andar = false, 
            loop = true 
        },
    
        ['dancar180'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_female^2', 
            andar = false, 
            loop = true 
        },
    
        ['dancar181'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_female^3', 
            andar = false, 
            loop = true 
        },
    
        ['dancar182'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_female^4', 
            andar = false, 
            loop = true 
        },
    
        ['dancar183'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_female^5', 
            andar = false, 
            loop = true 
        },
    
        ['dancar184'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_female^6', 
            andar = false, 
            loop = true 
        },
    
        ['dancar185'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar186'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar187'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar188'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar189'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar190'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v1_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar191'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar192'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar193'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar194'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar195'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar196'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar197'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar198'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar199'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar200'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar201'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar202'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_15_v2_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar203'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar204'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar205'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar206'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar207'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar208'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar209'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar210'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar211'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_male^3', 
            andar = false, 
            loop = true 
        },
        ['dancar212'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_male^4', 
            andar = false, 
            loop = true 
        },
        ['dancar213'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_male^5', 
            andar = false, 
            loop = true 
        },
        ['dancar214'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v1_male^6', 
            andar = false, 
            loop = true 
        },
        ['dancar215'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_female^1', 
            andar = false, 
            loop = true 
        },
        ['dancar216'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_female^2', 
            andar = false, 
            loop = true 
        },
        ['dancar217'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_female^3', 
            andar = false, 
            loop = true 
        },
        ['dancar218'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_female^4', 
            andar = false, 
            loop = true 
        },
        ['dancar219'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_female^5', 
            andar = false, 
            loop = true 
        },
        ['dancar220'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_female^6', 
            andar = false, 
            loop = true 
        },
        ['dancar221'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_male^1', 
            andar = false, 
            loop = true 
        },
        ['dancar222'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_male^2', 
            andar = false, 
            loop = true 
        },
        ['dancar223'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_male^3', 
            andar = false, 
            loop = true 
        },
    
        ['dancar224'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_male^4', 
            andar = false, 
            loop = true 
        },
    
        ['dancar225'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_male^5', 
            andar = false, 
            loop = true 
        },
    
        ['dancar226'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', 
            anim = 'hi_dance_crowd_17_v2_male^6', 
            andar = false, 
            loop = true 
        },
    
        ['dancar227'] = { 
            dict = 'anim@mp_player_intcelebrationfemale@the_woogie', 
            anim = 'the_woogie', 
            andar = false, 
            loop = true 
        },
        
        ['dancar228'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_center_up', 
            andar = false, 
            loop = true 
        },
        
        ['dancar229'] = { 
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center', 
            andar = false, 
            loop = true 
        },
        
        ['dancar230'] = { 
            dict = 'timetable@tracy@ig_8@idle_b', 
            anim = 'idle_d', 
            andar = false, 
            loop = true 
        },
    
        ['dancar231'] = { 
            dict = 'timetable@tracy@ig_5@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['dancar232'] = { 
            dict = 'anim@amb@nightclub@lazlow@hi_podium@', 
            anim = 'danceidle_hi_11_buttwiggle_b_laz', 
            andar = false, 
            loop = true 
        },
    
        ['dancar233'] = { 
            dict = 'move_clown@p_m_two_idles@', 
            anim = 'fidget_short_dance', 
            andar = false, 
            loop = true 
        },
    
        ['dancar234'] = { 
            dict = 'move_clown@p_m_zero_idles@',
            anim = 'fidget_short_dance', 
            andar = false, 
            loop = true 
        },
    
        ['dancar235'] = { 
            dict = 'misschinese2_crystalmazemcs1_ig', 
            anim = 'dance_loop_tao', 
            andar = false, 
            loop = true 
        },
    
        ['dancar236'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_center', 
            andar = false, 
            loop = true 
        },
    
        ['dancar237'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_center_down', 
            andar = false, 
            loop = true 
        },
    
        ['dancar238'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_center', 
            andar = false, 
            loop = true 
        },
    
        ['dancar239'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center_up', 
            andar = false, 
            loop = true 
        },
    
        ['dancar240'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center', 
            andar = true, 
            loop = true 
        },
    
        ['dancar241'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_center_up', 
            andar = false, 
            loop = true 
        },
    
        ['dancar242'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_center', 
            andar = false, 
            loop = true 
        },
    
    
        ['dancar243'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_center_down', 
            andar = false, 
            loop = true 
        },
    
        ['dancar244'] = { 
            dict = 'anim@amb@nightclub@dancers@podium_dancers@', 
            anim = 'hi_dance_facedj_17_v2_male^5', 
            andar = false, 
            loop = true 
        },
    
    
        ['dancar245'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_center', 
            andar = false, 
            loop = true 
        },
    
        ['dancar246'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_center_down', 
            andar = false, 
            loop = true 
        },
    
        ['dancar247'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_center', 
            andar = false, 
            loop = true 
        },
    
        ['dancar248'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_center_up', 
            andar = false, 
            loop = true 
        },
    
        ['dancar249'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_female^3', 
            andar = false, 
            loop = true 
        },
    
        ['dancar250'] = { 
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 
            anim = 'hi_dance_facedj_09_v2_female^1', 
            andar = false, 
            loop = true 
        },
    
        ['dancar251'] = { 
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_center', 
            andar = false, 
            loop = true 
        },
    
        ['dancar252'] = { 
            dict = 'anim@amb@nightclub@dancers@solomun_entourage@', 
            anim = 'mi_dance_facedj_17_v1_female^1', 
            andar = false, 
            loop = true 
        },
    
        ['dancar253'] = { 
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_center', 
            andar = false, 
            loop = true 
        },
    
        ['dancar254'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_left_down', 
            andar = false, 
            loop = true 
        },
    
        ['dancar255'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_left_up', 
            andar = false, 
            loop = true 
        },
    
        ['dancar256'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_right', 
            andar = false, 
            loop = true 
        },
    
        ['dancar257'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_right_down', 
            andar = false, 
            loop = true 
        },
    
        ['dancar258'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_right_up', 
            andar = false, 
            loop = true 
        },
    
        ['dancar259'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center', 
            andar = false, 
            loop = true 
        },
    
        ['dancar260'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center_down', 
            andar = false, 
            loop = true 
        },
    
        ['dancar261'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center_up', 
            andar = false, 
            loop = true 		
        },
    
        ['dancar262'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_left', 
            andar = false, 
            loop = true 
        },
        
        ['dancar263'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar264'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar265'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar266'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar267'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar268'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar269'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar270'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar271'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar272'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar273'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar274'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar275'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar276'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar277'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar278'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar279'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar280'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar281'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar282'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar283'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar284'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar285'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar286'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar287'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar288'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar289'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar290'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar291'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar292'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar293'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar294'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'high_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar295'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar296'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar297'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar298'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar299'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar300'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar301'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar302'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar303'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'low_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar304'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar305'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar306'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar307'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar308'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar309'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar310'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar311'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar312'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 
            anim = 'med_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar313'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar314'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar315'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar316'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar317'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar318'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar319'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar320'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar321'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'high_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar322'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar323'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar324'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar325'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar326'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar327'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar328'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar329'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar330'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'low_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar331'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar332'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar333'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar334'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar335'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar336'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar337'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar338'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar339'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 
            anim = 'med_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar340'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar341'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar342'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar343'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar344'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar345'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar346'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar347'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar348'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'high_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar349'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar350'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar351'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar352'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar353'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar354'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar355'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar356'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar357'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'low_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar358'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_center', 
            andar = false, 
            loop = true
        },
    
        ['dancar359'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_center_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar360'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_center_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar361'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_left', 
            andar = false, 
            loop = true
        },
    
        ['dancar362'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_left_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar363'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_left_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar364'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_right', 
            andar = false, 
            loop = true
        },
    
        ['dancar365'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_right_down', 
            andar = false, 
            loop = true
        },
    
        ['dancar366'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_right_up', 
            andar = false, 
            loop = true
        },
    
        ['dancar367'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center', 
            andar = false, 
            loop = true
        },
        
        ['dancar368'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar369'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_center_up', 
            andar = false, 
            loop = true
        },
        
        ['dancar370'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_left', 
            andar = false, 
            loop = true
        },
        
        ['dancar371'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_left_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar372'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_left_up', 
            andar = false, 
            loop = true
        },
        
        ['dancar373'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_right', 
            andar = false, 
            loop = true
        },
        
        ['dancar374'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_right_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar375'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_right_up', 
            andar = false, 
            loop = true
        },
        
        ['dancar376'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_center', 
            andar = false, 
            loop = true
        },
        
        ['dancar377'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_center_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar378'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_center_up', 
            andar = false, 
            loop = true
        },
        
        ['dancar379'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_left', 
            andar = false, 
            loop = true
        },
        
        ['dancar380'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_left_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar381'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_left_up', 
            andar = false, 
            loop = true
        },
        
        ['dancar382'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_right', 
            andar = false, 
            loop = true
        },
        
        ['dancar383'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_right_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar384'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'low_right_up', 
            andar = false, 
            loop = true
        },
        
        ['dancar385'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_center', 
            andar = false, 
            loop = true
        },
        
        ['dancar386'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_center_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar387'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_center_up', 
            andar = false, 
            loop = true
        },
        
        ['dancar388'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_left', 
            andar = false, 
            loop = true
        },
        
        ['dancar389'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_left_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar390'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_left_up', 
            andar = false, 
            loop = true
        },
        
        ['dancar391'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_right', 
            andar = false, 
            loop = true
        },
        
        ['dancar392'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_right_down', 
            andar = false, 
            loop = true
        },
        
        ['dancar393'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'med_right_up', 
            andar = false, 
            loop = true
        },
    
    
        ['dancar394'] = {
            dict = 'mini@strip_club@private_dance@idle', 
            anim = 'priv_dance_idle',
            loop = true 
        },
    
        ['dancar395'] = {
            dict = 'oddjobs@assassinate@multi@yachttarget@lapdance', 
            anim = 'yacht_ld_f',
            loop = true,
        },
    
        ['dancar396'] = {
            dict = 'mini@strip_club@lap_dance_2g@ld_2g_p3', 
            anim = 'ld_2g_p3_s2',
            loop = true,
        },
    
        ['dancar397'] = {
            dict = 'mini@strip_club@lap_dance_2g@ld_2g_p2', 
            anim = 'ld_2g_p2_s2',
            loop = true,
        },
    
        ['dancar398'] = {
            dict = 'mini@strip_club@lap_dance_2g@ld_2g_p1', 
            anim = 'ld_2g_p1_s2',
            loop = true,
        },
    
        ['dancar399'] = {
            dict = 'mini@strip_club@lap_dance@ld_girl_a_song_a_p1', 
            anim = 'ld_girl_a_song_a_p1_f',
            loop = true,
        },
    
        ['dancar400'] = {
            dict = 'mini@strip_club@lap_dance@ld_girl_a_song_a_p2', 
            anim = 'ld_girl_a_song_a_p2_f',
            loop = true,
        },
    
        ['dancar401'] = {
            dict = 'mini@strip_club@lap_dance@ld_girl_a_song_a_p3', 
            anim = 'ld_girl_a_song_a_p3_f',
            loop = true,
        },
    
        ['poledance'] = {
            dict = 'mini@strip_club@pole_dance@pole_dance1', 
            anim = 'pd_dance_01', 
            andar = false, 
            loop = true
        },
    
        ['poledance1'] = {
            dict = 'mini@strip_club@pole_dance@pole_dance2', 
            anim = 'pd_dance_02', 
            andar = false, 
            loop = true
        },
    
        ['poledance2'] = {
            dict = 'mini@strip_club@pole_dance@pole_dance3', 
            anim = 'pd_dance_03', 
            andar = false, 
            loop = true
        },
    
        ['sexo'] = { 
            dict = 'rcmpaparazzo_2', 
            anim = 'shag_loop_poppy', 
            andar = false, 
            loop = true 
        },
    
        ['sexo2'] = { 
            dict = 'rcmpaparazzo_2', 
            anim = 'shag_loop_a', 
            andar = false, 
            loop = true 
        },
    
        ['sexo3'] = { 
            dict = 'anim@mp_player_intcelebrationfemale@air_shagging', 
            anim = 'air_shagging', 
            andar = false, 
            loop = true 
        },
    
        ['sexo4'] = { 
            dict = 'oddjobs@towing', 
            anim = 'm_blow_job_loop', 
            andar = false, 
            loop = true, 
            carros = true 
        },
    
        ['sexo5'] = { 
            dict = 'oddjobs@towing', 
            anim = 'f_blow_job_loop', 
            andar = false, 
            loop = true, 
            carros = true 
        },
    
        ['sexo6'] = { 
            dict = 'mini@prostitutes@sexlow_veh', 
            anim = 'low_car_sex_loop_female', 
            andar = false, 
            loop = true, 
            carros = true 
        },
    
        ['sexo7'] = {
            dict = 'timetable@trevor@skull_loving_bear', 
            anim = 'skull_loving_bear', 
            andar = false, 
            loop = true
        },
    
        ['sentar2'] = { 
            dict = 'amb@world_human_picnic@male@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['sentar3'] = { 
            dict = 'anim@heists@fleeca_bank@ig_7_jetski_owner', 
            anim = 'owner_idle', 
            andar = false, 
            loop = true 
        },
    
        ['sentar4'] = { 
            dict = 'amb@world_human_stupor@male@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['sentar5'] = { 
            dict = 'amb@world_human_picnic@female@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['sentar6'] = { 
            dict = 'anim@amb@nightclub@lazlow@lo_alone@', 
            anim = 'lowalone_base_laz', 
            andar = false, 
            loop = true 
        },
    
        ['sentar7'] = { 
            dict = 'anim@amb@business@bgen@bgen_no_work@', 
            anim = 'sit_phone_phoneputdown_idle_nowork', 
            andar = false, 
            loop = true 
        },
    
        ['sentar8'] = { 
            dict = 'rcm_barry3', 
            anim = 'barry_3_sit_loop', 
            andar = false, 
            loop = true 
        },
    
        ['sentar9'] = { 
            dict = 'amb@world_human_picnic@male@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['sentar10'] = { 
            dict = 'amb@world_human_picnic@female@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['sentar11'] = { 
            dict = 'timetable@jimmy@mics3_ig_15@', 
            anim = 'idle_a_jimmy', 
            andar = false, 
            loop = true 
        },
    
        ['sentar12'] = { 
            dict = 'timetable@jimmy@mics3_ig_15@', 
            anim = 'mics3_15_base_jimmy', 
            andar = false, 
            loop = true 
        },
    
        ['sentar13'] = { 
            dict = 'amb@world_human_stupor@male@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['sentar14'] = { 
            dict = 'timetable@tracy@ig_14@', 
            anim = 'ig_14_base_tracy', 
            andar = false, 
            loop = true 
        },
    
        ['sentar15'] = { 
            dict = 'anim@heists@ornate_bank@hostages@hit', 
            anim = 'hit_loop_ped_b', 
            andar = false, 
            loop = true 
        },
        
        ['sentar16'] = { 
            dict = 'anim@heists@ornate_bank@hostages@ped_e@', 
            anim = 'flinch_loop', 
            andar = false, 
            loop = true 
        },
    
        ['sentar17'] = { 
            dict = 'timetable@ron@ig_5_p3', 
            anim = 'ig_5_p3_base', 
            andar = false, 
            loop = true 
        },
    
        ['sentar18'] = { 
            dict = 'timetable@reunited@ig_10', 
            anim = 'base_amanda', 
            andar = false, 
            loop = true 
        },
    
        ['sentar19'] = { 
            dict = 'timetable@ron@ig_3_couch', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['sentar20'] = { 
            dict = 'timetable@jimmy@mics3_ig_15@', 
            anim = 'mics3_15_base_tracy', 
            andar = false, 
            loop = true 
        },
    
        ['sentar21'] = { 
            dict = 'timetable@maid@couch@', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['sentar22'] = { 
            dict = 'timetable@ron@ron_ig_2_alt1', 
            anim = 'ig_2_alt1_base', 
            andar = false, 
            loop = true 
        },
    
        ['sentar23'] = {
            dict = 'missdrfriedlanderdrf_idles', 
            anim = 'drf_idle_drf', 
            andar = false, 
            loop = false
        },
        
        ['sentar24'] = { 
            dict = 'missfbi2@leadinout', 
            anim = 'fbi_2_int_leadinout_loop_steve', 
            andar = false, 
            loop = true
        },
        
        ['sentar25'] = {
            dict = 'missfbi3_party', 
            anim = 'snort_coke_a_female', 
            andar = false, 
            loop = false
        },
        
        ['sentar26'] = {
            dict = 'missheist_agency2aig_8', 
            anim = 'start_loop_foreman', 
            andar = false, 
            loop = false
        },
        
        ['sentar27'] = {
            dict = 'misslester1aig_3main', 
            anim = 'air_guitar_01_b', 
            andar = false, 
            loop = false
        },
    
        ['striper'] = { 
            dict = 'mini@strip_club@idles@stripper', 
            anim = 'stripper_idle_02', 
            andar = false, 
            loop = true 
        },
    
        ['escutar'] = { 
            dict = 'mini@safe_cracking', 
            anim = 'idle_base', 
            andar = false, 
            loop = true 
        },
    
        ['alongar'] = { 
            dict = 'anim@deathmatch_intros@unarmed', 
            anim = 'intro_male_unarmed_e', 
            andar = false, 
            loop = true 
        },
    
        ['dj'] = { 
            dict = 'anim@mp_player_intupperdj', 
            anim = 'idle_a', 
            andar = true, 
            loop = true 
        },
    
        ['rock'] = { 
            dict = 'anim@mp_player_intcelebrationmale@air_guitar', 
            anim = 'air_guitar', 
            andar = false, 
            loop = true 
        },
    
        ['rock2'] = { 
            dict = 'mp_player_introck', 
            anim = 'mp_player_int_rock', 
            andar = false, 
            loop = false 
        },
    
        ['abracar'] = { 
            dict = 'mp_ped_interaction', 
            anim = 'hugs_guy_a', 
            andar = false, 
            loop = false 
        },
    
        ['abracar2'] = { 
            dict = 'mp_ped_interaction', 
            anim = 'kisses_guy_b', 
            andar = false, 
            loop = false 
        },
    
        ['peitos'] = { 
            dict = 'mini@strip_club@backroom@', 
            anim = 'stripper_b_backroom_idle_b', 
            andar = false, 
            loop = false 
        },
    
        ['espernear'] = { 
            dict = 'missfam4leadinoutmcs2', 
            anim = 'tracy_loop', 
            andar = false, 
            loop = true 
        },
    
        ['arrumar'] = { 
            dict = 'anim@amb@business@coc@coc_packing_hi@', 
            anim = 'full_cycle_v1_pressoperator', 
            andar = false, 
            loop = true 
        },
    
        ['bebado'] = { 
            dict = 'missfam5_blackout', 
            anim = 'pass_out', 
            andar = false, 
            loop = false 
        },
    
        ['bebado2'] = { 
            dict = 'missheist_agency3astumble_getup', 
            anim = 'stumble_getup', 
            andar = false, 
            loop = false 
        },
    
        ['bebado3'] = { 
            dict = 'missfam5_blackout', 
            anim = 'vomit', 
            andar = false, 
            loop = false 
        },
    
        ['bebado4'] = { 
            dict = 'random@drunk_driver_1', 
            anim = 'drunk_fall_over', 
            andar = false, 
            loop = false 
        },
    
        ['yoga'] = { 
            dict = 'missfam5_yoga', 
            anim = 'f_yogapose_a', 
            andar = false, 
            loop = true 
        },
    
        ['yoga2'] = { 
            dict = 'amb@world_human_yoga@male@base', 
            anim = 'base_a', 
            andar = false, 
            l1oop = true 
        },
    
        ['abdominal'] = { 
            dict = 'amb@world_human_sit_ups@male@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['bixa'] = { 
            anim = 'WORLD_HUMAN_PROSTITUTE_LOW_CLASS' 
        },
    
        ['britadeira'] = { 
            dict = 'amb@world_human_const_drill@male@drill@base', 
            anim = 'base', 
            prop = 'prop_tool_jackham', 
            flag = 15, 
            hand = 28422 
        },
    
        ['cerveja'] = { 
            anim = 'WORLD_HUMAN_PARTYING' 
        },
    
        ['churrasco'] = { 
            anim = 'prop_HUMAN_BBQ' 
        },
    
        ['consertar'] = { 
            anim = 'WORLD_HUMAN_WELDING' 
        },
        ['encostar'] = { 
            dict = 'amb@lo_res_idles@', 
            anim = 'world_human_lean_male_foot_up_lo_res_base', 
            andar = false, 
            loop = true 
        },
    
        ['encostar2'] = {
            dict = 'bs_2a_mcs_10-0', 
            anim = 'hc_gunman_dual-0', 
            andar = false, 
            loop = true
        },
    
        ['encostar3'] = {
            dict = 'misscarstealfinalecar_5_ig_1', 
            anim = 'waitloop_lamar', 
            andar = false, 
            loop = true
        },
    
        ['encostar4'] = {
            dict = 'anim@amb@casino@out_of_money@ped_female@02b@base', 
            anim = 'base', 
            andar = false, 
            loop = true
        },
    
        ['encostar5'] = {
            dict = 'anim@amb@casino@hangout@ped_male@stand@03b@base', 
            anim = 'base', 
            andar = true, 
            loop = true
        },
    
        ['encostar6'] = {
            dict = 'anim@amb@casino@hangout@ped_female@stand@02b@base', 
            anim = 'base', 
            andar = false, 
            loop = true
        },
    
        ['encostar7'] = {
            dict = 'anim@amb@casino@hangout@ped_female@stand@02a@base', 
            anim = 'base', 
            andar = false, 
            loop = true
        },
    
        ['estatua'] = { 
            dict = 'amb@world_human_statue@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['flexao'] = { 
            dict = 'amb@world_human_push_ups@male@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['flexao2'] = { 
            anim = 'WORLD_HUMAN_MUSCLE_FLEX'
        },
    
        ['fumar'] = { 
            anim = 'WORLD_HUMAN_SMOKING' 
        },
    
        ['fumar2'] = { 
            anim = 'WORLD_HUMAN_PROSTITUTE_HIGH_CLASS' 
        },
    
        ['fumar3'] = { 
            anim = 'WORLD_HUMAN_AA_SMOKE' 
        },
    
        ['fumar4'] = { 
            anim = 'WORLD_HUMAN_SMOKING_POT' 
        },
    
        ['fumar5'] = {
            dict = 'amb@world_human_aa_smoke@male@idle_a',
            anim = 'idle_c',
            prop = 'prop_cs_ciggy_01',
            flag = 49,
            hand = 28422 
        },
    
        ['fumar6'] = {
            dict = 'amb@world_human_smoking@female@idle_a',
            anim = 'idle_b',
            prop = 'prop_cs_ciggy_01',
            flag = 49,
            hand = 28422 
        },
    
        ['malhar'] = { 
            dict = 'amb@world_human_muscle_free_weights@male@barbell@base', 
            anim = 'base', 
            prop = 'prop_curl_bar_01', 
            flag = 49, 
            hand = 28422 
        },
    
        ['malhar2'] = { 
            dict = 'amb@prop_human_muscle_chin_ups@male@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['martelo'] = { 
            dict = 'amb@world_human_hammering@male@base', 
            anim = 'base', 
            prop = 'prop_tool_hammer', 
            flag = 49, 
            hand = 28422 
        },
    
        ['pescar'] = { 
            dict = 'amb@world_human_stand_fishing@base', 
            anim = 'base', 
            prop = 'prop_fishing_rod_01', 
            flag = 49, 
            hand = 60309 
        },
    
        ['pescar2'] = { 
            dict = 'amb@world_human_stand_fishing@idle_a', 
            anim = 'idle_c', 
            prop = 'prop_fishing_rod_01', 
            flag = 49, 
            hand = 60309 
        },
    
        ['plantar'] = { 
            dict = 'amb@world_human_gardener_plant@female@base', 
            anim = 'base_female', 
            andar = false, 
            loop = true 
        },
    
        ['plantar2'] = { 
            dict = 'amb@world_human_gardener_plant@female@idle_a', 
            anim = 'idle_a_female', 
            andar = false, 
            loop = true 
        },
    
        ['procurar'] = { 
            dict = 'amb@world_human_bum_wash@male@high@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['soprador'] = { 
            dict = 'amb@code_human_wander_gardener_leaf_blower@base', 
            anim = 'static', 
            prop = 'prop_leaf_blower_01', 
            flag = 49, 
            hand = 28422 
        },
    
        ['soprador2'] = { 
            dict = 'amb@code_human_wander_gardener_leaf_blower@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_leaf_blower_01', 
            flag = 49, 
            hand = 28422 
        },
    
        ['soprador3'] = { 
            dict = 'amb@code_human_wander_gardener_leaf_blower@idle_a', 
            anim = 'idle_b', 
            prop = 'prop_leaf_blower_01', 
            flag = 49, 
            hand = 28422 
        },
    
        ['tragar'] = { 
            anim = 'WORLD_HUMAN_DRUG_DEALER' 
        },
    
        ['trotar'] = { 
            dict = 'amb@world_human_jog_standing@male@fitidle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['esquentar'] = { 
            anim = 'WORLD_HUMAN_STAND_FIRE' 
        },
    
        ['selfie'] = { 
            dict = 'cellphone@self', 
            anim = 'selfie_in_from_text', 
            prop = 'prop_amb_phone', 
            flag = 50, 
            hand = 28422 
        },
    
        ['selfie2'] = { 
            dict = 'cellphone@', 
            anim = 'cellphone_text_read_base_cover_low', 
            prop = 'prop_amb_phone', 
            flag = 50, 
            hand = 28422 
        },
    
        ['mecanico'] = {
            dict = 'amb@world_human_vehicle_mechanic@male@idle_a', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['mecanico2'] = {
            dict = 'mini@repair', 
            anim = 'fixing_a_player', 
            andar = false, 
            loop = true 
        },
    
        ['mecanico3'] = {
            dict = 'mini@repair', 
            anim = 'fixing_a_ped', 
            andar = false, 
            loop = true 
        },
    
        ['pullover'] = {
            dict = 'misscarsteal3pullover', 
            anim = 'pull_over_right', 
            andar = false, 
            loop = false 
        },
    
        ['airguitar'] = {
            dict = 'anim@mp_player_intcelebrationfemale@air_guitar', 
            anim = 'air_guitar', 
            andar = false, 
            loop = true 
        },
    
        ['airsynth'] = {
            dict = 'anim@mp_player_intcelebrationfemale@air_synth', 
            anim = 'air_synth', 
            andar = false, 
            loop = true 
        },
    
        ['puto'] = {
            dict = 'misscarsteal4@actor', 
            anim = 'actor_berating_loop', 
            andar = true, 
            loop = true 
        },
    
        ['puto2'] = {
            dict = 'oddjobs@assassinate@vice@hooker', 
            anim = 'argue_a', 
            andar = true, 
            loop = true 
        },
    
        ['puto3'] = {
            dict = 'mini@triathlon', 
            anim = 'want_some_of_this', 
            andar = false, 
            loop = false 
        },
    
        ['unhas'] = {
            dict = 'anim@amb@clubhouse@bar@drink@idle_a', 
            anim = 'idle_a_bartender', 
            andar = true, 
            loop = true 
        },
    
        ['mandarbeijo'] = { 
            dict = 'anim@mp_player_intcelebrationfemale@blow_kiss', 
            anim = 'blow_kiss', 
            andar = false, 
            loop = false 
        },
        
        ['mandarbeijo2'] = {
            dict = 'anim@mp_player_intselfieblow_kiss', 
            anim = 'exit', 
            andar = false, 
            loop = false 
        },
    
        ['bale'] = {
            dict = 'anim@mp_player_intcelebrationpaired@f_f_sarcastic', 
            anim = 'sarcastic_left', 
            andar = false, 
            loop = true 
        },
    
        ['bonzao'] = {
            dict = 'misscommon@response', 
            anim = 'bring_it_on', 
            andar = false, 
            loop = false 
        },
    
        ['cruzarbraco'] = {
            dict = 'anim@amb@nightclub@peds@', 
            anim = 'rcmme_amanda1_stand_loop_cop', 
            andar = true, 
            loop = true 
        },
    
        ['cruzarbraco2'] = {
            dict = 'amb@world_human_hang_out_street@female_arms_crossed@idle_a', 
            anim = 'idle_a', 
            andar = true, 
            loop = true 
        },
    
        ['wtf'] = {
            dict = 'anim@mp_player_intcelebrationfemale@face_palm', 
            anim = 'face_palm', 
            andar = true, 
            loop = false 
        },
    
        ['wtf2'] = {
            dict = 'random@car_thief@agitated@idle_a', 
            anim = 'agitated_idle_a', 
            andar = true, 
            loop = false 
        },
    
        ['wtf3'] = {
            dict = 'missminuteman_1ig_2', 
            anim = 'tasered_2', 
            andar = true, 
            loop = false 
        },
    
        ['wtf4'] = {
            dict = 'anim@mp_player_intupperface_palm', 
            anim = 'idle_a', 
            andar = true, 
            loop = false 
        },
    
        ['suicidio'] = {
            dict = 'mp_suicide', 
            anim = 'pistol', 
            andar = false, 
            loop = false 
        },
    
        ['suicidio2'] = {
            dict = 'mp_suicide', 
            anim = 'pill', 
            andar = false, 
            loop = false 
        },
    
        ['lutar'] = {
            dict = 'anim@deathmatch_intros@unarmed', 
            anim = 'intro_male_unarmed_c', 
            andar = false, 
            loop = false 
        },
    
        ['lutar2'] = {
            dict = 'anim@deathmatch_intros@unarmed', 
            anim = 'intro_male_unarmed_e', 
            andar = false, 
            loop = false 
        },
    
        ['dedo'] = {
            dict = 'anim@mp_player_intselfiethe_bird', 
            anim = 'idle_a', 
            andar = false, 
            loop = false 
        },
    
        ['mochila'] = {
            dict = 'move_m@hiking', 
            anim = 'idle', 
            andar = true, 
            loop = true 
        },
    
        ['exercicios'] = {
            dict = 'timetable@reunited@ig_2', 
            anim = 'jimmy_getknocked', 
            andar = true, 
            loop = true 
        },
    
        ['escorar'] = {
            dict = 'timetable@mime@01_gc', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['escorar2'] = {
            dict = 'misscarstealfinale', 
            anim = 'packer_idle_1_trevor', 
            andar = false, 
            loop = true 
        },
    
        ['escorar3'] = {
            dict = 'misscarstealfinalecar_5_ig_1', 
            anim = 'waitloop_lamar', 
            andar = false, 
            loop = true 
        },
    
        ['escorar4'] = {
            dict = 'rcmjosh2', 
            anim = 'josh_2_intp1_base', 
            andar = false, 
            loop = true 
        },
    
        -- ['meditar'] = {
        --
        --     dict = 'rcmcollect_paperleadinout@', 
        --     anim = 'meditiate_idle', 
        --     andar = false, 
        --     loop = true 
        -- },
    
        ['meditar2'] = {
            dict = 'rcmepsilonism3', 
            anim = 'ep_3_rcm_marnie_meditating', 
            andar = false, 
            loop = true 
        },
    
        ['meditar3'] = {
            dict = 'rcmepsilonism3', 
            anim = 'base_loop', 
            andar = false, 
            loop = true 
        },
    
        ['meleca2'] = {
            dict = 'anim@mp_player_intcelebrationfemale@nose_pick', 
            anim = 'nose_pick', 
            andar = false, 
            loop = false 
        },
    
        ['cortaessa'] = {
            dict = 'gestures@m@standing@casual', 
            anim = 'gesture_no_way', 
            andar = false, 
            loop = false 
        },
    
        ['meleca3'] = {
            dict = 'move_p_m_two_idles@generic', 
            anim = 'fidget_sniff_fingers', 
            andar = true, 
            loop = false 
        },
    
        ['bebado5'] = {
            dict = 'misscarsteal4@actor', 
            anim = 'stumble', 
            andar = false, 
            loop = false 
        },
    
        ['bebado6'] = {
            dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@drunk', 
            anim = 'outro_fallover', 
            andar = false, 
            loop = false
        },
    
        ['bebado7'] = {
            dict = 'switch@trevor@puking_into_fountain', 
            anim = 'trev_fountain_puke_loop', 
            andar = false, 
            loop = true
        },
    
        ['bebado8'] = {
            dict = 'switch@trevor@head_in_sink', 
            anim = 'trev_sink_idle', 
            andar = false, 
            loop = true
        },
    
        ['joia'] = {
            dict = 'anim@mp_player_intincarthumbs_uplow@ds@', 
            anim = 'enter', 
            andar = false, 
            loop = false 
        },
    
        ['joia2'] = {
            dict = 'anim@mp_player_intselfiethumbs_up', 
            anim = 'idle_a', 
            andar = false, 
            loop = false 
        },
    
        ['yeah'] = {
            dict = 'anim@mp_player_intupperair_shagging', 
            anim = 'idle_a', 
            andar = false, 
            loop = false 
        },
    
        ['assobiar'] = {
            dict = 'taxi_hail', 
            anim = 'hail_taxi', 
            andar = false, 
            loop = false 
        },
    
        ['carona'] = {
            dict = 'random@hitch_lift', 
            anim = 'idle_f', 
            andar = true, 
            loop = false 
        },
    
        ['estatua2'] = {
            dict = 'fra_0_int-1', 
            anim = 'cs_lamardavis_dual-1', 
            andar = false, 
            loop = true 
        },
    
        ['estatua3'] = {
            dict = 'club_intro2-0', 
            anim = 'csb_englishdave_dual-0', 
            andar = false, 
            loop = true 
        },
        ['colher'] = {
            dict = 'creatures@rottweiler@tricks@', 
            anim = 'petting_franklin', 
            andar = false, 
            loop = false 
        },
    
        ['rastejar'] = {
            dict = 'move_injured_ground', 
            anim = 'front_loop', 
            andar = false, 
            loop = true 
        },
    
        ['rastejar2'] = {
            dict = 'move_injured_ground', 
            anim = 'front_loop', 
            andar = false, 
            loop = true
        },
    
        ['rastejar3'] = {
            dict = 'missfbi3_sniping', 
            anim = 'prone_dave', 
            andar = false, 
            loop = true
        },
    
        ['pirueta'] = {
            dict = 'anim@arena@celeb@flat@solo@no_props@', 
            anim = 'cap_a_player_a', 
            andar = false, 
            loop = false 
        },
    
        ['pirueta2'] = {
            dict = 'anim@arena@celeb@flat@solo@no_props@', 
            anim = 'flip_a_player_a', 
            andar = false, 
            loop = false 
        },
    
        ['fodase'] = {
            dict = 'anim@arena@celeb@podium@no_prop@', 
            anim = 'flip_off_a_1st', 
            andar = false, 
            loop = false 
        },
    
        ['taco'] = {
            dict = 'anim@arena@celeb@flat@solo@no_props@', 
            anim = 'slugger_a_player_a', 
            andar = false, 
            loop = false 
        },
    
        ['onda'] = {
            dict = 'anim@mp_player_intupperfind_the_fish', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['alongar3'] = {
            dict = 'mini@triathlon', 
            anim = 'idle_f', 
            andar = false, 
            loop = true 
        },
    
        ['alongar4'] = {
            dict = 'mini@triathlon', 
            anim = 'idle_d', 
            andar = false, 
            loop = true 
        },
    
        ['alongar5'] = {
            dict = 'rcmfanatic1maryann_stretchidle_b', 
            anim = 'idle_e', 
            andar = false, 
            loop = true 
        },
    
        ['lutar3'] = {
            dict = 'rcmextreme2', 
            anim = 'loop_punching', 
            andar = true, 
            loop = true 
        },
    
        ['heroi'] = {
            dict = 'rcmbarry', 
            anim = 'base', 
            andar = true, 
            loop = true 
        },
    
        ['boboalegre'] = {
            dict = 'rcm_barry2', 
            anim = 'clown_idle_0', 
            andar = false, 
            loop = false 
        },
    
        ['boboalegre2'] = {
            dict = 'rcm_barry2', 
            anim = 'clown_idle_1', 
            andar = false, 
            loop = false 
        },
    
        ['boboalegre3'] = {
            dict = 'rcm_barry2', 
            anim = 'clown_idle_2', 
            andar = false, 
            loop = false 
        },
    
        ['boboalegre4'] = {
            dict = 'rcm_barry2', 
            anim = 'clown_idle_6', 
            andar = false, 
            loop = false 
        },
    
        ['boboalegre5'] = {
            dict = 'rcm_barry2', 
            anim = 'clown_idle_6', 
            andar = false, 
            loop = false
        },
    
        ['meditar4'] = {
            dict = 'timetable@amanda@ig_4', 
            anim = 'ig_4_base', 
            andar = false, 
            loop = true 
        },
    
        ['passaro'] = {
            dict = 'random@peyote@bird', 
            anim = 'wakeup', 
            andar = false, 
            loop = false 
        },
    
        ['cachorro'] = {
            dict = 'random@peyote@dog', 
            anim = 'wakeup', 
            andar = false, 
            loop = false 
        },
    
        ['karate'] = {
            dict = 'anim@mp_player_intcelebrationfemale@karate_chops', 
            anim = 'karate_chops', 
            andar = false, 
            loop = false 
        },
    
        ['karate2'] = {
            dict = 'anim@mp_player_intcelebrationmale@karate_chops', 
            anim = 'karate_chops', 
            andar = false, 
            loop = false 
        },
    
        ['ameacar'] = {
            dict = 'anim@mp_player_intcelebrationmale@cut_throat', 
            anim = 'cut_throat', 
            andar = false, 
            loop = false 
        },
    
        ['ameacar2'] = {
            dict = 'anim@mp_player_intcelebrationfemale@cut_throat', 
            anim = 'cut_throat', 
            andar = false, 
            loop = false 
        },
    
        ['boxe'] = {
            dict = 'anim@mp_player_intcelebrationmale@shadow_boxing', 
            anim = 'shadow_boxing', 
            andar = false, 
            loop = false 
        },
    
        ['boxe2'] = {
            dict = 'anim@mp_player_intcelebrationfemale@shadow_boxing', 
            anim = 'shadow_boxing', 
            andar = false, 
            loop = false 
        },
    
        ['mamamia'] = {
            dict = 'anim@mp_player_intcelebrationmale@finger_kiss', 
            anim = 'finger_kiss', 
            andar = true, 
            loop = false 
        },
    
        ['louco'] = {
            dict = 'anim@mp_player_intincaryou_locobodhi@ds@', 
            anim = 'idle_a', 
            andar = true, 
            loop = true 
        },
    
        ['xiu'] = {
            dict = 'anim@mp_player_intincarshushbodhi@ds@', 
            anim = 'idle_a_fp', 
            andar = true, 
            loop = true 
        },
    
        ['cruzar'] = {
            dict = 'amb@world_human_cop_idles@female@idle_b', 
            anim = 'idle_e', 
            andar = true, 
            loop = true 
        },
    
        ['cruzar2'] = {
            dict = 'anim@amb@casino@hangout@ped_male@stand@02b@idles', 
            anim = 'idle_a', 
            andar = true, 
            loop = true
        },
    
        ['cruzar3'] = {
            dict = 'amb@world_human_hang_out_street@male_c@idle_a', 
            anim = 'idle_b', 
            andar = true, 
            loop = true
        },
    
        ['cruzar4'] = {
            dict = 'random@street_race', 
            anim = '_car_b_lookout', 
            andar = true, 
            loop = true
        },
    
        ['cruzar5'] = {
            dict = 'random@shop_gunstore', 
            anim = '_idle', 
            andar = true, 
            loop = true
        },
    
        ['cruzar6'] = {
            dict = 'move_m@hiking', 
            anim = 'idle', 
            andar = true, 
            loop = true
        },
    
        ['cruzar7'] = {
            dict = 'anim@amb@casino@valet_scenario@pose_d@', 
            anim = 'base_a_m_y_vinewood_01', 
            andar = true, 
            loop = true
        },
        
        ['pose'] = {
            dict = 'missmic4premiere', 
            anim = 'prem_actress_star_a', 
            andar = false, 
            loop = true 
        },
    
        ['bjs'] = {
            dict = 'mini@hookers_spvanilla', 
            anim = 'idle_a', 
            andar = true, 
            loop = false 
        },
    
        ['vemca'] = {
            dict = 'anim@heists@chicken_heist@ig_5_guard_wave_in', 
            anim = 'guard_reaction_quick', 
            andar = true, 
            loop = false 
        },   
    
        ['cruzarbraco3'] = {
            dict = 'anim@heists@heist_safehouse_intro@variations@male@window', 
            anim = 'window_part_one_loop', 
            andar = true, 
            loop = false 
        },   
    
        ['chute'] = {
            dict = 'anim@mp_freemode_return@f@fail', 
            anim = 'fail_a', 
            andar = false, 
            loop = false 
        },
    
        ['no'] = {
            dict = 'mp_player_int_upper_nod',
            anim = 'mp_player_int_nod_no', 
            andar = true, 
            loop = true 
        },
    
        ['nao'] = {
            dict = 'anim@arena@celeb@podium@no_prop@', 
            anim = 'dance_b_3rd', 
            andar = false, 
            loop = true 
        },
    
        ['palhaco'] = {
            dict = 'rcm_barry2', 
            anim = 'clown_idle_6', 
            andar = false, 
            loop = true 
        },
    
        ['dancinha'] = {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 
            anim = 'med_center_down', 
            andar = false, 
            loop = true 
        },   
    
        ['dancinha2'] = {
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@', 
            anim = 'hi_dance_crowd_09_v1_female^3', 
            andar = false, 
            loop = true 
        },  
    
        ['dancinha2'] = {
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@', 
            anim = 'hi_dance_crowd_09_v1_female^3', 
            andar = false, 
            loop = true 
        },   
    
        ['deaf'] = {
            dict = 'misscarsteal2', 
            anim = 'sweep_high', 
            andar = false, 
            loop = true 
        }, 
    
        ['deaf2'] = {
            dict = 'gestures@miss@dockssetup1', 
            anim = 'floyd_dh1_aeab_01_g1', 
            andar = true, 
            loop = false 
        }, 
    
        ['deaf3'] = {
            dict = 'gestures@miss@fra_0', 
            anim = 'lamar_fkn0_cjae_01_g4', 
            andar = false, 
            loop = false 
        }, 
    
        ['deaf4'] = {
            dict = 'missexile2', 
            anim = 'franklinwavetohelicopter', 
            andar = false, 
            loop = false 
        }, 
    
        ['deaf5'] = {
            dict = 'missheist_jewelleadinout', 
            anim = 'jh_int_outro_loop_c', 
            andar = false, 
            loop = false 
        }, 
    
        ['celebration'] = {
            dict = 'anim@arena@celeb@flat@solo@no_props@', 
            anim = 'pageant_a_player_a', 
            andar = false, 
            loop = false 
        },
    
        ['encostado'] = {
            dict = 'misshair_shop@hair_dressers', 
            anim = 'assistant_base', 
            andar = false, 
            loop = true 
        }, 
    
        ['encostado2'] = {
            dict = 'anim@heists@prison_heist', 
            anim = 'ped_b_react', 
            andar = false, 
            loop = true 
        },    
    
        ['encostado3'] = {
            dict = 'anim@heists@prison_heiststation@cop_reactions', 
            anim = 'drunk_idle', 
            andar = false, 
            loop = true 
        },    
    
        ['dancinha3'] = {
            dict = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 
            anim = 'high_right_down', 
            andar = false, 
            loop = true 
        },    
    
        ['dedo2'] = {
            dict = 'anim@arena@celeb@flat@paired@no_props@', 
            anim = 'the_bird_a_player_a', 
            andar = false, 
            loop = true 
        }, 
    
        ['tempo'] = {
            dict = 'anim@random@shop_clothes@watches', 
            anim = 'idle_c', 
            andar = false, 
            loop = true 
        },
    
        ['olha'] = {
            dict = 'mini@strip_club@lap_dance@ld_girl_a_approach', 
            anim = 'ld_girl_a_approach_f', 
            andar = false, 
            loop = true 
        },
    
        ['mantra'] = {
            dict = 'misscarsteal1leadin', 
            anim = 'devon_idle_02', 
            andar = false, 
            loop = true 
        },
    
        ['mecanico4'] = {
            dict = 'anim@amb@garage@chassis_repair@', 
            anim = 'idle_02_amy_skater_01', 
            andar = false, 
            loop = true 
        },
    
        ['esperando'] = {
            dict = 'anim@amb@casino@shop@ped_female@01a@idles', 
            anim = 'idle_a', 
            andar = false,
            loop = true 
        },
    
        ['calmaai'] = {
            dict = 'anim@heists@ornate_bank@chat_manager', 
            anim = 'average_car', 
            andar = false, 
            loop = true 
        },
    
        ['basta'] = {
            dict = 'anim@heists@ornate_bank@chat_manager', 
            anim = 'fail', 
            andar = false, 
            loop = false 
        },
    
        ['basta2'] = {
            dict = 'mini@hookers_sp', 
            anim = 'idle_reject', 
            andar = false, 
            loop = false 
        },
    
        ['dancinha4'] = {
            dict = 'anim@amb@nightclub@dancers@crowddance_groups@', 
            anim = 'mi_dance_crowd_17_v2_female^6', 
            andar = false, 
            loop = false 
        }, 
    
        ['postura3'] = {
            dict = 'missbigscore2aleadinout@bs_2a_mcs_3', 
            anim = 'bankman_leadout_action', 
            andar = true, 
            loop = true 
        }, 
    
        ['postura4'] = {
            dict = 'missfbi2@leadinoutfbi_2_mcs_1', 
            anim = '_leadin_loop_fbi', 
            andar = true, 
            loop = true 
        },       
    
        ['postura5'] = {
            dict = 'timetable@amanda@ig_9', 
            anim = 'ig_9_base_amanda', 
            andar = true, 
            loop = true 
        },     
    
        ['cruzarbraco4'] = {
            dict = 'anim@heists@heist_corona@single_team', 
            anim = 'single_team_intro_boss', 
            andar = true, 
            loop = true 
        },    
    
        ['explicar'] = {
            dict = 'random@bus_tour_guide@idle_a', 
            anim = 'idle_b', 
            andar = true, 
            loop = false 
        },  
    
        ['obrigado'] = {
            dict = 'anim@arena@celeb@podium@no_prop@', 
            anim = 'regal_a_1st', 
            andar = false, 
            loop = false 
        },  
    
        ['unhas2'] = {
            dict = 'friends@fra@ig_1', 
            anim = 'base_idle', 
            andar = false, 
            loop = true 
        },  
    
        ['podeser'] = {
            dict = 'amb@world_human_hang_out_street@male_a@idle_a', 
            anim = 'idle_e', 
            andar = false, 
            loop = false 
        },  
    
        ['xiu2'] = {
            dict = 'anim@arena@celeb@flat@solo@no_props@', 
            anim = 'giggle_a_player_a', 
            andar = false, 
            loop = false 
        },
    
    
        ['agua'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_ld_flow_bottle', 
            flag = 49, 
            hand = 28422 
        },
    
        ['champ'] = {
            dict = 'anim@mp_player_intupperspray_champagne', 
            anim = 'idle_a', 
            prop = 'ba_prop_battle_champ_open', 
            flag = 49, 
            hand = 28422, 
            loop = true 
        },
    
        ['taca'] = {
            dict = 'anim@heists@humane_labs@finale@keycards', 
            anim = 'ped_a_enter_loop', 
            prop = 'prop_drink_champ', 
            flag = 49, 
            hand = 18905, 
            pos = {0.10,-0.03,0.03,-100.0,0.0,-10.0}
        },
    
        ['taca2'] = {
            dict = 'anim@heists@humane_labs@finale@keycards', 
            anim = 'ped_a_enter_loop', 
            prop = 'prop_drink_redwine', 
            flag = 49, 
            hand = 18905, 
            pos = {0.10,-0.03,0.03,-100.0,0.0,-10.0}
        },
    
        ['garcom'] = {
            dict = 'anim@move_f@waitress', 
            anim = 'idle', 
            prop = 'vw_prop_vw_tray_01a', 
            flag = 49, 
            hand = 28422 
        },
    
        ['garcom2'] = {
            dict = 'anim@move_f@waitress', 
            anim = 'idle', 
            prop = 'prop_food_tray_01', 
            flag = 49, 
            hand = 28422 
        },
    
        ['garcom3'] = {
            dict = 'anim@move_f@waitress', 
            anim = 'idle', 
            prop = 'prop_food_tray_02', 
            flag = 49, 
            hand = 28422 
        },
    
        ['garcom4'] = {
            dict = 'anim@move_f@waitress', 
            anim = 'idle', 
            prop = 'prop_food_tray_03', 
            flag = 49, 
            hand = 28422 
        },
    
        ['garcom5'] = {
            dict = 'anim@move_f@waitress', 
            anim = 'idle', 
            prop = 'h4_prop_h4_champ_tray_01b', 
            flag = 49, 
            hand = 28422 
        },
    
        ['garcom6'] = {
            dict = 'anim@move_f@waitress', 
            anim = 'idle', 
            prop = 'h4_prop_h4_champ_tray_01c', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'p_cs_bottle_01', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber2'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_energy_drink', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber4'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'p_whiskey_notop', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber5'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_beer_logopen', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber6'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_beer_blr', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber7'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_ld_flow_bottle', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber8'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_plastic_cup_02', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber9'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'prop_food_bs_juice03', 
            flag = 49, 
            hand = 28422 
        },
    
        ['beber10'] = {
            dict = 'amb@world_human_drinking@beer@male@idle_a', 
            anim = 'idle_a', 
            prop = 'ng_proc_sodacan_01b', 
            flag = 49, 
            hand = 28422 
        },
    
        ['encostar8'] = {
            dict = 'anim@amb@casino@hangout@ped_female@stand@01b@base', 
            anim = 'base', 
            andar = false, 
            loop = true 
        },
    
        ['encostar9'] = {
            dict = 'anim@amb@clubhouse@bar@bartender@', 
            anim = 'base_bartender', 
            andar = false, 
            loop = true 
        },
    
        ['encostar10'] = {
            dict = 'missclothing', 
            anim = 'idle_a', 
            andar = false, 
            loop = true 
        },
    
        ['encostar11'] = {
            dict = 'misscarstealfinale', 
            anim = 'packer_idle_1_trevor', 
            andar = false, 
            loop = true 
        },
    
        ['encostar12'] = {
            dict = 'missarmenian1leadinoutarm_1_ig_14_leadinout', 
            anim = 'leadin_loop', 
            andar = false, 
            loop = true 
        },
    
        ['cruzar8'] = {
            dict = 'anim@amb@casino@shop@ped_female@01a@base', 
            anim = 'base', 
            andar = true, 
            loop = true 
        },
    
        ['cruzar9'] = {
            dict = 'anim@amb@casino@valet_scenario@pose_c@', 
            anim = 'shuffle_feet_a_m_y_vinewood_01', 
            andar = true, 
            loop = true 
        },
    
        ['cruzar10'] = {
            dict = 'anim@amb@casino@hangout@ped_male@stand@03a@idles_convo', 
            anim = 'idle_a', 
            andar = true, 
            loop = true 
        },
    
        ['cruzar11'] = {
            dict = 'oddjobs@assassinate@guard', 
            anim = 'unarmed_fold_arms', 
            andar = true, 
            loop = true 
        },
    
        ['tchau'] = {
            dict = 'anim@mp_player_intupperwave',
            anim ='idle_a',
            andar = true,
            loop = true 
        },
    
        ['fera' ] = {
            dict = 'anim@mp_fm_event@intro' ,
            anim ='beast_transform' ,
            andar = true ,
            loop = false 
        },
    
        ['explodir' ] = {
            dict = 'anim@mp_player_intcelebrationmale@mind_blown' ,
            anim ='mind_blown' ,
            andar = false ,
            loop = false 
        },
    
        ['fedo' ] = {
            dict = 'anim@mp_player_intcelebrationfemale@stinker' ,
            anim ='stinker' ,
            andar = false ,
            loop = false 
        },
    
        ['pensar' ] = {
            dict = 'anim@amb@casino@out_of_money@ped_male@01b@base' ,
            anim ='base' ,
            andar = true ,
            loop = true 
        },
    
        ['pensar2' ] = {
            dict = 'misscarsteal4@aliens' ,
            anim ='rehearsal_base_idle_director' ,
            andar = true ,
            loop = true 
        },
    
        ['ferido' ] = {
            dict = 'anim@amb@casino@hangout@ped_female@stand_withdrink@01b@base' ,
            anim ='base' ,
            andar = true ,
            loop = true 
        },
    
        ['ferido2' ] = {
            dict = 'combat@damage@injured_pistol@to_writhe' ,
            anim ='variation_d' ,
            andar = false ,
            loop = false 
        },
    
        ['olhar' ] = {
            dict = 'oddjobs@basejump@' ,
            anim ='ped_d_loop' ,
            andar = true ,
            loop = true 
        },
    
        ['olhar2' ] = {
            dict = 'friends@fra@ig_1' ,
            anim ='base_idle' ,
            andar = true ,
            loop = true 
        },
    
        ['senha' ] = {
            dict = 'mp_heists@keypad@' ,
            anim ='idle_a' ,
            andar = false ,
            loop = true 
        },
    
        ['lavar' ] = {
            dict = 'missheist_agency3aig_23' ,
            anim ='urinal_sink_loop' ,
            andar = true ,
            loop = true 
        },
    
        ['triste' ] = {
            dict = 'misscarsteal2car_stolen' ,
            anim ='chad_car_stolen_reaction' ,
            andar = false ,
            loop = false 
        },
    
        ['aqc' ] = {
            dict = 'anim@deathmatch_intros@unarmed' ,
            anim ='intro_male_unarmed_a' ,
            andar = false ,
            loop = false 
        },
    
        ['aqc2' ] = {
            dict = 'anim@deathmatch_intros@unarmed' ,
            anim ='intro_male_unarmed_d' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec' ] = {
            dict = 'anim@deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_b' ,
            andar = false ,
            loop = true 
        },
    
        ['inspec2' ] = {
            dict = 'anim@deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_c' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec3' ] = {
            dict = 'anim@deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_d' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec4' ] = {
            dict = 'anim@deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_e' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec5' ] = {
            dict = 'mp_deathmatch_intros@1hmale' ,
            anim ='intro_male_1h_a_michael' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec6' ] = {
            dict = 'mp_deathmatch_intros@melee@1h' ,
            anim ='intro_male_melee_1h_a' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec7' ] = {
            dict = 'mp_deathmatch_intros@melee@1h' ,
            anim ='intro_male_melee_1h_b' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec8' ] = {
            dict = 'mp_deathmatch_intros@melee@1h' ,
            anim ='intro_male_melee_1h_c' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec9' ] = {
            dict = 'mp_deathmatch_intros@melee@1h' ,
            anim ='intro_male_melee_1h_d' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec10' ] = {
            dict = 'mp_deathmatch_intros@melee@1h' ,
            anim ='intro_male_melee_1h_e' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec11' ] = {
            dict = 'mp_deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_a' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec12' ] = {
            dict = 'mp_deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_b' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec13' ] = {
            dict = 'mp_deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_c' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec14' ] = {
            dict = 'mp_deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_d' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec15' ] = {
            dict = 'mp_deathmatch_intros@melee@2h' ,
            anim ='intro_male_melee_2h_e' ,
            andar = false ,
            loop = false 
        },
    
        ['inspec16' ] = {
            dict = 'anim@deathmatch_intros@1hmale' ,
            anim ='intro_male_1h_d_michael' ,
            andar = true ,
            loop = false 
        },

        ['enviar'] = {
            dict = 'mp_common',
            anim ='givetake1_a',
            andar = true ,
            loop = true 
        },
    
        ['swat' ] = {
            dict = 'swat' ,
            anim ='come' ,
            andar = true ,
            loop = false 
        },
    
        ['swat2' ] = {
            dict = 'swat' ,
            anim ='freeze' ,
            andar = true ,
            loop = false 
        },
    
        ['swat3' ] = {
            dict = 'swat' ,
            anim ='go_fwd' ,
            andar = true ,
            loop = false 
        },
    
        ['swat4' ] = {
            dict = 'swat' ,
            anim ='rally_point' ,
            andar = true ,
            loop = false 
        },
    
        ['swat5' ] = {
            dict = 'swat' ,
            anim ='understood' ,
            andar = true ,
            loop = false 
        },
    
        ['swat6' ] = {
            dict = 'swat' ,
            anim ='you_back' ,
            andar = true ,
            loop = false 
        },
    
        ['swat7' ] = {
            dict = 'swat' ,
            anim ='you_fwd' ,
            andar = true ,
            loop = false 
        },
    
        ['swat8' ] = {
            dict = 'swat' ,
            anim ='you_left' ,
            andar = true ,
            loop = false 
        },
    
        ['swat9' ] = {
            dict = 'swat' ,
            anim ='you_right' ,
            andar = true ,
            loop = false 
        },
    
        ['cigarro'] = { 
            prop = 'prop_cigar_02',
            flag = 49,
            hand = 47419,
            pos = {0.010,0,0,50.0,0.0,-80.0}
        },
    
        ['naruto'] = {
            dict = 'missfbi1', 
            anim = 'ledge_loop', 
            andar = true, 
            loop = true
        },
    
        ['naruto2'] = {
            dict = 'missfam5_yoga', 
            anim = 'a2_pose', 
            andar = true, 
            loop = true
        },
    
        ['rebolar'] = {
            dict = 'switch@trevor@mocks_lapdance', 
            anim = '001443_01_trvs_28_idle_stripper', 
            andar = false, 
            loop = true
        },
    
        ['celebrar'] = {
            dict = 'rcmfanatic1celebrate', 
            anim = 'celebrate', 
            andar = false, 
            loop = false
        },
    
        
        ['morto'] = {
            dict = 'anim@mp_player_intcelebrationmale@cut_throat', 
            anim = 'cut_throat', 
            andar = true, 
            loop = false
        },
    
        ['morto2'] = {
            dict = 'anim@mp_player_intcelebrationfemale@cut_throat', 
            anim = 'cut_throat', 
            andar = true, 
            loop = false
        },
        
        ['champanhe'] = {
            dict = 'anim@mp_player_intupperspray_champagne', 
            anim = 'idle_a', 
            prop = 'ba_prop_battle_champ_open',
            flag = 49,
            hand = 28422
        },
    
        ['abracocintura'] = {
            dict = 'misscarsteal2chad_goodbye', 
            anim = 'chad_armsaround_chad', 
            andar = false, 
            loop = true
        },
    
        ['abracocintura2'] = {
            dict = 'misscarsteal2chad_goodbye', 
            anim = 'chad_armsaround_chad', 
            andar = true, 
            loop = true
        },
    
        ['abracoombro'] = {
            dict = 'misscarsteal2chad_goodbye', 
            anim = 'chad_armsaround_girl', 
            andar = false, 
            loop = true
        },
    
        ['abracoombro2'] = {
            dict = 'misscarsteal2chad_goodbye', 
            anim = 'chad_armsaround_girl', 
            andar = true, 
            loop = true
        },
    
        ['casalm'] = {
            dict = 'timetable@trevor@ig_1', 
            anim = 'ig_1_thedontknowwhy_trevor', 
            andar = false, 
            loop = true
        },
    
        ['casalf'] = {
            dict = 'timetable@trevor@ig_1', 
            anim = 'ig_1_thedontknowwhy_patricia', 
            andar = false, 
            loop = true
        },
    
        ['casalm2'] = {
            dict = 'timetable@trevor@ig_1', 
            anim = 'ig_1_thedesertissobeautiful_trevor', 
            andar = false, 
            loop = true
        },
    
        ['casalf2'] = {
            dict = 'timetable@trevor@ig_1', 
            anim = 'ig_1_thedesertissobeautiful_patricia', 
            andar = false, 
            loop = true
        },
    
        ['danceclub'] = {
            dict = 'anim@amb@nightclub_island@dancers@beachdance@', 
            anim = 'hi_idle_a_m03',
            loop = true
        },
    
        ['danceclub2'] = {
            dict = 'anim@amb@nightclub_island@dancers@beachdance@', 
            anim = 'hi_idle_a_m05',
            loop = true
        },
    
        ['danceclub3'] = { 
            dict = 'anim@amb@nightclub_island@dancers@beachdance@', 
            anim = 'hi_idle_a_m02',
            loop = true
        },
    
        ['danceclub4'] = { 
            dict = 'anim@amb@nightclub_island@dancers@beachdance@', 
            anim = 'hi_idle_b_f01',
            loop = true
        },
    
        ['danceclub5'] = { 
            dict = 'anim@amb@nightclub_island@dancers@club@', 
            anim = 'hi_idle_a_f02',
            loop = true
        },
    
        ['danceclub6'] = { 
            dict = 'anim@amb@nightclub_island@dancers@club@', 
            anim = 'hi_idle_b_m03',
            loop = true
        },
    
        ['danceclub7'] = { 
            dict = 'anim@amb@nightclub_island@dancers@club@', 
            anim = 'hi_idle_d_f01',
            loop = true
        },
    
        ['dancedrink'] = { 
            dict = 'anim@amb@nightclub_island@dancers@beachdanceprop@', 
            anim = 'mi_idle_c_m01',
            prop = 'prop_beer_amopen',
            flag = 50, 
            hand = 28422,
            loop = true,
            andar = false
        },
    
        ['dancedrink2'] = { 
            dict = 'anim@amb@nightclub_island@dancers@beachdanceprop@', 
            anim = 'mi_loop_f1',
            prop = 'p_wine_glass_s',
            flag = 50, 
            hand = 28422,
            loop = true,
            andar = false
        },
    
        ['dancedrink3'] = { 
            dict = 'anim@amb@nightclub_island@dancers@beachdanceprop@', 
            anim = 'mi_loop_m04',
            prop = 'ba_prop_battle_whiskey_opaque_s',
            flag = 50, 
            hand = 28422,
            loop = true,
            andar = false
        },
    
        ['dancedrink4'] = { 
            dict = 'anim@amb@nightclub_island@dancers@beachdanceprops@male@', 
            anim = 'mi_idle_b_m04',
            prop = 'ba_prop_battle_whiskey_opaque_s',
            flag = 50, 
            hand = 28422,
            loop = true,
            andar = false
        },
    
        ['dancedrink5'] = { 
            dict = 'anim@amb@nightclub_island@dancers@crowddance_single_props@', 
            anim = 'hi_dance_prop_09_v1_female^3',
            prop = 'p_wine_glass_s',
            flag = 50, 
            hand = 28422,
            loop = true,
            andar = false
        },
    
        ['dancedrink6'] = { 
            dict = 'anim@amb@nightclub_island@dancers@crowddance_single_props@', 
            anim = 'hi_dance_prop_09_v1_male^3',
            prop = 'prop_beer_logopen',
            flag = 50, 
            hand = 28422,
            loop = true,
            andar = false
        },
    
        ['dancedrink7'] = { 
            dict = 'anim@amb@nightclub_island@dancers@crowddance_single_props@', 
            anim = 'hi_dance_prop_11_v1_female^3',
            prop = 'p_wine_glass_s',
            flag = 50, 
            hand = 28422,
            loop = true,
            andar = false
        },
    
        ['dancedrink8'] = { 
            dict = 'anim@amb@nightclub_island@dancers@crowddance_single_props@', 
            anim = 'hi_dance_prop_11_v1_female^1',
            prop = 'p_wine_glass_s',		
            flag = 50, 
            hand = 28422,
            loop = true,
            andar = false
        },


        ['binoculos'] = { 
            dict = 'amb@world_human_binoculars@male@enter', 
            anim = 'enter', 
            prop = 'prop_binoc_01', 
            flag = 50, 
            hand = 28422, 
            extra = function()
                --TriggerEvent('inventory:binoculos', true)
            end 
        },

        ['cagar'] = {
            -- noCommand = true,
            dict = 'missfbi3ig_0', 
            anim = 'shit_loop_trev',
            extra = function()
                PtfxThis('scr_amb_chop')
                SetTimeout(1000,function()
                    effect = StartParticleFxLoopedOnPedBone('ent_anim_dog_poo',PlayerPedId(),0.0,0.0,-0.6,0.0,0.0,20.0,GetPedBoneIndex(PlayerPedId(),11816),2.0,false,false,false)
                    effect2 = StartParticleFxLoopedOnPedBone('ent_anim_dog_poo',PlayerPedId(),0.0,0.0,-0.6,0.0,0.0,20.0,GetPedBoneIndex(PlayerPedId(),11816),2.0,false,false,false)
                    Citizen.Wait(1000)
                    StopParticleFxLooped(effect,0)
                    StopParticleFxLooped(effect2,0)
                end)
            end
        },

        ['bong'] = {
            dict = 'anim@safehouse@bong', 
            anim = 'bong_stage1',
            prop = 'prop_bong_01',
            flag = 50,
            hand = 60309,
            extra = function()
                if not IsPedInAnyVehicle(PlayerPedId()) then
                    TriggerEvent('cancelando',true)
                    TriggerEvent('progress',9,'Fumando...')
                    TriggerEvent('vrp_sounds:source','bong',0.5)
                    SetTimeout(8700,function()
                        vRP._DeletarObjeto()
                        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE',0.5)
                    end)
                    SetTimeout(9000,function()
                        vRP.loadAnimSet('MOVE_M@DRUNK@VERYDRUNK')
                        SetTimecycleModifier('REDMIST_blend')
                        ShakeGameplayCam('FAMILY5_DRUG_TRIP_SHAKE',1.0)
                        StartScreenEffect('DMT_flight',120000,false)
                        Citizen.Wait(120000)
                        TriggerEvent('cancelando',false)
                        SetTimecycleModifier('')
                        SetTransitionTimecycleModifier('')
                        StopGameplayCamShaking()
                        ResetPedMovementClipset(PlayerPedId(),0.0)
                    end)
                end
            end
        },

        ['dinheiro'] = {
            dict = 'anim@mp_player_intupperraining_cash', 
            anim = 'idle_a',
            andar = true
        },

        ['mijar'] = {
            -- noCommand = true,
            dict = 'misscarsteal2peeing', 
            anim = 'peeing_loop',
            extra = function()
                PtfxThis('core')
                SetTimeout(500,function()
                    effect = StartParticleFxLoopedOnPedBone('ent_amb_peeing',PlayerPedId(),0.0,0.2,0.0,-140.0,0.0,0.0,GetPedBoneIndex(PlayerPedId(),11816),2.5,false,false,false)
                    Citizen.Wait(5500)
                    StopParticleFxLooped(effect,0)
                end)
            end
        },

        ['pano'] = {
            dict = 'timetable@maid@cleaning_window@base', 
            anim = 'base',
            prop = 'prop_rag_01',
            flag = 49,
            hand = 28422,
            extra = function()
                local vehicle = vRP.getNearestVehicle(7)
                if IsEntityAVehicle(vehicle) then
                    TriggerEvent('progressBar', 'Limpando...', 15000)
                    SetTimeout(15000,function()
                        SetVehicleDirtLevel(vehicle,0.0)
                        SetVehicleUndriveable(vehicle,false)
                        vRP.DeletarObjeto()
                    end)
                end
            end
        },

        ['pano2'] = {
            dict = 'timetable@maid@cleaning_surface@base', 
            anim = 'base',
            prop = 'prop_rag_01', 
            flag = 49, 
            hand = 28422,
            extra = function()
                local vehicle = vRP.getNearestVehicle(7)
                if IsEntityAVehicle(vehicle) then
                    SetVehicleDirtLevel(vehicle,0.0)
                    SetVehicleUndriveable(vehicle,false)
                    vRP.DeletarObjeto()
                end
            end
        },

        ['livro'] = {
            dict = 'cellphone@', 
            anim = 'cellphone_text_read_base',
            prop = 'prop_novel_01', 
            flag = 49, 
            hand = 6286,
            pos = { 0.15,0.03,-0.065,0.0,180.0,90.0 }            
        },

        ['tiktok1'] = {
            dict = 'jumpinglow@danceanimation', 
            anim = 'jumpinglow_clip', 
            andar = false, 
            loop = true 
        },
        ['tiktok2'] = { dict = 'behere@danceanimation' , anim = 'behere_clip' , andar = false , loop = true },

        ['tiktok3'] = { dict = 'comrade@danceanimation' , anim = 'comrade_clip' , andar = false , loop = true },

        ['tiktok4'] = { dict = 'dancecustom1@danceanimation' , anim = 'dancecustom1_clip' , andar = false , loop = true },

        ['tiktok5'] = { dict = 'dancecustom2@danceanimation' , anim = 'dancecustom2_clip' , andar = false , loop = true },

        ['tiktok6'] = { dict = 'dancecustom3@danceanimation' , anim = 'dancecustom3_clip' , andar = false , loop = true },

        ['tiktok7'] = { dict = 'controllercrew@dance' , anim = 'controllercrew_clip' , andar = false , loop = true },

        ['tiktok8'] = { dict = 'layers@danceanimation' , anim = 'layers_clip' , andar = false , loop = true },

        ['tiktok9'] = { dict = 'ondaonda@danceanimation' , anim = 'onda_clip' , andar = false , loop = true },

        ['tiktok10'] = { dict = 'tonal@danceanimation' , anim = 'tonal_clip' , andar = false , loop = true },

        ['tiktok11'] = { dict = 'dinamites@dance' , anim = 'dinamites_clip' , andar = false , loop = true },

        ['tiktok12'] = { dict = 'dynamite@dance' , anim = 'dynamite_clip' , andar = false , loop = true },

        ['tiktok13'] = { dict = 'gomufasa@dance' , anim = 'gomufasa_clip' , andar = false , loop = true },

        ['tiktok14'] = { dict = 'indigo@dance' , anim = 'indigo_clip' , andar = false , loop = true },

        ['tiktok15'] = { dict = 'kpop@dance' , anim = 'kpop_clip' , andar = false , loop = true },

        ['tiktok16'] = { dict = 'outwest@dance' , anim = 'outwest_clip' , andar = false , loop = true },

        ['tiktok17'] = { dict = 'pullup@dance' , anim = 'pullup_clip' , andar = false , loop = true },

        ['tiktok18'] = { dict = 'springy@dance' , anim = 'springy_clip' , andar = false , loop = true },

        ['tiktok19'] = { dict = 'tally@danceanimation' , anim = 'tally_clip' , andar = false , loop = true },

        ['tiktok20'] = { dict = 'stuckdance@animation' , anim = 'stuckdance_clip' , andar = false , loop = true },

        ['reanimar'] = {
            perm = 'hospital.permissao',
            dict = 'gndmedicdesfribilador@animations',
            anim = 'gndmedicdesfribilador_clip', 
            prop = { 'gnd_desfribilador_prop', 'gnd_desfribilador_prop' },
            flag = 50,
            hand = { 60309, 28422 },
            pos = { 0.07, 0.08, 0.02, -102.78, -70.6, 13.84 },
            pos2 = { 0.07, 0.07, -0.03, -85.36, -304.17, 13.84 },
            andar = false, 
            loop = true,
        },
    },

    ['walkAnim'] = {
        { anim = 'move_m@alien' },
        { anim = 'anim_group_move_ballistic' },
        { anim = 'move_f@arrogant@a' },
        { anim = 'move_m@brave' },
        { anim = 'move_m@casual@a' },
        { anim = 'move_m@casual@b' },
        { anim = 'move_m@casual@c' },
        { anim = 'move_m@casual@d' },
        { anim = 'move_m@casual@e' },
        { anim = 'move_m@casual@f' },
        { anim = 'move_f@chichi' },
        { anim = 'move_m@confident' },
        { anim = 'move_m@business@a' },
        { anim = 'move_m@business@b' },
        { anim = 'move_m@business@c' },
        { anim = 'move_m@drunk@a' },
        { anim = 'move_m@drunk@slightlydrunk' },
        { anim = 'move_m@buzzed' },
        { anim = 'move_m@drunk@verydrunk' },
        { anim = 'move_f@femme@' },
        { anim = 'move_characters@franklin@fire' },
        { anim = 'move_characters@michael@fire' },
        { anim = 'move_m@fire' },
        { anim = 'move_f@flee@a' },
        { anim = 'move_p_m_one' },
        { anim = 'move_m@gangster@generic' },
        { anim = 'move_m@gangster@ng' },
        { anim = 'move_m@gangster@var_e' },
        { anim = 'move_m@gangster@var_f' },
        { anim = 'move_m@gangster@var_i' },
        { anim = 'anim@move_m@grooving@' },
        { anim = 'move_f@heels@c' },
        { anim = 'move_m@hipster@a' },
        { anim = 'move_m@hobo@a' },
        { anim = 'move_f@hurry@a' },
        { anim = 'move_p_m_zero_janitor' },
        { anim = 'move_p_m_zero_slow' },
        { anim = 'move_m@jog@' },
        { anim = 'anim_group_move_lemar_alley' },
        { anim = 'move_heist_lester' },
        { anim = 'move_f@maneater' },
        { anim = 'move_m@money' },
        { anim = 'move_m@posh@' },
        { anim = 'move_f@posh@' },
        { anim = 'move_m@quick' },
        { anim = 'female_fast_runner' },
        { anim = 'move_m@sad@a' },
        { anim = 'move_m@sassy' },
        { anim = 'move_f@sassy' },
        { anim = 'move_f@scared' },
        { anim = 'move_f@sexy@a' },
        { anim = 'move_m@shadyped@a' },
        { anim = 'move_characters@jimmy@slow@' },
        { anim = 'move_m@swagger' },
        { anim = 'move_m@tough_guy@' },
        { anim = 'move_f@tough_guy@' },
        { anim = 'move_p_m_two' },
        { anim = 'move_m@bag' },
        { anim = 'move_m@injured' }
    },
            
    ['expression'] = {
        ['angry'] = {
            anim = 'mood_angry_1'
        },
        ['drunk'] = {
            anim = 'mood_drunk_1'
        },
        ['dumb'] = {
            anim = 'pose_injured_1'
        },
        ['electrocuted'] = {
            anim = 'electrocuted_1'
        },
        ['grumpy'] = {
            anim = 'effort_1'
        },
        ['grumpy2'] = {
            anim = 'mood_drivefast_1'
        },
        ['grumpy3'] = {
            anim = 'pose_angry_1'
        },
        ['happy'] = {
            anim = 'mood_happy_1'
        },
        ['injured'] = {
            anim = 'mood_injured_1'
        },
        ['joyful'] = {
            anim = 'mood_dancing_low_1'
        },
        ['mouthbreather'] = {
            anim = 'smoking_hold_1'
        },
        ['neverBlink'] = {
            anim = 'pose_normal_1'
        },
        ['oneEye'] = {
            anim = 'pose_aiming_1'
        },
        ['shocked'] = {
            anim = 'shocked_1'
        },
        ['shocked2'] = {
            anim = 'shocked_2'
        },
        ['sleeping'] = {
            anim = 'mood_sleeping_1'
        },
        ['sleeping2'] = {
            anim = 'dead_1'
        },
        ['sleeping3'] = {
            anim = 'dead_2'
        },
        ['smug'] = {
            anim = 'mood_smug_1'
        },
        ['speculative'] = {
            anim = 'mood_aiming_1'
        },
        ['stressed'] = {
            anim = 'mood_stressed_1'
        },
        ['sulking'] = {
            anim = 'mood_sulk_1'
        },
        ['weird'] = {
            anim = 'effort_2'
        },
        ['weird2'] = {
            anim = 'effort_3'
        },
        ['di2'] = {
            anim = 'die_1'
        },
        ['normal'] = {
            anim = 'mood_normal_1'
        }
    },
}

return config
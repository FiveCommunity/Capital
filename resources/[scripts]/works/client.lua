vSERVER = Tunnel.getInterface(GetCurrentResourceName())

inWork = false
selection = 0

local jobs

local externalJobs = {}

RegisterJob = function(tbl)
    if tbl and tbl.name then
        externalJobs[tbl.name] = tbl
    end
end

RegisterCommand('job',function(s,a,r)
    local work = a[1] or ''
    if externalJobs[work] then
        return externalJobs[work].start();
    end
end)

local createJobs = function(perfectCity)
    if perfectCity == 1 then
        jobs = {}
        for k, v in pairs(externalJobs) do
            print(json.encode(v.business))
            if (not v.hidden and v.perfectCity) then
                table.insert(jobs, {
                    business = v.business,
                    name = v.name,
                    price = v.payment,
                    routes = v.routes,
                    description = v.description,
                    url = v.url
                })
            end
        end
    end
    if (not jobs) then
        jobs = {}
        for k, v in ipairs(list) do
            local cfg = works[v.work]
            table.insert(jobs, {
                business = cfg.name,
                name = v.work,
                price = 'R$'..cfg.payment.money.min..'/'..cfg.payment.money.max,
                routes = #cfg.routes,
                description = cfg.description,
                url = v.url
            })
        end
        
        for k, v in pairs(externalJobs) do
            if (not v.hidden and not v.perfectCity) then
                table.insert(jobs, {
                    business = v.business,
                    name = v.name,
                    price = v.payment,
                    routes = v.routes,
                    description = v.description,
                    url = v.url
                })
            end
        end
    end
    return jobs
end

RegisterNetEvent('works:open', function(perfectCity)
    if (not inWork) then
        local list = createJobs(perfectCity)

        LocalPlayer.state.Hud = false
        SetNuiFocus(true, false)
        SendNUIMessage({
            action = 'open',
            jobs = list
        })
    end
end)

local _tempCam;
createCam = function(coords, rotX, rotY, rotZ)
    LocalPlayer.state.Hud = false
    Citizen.Wait(1000)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    if (not DoesCamExist(_tempCam)) then 
        _tempCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)  
    end
    SetCamCoord(_tempCam, coords)
    SetCamRot(_tempCam, rotX, rotY, rotZ, 2)
    SetCamActive(_tempCam, true)
    RenderScriptCams(true, true, 0, true, true)
    DoScreenFadeIn(500)
end

destroyCam = function()
    Citizen.Wait(1000)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(_tempCam, false)
    _tempCam = nil
    DoScreenFadeIn(500)
    LocalPlayer.state.Hud = true
end

_stage = 0
_work = ''
task = false

startJob = function(work)
    TriggerEvent('notify', 'aviso', 'Central de Empregos', 'Pressione <b>F7</b> para sair de serviço!', 8000)

    if externalJobs[work] then
        return externalJobs[work].start();
    end

    inWork = true
    _work = work
    _config = works[work]
    TriggerEvent('notify', 'sucesso', 'Emprego', lang[work].startJob(work))

    local ped = PlayerPedId()
    local pCoord = GetEntityCoords(ped)
    Citizen.CreateThread(function()
        _stage = 1
        vSERVER.startUpdateRoute()
        createBlip(_config.coords.start)
        while (_stage == 1) do
            ped = PlayerPedId()
            pCoord = GetEntityCoords(ped)

            Text2D(0, 0.43, 0.95, 'Vá até o local da ~b~Empresa~w~', 0.4)
            local distance = #(pCoord - _config.coords.start)
            if (distance <= 10.0) then
                DrawMarker(1, _config.coords.start.x, _config.coords.start.y, _config.coords.start.z-0.97, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 3, 187, 232, 155, 0, 0, 0, 1)
                if (distance <= 1.2 and not IsPedInAnyVehicle(ped)) then 
                    RemoveBlip(blips)
                    PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 1)
                    _stage = 0
                    secondStage()
                end
            end
            Citizen.Wait(1)
        end
    end)

    local nearestBlips = {}

    local _markerThread = false
    local productionThread = function()
        if (_markerThread) then return; end;
        _markerThread = true
        Citizen.CreateThread(function()
            while (countTable(nearestBlips) > 0) do
                local _cache = nearestBlips
                for index, dist in pairs(_cache) do
                    local configProductions = productions[work][index]
                    if (dist <= 5.0) then
                        local _coord = vector3(configProductions.coord.x, configProductions.coord.y, configProductions.coord.z)
                        Text3D(_coord.x, _coord.y, _coord.z, '~b~E~w~ - '..product[configProductions.config].blipText, 400)
                        if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped) and not task) then
                            _functionProduction(configProductions)
                        end
                    end
                end
                Citizen.Wait(1)
            end
            _markerThread = false
        end)
    end

    secondStage = function()
        RemoveBlip(blips)

        if (vSERVER.startCutscene(work)) then
            createCam(_config.cams[1][1], _config.cams[1][2], _config.cams[1][3], _config.cams[1][4])
            PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', false)
            ShowAdvancedNotification('CHAR_ANTONIA', 'Antonia', _config.name, lang[work].jobStage(work))
            Citizen.Wait(10000)
            destroyCam()

            createCam(_config.cams[2][1], _config.cams[2][2], _config.cams[2][3], _config.cams[2][4])
            PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', false)
            ShowAdvancedNotification('CHAR_ANTONIA', 'Antonia', _config.name, lang[work].jobStart(work))
            Citizen.Wait(10000)
            destroyCam()

            if (work ~= 'Pedreiro' and work ~= 'Gari') then
                createCam(_config.cams[3][1], _config.cams[3][2], _config.cams[3][3], _config.cams[3][4])
                PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', false)
                ShowAdvancedNotification('CHAR_ANTONIA', 'Antonia', _config.name, lang[work].jobFarm(work))
                Citizen.Wait(10000)
                destroyCam()

                createCam(_config.cams[4][1], _config.cams[4][2], _config.cams[4][3], _config.cams[4][4])
                PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', false)
                ShowAdvancedNotification('CHAR_ANTONIA', 'Antonia', _config.name, lang[work].jobGarage(work))
                Citizen.Wait(10000)
                destroyCam()
            end
        end
 
        if (productions[work]) then
            Citizen.CreateThread(function()
                while (inWork) do
                    ped = PlayerPedId()
                    pCoord = GetEntityCoords(ped)
                    nearestBlips = {}
                    for k, v in pairs(productions[work]) do
                        local distance = #(pCoord - v.coord.xyz)
                        if (distance <= 5.0) then
                            nearestBlips[k] = distance
                        end
                    end
                    if (countTable(nearestBlips) > 0) then productionThread(); end;
                    Citizen.Wait(500)
                end
            end)
        end

        Citizen.CreateThread(function()
            while (inWork) do
                if (not productions[work]) then
                    ped = PlayerPedId()
                    pCoord = GetEntityCoords(ped)
                end
                
                local _idle = 1000
                local distance = #(pCoord - _config.coords.route)
                if (distance <= 3.0) then
                    _idle = 1
                    DrawMarker(1, _config.coords.route.x, _config.coords.route.y, _config.coords.route.z-0.97, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.4, 3, 187, 232, 155, 0, 0, 0, 1)
                    if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) then
                        _startWork()
                    end
                end
                Citizen.Wait(_idle)
            end
        end)
    end

    _startWork = function()
        _stage = 0
        selection = 1
        TriggerEvent('notify', 'sucesso', 'Emprego', lang[work]['startRoute'](work))
        TriggerEvent('notify', 'aviso', 'Emprego', 'Não esqueça de pegar o veículo do <b>emprego</b>.')
        createBlip(_config.routes, selection, true)
        while (inWork) do
            ped = PlayerPedId()
            pCoord = GetEntityCoords(ped)

            local _idle = 1000 
            local distance = #(pCoord - _config.routes[selection])
            if (distance <= 5.0) then
                _idle = 1
                Text3D(_config.routes[selection].x, _config.routes[selection].y, _config.routes[selection].z, '~b~E~w~ - '.._config.text, 400)
                if (distance <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 100 and checkVehicleFunctions(ped, config) and not task) then   
                    if (lastVehicleModel(GetPlayersLastVehicle(), _config.vehicle)) then
                        if (vSERVER.checkItem(_config.requireItem)) then
                            RemoveBlip(blips)
                            task = true
                        
                            if (_config.anim) then ExecuteCommand('e '.._config.anim); end;
                            LocalPlayer.state.BlockTasks = true
                            
                            if (_config.blipWithCar) then
                                FreezeEntityPosition(GetVehiclePedIsIn(ped), true)
                            else
                                LocalPlayer.state.freezeEntity = true
                            end

                            TriggerEvent('progressBar', lang[work]['progressBar'], _config.setTimeOut)
                            Citizen.SetTimeout(_config.setTimeOut, function()
                                LocalPlayer.state.BlockTasks = false
                                if (_config.blipWithCar) then
                                    FreezeEntityPosition(GetVehiclePedIsIn(ped), false)
                                else
                                    LocalPlayer.state.freezeEntity = false
                                end

                                vSERVER.givePayment(_config.routes, _config.payment, _config.name)
                                vRP.DeletarObjeto()
                                ClearPedTasks(ped)

                                selection = selection + 1
                                if (selection > #_config.routes) then
                                    selection = 1 
                                    TriggerEvent('notify', 'aviso', 'Emprego', lang[work]['resetRoutes'])
                                end
                                Citizen.Wait(500)
                                task = false
                                TriggerEvent('notify', 'aviso', 'Emprego', lang[work]['newRoute'], 8000)
                                createBlip(_config.routes, selection, true)
                            end)
                        end
                    else
                        TriggerEvent('notify', 'aviso', 'Emprego', lang[work]['noVehicleBusiness'](_config.name))
                    end
                end
            end
            Citizen.Wait(_idle)
        end
    end

    _functionProduction = function(_production)
        task = true
        if (vSERVER.checkItem(product[_production['config']]['requireItems'], true)) then
            SetEntityHeading(ped, _production['coord'].w)

            if (product[_production['config']]['anim']) then
                ExecuteCommand('e '..product[_production['config']]['anim'])
            end

            LocalPlayer.state.BlockTasks = true
            LocalPlayer.state.freezeEntity = true
            TriggerEvent('progressBar', product[_production['config']]['progressBarText'], product[_production['config']]['duration'])
            Citizen.SetTimeout(product[_production['config']]['duration'], function()
                task = false
                LocalPlayer.state.BlockTasks = false
                LocalPlayer.state.freezeEntity = false
                vSERVER.giveItem(_production['config'], GetEntityCoords(ped))
                ClearPedTasks(ped)
            end)
        else
            task = false
        end
    end
end

ShowAdvancedNotification = function(icon, sender, title, text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end

RegisterNUICallback('startJob', function(data, cb)
    SetNuiFocus(false, false)
    startJob(data['works'])
end)

RegisterNUICallback('close', function()
    LocalPlayer.state.Hud = true
    SetNuiFocus(false, false)
end)
--======================================================
-- Start Job
--======================================================
RegisterNetEvent('works:start',function(name)
    if (not inWork) then        
        startJob(name)
    else
        TriggerEvent('notify', 'aviso', 'Central de Empregos', 'Você possui um emprego ativo!')
    end
end)
--======================================================
-- Stop Service
--======================================================
local stopping = false
RegisterCommand('stopService', function()
    if (not stopping) then
        stopping = true
        if (inWork) then
            if (type(inWork) == 'string') then
                if externalJobs[inWork] then
                    externalJobs[inWork].stop()
                end
            else
                stopWork(lang[_work]['stopWork']())
            end
        end
        stopping = false
    end
end)
RegisterKeyMapping('stopService', 'Sair de Serviço', 'keyboard', 'F7')
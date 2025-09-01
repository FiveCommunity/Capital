if (GetResourceState('night_natural_disasters') == 'started') then return print('Sistema de desastre ativo. (Desativando Weather System)'); end;

local weathersConfig = config.weathers

local freezetime = false
local freezeweather = false
local newWeather = 0

if (not GlobalState.weatherSystem) then
    GlobalState.weatherSystem = true
    GlobalState.weather = 'XMAS'
    GlobalState.hours = 7
    GlobalState.minutes = 0
    GlobalState.blackout = false
end

local sourceVerification = function(source)
    local allow = false
    if (source == 0) then 
        allow = true
    else
        allow = vRP.hasPermission(vRP.getUserId(source), '+Staff.COO')
    end
    return allow 
end

local generateWeather = function()
    ::generateWeatherAgain::
    local weatherRandom = math.random(#config.weathers)
    if (weathersConfig[weatherRandom].active) then
        if (weathersConfig[weatherRandom].blacklist) then
            local blacklistRandom = math.random(100)
            if (blacklistRandom >= 50) then 
                goto generateWeatherAgain
            end  
        end
        GlobalState.weather = weathersConfig[weatherRandom].name
        print('Clima alterado para ^1'..GlobalState.weather..'^7.')
    end
end

RegisterCommand('time', function(source, args)
    local allow = sourceVerification(source)
    if (allow) then
        if (args[1]) then
            if (not args[2]) then args[2] = 0; end;
            GlobalState.hours, GlobalState.minutes = parseInt(args[1]), parseInt(args[2]);
            if (source ~= 0) then TriggerClientEvent('notify', source, 'sucesso', 'Clima', 'O <b>horário da cidade</b> foi alterado com sucesso!'); end;
            print('Tempo alterado para ^1'..GlobalState.hours..':'..GlobalState.minutes..'^7.')
        end
    end
end)

RegisterCommand('freezetime', function(source)
    local allow = sourceVerification(source)
    if (allow) then
        freezetime = (not freezetime)
        if (source ~= 0) then TriggerClientEvent('notify', source, 'sucesso', 'Clima', 'O tempo foi <b>'..(freezetime == true and 'congelado' or 'descongelado')..'</b> com sucesso!'); end;
        print('Tempo foi ^1'..(freezetime == true and 'congelado' or 'descongelado')..'^7.')
    end
end)

RegisterCommand('freezeweather', function(source)
    local allow = sourceVerification(source)
    if (allow) then
        freezeweather = (not freezeweather)
        if (source ~= 0) then TriggerClientEvent('notify', source, 'sucesso', 'Clima', 'O clima foi <b>'..(freezeweather == true and 'congelado' or 'descongelado')..'</b> com sucesso!'); end;
        print('Clima foi ^1'..(freezeweather == true and 'congelado' or 'descongelado')..'^7.')
    end
end)

RegisterCommand('weather', function(source, args)
    local allow = sourceVerification(source)
    if (allow) then
        if (args[1]) then
            GlobalState.weather = string.upper(args[1])
            if (source ~= 0) then TriggerClientEvent('notify', source, 'sucesso', 'Clima', 'O clima foi <b>alterado</b> com sucesso!'); end;
            print('Clima alterado para ^1'..GlobalState.weather..'^7.')
        end
    end
end)

RegisterCommand('blackout', function(source, args)
    local allow = sourceVerification(source)
    if (allow) then
        GlobalState.blackout = (not GlobalState.blackout)
        if (source ~= 0) then TriggerClientEvent('notify', source, 'sucesso', 'Clima', 'Você <b>'..(GlobalState.blackout and 'ativou' or 'desativou')..'</b> o blackout!'); end;
        TriggerClientEvent('gb_weather:blackout', -1, GlobalState.blackout)
        print('Blackout ^1'..(GlobalState.blackout and 'ativado' or 'desativado')..'^7.')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if (not freezeweather) then
            if (newWeather == 0) then generateWeather(); newWeather = 30; end;
            newWeather = parseInt(newWeather - 1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
        if (not freezetime) then
            GlobalState.minutes = (parseInt(GlobalState.minutes) + 1)
            if (GlobalState.minutes >= 60) then 
                GlobalState.minutes = 0; GlobalState.hours = (parseInt(GlobalState.hours) + 1);
                if (GlobalState.hours >= 24) then GlobalState.hours = 0; end;
            end
        end
    end
end)
if (GetResourceState('night_natural_disasters') == 'started') then return; end;

local staticTime = false

RegisterNetEvent('gb_weather:staticTime', function(data) staticTime = data; end)
RegisterNetEvent('gb_weather:blackout', function(bool) SetArtificialLightsState(bool); end)

Citizen.CreateThread(function()
    SetArtificialLightsState(GlobalState.blackout)
    while (true) do
        if (type(staticTime) ~= 'table') then
            SetWeatherTypeNow(GlobalState.weather)
            SetWeatherTypePersist(GlobalState.weather)
            SetWeatherTypeNowPersist(GlobalState.weather)
            NetworkOverrideClockTime(GlobalState.hours, GlobalState.minutes, 00)
        else
            SetWeatherTypeNow(staticTime['weather'])
            SetWeatherTypePersist(staticTime['weather'])
            SetWeatherTypeNowPersist(staticTime['weather'])
            NetworkOverrideClockTime(staticTime['hours'], staticTime['minutes'], 00)
        end
        Citizen.Wait(1000)
    end
end)

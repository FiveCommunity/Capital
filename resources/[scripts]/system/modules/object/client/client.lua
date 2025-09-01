local Props = {
    [GetHashKey('prop_atm_01')] = {
        text = '~b~E~w~ - Acessar ATM',
        action = function()
            TriggerEvent('open:bank')
        end
    },
    [GetHashKey('prop_atm_02')] = {
        text = '~b~E~w~ - Acessar ATM',
        action = function()
            TriggerEvent('open:bank')
        end
    },
    [GetHashKey('prop_atm_03')] = {
        text = '~b~E~w~ - Acessar ATM',
        action = function()
            TriggerEvent('open:bank')
        end
    },
    [GetHashKey('prop_fleeca_atm')] = {
        text = '~b~E~w~ - Acessar ATM',
        action = function()
            TriggerEvent('open:bank')
        end
    },
    [-654402915] = {
        text = '~b~E~w~ - Acessar Máquina',
        action = function()
            TriggerEvent('open:shop', 'Maquina')
        end
    },
    [992069095] = {
        text = '~b~E~w~ - Acessar Máquina',
        action = function()
            TriggerEvent('open:shop', 'Maquina')
        end
    },
    [1114264700] = {
        text = '~b~E~w~ - Acessar Máquina',
        action = function()
            TriggerEvent('open:shop', 'Maquina')
        end
    },
    [690372739] = {
        text = '~b~E~w~ - Acessar Máquina',
        action = function()
            TriggerEvent('open:shop', 'Maquina')
        end
    },
}

-- local nearestBlips = {}

-- local _markerThread = false
-- local markerThread = function()
--     if (_markerThread) then return; end;
--     _markerThread = true
--     Citizen.CreateThread(function()
--         while (countTable(nearestBlips) > 0) do
--             local ped = PlayerPedId()
--             local _cache = nearestBlips
--             for index, dist in pairs(_cache) do
--                 local config = Props[index]
--                 if (dist <= 1.0) then
--                     TextFloating(config.text, GetEntityCoords(ped))
--                     if (IsControlJustPressed(0, 38)) then
--                         if (config.action) then
--                             config.action()
--                         end
--                     end
--                 end
--             end
--             Citizen.Wait(1)
--         end
--         _markerThread = false
--     end)
-- end

-- Citizen.CreateThread(function()
--     while (true) do
--         local ped = PlayerPedId()
--         local pCoord = GetEntityCoords(ped)
--         nearestBlips = {}
--         for k, v in pairs(Props) do
--             local obj = GetClosestObjectOfType(pCoord, 1.5, k, false, false, false)
--             if (obj > 0) then
--                 local distance = #(pCoord - GetEntityCoords(obj))
--                 if (distance <= 2) then
--                     nearestBlips[k] = distance
--                 end
--             end
--         end
--         if (countTable(nearestBlips) > 0) then markerThread(); end;
--         Citizen.Wait(500)
--     end
-- end)
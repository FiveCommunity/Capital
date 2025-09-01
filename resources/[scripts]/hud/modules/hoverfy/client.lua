local hoverLocates = {}
local hoverCoords = {}

local showHoverfy = false
local manualHoverfy = false

local gridChunk = function(x)
	return math.floor((x + 8192) / 128)
end

local toChannel = function(v)
	return (v['x'] << 8) | v['y']
end

local getGridzone = function(x, y)
	local gridChunk = vector2(gridChunk(x), gridChunk(y))
	return toChannel(gridChunk)
end

Citizen.CreateThread(function()
    while (not Ready) do Citizen.Wait(100); end;
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)

        if (not manualHoverfy) then
            if (not showHoverfy) then
                local gridZone = getGridzone(pCoord.x, pCoord.y)

                if (hoverLocates[gridZone]) then
                    for _, v in pairs(hoverLocates[gridZone]) do
                        local distance = #(pCoord - v.coords)
                        if (distance <= v.distance) then
                            hoverCoords = { v.coords, v.distance }
                            UpdateStats('hoverfy', { show = true, key = v.key, text = v.text })
                            showHoverfy = true
                        end
                    end
                end
            end

            if (showHoverfy) then
                local distance = #(pCoord - hoverCoords[1])
                if (distance > hoverCoords[2]) then
                    UpdateStats('hoverfy', { show = false }) 
                    showHoverfy = false 
                end
            end
        end
        Citizen.Wait(1000)
    end
end)

customHoverfy = function(key, text)
    if (showHoverfy) then 
        showHoverfy = false 
        UpdateStats('hoverfy', { show = false }) 
    end

    if (key) then
        if (manualHoverfy) then return; end;
        manualHoverfy = true

        UpdateStats('hoverfy', {
            show = true,
            key = key,
            text = text
        }) 
    else
        if (not manualHoverfy) then return; end;
        manualHoverfy = false

        UpdateStats('hoverfy', { show = false }) 
    end
end
exports('customHoverfy', customHoverfy)

RegisterNetEvent('insert:hoverfy', function(coords, key, text, distance)
    local resource = (GetInvokingResource() or GetCurrentResourceName())
    local gridZone = getGridzone(coords.x, coords.y)
    if (not hoverLocates[gridZone]) then hoverLocates[gridZone] = {}; end;
    table.insert(hoverLocates[gridZone], { coords = coords, key = key, text = text, distance = distance, rsc = resource })
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    for k, v in pairs(hoverLocates) do
		for i = 1, #v do
			if (v[i]) and (v[i].rsc == resourceName) then
				hoverLocates[k][i] = nil;
			end
		end
	end
end)
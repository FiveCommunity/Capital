-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local systemBlips = {}
local userState = {}

Citizen.CreateThread(function()
    while (true) do
        for group,users in pairs(systemBlips) do
            for src,mode in pairs(users) do
                if GetPlayerPing(src) > 0 then
                    local ped = GetPlayerPed(src)
                    
                    mode.coords = vector4( GetEntityCoords(ped), GetEntityHeading(ped) )
                    
                    local syncTree = {}
                    for gview,_ in pairs(userState[src].views) do
                        syncTree[gview] = systemBlips[gview]
                    end
                    TriggerLatentClientEvent('sw-blips:update', src, 1024, syncTree)

                else
                    unTracePlayer(src)
                end
            end
        end
        Citizen.Wait(7000)
    end
end)

RegisterNetEvent('sw-blips:updateType',function(group,btype)
    local source = source
    if systemBlips[group] and systemBlips[group][source] then
        systemBlips[group][source].btype = btype
    end
end)

AddEventHandler('playerDropped',function()
    local source = source
	local data = userState[source]
    if data then
        systemBlips[data.group][source] = nil
        userState[source] = nil 
        TriggerClientEvent("sw-blips:playerRemoved",-1,source)
    end
end)
--==================================================================================================

function tracePlayer(source,group,viewGroups)
    if (not userState[source]) then
        if (not systemBlips[group]) then
            systemBlips[group] = {}
        end
        local ped = GetPlayerPed(source)
        systemBlips[group][source] = { coords = vector4( GetEntityCoords(ped), GetEntityHeading(ped) ), btype = "foot" }
        userState[source] = { group = group, views = viewGroups }
        TriggerClientEvent("sw-blips:setEnabled", source, group)
    end
end
AddEventHandler('sw-blips:tracePlayer', tracePlayer)
exports('tracePlayer',tracePlayer)

function unTracePlayer(source)
    local data = userState[source]
    if data then
        systemBlips[data.group][source] = nil
        userState[source] = nil 
        TriggerClientEvent("sw-blips:playerRemoved",-1,source)
        TriggerClientEvent("sw-blips:setEnabled", source, false)
    end
end
AddEventHandler('sw-blips:unTracePlayer', unTracePlayer)
exports('unTracePlayer',unTracePlayer)

--==================================================================================================
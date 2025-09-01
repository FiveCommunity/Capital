--=======================================================================================================================================
-- Drop Funtions
--=======================================================================================================================================
dropList = {}
nearestList = {}

function refreshDropInventory()
    local nearDrops, dropWeight, dropCount = sRP.getNearestDrops()
    if nearDrops then
        SendNUIMessage({ action = "setSecondText", text = "chão", weight = dropWeight })
        SendNUIMessage({ action = "setSecondItems", itemSList = nearDrops, slots = 50 })
        SendNUIMessage({ action = "display", type = "drop" })
    end
end

function cRP.setDrop(id,marker)
	dropList[id] = marker
    nearestList[id] = nil
end
--=======================================================================================================================================
-- Drop Threads
--=======================================================================================================================================
local pCDS = vec3(0,0,0)
Citizen.CreateThread(function()
    while true do
		pCDS = GetEntityCoords(PlayerPedId())
        for k,v in pairs(dropList) do				
            if #(pCDS - v.coord) <= 10.0 then
                if (not nearestList[k]) then
                    nearestList[k] = v
                end
            else
                if nearestList[k] then
                    nearestList[k] = nil
                end
            end
        end
		Citizen.Wait(800)
	end
end)

Citizen.CreateThread(function()
	while true do
		local _sleep = 200
        for k,v in pairs(nearestList) do				      
            if #(pCDS - v.coord) <= 3.5 then
                _sleep = 1
                if (not v.cdz) then
                    local _,cdz = GetGroundZFor_3dCoord(v.coord.x,v.coord.y,v.coord.z)
                    v.cdz = cdz
                end

                DrawMarker(0,v.coord.x,v.coord.y,v.cdz+0.3,0,0,0,0,0,130.0,0.15,0.15,0.15,3, 187, 232,200,1,0,0,0)
            end
        end
		Citizen.Wait(_sleep)
	end
end)
--=======================================================================================================================================
-- Drop Callbacks
--=======================================================================================================================================
RegisterNUICallback("DropItem", function(data, cb)
    local refresh = sRP.tryDropItem(data["slot"],data["amount"])
    if refresh then
        refreshPlayerInventory()
        refreshDropInventory()
    end
end)

RegisterNUICallback("PickupItem", function(data, cb)
    local refresh = sRP.tryPickupItem(parseInt(data["id"]),data["amount"],data["target"])
    if refresh then
        refreshPlayerInventory()
        refreshDropInventory()
    end
end)
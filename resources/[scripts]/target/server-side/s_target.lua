local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
--======================================================================================
local sTarget = {}
Tunnel.bindInterface("vrp_target",sTarget)

function sTarget.checkPermission(perm)
    return vRP.hasPermission(vRP.getUserId(source),perm)
end

function permissionHandler(user_id)
	local _source = vRP.getUserSource(user_id)
    if _source then
        TriggerClientEvent('vrp_target:clearPermissions', _source)
    end
end

AddEventHandler("group:event",permissionHandler)
--======================================================================================
function inventoryHandler(user_id)
	local _source = vRP.getUserSource(user_id)
    if _source then
        local inventory = vRP.getInventory(user_id)
        local user_items = {}
        for slot,data in pairs(inventory) do
            if (not user_items[data.item]) then
                user_items[data.item] = data.amount
            else
                user_items[data.item] = user_items[data.item] + data.amount
            end
        end
        TriggerLatentClientEvent('vrp_target:refreshItems', _source, 256, user_items)
    end
end

AddEventHandler("vRP:playerSpawn",inventoryHandler)
AddEventHandler("vRP:playerWonItem",inventoryHandler)
AddEventHandler("vRP:playerLoseItem",inventoryHandler)
AddEventHandler("vRP:playerCleanedInv",inventoryHandler)
--======================================================================================
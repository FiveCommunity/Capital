function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 8.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = true

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- Draw a Sprite on the center of a PolyZone to hint where it's located
Config.DrawSprite = true

-- The default distance to draw the Sprite
Config.DrawDistance = 10.0

-- The color of the sprite in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.DrawColor = {255, 255, 255, 255}

-- The color of the sprite in rgb when the PolyZone is targeted, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.SuccessDrawColor = {30, 144, 255, 255}

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = {255, 255, 255, 255}

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = true

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = true

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 238

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {

}

Config.PolyZones = {

}

Config.TargetBones = {

}

Config.TargetModels = {

}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {

}

Config.Peds = {

}
-------------------------------------------------------------------------------
-- Permission Check
-------------------------------------------------------------------------------
local sTarget = module("vrp","lib/Tunnel")["getInterface"]("vrp_target")
local user_permissions = {}

local function PermissionCheck(perm) 
	if (user_permissions[perm] == nil) then
		user_permissions[perm] = sTarget.checkPermission(perm)
	end
	return user_permissions[perm] 
end

local function PermissionsCheck(perms)
	for _,perm in pairs(perms) do
		if PermissionCheck(perm) then return true; end;
	end
end

RegisterNetEvent("vrp_target:clearPermissions",function()
	user_permissions = {}
end)
-------------------------------------------------------------------------------
-- Item Amounts
-------------------------------------------------------------------------------
local user_items = {}
local function ItemCheck(items)
	if items.idname then
		return (user_items[items.idname] or 0) >= items.amount
	else
		local have = true
		for _,item in ipairs(items) do
			if have then
				have = (user_items[item.idname] or 0) >= item.amount
			else
				break
			end
		end
		return have
	end
end

RegisterNetEvent("vrp_target:refreshItems",function(items)
	user_items = items
end)
-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
CreateThread(function()
	SpawnPeds()
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	if data.permission and not PermissionCheck(data.permission) then return false end
	if data.permissions and not PermissionsCheck(data.permissions) then return false end
	if data.item and not ItemCheck(data.item) then return false end
	return true
end
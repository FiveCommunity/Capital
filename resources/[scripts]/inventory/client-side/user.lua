LocalPlayer.state:set('usingItem', false, true)
--=======================================================================================================================================
-- Inventory Functions
--=======================================================================================================================================
inventoryOpen = false
--=========================================

Citizen.CreateThread(function()
    LocalPlayer.state.usingItem = false;
	SetNuiFocus(false,false);
    StopScreenEffect('MenuMGSelectionIn');
end)

function closeInventory()
    SetNuiFocus(false,false)
    SendNUIMessage({ action = "hide" })
    StopScreenEffect('MenuMGSelectionIn')
    TriggerEvent("inventory:onClose")
    TriggerServerEvent("inventory:onClose")    
    inventoryOpen = false
end
RegisterNetEvent("inventory:close",closeInventory)
RegisterNUICallback("NUIFocusOff",closeInventory)


AddStateBagChangeHandler('Handcuff', nil, function(bagName, key, value) 
    local player = GetPlayerFromStateBagName(bagName)
    if (player == 0) or (PlayerId() ~= player) or (not value) then return; end;
    closeInventory()
end)
--=========================================

function refreshSelected(state)
    local switch = {
        chest = function()
            refreshChestInventory();   
        end,
        drop = function()
            refreshDropInventory();
        end,
        inspect = function()
            refreshInspectInventory();
        end,
        vault = function()
            refreshVaultInventory();
        end
    }
    switch[(state or "drop")]()
end

function refreshPlayerInventory()
    local inventory,weights = sRP.getUserInventory()
    SendNUIMessage({ action = "setText", text = 'Mochila', weight = weights.current, max = weights.max })
    SendNUIMessage({ action = "setItems", itemList = inventory, slots = weights.slots })
end

RegisterNetEvent("intentory:refresh",function(inv)
    if inventoryOpen then
        refreshPlayerInventory()
    end
end)

RegisterNetEvent("ItemNotify",function(item, icon, status)
	SendNUIMessage({ action = "itemNotify", item = item, icon = icon, status = status })
end)
--=======================================================================================================================================
-- Key Mapping
--=======================================================================================================================================
if config.modules["base-system"] then
    blockInventory = false;
    LocalPlayer.state.throwingWeapon = false;
    LocalPlayer.state.usingItem = false;
    function canOpenInventory()
        if (not LocalPlayer.state.throwingWeapon) and (not LocalPlayer.state.usingItem) and (not inventoryOpen) and (not blockInventory) then
            local ped = PlayerPedId()
            if (GetEntityHealth(ped) > 100) and (not vRP.isHandcuffed()) and (not LocalPlayer.state.StraightJacket) and (not IsPedBeingStunned(ped)) and (not IsPlayerFreeAiming(ped)) and (not IsPauseMenuActive()) then
                return true
            end
        end
        return false
    end
    exports('canOpenInventory',canOpenInventory)

    RegisterCommand("+openinventory",function(source,args)
        if (not inventoryOpen) then    
            if canOpenInventory() then
                refreshPlayerInventory()
                refreshDropInventory()

                inventoryOpen = true
                SetNuiFocus(true, true)
            end
        else
            closeInventory()
        end
    end)

    RegisterCommand("+invbind01",function(source,args) useMiddleware("1",1); end)
    RegisterCommand("+invbind02",function(source,args) useMiddleware("2",1); end)
    RegisterCommand("+invbind03",function(source,args) useMiddleware("3",1); end)
    RegisterCommand("+invbind04",function(source,args) useMiddleware("4",1); end)
    RegisterCommand("+invbind05",function(source,args) useMiddleware("5",1); end)

    RegisterKeyMapping("+openinventory", "Abrir Inventario", "KEYBOARD", "GRAVE")
    RegisterKeyMapping("+invbind01", "Bind Inventario 1", "KEYBOARD", "1")
    RegisterKeyMapping("+invbind02", "Bind Inventario 2", "KEYBOARD", "2")
    RegisterKeyMapping("+invbind03", "Bind Inventario 3", "KEYBOARD", "3")
    RegisterKeyMapping("+invbind04", "Bind Inventario 4", "KEYBOARD", "4")
    RegisterKeyMapping("+invbind05", "Bind Inventario 5", "KEYBOARD", "5")

    Citizen.CreateThread(function()
        while true do
            -- Weapon Wheel
            if not LocalPlayer.state.isPlayingEvent then 
                BlockWeaponWheelThisFrame()
                DisableControlAction(0, 37, true)
            end 
            
            Citizen.Wait(1)
        end
    end)
end
--=======================================================================================================================================
-- Inventory Callbacks
--=======================================================================================================================================
local waitUse = false
RegisterNUICallback("UseItem", function(data, cb)
    if (not waitUse) then
        waitUse = true
        SetTimeout(2000,function() waitUse = false; end)
        useMiddleware(data["slot"],data["amount"],data["secundary"],true)
    end
end)

local blocksMiddleware = function()
    if (not LocalPlayer.state.throwingWeapon) and (not LocalPlayer.state.usingItem) and (not LocalPlayer.state.BlockTasks) then
        return true
    end
    return false
end

function useMiddleware(slot,amount,secundary,isbind)
    if (blocksMiddleware()) then
        sRP.tryUseItem(slot,amount,isbind)
    end
end

RegisterNUICallback("SwapItems", function(data, cb)
    local refresh = sRP.trySwapItems(data["slot"],data["target"],data["amount"])
    if refresh then
        refreshPlayerInventory() 
        refreshSelected(data["secundary"])
    end
end)

RegisterNUICallback("SendItem", function(data, cb)
    local refresh = sRP.trySendItem(data["slot"],data["amount"])
    if refresh then
        refreshPlayerInventory()
        refreshSelected(data["secundary"])
    end
end)
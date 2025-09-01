if config.modules["inspect-system"] then
    --=======================================================================================================================================
    -- Inspect Functions
    --=======================================================================================================================================
    inspectOpened = false
    --=========================================
    function loadInspectInventory(shop)
        inventoryOpen = true
        StartScreenEffect('MenuMGSelectionIn', 0, true)
        refreshPlayerInventory()
        refreshInspectInventory()
        
        SetNuiFocus(true, true)
    end

    function refreshInspectInventory()
        local playerItems, weights = sRP.getInspect()
        if playerItems then
            SendNUIMessage({ action = "setSecondText", text = "revistar", weight = weights.current, max = weights.max })
            SendNUIMessage({ action = "setSecondItems", itemSList = playerItems, slots = weights.slots })
            SendNUIMessage({ action = "display", type = "inspect" })
        end
    end

    function cRP.loadInspect()
        loadInspectInventory()
    end

    --=======================================================================================================================================
    -- Inspect Callbacks
    --=======================================================================================================================================
    
    RegisterNUICallback("PutInspectItem", function(data, cb)
        local refresh = sRP.tryPutInspectItem(data["slot"],data["amount"],data["target"])
        if refresh then
            refreshPlayerInventory()
            refreshInspectInventory()
        end
    end)

    RegisterNUICallback("RemInspectItem", function(data, cb)
        local refresh = sRP.tryRemInspectItem(data["slot"],data["amount"],data["target"])
        if refresh then
            refreshPlayerInventory()
            refreshInspectInventory()
        end
    end)
end
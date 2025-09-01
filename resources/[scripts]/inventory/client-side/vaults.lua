if config.modules["vault-system"] then
	--=======================================================================================================================================
	-- Vault Funtions
	--=======================================================================================================================================
	function loadVaultInventory()
		inventoryOpen = true
		StartScreenEffect('MenuMGSelectionIn', 0, true)
		refreshPlayerInventory()
		refreshVaultInventory()
		SetNuiFocus(true, true)
	end

	function refreshVaultInventory()
		local vaultItems, weights, name = sRP.getVaultItems()
		if vaultItems then
			SendNUIMessage({ action = "setSecondText", text = name:lower(), weight = weights.current, max = weights.max })
			SendNUIMessage({ action = "setSecondItems", itemSList = vaultItems, slots = weights.slots })
			SendNUIMessage({ action = "display", type = "vault" })
		end
	end

	function cRP.loadVault()
		loadVaultInventory()
	end

	--=======================================================================================================================================
	-- Vault Callbacks
	--=======================================================================================================================================
	
	RegisterNUICallback("SwapVault", function(data, cb)
		local refresh = sRP.trySwapVault(data["slot"],data["target"],data["amount"])
		if refresh then
			refreshVaultInventory()
		end
	end)

	RegisterNUICallback("TakeFromVault", function(data, cb)
		local refresh = sRP.tryRemoveVaultItem(data["slot"],data["amount"],data["target"])
		if refresh then
			refreshPlayerInventory()
			refreshVaultInventory()
		end
	end)

	RegisterNUICallback("PutIntoVault", function(data, cb)
		local refresh = sRP.tryPutVaultItem(data["slot"],data["amount"],data["target"])
		if refresh then
			refreshPlayerInventory()
			refreshVaultInventory()
		end
	end)
end
local weaponsBlacklisted = {
	['WEAPON_PETROLCAN'] = true,
    ['WEAPON_FLARE'] = true,
    ['WEAPON_GRENADE'] = true,
    ['WEAPON_PIPEBOMB'] = true,
    ['WEAPON_SMOKEGRENADE'] = true,
    ['WEAPON_MOLOTOV'] = true,
    ['WEAPON_SNOWBALL'] = true,
    ['WEAPON_PEPPERSPRAY'] = true,
    ['WEAPON_WRENCH'] = true,
    ['WEAPON_SWITCHBLADE'] = true,
    ['WEAPON_STUNGUN'] = true,
    ['WEAPON_NIGHTSTICK'] = true,
    ['WEAPON_MACHETE'] = true,
    ['WEAPON_CROWBAR'] = true,
    ['WEAPON_HAMMER'] = true,
    ['WEAPON_BAT'] = true,
    ['WEAPON_SHOES'] = true,
    ['WEAPON_KATANA'] = true,
    ['GADGET_PARACHUTE'] = true,
    ['WEAPON_KNUCKLE'] = true,
    ['WEAPON_POOLCUE'] = true,
    ['WEAPON_PAO'] = true,
    ['WEAPON_PICARETA'] = true,
    ['WEAPON_PLACA'] = true,
    ['WEAPON_FLASHLIGHT'] = true,
    ['WEAPON_BATTLEAXE'] = true
}

AddStateBagChangeHandler('weapon_model', nil, function(bagName, key, value) 
    local entity = GetPlayerFromStateBagName(bagName)
    if (entity == 0) or (PlayerId() ~= entity) then return; end;

    if (value ~= nil) then
        if (weaponsBlacklisted[value]) then return; end;

        UpdateStats('weapon', {
            show = true,
            name = value,
            currentAmmo = 0,
            maxAmmo = 0
        })

        Citizen.CreateThread(function()
            local Cache = {}
            while (LocalPlayer.state.weapon_model) do
                local ped = PlayerPedId()   
                local totalAmmo = GetAmmoInPedWeapon(ped, GetHashKey(value))
                local _, ammoInClip = GetAmmoInClip(ped, GetHashKey(value))
                
                if (Cache.totalAmmo ~= totalAmmo) or (Cache.ammoInClip ~= ammoInClip) then
                    Cache.totalAmmo = totalAmmo
                    Cache.ammoInClip = ammoInClip

                    if (totalAmmo - ammoInClip) <= 0 then
                        totalAmmo = 0
                    else
                        totalAmmo = (totalAmmo - ammoInClip)
                    end

                    UpdateStats('weapon', {
                        show = true,
                        name = value,
                        currentAmmo = ammoInClip,
                        maxAmmo = totalAmmo
                    })
                end                
                Citizen.Wait(100)
            end
            UpdateStats('weapon', { show = false })
        end)
    end
end)

RegisterNetEvent('hud_weapon:disable', function() UpdateStats('weapon', { show = false }) end)
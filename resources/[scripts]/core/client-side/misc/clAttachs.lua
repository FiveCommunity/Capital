local vSERVER = Tunnel.getInterface('Attachs')

local weapons = {
	['attachs'] = {
		-- PISTOLAS
		['WEAPON_PISTOL'] = {
			components = { 'COMPONENT_AT_PI_FLSH' }
		},
		['WEAPON_COMBATPISTOL'] = {
			components = { 'COMPONENT_AT_PI_FLSH' }
		},
		['WEAPON_PISTOL_MK2'] = {
			components = { 'COMPONENT_AT_PI_RAIL', 'COMPONENT_AT_PI_FLSH_02', 'COMPONENT_AT_PI_COMP' }
		},
		['WEAPON_CERAMICPISTOL'] = {
			components = { 'COMPONENT_CERAMICPISTOL_CLIP_02' }
		},
		['WEAPON_REVOLVER_MK2'] = {
			components = { 'COMPONENT_AT_SCOPE_MACRO_MK2', 'COMPONENT_AT_PI_FLSH', 'COMPONENT_AT_PI_COMP_03' }
		},
		['WEAPON_SNSPISTOL_MK2'] = {
			components = { 'COMPONENT_SNSPISTOL_MK2_CLIP_02', 'COMPONENT_AT_PI_FLSH_03', 'COMPONENT_AT_PI_RAIL_02' }
		},

		-- SHOTGUNS
		['WEAPON_PUMPSHOTGUN'] = {
			components = { 'COMPONENT_AT_AR_FLSH' }
		},
		['WEAPON_PUMPSHOTGUN_MK2'] = {
			components = { 'COMPONENT_AT_SIGHTS', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_MUZZLE_08' }
		},

		-- SMG
		['WEAPON_COMBATPDW'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_AFGRIP' }
		},
		['WEAPON_ASSAULTSMG'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MACRO' }
		},
		['WEAPON_SMG_MK2'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL_SMG_MK2', 'COMPONENT_AT_MUZZLE_07', 'COMPONENT_AT_SB_BARREL_02' }
		},
		['WEAPON_SMG'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO_02' }
		},
		['WEAPON_MINISMG'] = {
			components = { 'COMPONENT_MINISMG_CLIP_02' }
		},
		['WEAPON_TECPISTOL'] = {
			components = { 'COMPONENT_TECPISTOL_CLIP_02', 'COMPONENT_AT_SCOPE_SMALL_TECPISTOL' }
		},

		-- RIFLES
		['WEAPON_CARBINERIFLE'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MEDIUM' }
		},
		['WEAPON_MILITARYRIFLE'] = {
			components = { 'COMPONENT_MILITARYRIFLE_CLIP_01', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_FLSH' }
		},
		['WEAPON_CARBINERIFLE_MK2'] = {
			components = { 'COMPONENT_AT_MUZZLE_04', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2' }
		},
		['WEAPON_ASSAULTRIFLE'] = {
			components = { 'COMPONENT_ASSAULTRIFLE_CLIP_01', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO', 'COMPONENT_AT_AR_AFGRIP' }
		},
		['WEAPON_ASSAULTRIFLE_MK2'] = {
			components = { 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2', 'COMPONENT_AT_MUZZLE_07', 'COMPONENT_AT_AR_BARREL_02' }
		},
		['WEAPON_SPECIALCARBINE'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
		},
		['WEAPON_SPECIALCARBINE_MK2'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2', 'COMPONENT_AT_MUZZLE_07', 'COMPONENT_AT_SC_BARREL_02', 'COMPONENT_AT_AR_AFGRIP_02' }
		},
		['WEAPON_BULLPUPRIFLE_MK2'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_BP_BARREL_02', 'COMPONENT_AT_MUZZLE_07', 'COMPONENT_AT_AR_AFGRIP_02' }
		},
        ['WEAPON_HEAVYRIFLE'] = {
			components = { 'COMPONENT_HEAVYRIFLE_CLIP_01', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
		},
        ['WEAPON_TACTICALRIFLE'] = {
			components = { 'COMPONENT_AT_AR_FLSH' }
		},
        ['WEAPON_COMPACTRIFLE'] = {
			components = { 'COMPONENT_COMPACTRIFLE_CLIP_02' }
		},

		-- SNIPER
		['WEAPON_SNIPERRIFLE'] = {
			components = { 'COMPONENT_AT_SCOPE_MAX' }
		}
	},
	['attachs2'] = {
		-- PISTOLAS
		['WEAPON_PISTOL'] = {
			components = { 'COMPONENT_PISTOL_CLIP_02', 'COMPONENT_AT_PI_FLSH', 'COMPONENT_AT_PI_SUPP_02' }
		},
		['WEAPON_COMBATPISTOL'] = {
			components = { 'COMPONENT_AT_PI_FLSH', 'COMPONENT_COMBATPISTOL_CLIP_02', 'COMPONENT_AT_PI_SUPP' }
		},
		['WEAPON_PISTOL_MK2'] = {
			components = { 'COMPONENT_AT_PI_RAIL', 'COMPONENT_AT_PI_FLSH_02', 'COMPONENT_AT_PI_COMP', 'COMPONENT_AT_PI_SUPP_02', 'COMPONENT_PISTOL_MK2_CLIP_02' }
		},
		['WEAPON_CERAMICPISTOL'] = {
			components = { 'COMPONENT_CERAMICPISTOL_CLIP_02', 'COMPONENT_CERAMICPISTOL_SUPP' }
		},
		['WEAPON_REVOLVER_MK2'] = {
			components = { 'COMPONENT_AT_SCOPE_MACRO_MK2', 'COMPONENT_AT_PI_FLSH', 'COMPONENT_AT_PI_COMP_03' }
		},
		['WEAPON_SNSPISTOL_MK2'] = {
			components = { 'COMPONENT_SNSPISTOL_MK2_CLIP_02', 'COMPONENT_AT_PI_FLSH_03', 'COMPONENT_AT_PI_RAIL_02', 'COMPONENT_AT_PI_SUPP_02' }
		},

		-- SHOTGUNS
		['WEAPON_PUMPSHOTGUN'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SR_SUPP' }
		},
		['WEAPON_PUMPSHOTGUN_MK2'] = {
			components = { 'COMPONENT_AT_SIGHTS', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SR_SUPP_03' }
		},

		-- SMG
		['WEAPON_COMBATPDW'] = {
			components = { 'COMPONENT_COMBATPDW_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_AFGRIP' }
		},
		['WEAPON_ASSAULTSMG'] = {
			components = { 'COMPONENT_AT_AR_SUPP', 'COMPONENT_ASSAULTSHOTGUN_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MACRO' }
		},
		['WEAPON_SMG_MK2'] = {
			components = { 'COMPONENT_SMG_MK2_CLIP_02', 'COMPONENT_AT_PI_SUPP', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL_SMG_MK2', 'COMPONENT_AT_SB_BARREL_02' }
		},
		['WEAPON_SMG'] = {
			components = { 'COMPONENT_AT_PI_SUPP', 'COMPONENT_SMG_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO_02' }
		},
		['WEAPON_MACHINEPISTOL'] = {
			components = { 'COMPONENT_MACHINEPISTOL_CLIP_02', 'COMPONENT_AT_PI_SUPP' }
		},
		['WEAPON_MINISMG'] = {
			components = { 'COMPONENT_MINISMG_CLIP_02' }
		},
		['WEAPON_TECPISTOL'] = {
			components = { 'COMPONENT_TECPISTOL_CLIP_02', 'COMPONENT_AT_SCOPE_SMALL_TECPISTOL', 'COMPONENT_AT_PI_SUPP' }
		},

		-- RIFLES
		['WEAPON_CARBINERIFLE'] = {
			components = { 'COMPONENT_AT_AR_SUPP', 'COMPONENT_CARBINERIFLE_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MEDIUM' }
		},
		['WEAPON_CARBINERIFLE_MK2'] = {
			components = { 'COMPONENT_AT_AR_SUPP', 'COMPONENT_CARBINERIFLE_MK2_CLIP_02', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2' }
		},
		['WEAPON_MILITARYRIFLE'] = {
			components = { 'COMPONENT_MILITARYRIFLE_CLIP_02', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_SUPP'}
		},
		['WEAPON_ASSAULTRIFLE'] = {
			components = { 'COMPONENT_AT_AR_SUPP_02', 'COMPONENT_ASSAULTRIFLE_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO', 'COMPONENT_AT_AR_AFGRIP' }
		},
		['WEAPON_ASSAULTRIFLE_MK2'] = {
			components = { 'COMPONENT_AT_AR_SUPP_02', 'COMPONENT_ASSAULTRIFLE_MK2_CLIP_02', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2', 'COMPONENT_AT_AR_BARREL_02' }
		},
		['WEAPON_SPECIALCARBINE'] = {
			components = { 'COMPONENT_AT_AR_SUPP_02', 'COMPONENT_SPECIALCARBINE_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
		},
		['WEAPON_SPECIALCARBINE_MK2'] = {
			components = { 'COMPONENT_AT_AR_SUPP_02', 'COMPONENT_SPECIALCARBINE_MK2_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2', 'COMPONENT_AT_SC_BARREL_02', 'COMPONENT_AT_AR_AFGRIP_02' }
		},
		['WEAPON_BULLPUPRIFLE_MK2'] = {
			components = { 'COMPONENT_BULLPUPRIFLE_MK2_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_BP_BARREL_02', 'COMPONENT_AT_AR_SUPP', 'COMPONENT_AT_AR_AFGRIP_02' }
		},
        ['WEAPON_HEAVYRIFLE'] = {
			components = { 'COMPONENT_AT_AR_SUPP', 'COMPONENT_HEAVYRIFLE_CLIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
		},

		['WEAPON_SNIPERRIFLE'] = {
			components = { 'COMPONENT_AT_SCOPE_MAX', 'COMPONENT_AT_AR_SUPP_02', 'COMPONENT_SNIPERRIFLE_VARMOD_LUXE' }
		},
		['WEAPON_TACTICALRIFLE'] = {
			components = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_SUPP_02' }
		},
        ['WEAPON_COMPACTRIFLE'] = {
			components = { 'COMPONENT_COMPACTRIFLE_CLIP_02' }
		},
	}
}

--[[
RegisterCommand('attachs',function(source, args)
	local ped = PlayerPedId()
	if (vSERVER.checkAttachs({ 'vip.permissao', 'attachs.permissao' })) then
		if not (args[1]) then
			TriggerEvent('notify', 'Attachs', 'Utilize o <b>comando</b> listado abaixo: <br> <br><b>/attachs colocar;</b> <br><b>/attachs retirar.</b>')
		else
			args[1] = string.lower(args[1])
			addComponents(ped, weapons['attachs'], args[1])
		end
	end
end)

RegisterCommand('attachs2',function(source, args)
	local ped = PlayerPedId()
	if (vSERVER.checkAttachs({ 'attachs2.permissao' }, true)) then
		if not (args[1]) then
			TriggerEvent('notify', 'Attachs', 'Utilize o <b>comando</b> listado abaixo: <br> <br><b>/attachs2 colocar;</b> <br><b>/attachs2 retirar.</b>')
		else
			args[1] = string.lower(args[1])
			addComponents(ped, weapons['attachs2'], args[1])
		end
	end
end)
]]

addComponents = function(ped, weapons, args)
	for k, v in pairs(weapons) do
		local arma = GetHashKey(k)
		if (GetSelectedPedWeapon(ped) == arma) then
			for i = 1, #v.components do
				if (args == 'colocar') then
					GiveWeaponComponentToPed(ped, arma, GetHashKey(v.components[i]))
				elseif (args == 'retirar') then
					RemoveWeaponComponentFromPed(ped, arma, GetHashKey(v.components[i]))
				end
				i = i + 1
			end
		end
	end 
end

-- RegisterCommand('wcolor',function(source, args)
-- 	local tinta = parseInt(args[1])
-- 	if (tinta >= 0) and vSERVER.checkColor({ 'vip.permissao', 'attachs.permissao' }) then
-- 		local ped = PlayerPedId()
-- 		SetPedWeaponTintIndex(ped, GetSelectedPedWeapon(ped), tinta)
-- 	end
-- end)
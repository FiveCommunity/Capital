Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

config = {}

config.permissions = {
    ['vippm.permissao'] = 'Vip Policia'
}

config.attachs = {
    ['BPM'] = {
        ['active'] = false,
        ['weapons'] = {
            ['WEAPON_COMBATPISTOL'] = {
                ['components'] = { 'COMPONENT_AT_PI_FLSH' }
            },
            ['WEAPON_COMBATPDW'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SMG'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO_02' }
            },
            ['WEAPON_PUMPSHOTGUN'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH' }
            },
            ['WEAPON_PUMPSHOTGUN_MK2'] = {
                ['components'] = { 'COMPONENT_AT_SIGHTS', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_MUZZLE_08' }
            },
            ['WEAPON_CARBINERIFLE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MEDIUM' }
            },
            ['WEAPON_CARBINERIFLE_MK2'] = {
                ['components'] = { 'COMPONENT_AT_MUZZLE_04', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2' }
            },
            ['WEAPON_SPECIALCARBINE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SNIPERRIFLE'] = {
                ['components'] = { 'COMPONENT_AT_SCOPE_MAX' }
            }
        },
        ['perm'] = nil
    },
    ['TATICA'] = {
        ['active'] = false,
        ['weapons'] = {
            ['WEAPON_COMBATPISTOL'] = {
                ['components'] = { 'COMPONENT_AT_PI_FLSH' }
            },
            ['WEAPON_COMBATPDW'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SMG'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO_02' }
            },
            ['WEAPON_PUMPSHOTGUN'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH' }
            },
            ['WEAPON_PUMPSHOTGUN_MK2'] = {
                ['components'] = { 'COMPONENT_AT_SIGHTS', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_MUZZLE_08' }
            },
            ['WEAPON_CARBINERIFLE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MEDIUM' }
            },
            ['WEAPON_CARBINERIFLE_MK2'] = {
                ['components'] = { 'COMPONENT_AT_MUZZLE_04', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2' }
            },
            ['WEAPON_SPECIALCARBINE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SNIPERRIFLE'] = {
                ['components'] = { 'COMPONENT_AT_SCOPE_MAX' }
            }
        },
        ['perm'] = nil
    },
    ['EXERCITO'] = {
        ['active'] = false,
        ['weapons'] = {
            ['WEAPON_COMBATPISTOL'] = {
                ['components'] = { 'COMPONENT_AT_PI_FLSH' }
            },
            ['WEAPON_COMBATPDW'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SMG'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO_02' }
            },
            ['WEAPON_PUMPSHOTGUN'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH' }
            },
            ['WEAPON_PUMPSHOTGUN_MK2'] = {
                ['components'] = { 'COMPONENT_AT_SIGHTS', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_MUZZLE_08' }
            },
            ['WEAPON_CARBINERIFLE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MEDIUM' }
            },
            ['WEAPON_CARBINERIFLE_MK2'] = {
                ['components'] = { 'COMPONENT_AT_MUZZLE_04', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2' }
            },
            ['WEAPON_SPECIALCARBINE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SNIPERRIFLE'] = {
                ['components'] = { 'COMPONENT_AT_SCOPE_MAX' }
            }
        },
        ['perm'] = nil
    },
    ['PCP'] = {
        ['active'] = false,
        ['weapons'] = {
            ['WEAPON_COMBATPISTOL'] = {
                ['components'] = { 'COMPONENT_AT_PI_FLSH' }
            },
            ['WEAPON_COMBATPDW'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_SMALL', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SMG'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MACRO_02' }
            },
            ['WEAPON_PUMPSHOTGUN'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH' }
            },
            ['WEAPON_PUMPSHOTGUN_MK2'] = {
                ['components'] = { 'COMPONENT_AT_SIGHTS', 'COMPONENT_AT_SCOPE_SMALL_MK2', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_MUZZLE_08' }
            },
            ['WEAPON_CARBINERIFLE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_AR_AFGRIP', 'COMPONENT_AT_SCOPE_MEDIUM' }
            },
            ['WEAPON_CARBINERIFLE_MK2'] = {
                ['components'] = { 'COMPONENT_AT_MUZZLE_04', 'COMPONENT_AT_AR_AFGRIP_02', 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM_MK2' }
            },
            ['WEAPON_SPECIALCARBINE'] = {
                ['components'] = { 'COMPONENT_AT_AR_FLSH', 'COMPONENT_AT_SCOPE_MEDIUM', 'COMPONENT_AT_AR_AFGRIP' }
            },
            ['WEAPON_SNIPERRIFLE'] = {
                ['components'] = { 'COMPONENT_AT_SCOPE_MAX' }
            }
        },
        ['perm'] = nil
    },
}

config.training = {
    ['BPM'] = { 
        ['active'] = false, -- Arrumar para o novo inventário
        ['perm'] = nil
    },
    ['TATICA'] = { 
        ['active'] = false, -- Arrumar para o novo inventário
        ['perm'] = nil
    },
    ['EXERCITO'] = { 
        ['active'] = false, -- Arrumar para o novo inventário
        ['perm'] = nil
    },
    ['PCP'] = { 
        ['active'] = false, -- Arrumar para o novo inventário
        ['perm'] = nil
    },
}

config.arsenal = {
    ['BPM'] = {
        ['name'] = 'POLICIA MILITAR', ['description'] = 'Arsenal da policia militar', -- colocar descrição dps
        ['weapons'] = {
            ['cooldownWeapons'] = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'weapon_combatpistol', ['name'] = 'Glock', ['ammo'] = 50, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'weapon_combatpdw', ['name'] = 'MPX', ['ammo'] = 250, ['perm'] = nil, price = 2000 },
            { ['spawn'] = 'weapon_smg_mk2', ['name'] = 'Scorpion', ['ammo'] = 250, ['perm'] = nil, price = 2000 },
            { ['spawn'] = 'weapon_pumpshotgun_mk2', ['name'] = 'Remington', ['ammo'] = 250, ['perm'] = nil, price = 3000 },
            { ['spawn'] = 'weapon_pumpshotgun', ['name'] = 'Mossberg', ['ammo'] = 250, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'weapon_carbinerifle_mk2', ['name'] = 'M4A4', ['ammo'] = 250, ['perm'] = nil, price = 4000 },
            { ['spawn'] = 'weapon_pepperspray', ['name'] = 'Spray de Pimenta', ['ammo'] = 250, ['perm'] = nil, price = 300 },
            { ['spawn'] = 'weapon_stungun', ['name'] = 'Taser', ['ammo'] = 250, ['perm'] = nil, price = 300 },
        },
        ['utilitarys'] =  {
            ['cooldownUtilitarys']  = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'radio', ['name'] = 'Rádio', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'barreira', ['name'] = 'Barreira', ['quantity'] = 1, ['perm'] = nil, price = 50, infinityBuy = true, noCooldown = true },
            { ['spawn'] = 'cone', ['name'] = 'Cone', ['quantity'] = 1, ['perm'] = nil, price = 50, infinityBuy = true, noCooldown = true },
            { ['spawn'] = 'mochila-pequena', ['name'] = 'Mochila Pequena', ['quantity'] = 1, ['perm'] = nil, price = 3000 },
            { ['spawn'] = 'algema', ['name'] = 'Algema', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'colete-militar', ['name'] = 'Colete Militar', ['quantity'] = 1, ['perm'] = nil, price = 200 },
            { ['type'] = 'arma', ['spawn'] = 'weapon_nightstick', ['name'] = 'Cassetete', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['type'] = 'arma', ['spawn'] = 'weapon_flashlight', ['name'] = 'Lanterna', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'teste-residual', ['name'] = 'Teste Residual', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'teste-quimico', ['name'] = 'Teste Químico', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'desfibrilador', ['name'] = 'Desfibrilador', ['quantity'] = 1, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'tesoura', ['name'] = 'Tesoura', ['quantity'] = 1, ['perm'] = nil, price = 5000 },
        },
        ['kits'] = {
            ['cooldownKits'] = { ['time'] = 30, ['noCooldown'] = 'vip-policia.permissao' },
            {
                ['name'] = 'Kit de Componentes', 
                ['price'] = 1200,
                ['itens'] = {
                    ['clip-extendido'] = {  ['quantity'] = 1,   ['price'] = 200 },
                    ['supressor'] = {       ['quantity'] = 1,   ['price'] = 200 },
                    ['compensador'] = {     ['quantity'] = 1,   ['price'] = 200 },
                    ['lanterna-acoplavel'] = { ['quantity'] = 1,['price'] = 200 },
                    ['mira-avancada'] = {   ['quantity'] = 1,   ['price'] = 200 },
                    ['grip-avancado'] = {   ['quantity'] = 1,   ['price'] = 200 },
                },
                ['perm'] = nil
            },
        },

        ['canExtraAmmo'] = { 
            ['active'] = true, 
            ['quantity'] = { ['min'] = 50, ['max'] = 250 }, 
            ['perm'] = nil 
        },
        ['webhooks'] = {
            ['weapons'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['utilitarys'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['kits'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['ammo'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo'
        }
    },
    ['TATICA'] = {
        ['name'] = 'POLICIA MILITAR', ['description'] = 'Arsenal da policia militar', -- colocar descrição dps
        ['weapons'] = {
            ['cooldownWeapons'] = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'weapon_combatpistol', ['name'] = 'Glock', ['ammo'] = 50, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'weapon_combatpdw', ['name'] = 'MPX', ['ammo'] = 250, ['perm'] = nil, price = 2000 },
            { ['spawn'] = 'weapon_smg_mk2', ['name'] = 'Scorpion', ['ammo'] = 250, ['perm'] = nil, price = 2000 },
            { ['spawn'] = 'weapon_pumpshotgun_mk2', ['name'] = 'Remington', ['ammo'] = 250, ['perm'] = nil, price = 3000 },
                        { ['spawn'] = 'weapon_pumpshotgun', ['name'] = 'Mossberg', ['ammo'] = 250, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'weapon_carbinerifle_mk2', ['name'] = 'M4A4', ['ammo'] = 250, ['perm'] = nil, price = 4000 },
            { ['spawn'] = 'weapon_specialcarbine', ['name'] = 'Parafal', ['ammo'] = 250, ['perm'] = nil, price = 4000 },
            { ['spawn'] = 'weapon_pepperspray', ['name'] = 'Spray de Pimenta', ['ammo'] = 250, ['perm'] = nil, price = 300 },
            { ['spawn'] = 'weapon_stungun', ['name'] = 'Taser', ['ammo'] = 250, ['perm'] = nil, price = 300 },
        },
        ['utilitarys'] =  {
            ['cooldownUtilitarys']  = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'radio', ['name'] = 'Rádio', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'barreira', ['name'] = 'Barreira', ['quantity'] = 1, ['perm'] = nil, price = 50, infinityBuy = true, noCooldown = true },
            { ['spawn'] = 'cone', ['name'] = 'Cone', ['quantity'] = 1, ['perm'] = nil, price = 50, infinityBuy = true, noCooldown = true },
            { ['spawn'] = 'mochila-pequena', ['name'] = 'Mochila Pequena', ['quantity'] = 1, ['perm'] = nil, price = 3000 },
            { ['spawn'] = 'algema', ['name'] = 'Algema', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'colete-militar', ['name'] = 'Colete Militar', ['quantity'] = 1, ['perm'] = nil, price = 200 },
            -- { ['spawn'] = 'weapon_smokegrenade', ['name'] = 'Granada de Fumaça', ['quantity'] = 25, ['perm'] = nil, price = 200 },
            { ['type'] = 'arma', ['spawn'] = 'weapon_nightstick', ['name'] = 'Cassetete', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['type'] = 'arma', ['spawn'] = 'weapon_flashlight', ['name'] = 'Lanterna', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'teste-residual', ['name'] = 'Teste Residual', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'teste-quimico', ['name'] = 'Teste Químico', ['quantity'] = 1, ['perm'] = nil, price = 150 },
        },
        ['kits'] = {
            ['cooldownKits'] = { ['time'] = 30, ['noCooldown'] = 'vip-policia.permissao' },
            {
                ['name'] = 'Kit de Componentes', 
                ['price'] = 1200,
                ['itens'] = {
                    ['clip-extendido'] = {  ['quantity'] = 1,   ['price'] = 200 },
                    ['supressor'] = {       ['quantity'] = 1,   ['price'] = 200 },
                    ['compensador'] = {     ['quantity'] = 1,   ['price'] = 200 },
                    ['lanterna-acoplavel'] = { ['quantity'] = 1,['price'] = 200 },
                    ['mira-avancada'] = {   ['quantity'] = 1,   ['price'] = 200 },
                    ['grip-avancado'] = {   ['quantity'] = 1,   ['price'] = 200 },
                },
                ['perm'] = nil
            },
        },
        ['canExtraAmmo'] = { 
            ['active'] = true, 
            ['quantity'] = { ['min'] = 50, ['max'] = 250 }, 
            ['perm'] = nil 
        },
        ['webhooks'] = {
            ['weapons'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['utilitarys'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['kits'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['ammo'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo'
        }
    },
    ['EXERCITO'] = {
        ['name'] = 'EXERCITO', ['description'] = 'Arsenal da Exército da Capital', -- colocar descrição dps
        ['weapons'] = {
            ['cooldownWeapons'] = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'weapon_combatpistol', ['name'] = 'Glock', ['ammo'] = 50, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'weapon_combatpdw', ['name'] = 'MPX', ['ammo'] = 250, ['perm'] = nil, price = 2000 },
            { ['spawn'] = 'weapon_smg_mk2', ['name'] = 'Scorpion', ['ammo'] = 250, ['perm'] = nil, price = 2000 },
            { ['spawn'] = 'weapon_pumpshotgun_mk2', ['name'] = 'Remington', ['ammo'] = 250, ['perm'] = nil, price = 3000 },
            { ['spawn'] = 'weapon_pumpshotgun', ['name'] = 'Mossberg', ['ammo'] = 250, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'weapon_carbinerifle_mk2', ['name'] = 'M4A4', ['ammo'] = 250, ['perm'] = nil, price = 4000 },
            { ['spawn'] = 'weapon_specialcarbine', ['name'] = 'Parafal', ['ammo'] = 250, ['perm'] = nil, price = 4000 },
            { ['spawn'] = 'weapon_pepperspray', ['name'] = 'Spray de Pimenta', ['ammo'] = 250, ['perm'] = nil, price = 300 },
            { ['spawn'] = 'weapon_stungun', ['name'] = 'Taser', ['ammo'] = 250, ['perm'] = nil, price = 300 },
        },
        ['utilitarys'] =  {
            ['cooldownUtilitarys']  = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'radio', ['name'] = 'Rádio', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'barreira', ['name'] = 'Barreira', ['quantity'] = 1, ['perm'] = nil, price = 50, infinityBuy = true, noCooldown = true },
            { ['spawn'] = 'cone', ['name'] = 'Cone', ['quantity'] = 1, ['perm'] = nil, price = 50, infinityBuy = true, noCooldown = true },
            { ['spawn'] = 'mochila-pequena', ['name'] = 'Mochila Pequena', ['quantity'] = 1, ['perm'] = nil, price = 3000 },
            { ['spawn'] = 'algema', ['name'] = 'Algema', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'colete-militar', ['name'] = 'Colete Militar', ['quantity'] = 1, ['perm'] = nil, price = 200 },
            { ['type'] = 'arma', ['spawn'] = 'weapon_nightstick', ['name'] = 'Cassetete', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['type'] = 'arma', ['spawn'] = 'weapon_flashlight', ['name'] = 'Lanterna', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'teste-residual', ['name'] = 'Teste Residual', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'teste-quimico', ['name'] = 'Teste Químico', ['quantity'] = 1, ['perm'] = nil, price = 150 },
        },
        ['kits'] = {
            ['cooldownKits'] = { ['time'] = 30, ['noCooldown'] = 'vip-policia.permissao' },
            {
                ['name'] = 'Kit de Componentes', 
                ['price'] = 1200,
                ['itens'] = {
                    ['clip-extendido'] = {  ['quantity'] = 1,   ['price'] = 200 },
                    ['supressor'] = {       ['quantity'] = 1,   ['price'] = 200 },
                    ['compensador'] = {     ['quantity'] = 1,   ['price'] = 200 },
                    ['lanterna-acoplavel'] = { ['quantity'] = 1,['price'] = 200 },
                    ['mira-avancada'] = {   ['quantity'] = 1,   ['price'] = 200 },
                    ['grip-avancado'] = {   ['quantity'] = 1,   ['price'] = 200 },
                },
                ['perm'] = nil
            },
        },

        ['canExtraAmmo'] = { 
            ['active'] = true, 
            ['quantity'] = { ['min'] = 50, ['max'] = 250 }, 
            ['perm'] = nil 
        },
        ['webhooks'] = {
            ['weapons'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['utilitarys'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['kits'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['ammo'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo'
        }
    },
    ['PCP'] = {
        ['name'] = 'Polícia Cidade Perfeita', ['description'] = 'Arsenal da Polícia Cidade Perfeita', -- colocar descrição dps
        ['weapons'] = {
            ['cooldownWeapons'] = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'weapon_combatpistol', ['name'] = 'Glock', ['ammo'] = 50, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'weapon_combatpdw', ['name'] = 'MPX', ['ammo'] = 250, ['perm'] = nil, price = 2000 },
            { ['spawn'] = 'weapon_smg_mk2', ['name'] = 'Scorpion', ['ammo'] = 250, ['perm'] = nil, price = 2000 },
            { ['spawn'] = 'weapon_pumpshotgun_mk2', ['name'] = 'Remington', ['ammo'] = 250, ['perm'] = nil, price = 3000 },
            { ['spawn'] = 'weapon_pumpshotgun', ['name'] = 'Mossberg', ['ammo'] = 250, ['perm'] = nil, price = 1000 },
            { ['spawn'] = 'weapon_carbinerifle_mk2', ['name'] = 'M4A4', ['ammo'] = 250, ['perm'] = nil, price = 4000 },
            { ['spawn'] = 'weapon_specialcarbine', ['name'] = 'Parafal', ['ammo'] = 250, ['perm'] = nil, price = 4000 },
            { ['spawn'] = 'weapon_pepperspray', ['name'] = 'Spray de Pimenta', ['ammo'] = 250, ['perm'] = nil, price = 300 },
            { ['spawn'] = 'weapon_stungun', ['name'] = 'Taser', ['ammo'] = 250, ['perm'] = nil, price = 300 },
        },
        ['utilitarys'] =  {
            ['cooldownUtilitarys']  = { ['time'] = 30, ['noCooldown'] = 'vippm.permissao' },
            { ['spawn'] = 'radio', ['name'] = 'Rádio', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'barreira', ['name'] = 'Barreira', ['quantity'] = 1, ['perm'] = nil, price = 50, infinityBuy = true, noCooldown = true },
            { ['spawn'] = 'cone', ['name'] = 'Cone', ['quantity'] = 1, ['perm'] = nil, price = 50, infinityBuy = true, noCooldown = true },
            { ['spawn'] = 'mochila-pequena', ['name'] = 'Mochila Pequena', ['quantity'] = 1, ['perm'] = nil, price = 3000 },
            { ['spawn'] = 'algema', ['name'] = 'Algema', ['quantity'] = 1, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'colete-militar', ['name'] = 'Colete Militar', ['quantity'] = 1, ['perm'] = nil, price = 200 },
            { ['type'] = 'arma', ['spawn'] = 'weapon_nightstick', ['name'] = 'Cassetete', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['type'] = 'arma', ['spawn'] = 'weapon_flashlight', ['name'] = 'Lanterna', ['ammo'] = 0, ['perm'] = nil, price = 50 },
            { ['spawn'] = 'teste-residual', ['name'] = 'Teste Residual', ['quantity'] = 1, ['perm'] = nil, price = 150 },
            { ['spawn'] = 'teste-quimico', ['name'] = 'Teste Químico', ['quantity'] = 1, ['perm'] = nil, price = 150 },
        },
        ['kits'] = {
            ['cooldownKits'] = { ['time'] = 30, ['noCooldown'] = 'vip-policia.permissao' },
            {
                ['name'] = 'Kit de Componentes', 
                ['price'] = 1200,
                ['itens'] = {
                    ['clip-extendido'] = {  ['quantity'] = 1,   ['price'] = 200 },
                    ['supressor'] = {       ['quantity'] = 1,   ['price'] = 200 },
                    ['compensador'] = {     ['quantity'] = 1,   ['price'] = 200 },
                    ['lanterna-acoplavel'] = { ['quantity'] = 1,['price'] = 200 },
                    ['mira-avancada'] = {   ['quantity'] = 1,   ['price'] = 200 },
                    ['grip-avancado'] = {   ['quantity'] = 1,   ['price'] = 200 },
                },
                ['perm'] = nil
            },
        },

        ['canExtraAmmo'] = { 
            ['active'] = true, 
            ['quantity'] = { ['min'] = 50, ['max'] = 250 }, 
            ['perm'] = nil 
        },
        ['webhooks'] = {
            ['weapons'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['utilitarys'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['kits'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo',
            ['ammo'] = 'https://discord.com/api/webhooks/1198805539669430412/-fuBPxtI56L2aWk1yCVZSksWxUU73SWEpdcG9ctCZxNvO4ujf42mqh8X9j-GgEm_ECIo'
        }
    },
}

config.locs = {
    -- [ Principal ] --
    { 
        coord = vector3(-594.1055, -1059.587, 22.422), 
        config = 'BPM', 
        ped = {
            coord = vector4(-594.145, -1059.6, 22.422, 351.4961),
            skin = 's_m_m_fiboffice_01'
        },
        perm = {'policia.permissao', 'staff.permissao'}
    },
    -- [ Rota ] --
    { 
        coord = vector3(-1216.457, -2271.428, 14.56995), 
        config = 'TATICA', 
        ped = {
            coord = vector4(-1216.457, -2271.428, 14.56995, 155.9055),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'policia.permissao'
    },
    -- [ Civil ] --
    { 
        coord = vector3(486.3692, -996.1318, 30.67834), 
        config = 'BPM', 
        ped = {
            coord = vector4(486.3692, -996.1318, 30.67834, 124.7244),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'policia.permissao'
    },
    -- [ Força tática 2 ] --
    { 
        coord = vector3(830.4923, 174.6198, 83.33411), 
        config = 'TATICA', 
        ped = {
            coord = vector4(830.4923, 174.6198, 83.33411, 235.2756),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'policia.permissao'
    },
    -- [ PRF ] --
    { 
        coord = vector3(2603.908, 5342.611, 47.61243), 
        config = 'BPM', 
        ped = {
            coord = vector4(2603.908, 5342.611, 47.61243, 291.9685),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'policia.permissao'
    },
    -- [ GCC ] --
    { 
        coord = vector3(701.2615, 251.2088, 97.90918), 
        config = 'BPM', 
        ped = {
            coord = vector4(701.2615, 251.2088, 97.90918, 53.85827),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'policia.permissao'
    },
    -- [ BAEP ] --
    { 
        coord = vector3(-436.1011, 5987.631, 31.67249), 
        config = 'TATICA', 
        ped = {
            coord = vector4(-436.1011, 5987.631, 31.67249, 48.18897),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'policia.permissao'
    },
    -- [ Prisao ] --
    { 
        coord = vector3(1838.664, 2575.833, 46.01172), 
        config = 'BPM', 
        ped = {
            coord = vector4(1838.664, 2575.833, 46.01172, 269.2914),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'policia.permissao'
    },
    -- [ Exército ] --
    { 
        coord = vector3(-1860.013, 3303.745, 32.93628), 
        config = 'EXERCITO', 
        ped = {
            coord = vector4(-1860.013, 3303.745, 32.93628, 144.5669),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'exercito.permissao'
    },
    -- [ POLICIA CIDADE PERFEITA ] --
    { 
        coord = vector3(-53.24835, -4833.35, 18.09155), 
        config = 'PCP', 
        ped = {
            coord = vector4(-53.28791, -4833.363, 18.09155, 266.4567),
            skin = 's_m_m_fiboffice_01'
        },
        perm = 'pcp.permissao'
    },
}
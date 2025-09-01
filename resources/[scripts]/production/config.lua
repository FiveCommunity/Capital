Proxy = module('vrp', 'lib/Proxy')
Tunnel = module('vrp', 'lib/Tunnel')
vRP = Proxy.getInterface('vRP')

configs = {}

configs.products = {
    --==================================================================================================================

    ['embalagem'] = {
        ['embalagem-plastica'] = {
            name = 'Embalagem Plástica',
            delay = 10000,
            materials = {
                ['plastico'] = { name = 'Plástico', amount = 4 },
            }
        }
    },

    ['racetablet'] = {
        ['tabletcorrida'] = {
            name = 'Tablet Corrida',
            delay = 10000,
            materials = {
                ['plastico'] = { name = 'Plástico', amount = 4 },
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
            }
        }
    },

    --==================================================================================================================

    ['china'] = {
        ['box_weapon_katana'] = {
            name = 'Katana',
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 5 },
                ['cobre'] = { name = 'Cobre', amount = 20 },
                ['borracha'] = { name = 'Borracha', amount = 20 }
            }
        },
        ['box_weapon_bat'] = {
            name = 'Taco de Beisebol',
            delay = 10000,
            multiply = 2,
            materials = {
                ['cabo'] = { name = 'Cabo', amount = 50 },
                ['cano'] = { name = 'Cano', amount = 50 },
                ['ferro'] = { name = 'Ferrolho', amount = 50 },
                ['mola'] = { name = 'Mola', amount = 50 },
            }
        },
        ['box_weapon_switchblade'] = {
            name = 'Canivete',
            delay = 10000,
            multiply = 1,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 5 },
                ['cobre'] = { name = 'Cobre', amount = 20 },
                ['borracha'] = { name = 'Borracha', amount = 20 }
            }
        },
        ['box_weapon_knuckle'] = {
            name = 'Soco Inglês',
            delay = 10000,
            multiply = 2,
            materials = {
                ['cabo'] = { name = 'Cabo', amount = 70 },
                ['cano'] = { name = 'Cano', amount = 70 },
                ['ferro'] = { name = 'Ferrolho', amount = 70 },
                ['mola'] = { name = 'Mola', amount = 70 },
                ['madeira'] = { name = 'Madeira', amount = 1 }
            }
        },
        ['box_weapon_poolcue'] = {
            name = 'Taco de Sinuca',
            delay = 10000,
            multiply = 2,
            materials = {
                ['cabo'] = { name = 'Cabo', amount = 40 },
                ['cano'] = { name = 'Cano', amount = 40 },
                ['ferro'] = { name = 'Ferrolho', amount = 40 },
                ['mola'] = { name = 'Mola', amount = 40 },
                ['madeira'] = { name = 'Madeira', amount = 2 }
            }
        },
        ['box_weapon_picareta'] = {
            name = 'Picareta',
            delay = 10000,
            multiply = 1,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 20 },
                ['aluminio'] = { name = 'Alumínio', amount = 20 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 4 },
                ['cobre'] = { name = 'Cobre', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 20 }
            }
        },
        ['box_weapon_placa'] = {
            name = 'Placa',
            delay = 10000,
            multiply = 1,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 30 },
                ['aluminio'] = { name = 'Alumínio', amount = 30 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 4 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['borracha'] = { name = 'Borracha', amount = 20 }
            }
        },
        ['box_weapon_pao'] = {
            name = 'Pão',
            delay = 10000,
            multiply = 1,
            materials = {
                ['trigo'] = { name = 'Trigo', amount = 20 },
                ['ferro'] = { name = 'Ferro', amount = 20 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 3 },
                ['cobre'] = { name = 'Cobre', amount = 10 }
            }
        },
    },

    ['parafal'] = {
        ['box_weapon_specialcarbine'] = {
            name = 'Parafal',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 36000 },
                ['clip'] = { name = 'Clip', amount = 50 },
                ['culatra'] = { name = 'Culatra', amount = 60 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 60 },
                ['slide'] = { name = 'Slide', amount = 60 },
                ['cabo'] = { name = 'Cabo', amount = 50 },
                ['titanio'] = { name = 'Titânio', amount = 4 },
            }
        },
    },

    ['grotorante'] = {
        ['salsired'] = {
            name = 'Linguiça do Red',
            delay = 10000,
            multiply = 10,
            anim = 'churrasco',
            materials = {
                ['sling'] = { name = 'S. de Linguiça', amount = 10 },
            }
        },
        ['brisadeiro'] = {
            name = 'Brisadeiro',
            delay = 10000,
            multiply = 10,
            materials = {
                ['granulado'] = { name = 'Granulado', amount = 10 },
                ['potedechoco'] = { name = 'P. Chocolate', amount = 10 },
                ['ervac'] = { name = 'Erva Culinária', amount = 10 },
            }
        },
        ['suco-caju'] = {
            name = 'Suco de Caju',
            delay = 10000,
            multiply = 20,
            materials = {
                ['caju'] = { name = 'Caju', amount = 10 },
                ['agua'] = { name = 'Agua', amount = 10 },
            }
        },
        ['rosqpau'] = {
            name = 'Rosq. do Paulo',
            delay = 10000,
            multiply = 10,
            materials = {
                ['farinha-trigo'] = { name = 'Farinha', amount = 10 },
                ['potedechoco'] = { name = 'P. Chocolate', amount = 10 },
                ['manteiga'] = { name = 'Manteiga', amount = 10 },
            }
        },
    },

    ['melgual'] = {
        ['chamel'] = {
            name = 'Chá de Mel',
            delay = 10000,
            multiply = 10,
            anim = 'mexer',
            materials = {
                ['mel'] = { name = 'Mel', amount = 10 },
                ['agua'] = { name = 'agua', amount = 10 },
            }
        },
        ['bolomel'] = {
            name = 'Bolo de Mel',
            delay = 10000,
            multiply = 10,
            anim = 'mexer',
            materials = {
                ['mel'] = { name = 'Mel', amount = 10 },
                ['farinha-trigo'] = { name = 'farinha-trigo', amount = 10 },
                ['manteiga'] = { name = 'manteiga', amount = 10 },
                ['agua'] = { name = 'agua', amount = 10 },
            }
        },
        ['paomel'] = {
            name = 'Pão de Mel',
            delay = 10000,
            multiply = 10,
            anim = 'mexer',
            materials = {
                ['mel'] = { name = 'Mel', amount = 10 },
                ['farinha-trigo'] = { name = 'farinha-trigo', amount = 10 },
                ['manteiga'] = { name = 'manteiga', amount = 10 },
                ['agua'] = { name = 'agua', amount = 10 },
            }
        },
        ['chocolate-quente'] = {
            name = 'Chocolate Q.',
            delay = 10000,
            multiply = 10,
            anim = 'mexer',
            materials = {
                ['potedechoco'] = { name = 'chocolate', amount = 10 },
                ['agua'] = { name = 'agua', amount = 10 },
            }
        },
        ['chimas'] = {
            name = 'Chimas',
            delay = 10000,
            multiply = 1,
            anim = 'mexer',
            materials = {
                ['gtermica'] = { name = 'G. Termica', amount = 10 },
                ['cuia'] = { name = 'Cuia', amount = 10 },
                ['erva-mate'] = { name = 'Erva Mate', amount = 10 },
            }
        },
    },

    --==================================================================================================================

    ['guns'] = {
        -- ['weapon_machinepistol'] = {
        --     name = 'Tec-9',
        --     delay = 10000,
        --     materials = {
        --         ['clip'] = { name = 'Clip', amount = 15 },
        --         ['culatra'] = { name = 'Culatra', amount = 20 },
        --         ['ferrolho'] = { name = 'Ferrolho', amount = 20 },
        --         ['slide'] = { name = 'Slide', amount = 20 },
        --         ['cabo'] = { name = 'Cabo', amount = 15 },
        --         ['titanio'] = { name = 'Titânio', amount = 2 },
        --     }
        -- },
        ['box_weapon_minismg'] = {
            name = 'S VZ61',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 10500 },
                ['clip'] = { name = 'Clip', amount = 15 },
                ['culatra'] = { name = 'Culatra', amount = 20 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 20 },
                ['slide'] = { name = 'Slide', amount = 20 },
                ['cabo'] = { name = 'Cabo', amount = 15 },
                ['titanio'] = { name = 'Titânio', amount = 2 },
            }
        },
        -- ['weapon_smg_mk2'] = {
        --     name = 'Scorpion',
        --     delay = 10000,
        --     materials = {
        --         ['clip'] = { name = 'Clip', amount = 17 },
        --         ['culatra'] = { name = 'Culatra', amount = 22 },
        --         ['ferrolho'] = { name = 'Ferrolho', amount = 22 },
        --         ['slide'] = { name = 'Slide', amount = 22 },
        --         ['cabo'] = { name = 'Cabo', amount = 17 },
        --         ['titanio'] = { name = 'Titânio', amount = 2 },
        --     }
        -- },
        ['box_weapon_pistol'] = {
            name = 'Colt .45',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 4500 },
                ['clip'] = { name = 'Clip', amount = 7 },
                ['culatra'] = { name = 'Culatra', amount = 7 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 7 },
                ['slide'] = { name = 'Slide', amount = 7 },
                ['cabo'] = { name = 'Cabo', amount = 7 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
            }
        },
        -- ['weapon_pistol_mk2'] = {
        --     name = 'Five-SeveN',
        --     delay = 10000,
        --     materials = {
        --         ['clip'] = { name = 'Clip', amount = 12 },
        --         ['culatra'] = { name = 'Culatra', amount = 12 },
        --         ['ferrolho'] = { name = 'Ferrolho', amount = 12 },
        --         ['slide'] = { name = 'Slide', amount = 12 },
        --         ['cabo'] = { name = 'Cabo', amount = 12 },
        --         ['titanio'] = { name = 'Titânio', amount = 1 },
        --     }
        -- },
        ['box_weapon_snspistol'] = {
            name = 'H&K .45',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 3000 },
                ['clip'] = { name = 'Clip', amount = 5 },
                ['culatra'] = { name = 'Culatra', amount = 5 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 5 },
                ['slide'] = { name = 'Slide', amount = 5 },
                ['cabo'] = { name = 'Cabo', amount = 5 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
            }
        },
        -- ['weapon_pistol50'] = {
        --     name = 'Desert Deagle',
        --     delay = 10000,
        --     materials = {
        --         ['clip'] = { name = 'Clip', amount = 15 },
        --         ['culatra'] = { name = 'Culatra', amount = 15 },
        --         ['ferrolho'] = { name = 'Ferrolho', amount = 15 },
        --         ['slide'] = { name = 'Slide', amount = 15 },
        --         ['cabo'] = { name = 'Cabo', amount = 15 },
        --         ['titanio'] = { name = 'Titânio', amount = 1 },
        --     }
        -- },
        ['box_weapon_microsmg'] = {
            name = 'Uzi',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 10500 },
                ['clip'] = { name = 'Clip', amount = 15 },
                ['culatra'] = { name = 'Culatra', amount = 20 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 20 },
                ['slide'] = { name = 'Slide', amount = 20 },
                ['cabo'] = { name = 'Cabo', amount = 15 },
                ['titanio'] = { name = 'Titânio', amount = 2 },
            }
        },
        -- ['weapon_gusenberg'] = {
        --     name = 'Thompson',
        --     delay = 10000,
        --     materials = {
        --         ['clip'] = { name = 'Clip', amount = 15 },
        --         ['culatra'] = { name = 'Culatra', amount = 20 },
        --         ['ferrolho'] = { name = 'Ferrolho', amount = 20 },
        --         ['slide'] = { name = 'Slide', amount = 20 },
        --         ['cabo'] = { name = 'Cabo', amount = 15 },
        --         ['titanio'] = { name = 'Titânio', amount = 2 },
        --     }
        -- },
        -- ['weapon_assaultsmg'] = {
        --     name = 'M-TAR',
        --     delay = 10000,
        --     materials = {
        --         ['clip'] = { name = 'Clip', amount = 22 },
        --         ['culatra'] = { name = 'Culatra', amount = 27 },
        --         ['ferrolho'] = { name = 'Ferrolho', amount = 27 },
        --         ['slide'] = { name = 'Slide', amount = 27 },
        --         ['cabo'] = { name = 'Cabo', amount = 22 },
        --         ['titanio'] = { name = 'Titânio', amount = 2 },
        --     }
        -- },
        -- ['weapon_assaultrifle'] = {
        --     name = 'AK-47',
        --     delay = 10000,
        --     materials = {
        --         ['clip'] = { name = 'Clip', amount = 35 },
        --         ['culatra'] = { name = 'Culatra', amount = 45 },
        --         ['ferrolho'] = { name = 'Ferrolho', amount = 45 },
        --         ['slide'] = { name = 'Slide', amount = 45 },
        --         ['cabo'] = { name = 'Cabo', amount = 35 },
        --         ['titanio'] = { name = 'Titânio', amount = 4 },
        --     }
        -- },
        ['box_weapon_specialcarbine_mk2'] = {
            name = 'H&K G36C',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 36000 },
                ['clip'] = { name = 'Clip', amount = 50 },
                ['culatra'] = { name = 'Culatra', amount = 60 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 60 },
                ['slide'] = { name = 'Slide', amount = 60 },
                ['cabo'] = { name = 'Cabo', amount = 50 },
                ['titanio'] = { name = 'Titânio', amount = 4 },
            }
        },
        ['box_weapon_carbinerifle_mk2'] = {
            name = 'R5 RGP',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 36000 },
                ['clip'] = { name = 'Clip', amount = 50 },
                ['culatra'] = { name = 'Culatra', amount = 60 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 60 },
                ['slide'] = { name = 'Slide', amount = 60 },
                ['cabo'] = { name = 'Cabo', amount = 50 },
                ['titanio'] = { name = 'Titânio', amount = 4 },
            }
        },
        ['box_weapon_assaultrifle_mk2'] = {
            name = 'AK-103',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 27000 },
                ['clip'] = { name = 'Clip', amount = 40 },
                ['culatra'] = { name = 'Culatra', amount = 50 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 50 },
                ['slide'] = { name = 'Slide', amount = 50 },
                ['cabo'] = { name = 'Cabo', amount = 40 },
                ['titanio'] = { name = 'Titânio', amount = 4 },
            }
        },
        ['box_weapon_pumpshotgun_mk2'] = {
            name = 'B. Remington',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 30000 },
                ['clip'] = { name = 'Clip', amount = 50 },
                ['culatra'] = { name = 'Culatra', amount = 60 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 60 },
                ['slide'] = { name = 'Slide', amount = 60 },
                ['cabo'] = { name = 'Cabo', amount = 50 },
                ['titanio'] = { name = 'Titânio', amount = 4 },
            }
        },
    },

    ['guns_2'] = {
        ['box_weapon_machinepistol'] = {
            name = 'Tec-9',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 10500 },
                ['clip'] = { name = 'Clip', amount = 15 },
                ['culatra'] = { name = 'Culatra', amount = 20 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 20 },
                ['slide'] = { name = 'Slide', amount = 20 },
                ['cabo'] = { name = 'Cabo', amount = 15 },
                ['titanio'] = { name = 'Titânio', amount = 2 },
            }
        },

        ['box_weapon_smg_mk2'] = {
            name = 'Scorpion',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 12000 },
                ['clip'] = { name = 'Clip', amount = 17 },
                ['culatra'] = { name = 'Culatra', amount = 22 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 22 },
                ['slide'] = { name = 'Slide', amount = 22 },
                ['cabo'] = { name = 'Cabo', amount = 17 },
                ['titanio'] = { name = 'Titânio', amount = 2 },
            }
        },

        ['box_weapon_pistol_mk2'] = {
            name = 'Five-SeveN',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 7500 },
                ['clip'] = { name = 'Clip', amount = 12 },
                ['culatra'] = { name = 'Culatra', amount = 12 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 12 },
                ['slide'] = { name = 'Slide', amount = 12 },
                ['cabo'] = { name = 'Cabo', amount = 12 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
            }
        },

        ['box_weapon_pistol50'] = {
            name = 'Desert Deagle',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 9000 },
                ['clip'] = { name = 'Clip', amount = 15 },
                ['culatra'] = { name = 'Culatra', amount = 15 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 15 },
                ['slide'] = { name = 'Slide', amount = 15 },
                ['cabo'] = { name = 'Cabo', amount = 15 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
            }
        },

        ['box_weapon_gusenberg'] = {
            name = 'Thompson',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 10500 },
                ['clip'] = { name = 'Clip', amount = 15 },
                ['culatra'] = { name = 'Culatra', amount = 20 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 20 },
                ['slide'] = { name = 'Slide', amount = 20 },
                ['cabo'] = { name = 'Cabo', amount = 15 },
                ['titanio'] = { name = 'Titânio', amount = 2 },
            }
        },
        ['box_weapon_assaultsmg'] = {
            name = 'M-TAR',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 15000 },
                ['clip'] = { name = 'Clip', amount = 22 },
                ['culatra'] = { name = 'Culatra', amount = 27 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 27 },
                ['slide'] = { name = 'Slide', amount = 27 },
                ['cabo'] = { name = 'Cabo', amount = 22 },
                ['titanio'] = { name = 'Titânio', amount = 2 },
            }
        },
        ['box_weapon_assaultrifle'] = {
            name = 'AK-47',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 25500 },
                ['clip'] = { name = 'Clip', amount = 35 },
                ['culatra'] = { name = 'Culatra', amount = 45 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 45 },
                ['slide'] = { name = 'Slide', amount = 45 },
                ['cabo'] = { name = 'Cabo', amount = 35 },
                ['titanio'] = { name = 'Titânio', amount = 4 },
            }
        },
        ['box_weapon_pumpshotgun_mk2'] = {
            name = 'B. Remington',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 30000 },
                ['clip'] = { name = 'Clip', amount = 50 },
                ['culatra'] = { name = 'Culatra', amount = 60 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 60 },
                ['slide'] = { name = 'Slide', amount = 60 },
                ['cabo'] = { name = 'Cabo', amount = 50 },
                ['titanio'] = { name = 'Titânio', amount = 4 },
            }
        },
        ['box_weapon_carbinerifle_mk2'] = {
            name = 'R5 RGP',
            delay = 10000,
            materials = {
                ['reais'] = { name = 'Reais', amount = 36000 },
                ['clip'] = { name = 'Clip', amount = 50 },
                ['culatra'] = { name = 'Culatra', amount = 60 },
                ['ferrolho'] = { name = 'Ferrolho', amount = 60 },
                ['slide'] = { name = 'Slide', amount = 60 },
                ['cabo'] = { name = 'Cabo', amount = 50 },
                ['titanio'] = { name = 'Titânio', amount = 4 },
            }
        },
    },

    --==================================================================================================================

    ['wammos'] = {
        ['ammo_5mm'] = {
            name = 'Munição 5mm',
            delay = 30000,
            multiply = 200,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 25 },
            }
        },
        ['ammo_9mm'] = {
            name = 'Munição 9mm',
            delay = 30000,
            multiply = 200,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 40 },
                ['aluminio'] = { name = 'Alumínio', amount = 40 },
                ['ferro'] = { name = 'Ferro', amount = 40 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 40 },
            }
        },
        ['ammo_762mm'] = {
            name = 'Munição 762mm',
            delay = 30000,
            multiply = 200,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 55 },
                ['aluminio'] = { name = 'Alumínio', amount = 55 },
                ['ferro'] = { name = 'Ferro', amount = 55 },
                ['titanio'] = { name = 'Titânio', amount = 2 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 55 },
            }
        },
        ['ammo_12cbc'] = {
            name = 'Munição CBC 12',
            delay = 30000,
            multiply = 200,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 55 },
                ['aluminio'] = { name = 'Alumínio', amount = 55 },
                ['ferro'] = { name = 'Ferro', amount = 55 },
                ['titanio'] = { name = 'Titânio', amount = 2 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 55 },
            }
        },
    },

    --==================================================================================================================

    ['farinha'] = {
        ['farinha'] = {
            name = 'Farinha',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['farinha-trigo'] = { name = 'Farinha de Trigo', amount = 60 },
                ['folha'] = { name = 'Folha', amount = 60 },
                ['casca-semente'] = { name = 'Casca de Semente', amount = 60 },
            }
        },
    },


    ['rape_ayahuasca'] = {
        ['WEAPON_BOW'] = {
            name = 'Arco',
            delay = 20000,
            multiply = 1,
            materials = {
                ['madeira'] = { name = 'Madeira', amount = 10 },
                ['couro'] = { name = 'Couro', amount = 10 },
            }
        },
        ['flecha'] = {
            name = 'Flecha',
            delay = 20000,
            multiply = 5,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['madeira'] = { name = 'Madeira', amount = 10 },
                ['pena'] = { name = 'Pena', amount = 10 },
            }
        },
        ['rape'] = {
            name = 'Rape',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['farinha-trigo'] = { name = 'Farinha de Trigo', amount = 60 },
                ['folha'] = { name = 'Folha', amount = 60 },
                ['casca-semente'] = { name = 'Casca de Semente', amount = 60 },
            }
        },
        ['ayahuasca'] = {
            name = 'Rape',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['farinha-trigo'] = { name = 'Farinha de Trigo', amount = 60 },
                ['folha'] = { name = 'Folha', amount = 60 },
                ['casca-semente'] = { name = 'Casca de Semente', amount = 60 },
            }
        },
    },


    ['balinha'] = {
        ['balinha'] = {
            name = 'Balinha',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['folha-papel'] = { name = 'Folha de Papel', amount = 50 },
                ['efedrina'] = { name = 'Efedrina', amount = 40 },
                ['metileno'] = { name = 'Metileno', amount = 40 },
            }
        },
    },

    ['viagra'] = {
        ['viagra'] = {
            name = 'Viagra',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['sildenafila'] = { name = 'Sildenafila', amount = 40 },
                ['eter'] = { name = 'Éter', amount = 40 },
                ['farinha-trigo'] = { name = 'Farinha de Trigo', amount = 50 },
            }
        },
    },

    ['meta'] = {
        ['meta'] = {
            name = 'Meta',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['po-aluminio'] = { name = 'Pó de Alumínio', amount = 20 },
                ['folha-papel'] = { name = 'Folha de Papel', amount = 50 },
                ['efedrina'] = { name = 'Efedrina', amount = 40 },
            }
        },
    },

    ['erva'] = { -- maconha
        ['erva'] = {
            name = 'Erva',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['seda'] = { name = 'Seda', amount = 60 },
                ['folha'] = { name = 'Folha', amount = 60 },
                ['casca-semente'] = { name = 'Casca de Semente', amount = 60 },
            }
        },
    },

    ['skunk'] = { -- skunk
        ['skunk'] = {
            name = 'Skunk',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['seda'] = { name = 'Seda', amount = 60 },
                ['folha'] = { name = 'Folha', amount = 60 },
                ['casca-semente'] = { name = 'Casca de Semente', amount = 60 },
            }
        },
    },

    ['heroina'] = { -- heroina
        ['heroina'] = {
            name = 'H.',
            delay = 20000,
            multiply = 100,
            materials = {
                ['agulha'] = { name = 'Agulha', amount = 20 },
                ['seringa'] = { name = 'Seringa', amount = 20 },
                ['opio'] = { name = 'Ópio', amount = 50 },
                ['folha'] = { name = 'Folha', amount = 50 },
            }
        },
    },

    -- ['ayahuasca'] = { -- heroina
    --     ['ayahuasca'] = {
    --         name = 'Ayahuasca',
    --         delay = 20000,
    --         multiply = 100,
    --         materials = {
    --             ['agulha'] = { name = 'Agulha', amount = 20 },
    --             ['seringa'] = { name = 'Seringa', amount = 20 },
    --             ['opio'] = { name = 'Ópio', amount = 50 },
    --             ['folha'] = { name = 'Folha', amount = 50 },
    --         }
    --     },
    -- },

    -- ['rape'] = { -- heroina
    --     ['rape'] = {
    --         name = 'Rapé',
    --         delay = 20000,
    --         multiply = 100,
    --         materials = {
    --             ['agulha'] = { name = 'Agulha', amount = 20 },
    --             ['seringa'] = { name = 'Seringa', amount = 20 },
    --             ['opio'] = { name = 'Ópio', amount = 50 },
    --             ['folha'] = { name = 'Folha', amount = 50 },
    --         }
    --     },
    -- },

    ['lanca'] = { -- lanca
        ['lanca'] = {
            name = 'Lança',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['opio'] = { name = 'Ópio', amount = 50 },
                ['eter'] = { name = 'Éter', amount = 50 },
                ['metileno'] = { name = 'Metileno', amount = 40 },
            }
        },
    },

    ['oxy'] = { -- oxy
        ['oxy'] = {
            name = 'Oxy',
            delay = 20000,
            multiply = 100,
            materials = {
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 20 },
                ['opio'] = { name = 'Ópio', amount = 50 },
                ['folha'] = { name = 'Folha', amount = 50 },
                ['farinha-trigo'] = { name = 'Farinha de Trigo', amount = 50 },
            }
        },
    },

    --==================================================================================================================

    ['master_bloqueador'] = {
        ['b-rastreador'] = {
            name = 'Bloqueador de Rastreador',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 30 },
                ['aluminio'] = { name = 'Alumínio', amount = 30 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 20 },
                ['borracha'] = { name = 'Borracha', amount = 20 }
            }
        },
        ['emb-masterpick'] = {
            name = 'Emb. Masterpick',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 4 },
                ['aluminio'] = { name = 'Alumínio', amount = 4 },
                ['plastico'] = { name = 'Plástico', amount = 1 },
                ['cobre'] = { name = 'Cobre', amount = 1 },
                ['borracha'] = { name = 'Borracha', amount = 1 }
            }
        },
    },

    ['flipper'] = {
        ['flipper-mk1'] = {
            name = 'Flipper Mk1',
            multiply = 1,
            delay = 10000,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 25 },
             }
            },
        ['flipper-mk2'] = {
            name = 'Flipper Mk2',
            multiply = 1,
            delay = 10000,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 25 },
            }
        },
        ['flipper-mk3'] = {
            name = 'Flipper Mk3',
            multiply = 1,
            delay = 10000,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 25 },
            }
        },
        ['flipper-mk4'] = {
            name = 'Flipper Mk4',
            multiply = 1,
            delay = 10000,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 25 },
            }
        },
        ['flipper-mk5'] = {
            name = 'Flipper Mk5',
            multiply = 1,
            delay = 10000,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 25 },
            }
        },
        ['chave-ouro'] = {
            name = 'Chave de Ouro',
            multiply = 1,
            delay = 10000,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 25 },
            }
        },
        ['chave-platina'] = {
            name = 'Chave de platina',
            multiply = 1,
            delay = 10000,
            materials = {
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['titanio'] = { name = 'Titânio', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 25 },
            }
        },
        -- ['flipper-mk1'] = { name = 'Flipper MK-1', amount = 30 },
        -- ['flipper-mk2'] = { name = 'Flipper MK-2', amount = 30 },
        -- ['flipper-mk3'] = { name = 'Flipper MK-3', amount = 25 },
        -- ['flipper-mk4'] = { name = 'Flipper MK-4', amount = 20 },
        -- ['flipper-mk5'] = { name = 'Flipper MK-5', amount = 20 },
        -- ['chave-ouro'] = { name = 'Flipper MK-1', amount = 30 },
        -- ['chave-platina'] = { name = 'Flipper MK-1', amount = 30 },
    },

    ['mecanica_troll'] = {
        ['volante-doidao'] = {
            name = 'Volante doidão',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 15 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
        ['casca-banana'] = {
            name = 'Casca de banana',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 15 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
        ['fon-fon'] = {
            name = 'Fon fon',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 15 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
        ['ronco-palhaco'] = {
            name = 'Ronco do palhaço',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 15 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
        ['alinhamento-volante'] = {
            name = 'Alinhamento de volante',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 15 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
        ['motor-arranque'] = {
            name = 'Motor de arranque',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 15 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
        ['remodelagem-pneu'] = {
            name = 'Remodelagem de pneu',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 15 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
        ['troca-buzina'] = {
            name = 'Troca buzina',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 15 },
                ['aluminio'] = { name = 'Alumínio', amount = 15 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
    },

    ['bombac4'] = {
        ['c4'] = {
            name = 'C4',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 5 },
                ['plastico'] = { name = 'Plástico', amount = 5 },
                ['borracha'] = { name = 'Borracha', amount = 5 }
            }
        },
    },

    ['melzinho'] = {
        ['melzinho'] = {
            name = 'Melzinho',
            multiply = 1,
            delay = 10000,
            materials = {
                ['mel'] = { name = 'Mel', amount = 3 },
                ['agua'] = { name = 'Água', amount = 1 },
                ['embalagem-plastica'] = { name = 'Emb. Plástica', amount = 3 },
            }
        },
    },

    ['camisaforca'] = {
        ['emb-camisaforca'] = {
            name = 'Camisa de Força',
            delay = 10000,
            multiply = 1,
            materials = {
                ['tecido'] = { name = 'Tecido', amount = 8 },
            }
        },
    },

    ['colete_camisa'] = {
        ['emb-camisaforca'] = {
            name = 'Camisa de Força',
            delay = 10000,
            multiply = 1,
            materials = {
                ['tecido'] = { name = 'Tecido', amount = 8 },
            }
        },
        ['emb-colete'] = {
            name = 'Colete',
            delay = 10000,
            multiply = 1,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 20 },
                ['aluminio'] = { name = 'Alumínio', amount = 20 },
                ['plastico'] = { name = 'Plástico', amount = 10 },
                ['tecido'] = { name = 'Tecido', amount = 1 },
                ['borracha'] = { name = 'Borracha', amount = 10 }
            }
        },
    },

    ['algema_colete'] = {
        ['capuz'] = {
            name = 'Capuz',
            delay = 10000,
            materials = {
                ['tecido'] = { name = 'Tecido', amount = 1 },
                ['plastico'] = { name = 'Plástico', amount = 10 },
                ['borracha'] = { name = 'Borracha', amount = 10 }
            }
        },
        ['algema'] = {
            name = 'Algema',
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 30 },
                ['aluminio'] = { name = 'Alumínio', amount = 25 },
                ['cobre'] = { name = 'Cobre', amount = 25 },
                ['plastico'] = { name = 'Plástico', amount = 20 },
                ['borracha'] = { name = 'Borracha', amount = 20 }
            }
        },
        ['emb-colete'] = {
            name = 'Colete',
            delay = 10000,
            multiply = 1,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 20 },
                ['aluminio'] = { name = 'Alumínio', amount = 20 },
                ['plastico'] = { name = 'Plástico', amount = 10 },
                ['tecido'] = { name = 'Tecido', amount = 1 },
                ['borracha'] = { name = 'Borracha', amount = 10 }
            }
        },
    },

    ['vaselina'] = {
        ['vaselina'] = {
            name = 'Vaselina',
            multiply = 1,
            delay = 10000,
            materials = {
                ['seringa'] = { name = 'Seringa', amount = 1 },
                ['agulha'] = { name = 'Agulha', amount = 1 },
                ['efedrina'] = { name = 'Efedrina', amount = 20 },
                ['eter'] = { name = 'Éter', amount = 20 }
            }
        },
    },

    ['colete_adrenalina'] = {
        ['emb-colete'] = {
            name = 'Colete',
            delay = 10000,
            multiply = 1,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 20 },
                ['aluminio'] = { name = 'Alumínio', amount = 20 },
                ['plastico'] = { name = 'Plástico', amount = 10 },
                ['tecido'] = { name = 'Tecido', amount = 1 },
                ['borracha'] = { name = 'Borracha', amount = 10 }
            }
        },
        ['adrenalina'] = {
            name = 'Adrenalina',
            multiply = 1,
            delay = 10000,
            materials = {
                ['seringa'] = { name = 'Seringa', amount = 1 },
                ['agulha'] = { name = 'Agulha', amount = 1 },
                ['efedrina'] = { name = 'Efedrina', amount = 20 },
                ['eter'] = { name = 'Éter', amount = 20 }
            }
        },
    },

    ['placa_ticket'] = {
        ['ticket'] = {
            name = 'Ticket',
            multiply = 1,
            delay = 10000,
            materials = {
                ['folha-papel'] = { name = 'Folha de Papel', amount = 1 },
                ['lata-tinta'] = { name = 'Lata de Tinta', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 1 }
            }
        },
        ['emb-placa'] = {
            name = 'Placa Clonada',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 20 },
                ['aluminio'] = { name = 'Alumínio', amount = 20 },
                ['cobre'] = { name = 'Cobre', amount = 15 },
                ['plastico'] = { name = 'Plástico', amount = 15 },
                ['borracha'] = { name = 'Borracha', amount = 15 }
            }
        },
    },

    --==================================================================================================================

    ['reciclagem'] = {
        ['borracha'] = {
            name = 'Borracha',
            multiply = 3,
            delay = 3000,
            materials = { ['luva-latex'] = { name = 'Luva de Látex', amount = 1 } }
        },
        ['aluminio'] = {
            name = 'Alumínio',
            multiply = 3,
            delay = 3000,
            materials = { ['lata-refrigerante'] = { name = 'Lata de Refrigerante', amount = 1 } }
        },
        ['plastico'] = {
            name = 'Plástico',
            multiply = 3,
            delay = 3000,
            materials = { ['garrafa-pet'] = { name = 'Lata de Refrigerante', amount = 1 } }
        },
        ['cobre'] = {
            name = 'Cobre',
            multiply = 3,
            delay = 3000,
            materials = { ['bateria-velha'] = { name = 'Bateria Velha', amount = 1 } }
        },
        ['ferro'] = {
            name = 'Ferro',
            multiply = 3,
            delay = 3000,
            materials = { ['barra-ferro'] = { name = 'Barra de Ferro', amount = 1 } }
        },
    },

    ['prison'] = {
        ['cigarro'] = {
            name = 'Cigarro',
            multiply = 1,
            delay = 10000,
            materials = {
                ['sildenafila'] = { name = 'Sildenafila', amount = 3 },
                ['eter'] = { name = 'Éter', amount = 3 },
                ['efedrina'] = { name = 'Efedrina', amount = 3 },
                ['metileno'] = { name = 'Metileno', amount = 3 },
            }
        },
        ['chave-prisao'] = {
            name = 'Chave da Prisão',
            multiply = 1,
            delay = 10000,
            materials = {
                ['pedaco-chave'] = { name = 'Pedaço de Chave', amount = 50 },
            }
        },
        ['pedaco-chave'] = {
            name = 'Pedaço de Chave',
            multiply = 1,
            delay = 10000,
            materials = {
                ['bateria-velha'] = { name = 'Bateria Velha', amount = 20 },
                ['barra-ferro'] = { name = 'Barra de Ferro', amount = 20 },
                ['lata-refrigerante'] = { name = 'Lata de Refrigerante', amount = 20 },
                ['garrafa-pet'] = { name = 'Garrafa PET', amount = 20 },
            }
        }
    },

    ['leiteiro'] = {
        ['leite'] = {
            name = 'Leite',
            multiply = 5,
            delay = 10000,
            materials = { ['balde-leite'] = { name = 'Balde de Leite', amount = 1 } },
            refund = { ['balde'] = { amount = 1 } },
        },
        ['queijo'] = {
            name = 'Queijo',
            multiply = 1,
            delay = 10000,
            materials = { ['leite'] = { name = 'Leite', amount = 2 } }
        },
        ['manteiga'] = {
            name = 'Manteiga',
            multiply = 1,
            delay = 10000,
            materials = { ['leite'] = { name = 'Leite', amount = 2 } }
        },
        ['iogurte'] = {
            name = 'Iogurte',
            multiply = 1,
            delay = 10000,
            materials = {
                ['garrafavazia'] = { name = 'Garrafa Vazia', amount = 1 },
                ['leite'] = { name = 'Leite', amount = 10 }
            }
        },
    },

    ['madereira'] = {
        ['seda'] = {
            name = 'Seda',
            multiply = 1,
            delay = 10000,
            materials = { ['madeira'] = { name = 'Madeira', amount = 2 } }
        },
        ['folha-papel'] = {
            name = 'Folha de Papel',
            multiply = 1,
            delay = 10000,
            materials = { ['madeira'] = { name = 'Madeira', amount = 2 } }
        },
    },

    ['minerador'] = {
        ['ferro'] = {
            name = 'Ferro',
            multiply = 5,
            delay = 10000,
            materials = { ['minerio-ferro'] = { name = 'Minério de Ferro', amount = 1 } }
        },
        ['aluminio'] = {
            name = 'Alumínio',
            multiply = 5,
            delay = 10000,
            materials = { ['minerio-bauxita'] = { name = 'Minério de Bauxita', amount = 1 } }
        },
        ['cobre'] = {
            name = 'Cobre',
            multiply = 5,
            delay = 10000,
            materials = { ['minerio-calcosita'] = { name = 'Minério de Calcosita', amount = 1 } }
        },
    },

    ['laricas'] = {
        ['hamburguer'] = {
            name = 'Hambúrguer',
            multiply = 2,
            delay = 10000,
            anim = 'churrasco',
            materials = {
                ['musculo-cru'] = { name = 'Músculo Cru', amount = 1 },
                ['maminha-cru'] = { name = 'Maminha Cru', amount = 1 },
                ['picanha-cru'] = { name = 'Picanha Cru', amount = 1 },
                ['cupim-cru'] = { name = 'Cupim Cru', amount = 1 },
                ['costela-cru'] = { name = 'Costela Cru', amount = 1 },
            }
        },
        ['pao-hamburguer'] = {
            name = 'Pão de Hambúrguer',
            multiply = 2,
            delay = 10000,
            anim = 'churrasco',
            materials = {
                ['farinha-trigo'] = { name = 'Farinha de Trigo', amount = 2 },
            }
        },
        ['xburger'] = {
            name = 'X-Burger',
            multiply = 2,
            delay = 10000,
            anim = 'churrasco',
            materials = {
                ['hamburguer'] = { name = 'Hambúrguer', amount = 1 },
                ['pao-hamburguer'] = { name = 'Pão de Hambúrguer', amount = 1 },
                ['queijo'] = { name = 'Queijo', amount = 1 },
                ['manteiga'] = { name = 'Manteiga', amount = 1 },
            }
        },
        ['xsalada'] = {
            name = 'X-Salada',
            multiply = 2,
            delay = 10000,
            anim = 'churrasco',
            materials = {
                ['hamburguer'] = { name = 'Hambúrguer', amount = 1 },
                ['pao-hamburguer'] = { name = 'Pão de Hambúrguer', amount = 1 },
                ['tomate'] = { name = 'Tomate', amount = 1 },
                ['alface'] = { name = 'Alface', amount = 1 },
                ['queijo'] = { name = 'Queijo', amount = 1 },
                ['manteiga'] = { name = 'Manteiga', amount = 1 },
            }
        },
        ['xtudo'] = {
            name = 'X-Tudo',
            multiply = 2,
            delay = 10000,
            anim = 'churrasco',
            materials = {
                ['hamburguer'] = { name = 'Hambúrguer', amount = 1 },
                ['pao-hamburguer'] = { name = 'Pão de Hambúrguer', amount = 1 },
                ['tomate'] = { name = 'Tomate', amount = 1 },
                ['alface'] = { name = 'Alface', amount = 1 },
                ['camarao'] = { name = 'Camarão', amount = 1 },
                ['queijo'] = { name = 'Queijo', amount = 1 },
                ['manteiga'] = { name = 'Manteiga', amount = 1 },
            }
        },
        ['espetinho-camarao'] = {
            name = 'Esp. Camarão',
            multiply = 2,
            delay = 10000,
            anim = 'churrasco',
            materials = {
                ['camarao'] = { name = 'Camarão', amount = 2 },
            }
        },
        ['caviar'] = {
            name = 'Caviar',
            multiply = 2,
            delay = 10000,
            anim = 'churrasco',
            materials = {
                ['sardinha'] = { name = 'Sardinha', amount = 2 }
            }
        },
        ['milho'] = {
            name = 'Milho Cozido',
            multiply = 1,
            delay = 10000,
            anim = 'churrasco',
            materials = {
                ['espiga-milho'] = { name = 'Espiga Milho', amount = 2 },
            }
        },
        ['farinha-trigo'] = {
            name = 'Farinha de Trigo',
            multiply = 2,
            delay = 5000,
            materials = {
                ['trigo'] = { name = 'Trigo', amount = 1 },
            }
        },
        -- bebidas
        ['cha-camomila'] = {
            name = 'Chá de Camomila',
            multiply = 1,
            delay = 10000,
            materials = {
                ['camomila'] = { name = 'Camomila', amount = 1 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['energetico'] = {
            name = 'Energético',
            multiply = 1,
            delay = 10000,
            materials = {
                ['graos-guarana'] = { name = 'Grãos de Guaraná', amount = 1 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['cafe'] = {
            name = 'Café',
            multiply = 1,
            delay = 10000,
            materials = {
                ['graos-cafe'] = { name = 'Grãos de Café', amount = 1 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['suco-morango'] = {
            name = 'Suco Morango',
            multiply = 1,
            delay = 10000,
            materials = {
                ['morango'] = { name = 'Morango', amount = 2 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['suco-banana'] = {
            name = 'Suco Banana',
            multiply = 1,
            delay = 10000,
            materials = {
                ['banana'] = { name = 'Banana', amount = 2 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['suco-abacaxi'] = {
            name = 'Suco Abacaxi',
            multiply = 1,
            delay = 10000,
            materials = {
                ['abacaxi'] = { name = 'Abacaxi', amount = 2 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['suco-caju'] = {
            name = 'Suco Caju',
            multiply = 1,
            delay = 10000,
            materials = {
                ['caju'] = { name = 'Caju', amount = 2 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['suco-maracuja'] = {
            name = 'Suco Maracuja',
            multiply = 1,
            delay = 10000,
            materials = {
                ['maracuja'] = { name = 'Maracujá', amount = 2 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['suco-uva'] = {
            name = 'Suco Uva',
            multiply = 1,
            delay = 10000,
            materials = {
                ['uva'] = { name = 'Uva', amount = 2 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['suco-pessego'] = {
            name = 'Suco Pêssego',
            multiply = 1,
            delay = 10000,
            materials = {
                ['pessego'] = { name = 'Pêssego', amount = 2 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
        ['suco-kiwi'] = {
            name = 'Suco Kiwi',
            multiply = 1,
            delay = 10000,
            materials = {
                ['kiwi'] = { name = 'Kiwi', amount = 2 },
                ['agua'] = { name = 'Água', amount = 1 },
            }
        },
    },
    ['craftchimarrao'] = {
        ['chimarrao'] = {
            name = 'Chimarrão',
            multiply = 1,
            delay = 10000,
            materials = { ['erva-mate'] = { name = 'Erva Mate', amount = 2 } }
        },
    },
    ['latadetinta'] = {
        ['lata-tinta'] = {
            name = 'Lata de Tinta',
            multiply = 1,
            delay = 10000,
            materials = { ['ferro'] = { name = 'Ferro', amount = 2 } }
        },
    },
    ['craftseringa'] = {
        ['seringa'] = {
            name = 'Seringa',
            multiply = 1,
            delay = 10000,
            materials = { ['plastico'] = { name = 'Plástico', amount = 4 } }
        },
        ['agulha'] = {
            name = 'Agulha',
            multiply = 1,
            delay = 10000,
            materials = { ['aluminio'] = { name = 'Alumínio', amount = 2 } }
        },
    },
    ['craftarmas'] = {
        ['clip'] = {
            name = 'Clip',
            multiply = 1,
            delay = 10000,
            materials = { ['plastico'] = { name = 'Plástico', amount = 10 } }
        },
        ['culatra'] = {
            name = 'Culatra',
            multiply = 1,
            delay = 10000,
            materials = { ['cobre'] = { name = 'Cobre', amount = 10 } }
        },
        ['ferrolho'] = {
            name = 'Ferrolho',
            multiply = 1,
            delay = 10000,
            materials = { ['aluminio'] = { name = 'Alumínio', amount = 10 } }
        },
        ['slide'] = {
            name = 'Slide',
            multiply = 1,
            delay = 10000,
            materials = { ['ferro'] = { name = 'Ferro', amount = 10 } }
        },
        ['cabo'] = {
            name = 'Cabo',
            multiply = 1,
            delay = 10000,
            materials = { ['borracha'] = { name = 'Borracha', amount = 10 } }
        },
    },
    ['craftmochila'] = {
        ['tecido'] = {
            name = 'Tecido',
            multiply = 1,
            delay = 10000,
            materials = { ['couro'] = { name = 'Couro', amount = 5 } }
        },
        ['mochila'] = {
            name = 'Mochila',
            multiply = 1,
            delay = 10000,
            materials = { ['tecido'] = { name = 'Tecido', amount = 10 } }
        },
    },
    ['nitro_ticket'] = {
        ['ticket'] = {
            name = 'Ticket',
            multiply = 1,
            delay = 10000,
            materials = {
                ['folha-papel'] = { name = 'Folha de Papel', amount = 1 },
                ['lata-tinta'] = { name = 'Lata de Tinta', amount = 1 },
                ['embalagem-plastica'] = { name = 'Embalagem Plástica', amount = 1 }
            }
        },
    },
    ['nitro'] = {
        ['nitro'] = {
            name = 'Nitro',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Aluminio', amount = 10 },
                ['gas'] = { name = 'Gás', amount = 10 },
            }
        },
    },
    ['chavenitro'] = {
        ['chave-nitro'] = {
            name = 'Chave Nitro',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 25 },
                ['aluminio'] = { name = 'Aluminio', amount = 25 },
            }
        },
    },
    ['kit_desmanche'] = {
        ['kit-desmanche-novo'] = {
            name = 'Kit Desmanche Novo',
            multiply = 1,
            delay = 10000,
            materials = {
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 10 },
                ['plastico'] = { name = 'Plástico', amount = 10 },
                ['borracha'] = { name = 'Borracha', amount = 10 }
            }
        },
    },
    ['pager_masterpick'] = {
        ['emb-masterpick'] = {
            name = 'Emb. Masterpick',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 4 },
                ['aluminio'] = { name = 'Alumínio', amount = 4 },
                ['plastico'] = { name = 'Plástico', amount = 1 },
                ['cobre'] = { name = 'Cobre', amount = 1 },
                ['borracha'] = { name = 'Borracha', amount = 1 }
            }
        },
        ['pager'] = {
            name = 'Pager',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['plastico'] = { name = 'Plástico', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 10 },
                ['borracha'] = { name = 'Borracha', amount = 10 }
            }
        },
    },

    ['adrenalina'] = {
        ['adrenalina'] = {
            name = 'Adrenalina',
            multiply = 1,
            delay = 10000,
            materials = {
                ['seringa'] = { name = 'Seringa', amount = 1 },
                ['agulha'] = { name = 'Agulha', amount = 1 },
                ['efedrina'] = { name = 'Efedrina', amount = 20 },
                ['eter'] = { name = 'Éter', amount = 20 }
            }
        },
    },

    --==================================================================================================================

    ['wattachs'] = {
        ['clip-extendido'] = {
            name = 'Clip Extendido',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 5 },
                ['plastico'] = { name = 'Plástico', amount = 5 },
                ['borracha'] = { name = 'Borracha', amount = 5 }
            }
        },
        ['supressor'] = {
            name = 'Supressor',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 5 },
                ['plastico'] = { name = 'Plástico', amount = 5 },
                ['borracha'] = { name = 'Borracha', amount = 5 }
            }
        },
        ['compensador'] = {
            name = 'Compensador',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 5 },
                ['plastico'] = { name = 'Plástico', amount = 5 },
                ['borracha'] = { name = 'Borracha', amount = 5 }
            }
        },
        ['lanterna-acoplavel'] = {
            name = 'Lanterna Acoplável',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 5 },
                ['plastico'] = { name = 'Plástico', amount = 5 },
                ['borracha'] = { name = 'Borracha', amount = 5 }
            }
        },
        ['mira-avancada'] = {
            name = 'Mira Avançada',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 5 },
                ['plastico'] = { name = 'Plástico', amount = 5 },
                ['borracha'] = { name = 'Borracha', amount = 5 }
            }
        },
        ['grip-avancado'] = {
            name = 'Grip Avançado',
            multiply = 1,
            delay = 10000,
            materials = {
                ['ferro'] = { name = 'Ferro', amount = 10 },
                ['aluminio'] = { name = 'Alumínio', amount = 10 },
                ['cobre'] = { name = 'Cobre', amount = 5 },
                ['plastico'] = { name = 'Plástico', amount = 5 },
                ['borracha'] = { name = 'Borracha', amount = 5 }
            }
        },
    },
    ['chimas'] = {
        ['chimas'] = {
            name = 'chimas',
            multiply = 1,
            delay = 10000,
            materials = {
                ['gtermica'] = { name = 'G. Termica', amount = 10 },
                ['cuia'] = { name = 'Cuia', amount = 10 },
                ['erva-mate'] = { name = 'Erva Mate', amount = 10 },
            }
        },
    },
}

configs.productions = {

    --==================================================================================================================

    ['craft_armas'] = {
        type = 'production',
        label = 'Produção de Armas',
        products = configs.products.guns,
        permission = { '+Ratoeira.ViceLider', '+ComandoNorte.ViceLider' }, 
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['armas'] = {
        type = 'production',
        label = 'Produção de Armas',
        products = configs.products.guns_2,
        permission = { '+MDS.ViceLider' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    --==================================================================================================================

    ['municao'] = {
        type = 'production',
        label = 'Produção de Munição',
        products = configs.products.wammos, 
        permission = {'+Hydra.Gerente', '+OsVeio.Gerente', '+Palhacos.Gerente'},
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    --==================================================================================================================

    ['farinha'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.farinha,
        permission = { '+MonteCristo.Gerente', '+Mantem.Gerente', '+Ciringa.Gerente', '+Umbrella.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['balinha'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.balinha,
        permission = { 'balinha.permissao' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['viagra'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.viagra,
        permission = { '+Boiadeiras.Gerente', '+Underdogs.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['nitro'] = {
        type = 'production',
        label = 'Produção de Nitro',
        products = configs.products.nitro,
        permission = { '+BennysTunner.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },
    ['chave-nitro'] = {
        type = 'production',
        label = 'Produção de Chave de Nitro',
        products = configs.products.chavenitro,
        permission = { 'staff.permissao' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },
    ['meta'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.meta,
        permission = { '+Juramento.Gerente', '+CartelNPN.Gerente', '+Dinastia.Gerente', '+Observatorio.Gerente', '+Phoenix.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },
    ['parafal'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.parafal,
        permission = { '+Dinastia.ViceLider' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },
    ['erva'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.erva,
        permission = { '+Medelin.Gerente', '+LaFronteira.Gerente', '+Aztecas.Gerente', '+Helipa.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['lanca'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.lanca,
        permission = { '+MorroMina.Gerente', '+Bahamas.Gerente',  '+Dende.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['oxy'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.oxy,
        permission = { '+FavelaBarragem.Gerente', '+Fundao.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['heroina'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.heroina,
        permission = { '+Juramento.Gerente', '+Mare.Gerente', '+CDD.Gerente', '+Turano.Gerente', '+Penha.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['rape'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.heroina,
        permission = { '+Wanana.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['rape_ayahuasca'] = {
        type = 'production',
        label = 'Produção de Droga',
        products = configs.products.rape_ayahuasca,
        permission = { '+Wanana.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    --==================================================================================================================

    ['china'] = {
        type = 'production',
        label = 'Produção de Arma Branca',
        products = configs.products.china,
        permission = { '+Chineses.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['master_bloqueador'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.master_bloqueador,
        permission = { '+Blackout.Gerente', '+Comitiva.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['mecanica_troll'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.mecanica_troll,
        permission = { '+Palhacos.ViceLider', '+Palhacos.Lider' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['bombac4'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.bombac4,
        permission = { '+Ghost.Gerente', '+Caos.Gerente', '+LosPraca.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },
    
    ['flipper'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.flipper,
        permission = { '+Triade.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['camisaforca'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.camisaforca,
        permission = { '+CosaNostra.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['algema_colete'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.algema_colete,
        permission = { 
            '+TheFusion.Gerente', 
            '+Medelin.Gerente', 
            '+Hydra.Gerente', 
            '+Irmandade.Gerente', 
            '+MotoClub.Gerente', 
            '+Olimpo.Gerente'
        },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['colete_camisa'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.colete_camisa,
        permission = { '+TheFusion.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['colete_adrenalina'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.colete_adrenalina,
        permission = '+Olimpo.Gerente',
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['placa_ticket'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.placa_ticket,
        permission = { '+Bennys.Gerente', '+Sindicato.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['kit_desmanche'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.kit_desmanche,
        permission = { '+Cupim.Gerente', '+OsCrias.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['pager_masterpick'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.pager_masterpick,
        permission = { '+Cupim.Gerente', '+Chineses.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['adrenalina'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.adrenalina,
        permission = { '+BennysTunner.Gerente', '+Olimpo.Gerente', '+CosaNostra.Gerente' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },

    ['vaselina'] = {
        type = 'production',
        label = 'Produção de Contrabando',
        products = configs.products.vaselina,
        permission = { 'mptv.permissao' },
        webhook =
        'https://discord.com/api/webhooks/1198812605804986478/xFPaLBbOkpu6YdqvohwpYaACnQa8fbUETBqAd0e5ppXQ_sz_867y_BMUgZsTi-FU3wgB'
    },


    ['reciclagem'] = {
        type = 'production',
        label = 'Reciclagem',
        products = configs.products.reciclagem,
        webhook = ''
    },

    ['prison'] = {
        type = 'production',
        label = 'Prisão',
        products = configs.products.prison,
        webhook = ''
    },

    ['leiteiro'] = {
        type = 'production',
        label = 'Fábrica de Lacticínios',
        products = configs.products.leiteiro,
        webhook = ''
    },

    ['madereira'] = {
        type = 'production',
        label = 'Madereira',
        products = configs.products.madereira,
        webhook = ''
    },

    ['laricas'] = {
        type = 'production',
        coords = vector4(-1842.514, -1185.508, 14.31726, 59.52755),
        label = 'Laricas',
        products = configs.products.laricas,
        permission = 'laricas.permissao',
        webhook = ''
    },

    ['minerador'] = {
        type = 'production',
        label = 'Minerador',
        products = configs.products.minerador,
        webhook = ''
    },

    ['craftchimarrao'] = {
        type = 'production',
        label = 'Moagem',
        products = configs.products.craftchimarrao,
        permission = 'blackout.permissao',
        webhook = ''
    },

    ['nitro_ticket'] = {
        type = 'production',
        label = 'LS Races',
        products = configs.products.nitro_ticket,
        permission = 'empresaspaulo.permissao',
        webhook = ''
    },

    ['race_tablet'] = {
        type = 'production',
        label = 'Tablet de Corrida',
        products = configs.products.racetablet,
        permission = '',
        webhook = ''
    },

    ['latadetinta'] = {
        type = 'production',
        label = 'Fundição',
        products = configs.products.latadetinta,
        webhook = ''
    },

    ['craftseringa'] = {
        type = 'production',
        label = 'Laboratório',
        products = configs.products.craftseringa,
        webhook = ''
    },

    ['craftarmas'] = {
        type = 'production',
        label = 'Metalúrgica',
        products = configs.products.craftarmas,
        permission = { '+Ratoeira.ViceLider', '+MDS.ViceLider', '+ComandoNorte.ViceLider' },
        webhook = ''
    },

    ['craftembalagem'] = {
        type = 'production',
        label = 'Embalagem',
        products = configs.products.embalagem,
        permission = nil,
        webhook = ''
    },

    ['craftmochila'] = {
        type = 'production',
        label = 'Costureira',
        products = configs.products.craftmochila,
        permission = nil,
        webhook = ''
    },

    ['wattachs'] = {
        type = 'production',
        label = 'Attachs',
        products = configs.products.wattachs,
        permission = { '+Legiao.Gerente', '+K10.Gerente', '+Venezza.Gerente' },
        webhook = ''
    },

    ['chimas'] = {
        type = 'production',
        label = 'Chimas',
        products = configs.products.chimas,
        permission = { '+BandoDosGauchos.Gerente' },
        webhook = ''
    },
    ['grotorante'] = {
        type = 'production',
        label = 'Grotorante',
        coords = vector4(-1595.182, -994.8132, 13.20508, 144.5669),
        products = configs.products.grotorante,
        permission = { 'grotorante.permissao' },
        webhook = ''
    },
    ['melgual'] = {
        type = 'production',
        label = 'Melgual',
        coords = vector4(120.7516, -1041.244, 29.29675, 340.1575),
        products = configs.products.melgual,
        permission = { 'melgual.permissao' },
        webhook = ''
    },
    ['skunk'] = {
        type = 'production',
        label = 'Laboratório',
        products = configs.products.skunk,
        permission = { '+DubaiGang.Gerente', '+Bras.Gerente' },
        webhook = ''
    },
    ['melzinho'] = {
        type = 'production',
        label = 'Laboratório',
        products = configs.products.melzinho,
        permission = { '+Tropical.Gerente' },
        webhook = ''
    }

}

configProductions = configs.productions

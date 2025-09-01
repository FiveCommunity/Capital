config.blips = {
    ['carOnly'] = {
        sprite = 357,
        color = 3,
        scale = 0.6,
    },
    ['heliOnly'] = {
        sprite = 64,
        color = 3,
        scale = 0.6,
    },
    ['planeOnly'] = {
        sprite = 307,
        color = 3,
        scale = 0.6,
    },
    ['boatsOnly'] = {
        sprite = 427,
        color = 3,
        scale = 0.6,
    },
}

config.trunks = {
    webhooks = {
        put = 'https://discord.com/api/webhooks/1205512638692327494/ysmm1hHpbRvkAODtFWAQR-z6qS1jBx8Gz52al-uPwZAMjy9-oT_i-UvmznW3BAMWhMuU',
        remove = 'https://discord.com/api/webhooks/1205512695311237170/uiMtP6rNVH6Vp1rxXOEomx_znThZCb-Sm3yOKR2MCs7aKakId-P-J6SRzKyj7mDfEOna'
    },
    gloveSlots = 10,
    mainSlots = 100,

    restrict = {
        ['default'] = {
            mode = 'deny', -- only|deny
            items = {
                'vip-bronze', 'vip-prata', 'vip-ouro', 'vip-capital', 'placa-vip', 'chip-vip', 'nome-vip', 'resetchar',
                'contrato-basic', 'contrato-modern', 'contrato-high', 'contrato-apartament', 'bolso-pequeno', 
                'bolso-medio', 'bolso-grande',
            }
        },
        ['mule2'] = {
            mode = 'only', -- only|deny
            items = {
                'couro', 'musculo-cru', 'maminha-cru', 'cupim-cru', 'picanha-cru', 'picanha-cru', 'costela-cru'
            }
        },
        ['trash2'] = {
            mode = 'only', -- only|deny
            items = {
                'luva-latex', 'lata-refrigerante', 'garrafa-pet', 'bateria-velha', 'barra-ferro'
            }
        },
        ['pony'] = {
            mode = 'only', -- only|deny
            items = { 'saco-roupa' }
        },
        ['taco'] = {
            mode = 'only', -- only|deny
            items = {
                'hamburguer', 'xburger', 'xsalada', 'xtudo', 'espetinho-camarao', 'caviar', 'milho', 'energetico', 'cafe',
                'cha-camomila', 'suco-caju', 'suco-kiwi', 'suco-morango', 'suco-abacaxi', 'suco-laranja', 'suco-maracuja',
                'suco-uva', 'suco-banana', 'suco-pessego', 'leite', 'queijo', 'iogurte', 'manteiga', 'pao-hamburguer',
                'baiacu', 'tilapia', 'camarao', 'robalo', 'cavala', 'sardinha', 'carapau', 'salmao', 'carpa', 'graos-cafe',
                'graos-guarana', 'camomila', 'morango', 'banana', 'abacaxi', 'espiga-milho', 'trigo', 'folha', 'casca-semente',
                'laranja', 'caju', 'maracuja', 'uva', 'pessego', 'kiwi', 'musculo-cru', 'maminha-cru', 'cupim-cru',
                'picanha-cru', 'costela-cru', 'sanduiche', 'soda', 'cola', 'pirulito', 'donut', 'chocolate', 'hotdog',
                'alface', 'tomate', 'salsired', 'rosqpau'
            }
        },
        
    },
}

config.plateFormat = 'LLL DLDD'

config.taxSafe = 0.05
config.taxDetained = 0.05
config.ipvaTax = 0.05
config.ipvaDays = 7

config.garageTax = 5000

config.interiors = {

    ['homes'] = {
        player = vec4(206.98,-999.06,-99.0,92.22),
        menu = vec4(206.189,-994.7604,-99.01465,314.6457),
        boxes = {
            vec4(202.87,-1004.2,-99.42,176.84),
            vec4(199.37,-1004.01,-99.42,176.84),
            vec4(195.88,-1003.82,-99.42,176.85),
            vec4(192.38,-1003.63,-99.42,176.84),
            vec4(192.52,-996.99,-99.42,176.45),
            vec4(196.02,-997.2,-99.42,176.45),
            vec4(199.51,-997.42,-99.42,176.45),
            vec4(203.0,-997.64,-99.42,176.45)
        },
        block = {
            ['mule'] = true,
            ['mule2'] = true,
            ['mule3'] = true,
            ['pounder'] = true,
            ['mb608d'] = true,
            ['caminhaozinho'] = true,
        }
    },

    ['apartment'] = {
        player = vec4(240.6,-1004.78,-98.99,87.84),
        menu = vec4(235.26,-976.26,-98.9,317.4803),
        boxes = {
            vec4(223.02,-1001.06,-99.42,242.85),
            vec4(223.2,-997.06,-99.42,241.76),
            vec4(223.38,-993.06,-99.42,241.76),
            vec4(223.55,-989.07,-99.42,241.76),
            vec4(223.73,-985.07,-99.42,241.76),
            vec4(223.91,-981.08,-99.42,241.76),
            vec4(233.54,-981.16,-99.42,115.28),
            vec4(233.51,-985.16,-99.42,115.28),
            vec4(233.48,-989.16,-99.42,115.28),
            vec4(233.45,-993.16,-99.42,115.28),
            vec4(233.42,-997.16,-99.42,115.28),
            vec4(233.39,-1001.16,-99.42,115.28)
        },
    },

    ['galaxy'] = {
        player = vec4(-1507.6,-3017.14,-79.24,9.9),
        menu = vec4(-1507.556, -3005.156, -81.55823, 5.669291),
        boxes = {
            vec4(-1497.39,-2998.42,-82.62,0.42),
            vec4(-1501.4,-2998.45,-82.63,0.42),
            vec4(-1505.4,-2998.47,-82.63,0.42),
            vec4(-1509.4,-2998.5,-82.63,0.42),
            vec4(-1513.4,-2998.53,-82.63,0.41),
            vec4(-1517.39,-2998.56,-82.63,0.42),
            vec4(-1517.42,-2988.13,-82.63,180.43),
            vec4(-1513.42,-2988.1,-82.63,180.43),
            vec4(-1509.42,-2988.07,-82.63,180.42),
            vec4(-1505.42,-2988.04,-82.63,180.43),
            vec4(-1501.42,-2988.01,-82.63,180.43),
            vec4(-1497.42,-2987.98,-82.62,180.41),
        },
    },

    ['newbunker'] = {
        player = vec4(824.6506, -2205.455, -49.00439, 272.126),
        menu = vec4(824.5846, -2211.732, -49.00439, 181.4173),
        boxes = {
            vec4(819.7187, -2213.512, -49.42566, 272.126),
            vec4(819.5209, -2219.051, -49.42566, 269.2914),
            vec4(819.8242, -2229.508, -49.42566, 226.7717),
            vec4(819.6396, -2238.897, -49.42566, 269.2914),
            vec4(819.5868, -2244.382, -49.42566, 269.2914),
            vec4(837.6791, -2216.585, -49.42566, 133.2283),
            vec4(837.7978, -2226.501, -49.42566, 87.87402),
            vec4(837.7978, -2232.066, -49.42566, 87.87402),
            vec4(837.4813, -2241.64, -49.42566, 42.51968)
        },
    }
}

config.garages = {
    -- [Publica favela] --
    {
        coords = vector3(-1504.734, 4956.25, 63.82202),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-1500.686, 4965.402, 63.46814, 348.6614)
        },
        tax = 'percent',
    },
    -- [Publica porto] --
    {
        coords = vector3(242.4527, -2940.211, 6.246094),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(235.9121, -2944.602, 5.926025, 192.7559)
        },
        tax = 'percent',
    },
    -- -- 
    {
        coords = vector3(525.9033, 5541.64, 778.2373),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(524.7429, 5535.416, 777.9678, 172.9134)
        },
        tax = 'percent',
    },
    -- Garagem Praca (Publica)
    {
        coords = vector3(117.5341, -1049.011, 29.19556),
        rule = 'carOnly',
        showBlip = true,
        interior = {         
            id = 'newbunker',
            parking = vector4(112.2198, -1053.758, 28.52161, 246.6142),
        },
        points = {}
    },
    {
        coords = vector3(11.57802, -5247.785, 7.476196),
        rule = 'carOnly',
        showBlip = true,
        interior = {         
            id = 'newbunker',
            parking = vector4(5.314286, -5248.141, 7.375122, 102.0472),
        },
        points = {}
    },
    -- Garagem Pier (Publica)
    {
        coords = vector4(-1603.978, -832.0352, 10.07104, 320.315),
        rule = 'carOnly',
        showBlip = true,
        interior = {         
            id = 'newbunker',
            parking = vector4(-1612.958, -818.4659, 9.632935, 45.35433)
        },
        points = {},
        tax = 'percent',
    },
    -- Garagem Aeroporto (Publica)
    {
        coords = vector4(-720.1978, -2235.178, 7.223389, 274.9606),
        rule = 'carOnly',
        showBlip = true,
        interior = {         
            id = 'newbunker',
            parking = vector4(-712.9451, -2228.809, 6.111328, 0)
        },
        points = {},
        tax = 'percent',
    },
    -- Garagem Sandy (Publica)
    {
        coords = vector4(182.7297, 2790.303, 45.6073, 357.1653),
        rule = 'carOnly',
        showBlip = true,
        interior = {         
            id = 'newbunker',
            parking = vector4(191.8813, 2787.521, 45.86011, 280.6299)
        },
        points = {},
        tax = 'percent',
    },
    -- Garagem Paleto (Publica)
    {
        coords = vector4(-223.3978, 6243.244, 31.48718, 45.35433),
        rule = 'carOnly',
        showBlip = true,
        interior = {         
            id = 'newbunker',
            parking = vector4(-226.6022, 6249.244, 31.04907, 76.53543)
        },
        points = {},
        tax = 'percent',
    },
    -- Garagem Grapeseed (Publica)
    {
        coords = vector4(2564.321, 4680.422, 34.06519, 48.18897),
        rule = 'carOnly',
        showBlip = true,
        interior = {         
            id = 'newbunker',
            parking  = vector4(2561.182, 4687.622, 34.2843, 68.03149)
        },
        points = {},
        tax = 'percent',
    },
    -- Garagem ManinaBeach (Publica)
    {
        coords = vector4(-441.8242, 7355.829, 6.532593, 2.834646),
        rule = 'carOnly',
        showBlip = true,
        interior = {         
            id = 'newbunker',
            parking = vector4(-432.0659, 7362.936, 6.498901, 345.8268)
        },
        points = {},
        tax = 'percent',
    },
    {
        coords = vector3(525.9033, 5541.64, 778.2373),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(524.7429, 5535.416, 777.9678, 172.9134)
        },
        tax = 'percent',
    },
    {
        coords = vector3(1621.319, 3564.475, 35.27844),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(1628.413, 3561.086, 35.21094, 280.6299)
        },
        tax = 'percent',
    },
    {
        coords = vector3(361.9912, 298.7077, 103.874),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(374.9539, 294.9231, 103.2675, 161.5748)
        },
        tax = 'percent',
    },
    {
        coords = vector3(1036.47, -763.2527, 57.99194),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(1046.519, -774.4352, 58.00879, 87.87402)
        },
        tax = 'percent',
    },
    {
        coords = vector3(-1184.189, -1509.613, 4.645386),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-1184.163, -1496.505, 4.375854, 306.1417)
        },
        tax = 'percent',
    },
    {
        coords = vector3(68.05714, 13.09451, 69.21387),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(63.69231, 15.95605, 69.09595, 337.3228)
        },
        tax = 'percent',
    },
    {
        coords = vector3(527.6703, -146.4264, 58.36267),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(536.8483, -136.6549, 59.54211, 175.748)
        },
        tax = 'percent',
    },
    
    -- ManinaBeach Bike
    {
        marker = 'bike',
        coords = vector3(-283.9384, 7167.877, 6.414673),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-291.4945, 7167.547, 6.397827, 93.5433),
        },
        vehicles = {
            'bmx',
            'tribike3',
            'tribike2',
        }
    },

        {
        marker = 'bike',
        coords = vector3(45.86374, -2793.152, 5.706909),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(35.36703, -2797.371, 0.8879395, 136.063),
        },
        vehicles = {
            'dinghy4',
        }
    },

    {
        marker = 'boat',
        coords = vector3(-371.4989, -5007.508, 4.527466) ,
        rule = 'boatsOnly',
        permission = 'policia.permissao',
        showBlip = true,
        points = {
            vector4(-384.0659, -5006.532, 0.1464844, 59.52755),
        },
        vehicles = {
            'predator',
        }
    },
    
    -- Aeroporto Bike
    {
        marker = 'bike',
        coords = vector3(-1034.413, -2675.433, 13.82861),
        rule = 'carOnly',
        showBlip = true,
        points = {
            vector4(-1040.426, -2674.167, 13.82861, 325.9843),
            vector4(-1042.497, -2671.873, 13.82861, 320.315),
            vector4(-1044.672, -2670.264, 13.82861, 314.6457)
        },
        vehicles = {
            'bmx',
            'tribike3',
            'tribike2',
        }
    },

    -- BARCOS ==================================================================
    {
        coords = vector3(-926.1627, 6490.352, 1.88208),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(-919.0417, 6490.708, 0.112793, 354.3307) 
        },
    },
    {
        coords = vector3(1495.332, 3834.857, 32.02637),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(1493.723, 3838.075, 30.17285, 328.8189)
        },
    },
    {
        coords = vector3(-1613.354, -1148.664, 1.376587),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(-1634.136, -1167.468, 0.112793, 127.5591)
        },
    },
    {
        coords = vector3(1298.848, -3130.035, 5.959717),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(1312.378, -3082.866, 1.494507, 189.9213)
        },
    },
    {
        coords = vector3(5124.567, -4639.49, 1.393433),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(5122.523, -4645.965, 0.2645264, 257.9528)
        },
    },
    {
        coords = vector3(-1604.993, 5257.477, 2.067383),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(-1600.708, 5261.051, 0.112793, 19.84252)
        },
    },
    
    -- ROTA ====================================================================
    {
        coords = vector3(-1207.187, -2316.29, 14.56995),
        rule = 'carOnly',
        permission = 'policia.permissao',
        interior = {         
            id = 'newbunker',
            parking = vector4(-1194.396, -2310.356, 14.41833, 331.6535),
        }, 
        points = {},
        vehicles = {
            'sw4revrota1',
            'trail2020rota1',
            'trail2020rota2',
        }
    },

    -- Policia Federal =========================================================
    {
        coords = vector3(2620.246, 5364.211, 47.29236),
        rule = 'carOnly',
        permission = 'policia.permissao',
        interior = {         
            id = 'newbunker',
            parking = vector4(2621.842, 5351.921, 47.3092, 189.9213),
        }, 
        points = {},
        vehicles = {
            'trail21federalg2',
            'flatbed',
            'tiger800prfe',
            'pcivictyperPRFE',
            'corvettepc'
        }
    },
    {
        coords = vector3(2618.229, 5368.563, 48.08423),
        rule = 'carOnly',
        permission = 'policia.permissao',
        marker = 'heli',
        points = {
            vector4(2615.13, 5371.991, 48.30334, 235.2756)
        },
        vehicles = {
            'heligeralprf'
        }
    },
    {
        coords = vector3(1840.365, 2545.991, 45.65784),
        rule = 'carOnly',
        permission = 'policia.permissao', 
        points = {
            vector4(1833.31, 2549.38, 45.87695, 269.2914)
        },
        vehicles = {
            'trail21federalg2',
            'flatbed',
            'tiger800prfe',
            'pcivictyperPRFE',
            'corvettepc'
        }
    },

    -- Policia Cidade Perfeita =========================================================
    -- Cidade perfeita --
    {
        coords = vector3(-190.3121, -5092.272, 6.178711),
        rule = 'carOnly',
        permission = 'hospital.permissao',
        points = {
            vector4(-197.7495, -5086.787, 6.195557, 85.03937)
        },
        vehicles = {
            'basecus',
            'ambulance'
        }
    },
    {
        coords = vector3(-72.22417, -4843.596, 18.09155),
        rule = 'carOnly',
        permission = 'pcp.permissao',  
        points = {
            vector4(-75.50769, -4838.94, 18.09155, 90.70866)
        },
        vehicles = {
            'tcrossft2',
            'corvettepmc2',
            'chernobog',
            'pbus'
        }
    },
    {
        coords = vector3(300.9626, -4191.205, 9.447632),
        rule = 'carOnly',
        permission = 'pcp.permissao',  
        points = {
            vector4(305.5385, -4199.895, 9.447632, 87.87402)
        },
        vehicles = {
            'tcrossft2',
            'corvettepmc2',
            'chernobog',
            'pbus'
        }
    },
    {
        coords = vector3(-142.0615, -5665.543, 4.915039),
        rule = 'carOnly',
        points = {
            vector4(-139.5033, -5668.154, 4.527466, 345.8268)
        },
        vehicles = {
            'taxi'
        }
    },
    --

    -- Policia Militar =========================================================
    { -- TATICA
        coords = vector3(824.0835, 153.5077, 83.33411),
        rule = 'carOnly',
        permission = 'policia.permissao',  
        points = {
            vector4(818.5714, 157.6615, 83.33411, 48.18897)
        },
        vehicles = {
            'tiger800ft',
            'tcrossft',
            'trail21cfp',
            'trail20ftcoral',
        }
    },
    {
        coords = vector3(-559.7538, -1039.688, 22.16919),
        rule = 'carOnly',
        permission = 'policia.permissao',  
        interior = {         
            id = 'newbunker',
            parking = vector4(-561.1121, -1036.431, 21.49524, 87.87402),
        },
        points = {},
        vehicles = {
            'duster21dpm1',
            'duster21rp',
            'spincgp',
            'spinrp1',
            'trail20cfp1',
            'trail21cfp',
            'xre19rpm',
            'basepm',
            'tiger800pm',
            'tcrosspmc',
            'capitalblindado',
            'pcivictyperGMC',
            'corvettepmc'
        }
    },
    {
        coords = vector3(-568.6022, -1063.081, 35.31213),
        rule = 'carOnly',
        permission = '+PMC.Soldado2',
        marker = 'heli',
        points = {
            vector4(-574.2198, -1057.886, 35.64905, 223.937)
        },
        vehicles = {
            'heligeral'
        }
    },
    {
        coords = vector3(1840.589, 2538.422, 45.65784),
        rule = 'carOnly',
        permission = 'policia.permissao',    
        points = {
            vector4(1832.914, 2542.141, 45.87695, 272.126)
        },
        vehicles = {
            'duster21dpm1',
            'duster21rp',
            'spincgp',
            'spinrp1',
            'trail20cfp1',
            'trail21cfp',
            'xre19rpm',
            'basepm',
            'tiger800pm',
            'tcrosspmc',
            'capitalblindado',
            'pcivictyperGMC',
            'corvettepmc'
        }
    },



    -- Policia Civil ===========================================================
    {
        coords = vector3(427.1736, -986.7297, 25.6908),
        rule = 'carOnly',
        points = {
            vector4(425.7099, -984.2242, 25.2865, 269.2914),
            vector4(425.4857, -981.6132, 25.2865, 272.126),
            vector4(425.5516, -978.8967, 25.2865, 272.126),
            vector4(425.7495, -976.2198, 25.2865, 272.126)
        },
    },
    {
        coords = vector3(427.1736, -986.7297, 25.6908),
        rule = 'carOnly',
        points = {
            vector4(446.5846, -996.8967, 25.30334, 272.126),
            vector4(445.5297, -988.8, 25.20215, 272.126),
            vector4(446.0308, -986.2813, 25.30334, 272.126),
            vector4(436.6549, -986.1362, 25.30334, 87.87402),
            vector4(436.8528, -988.7736, 25.30334, 87.87402),
            vector4(437.1429, -991.411, 25.30334, 87.87402),
            vector4(437.2615, -994.0747, 25.30334, 87.87402),
            vector4(437.2747, -996.9758, 25.30334, 87.87402),
        },

    }, 
    {
        coords = vector3(441.3495, -984.9099, 25.6908),
        rule = 'carOnly',
        permission = 'policia.permissao',
        points = {
            vector4(446.5846, -996.8967, 25.30334, 272.126),

            vector4(446.0308, -986.2813, 25.30334, 272.126),
            vector4(436.6549, -986.1362, 25.30334, 87.87402),
            vector4(436.8528, -988.7736, 25.30334, 87.87402),
            vector4(437.1429, -991.411, 25.30334, 87.87402),
            vector4(437.2615, -994.0747, 25.30334, 87.87402),
            vector4(437.2747, -996.9758, 25.30334, 87.87402),
        },
        vehicles = {
            'sw4pm',
            'corollapc',
            'trail22pc',
            'pcivictyper',
            'tiger800pc'
        }
    }, 
    {
        coords = vector3(1840.589, 2531.103, 45.65784),
        rule = 'carOnly',
        permission = 'policia.permissao', 
        points = {
            vector4(1832.769, 2534.387, 45.87695, 266.4567)
        },
        vehicles = {
            'sw4pm',
            'corollapc',
            'trail22pc',
            'pcivictyper',
            'tiger800pc'
        }
    }, 
    {
        coords = vector3(455.1033, -986.5978, 43.45056),
        rule = 'carOnly',
        permission = 'policia.permissao',
        marker = 'heli',
        points = {
            vector4(448.9978, -981.2703, 43.45056, 19.84252)
        },
        vehicles = {
            'heligeralpc'
        }
    },

    -- GCC ===========================================================
    {
        coords = vector3(683.1956, 269.0374, 93.78101),
        rule = 'carOnly',
        permission = 'policia.permissao',
        interior = {         
            id = 'newbunker',
            parking = vector4(681.8373, 261.2835, 93.78101, 144.5669),
        }, 
        points = {},
        vehicles = {
            'trail19gcm',
            'xre19gcm',
            'golpm',
            'corvettegcc',
            'tiger800gcc',
            'pcivictyperGCC'
        }
    },
    {
        coords = vector3(699.2571, 244.3517, 93.0564),
        rule = 'carOnly',
        permission = 'policia.permissao',
        marker = 'heli',
        points = {
            vector4(697.2659, 232.9319, 92.66882, 119.0551)
        },
        vehicles = {
            'heligeralgcc'
        }
    },

    -- BAEP ============================================================
    {
        coords = vector3(-459.6791, 6044.664, 31.67249),
        rule = 'carOnly',
        permission = 'policia.permissao',
        interior = {         
            id = 'newbunker',
            parking = vector4(-462.5011, 6035.697, 31.52087, 133.2283),
        },     
        points = {},
        vehicles = {
            'trailbaep4',
            'tiger800baec'
        }
    },

    -- EXERCITO ============================================================
    {
        coords = vector3(-2172.607, 3255.706, 32.80151),
        rule = 'carOnly',
        permission = 'exercito.permissao',   
        points = {
            vector4(-2160.739, 3256.417, 32.80151, 243.7795)
        },
        vehicles = {
            'barracks3',
            'crusader',
            'pcivictyperx',
            'corvettex',
            'trail19x',
            'rhino',
            'halftrack'
        }
    },
    {
        coords = vector3(-2244.422, 3324.119, 33.25647),
        rule = 'carOnly',
        permission = 'exercito.permissao',   
        points = {
            vector4(-2245.055, 3330.963, 33.00366, 249.4488)
        },
    },

    -- Mecânica ===========================================================
    {
        coords = vector3(918.6066, -932.0176, 42.69226),
        rule = 'carOnly',
        permission = 'mecanico.permissao',
        points = {
            vector4(917.2615, -944.6638, 42.69226, 269.2914)
        },
        vehicles = {
            'flatbed'
        }
    },
    {
        coords = vector3(947.8682, -972.3956, 39.2887),
        rule = 'carOnly',
        permission = 'mecanica.permissao',
        points = {
            vector4(934.4703, -972.0396, 39.54138, 87.87402)
        },
        vehicles = {
            'flatbed'
        }
    },
    {
        coords = vector3(1772.532, 3327.903, 41.42859),
        rule = 'carOnly',
        permission = 'palhacos.permissao',
        points = {
            vector4(1777.661, 3337.635, 41.09155, 294.8032)
        },
        vehicles = {
            'flatbed'
        }
    },
    {
        coords = vector3(1165.714, 2655.494, 38.00806),
        rule = 'carOnly',
        permission = 'bracho.permissao',
        interior = {         
            id = 'galaxy',
            parking = vector4(1169.459, 2664.87, 37.92383, 354.3307),
        }, 
        points = {},
        vehicles = {
            'flatbed'
        }
    },
    -- bracho heli
    {
        coords = vector3(2719.015, 3510.145, 62.62561),
        rule = 'carOnly',
        permission = 'bracho.permissao',
        rule = 'heliOnly',
        marker = 'heli',
        points = {
            vector4(2715.587, 3519.165, 63.28284, 155.9055)
        },
    },

    -- Hospital ===========================================================
    {
        coords = vector3(-2078.914, -481.833, 12.43005),
        rule = 'carOnly',
        permission = 'hospital.permissao',
        points = {
            vector4(-2082.963, -481.7407, 12.19409, 232.4409),
            vector4(-2086.325, -487.0417, 12.19409, 229.6063)
        },
        vehicles = {
            'basecus',
            'ambulance'
        }
    },
    {
        coords = vector3(1744.51, 3513.481, 36.74426),
        rule = 'carOnly',
        permission = 'hospital.permissao',
        points = {
            vector4(1742.677, 3517.82, 36.52527, 119.0551),
        },
        vehicles = {
            'basecus',
            'ambulance'
        }
    },
    {
        coords = vector3(-549.6528, 7368.725, 12.83447),
        rule = 'carOnly',
        permission = 'hospital.permissao',
        points = {
            vector4(-549.5341, 7372.022, 12.83447, 51.02362),
        },
        vehicles = {
            'basecus',
            'ambulance'
        }
    },
    {
        coords = vector3(-2094.435, -476.4264, 26.43225),
        rule = 'carOnly',
        permission = '+CUS.Medico',
        marker = 'heli',
        points = {
            vector4(-2098.457, -482.3473, 26.51648, 323.14959716797)
        },
        vehicles = {
            'heligeralcus'
        }
    },
    {
        coords = vector3(1770.712, 3526.444, 36.44104),
        rule = 'carOnly',
        permission = '+CUS.Medico',
        marker = 'heli',
        points = {
            vector4(1788.725, 3523.081, 38.4967, 28.34646)
        },
        vehicles = {
            'heligeralcus'
        }
    },
    {
        coords = vector3(-552.3165, 7379.723, 12.83447),
        rule = 'carOnly',
        permission = '+CUS.Medico',
        marker = 'heli',
        points = {
            vector4(-561.7978, 7379.776, 12.78394, 0)
        },
        vehicles = {
            'heligeralcus'
        }
    },


    -- Empregos ===========================================================
    {
        coords = vector3(714.3033, -979.1868, 24.10693),
        rule = 'carOnly',
        points = {
            vector4(712.9714, -981.6263, 24.14063, 226.7717),
            vector4(709.1736, -982.9319, 24.10693, 226.7717),
            vector4(704.2022, -982.7341, 24.10693, 229.6063)
        },
        vehicles = {
            'bison3'
        }
    }, 
    {
        coords = vector3(1191.705, -3249.336, 6.0271),
        rule = 'carOnly',
        points = {
            vector4(1187.051, -3246.105, 6.0271, 87.87402),
            vector4(1187.064, -3242.875, 6.0271, 87.87402),
            vector4(1186.998, -3239.855, 6.0271, 85.03937),
            vector4(1186.734, -3236.809, 6.0271, 87.87402)
        },
        vehicles = {
            'boxville4'
        }
    }, 
    {
        coords = vector3(1191.705, -3249.336, 6.0271),
        rule = 'carOnly',
        points = {
            vector4(1187.051, -3246.105, 6.0271, 87.87402),
            vector4(1187.064, -3242.875, 6.0271, 87.87402),
            vector4(1186.998, -3239.855, 6.0271, 85.03937),
            vector4(1186.734, -3236.809, 6.0271, 87.87402)
        },
        vehicles = {
            'boxville4'
        }
    }, 
    -- {
    --     coords = vector3(121.9253, 98.87473, 81.24463),
    --     rule = 'carOnly',
    --     points = {
    --         vector4(115.6747, 96.92308, 80.72229, 249.4488)
    --     },
    --     vehicles = {
    --         'boxville2'
    --     }
    -- }, 
    -- {
    --     coords = vector3(1998.791, 3063.982, 47.03955),
    --     rule = 'carOnly',
    --     points = {
    --         vector4(1994.018, 3062.4, 47.03955, 147.4016),
    --         vector4(1999.292, 3059.09, 47.03955, 144.5669)
    --     },
    --     vehicles = {
    --         'boxville'
    --     }
    -- }, 
    {
        coords = vector3(-1832.453, -1213.569, 13.00293),
        rule = 'carOnly',
        points = {
            vector4(-1836.844, -1217.473, 13.00293, 184.252)
        },
        vehicles = {
            'taco'
        }
    }, 
    {
        coords = vector3(921.6923, 3573.455, 33.50916),
        rule = 'carOnly',
        points = {
            vector4(924.0396, 3566.136, 33.77881, 178.5827)
        },
        vehicles = {
            'bison2'
        }
    }, 
    -- Safadasso
    {
        coords = vector3(-1099.055, -449.5516, 49.70178),
        permission = '+SafadassoJornal.Diretor',
        points = {
            vector4(-1091.248, -462.0923, 49.70178, 22.67716)
        },
        vehicles = { 'helisafadasso' }
    },
    {
        coords = vector3(-1041.64, -495.4286, 36.25574),
        permission = 'safadasso.permissao',
        points = {
            vector4(-1036.906, -492.0132, 36.55896, 209.7638),
            vector4(-1033.582, -490.4176, 36.81177, 206.9291),
        },
        vehicles = {
            'van_safadasso',
            'moto_safadasso'
        }
    },
    -- MPTV
    {
        coords = vector3(-569.2879, -932.189, 36.82861),
        permission = 'mptv.permissao',
        points = {
            vector4(-583.1341, -930.4088, 36.82861, 85.03937)
        },
        vehicles = { 'mptv_heli' }
    },
    {
        coords = vector3(-558.7648, -921.0989, 23.87109),
        permission = 'mptv.permissao',
        points = {
            vector4(-556.1539, -929.367, 23.85425, 269.2914),
            vector4(-556.7604, -933.8242, 23.8374, 269.2914),
        },
        vehicles = {
            'mptv_van',
            --'mptv_moto'
        }
    },

    {
        coords = vector3(895.9121, -178.7341, 74.69006),
        rule = 'carOnly',
        points = {
            vector4(899.6044, -180.8439, 73.44324, 240.9449),
            vector4(897.6, -183.7714, 73.35901, 238.1102),
        },
        vehicles = {
            'taxi'
        }
    },
    {
        coords = vector3(403.3319, -1627.279, 29.27991),
        rule = nil,
        points = {
            vector4(405.5736, -1637.802, 29.27991, 235.2756)
        },
        vehicles = {
            'flatbed'
        }
    },
    {
        coords = vector3(430.2857, 3574.101, 33.22266),
        rule = nil,
        points = {
            vector4(422.8088, 3573.982, 33.22266, 340.1575)
        },
        vehicles = {
            'flatbed'
        }
    },
    {
        coords = vector3(-469.5692, -1721.697, 18.68127),
        rule = nil,
        points = {
            vector4(-457.5428, -1713.864, 18.63074, 308.9764)
        },
        vehicles = {
            'trash2'
        }
    },

    {
        coords = vector3(3836.519, -44.04395, 2.269653),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(3838.971, -47.61758, 0.04541016, 99.21259)
        },
    },
    {
        coords = vector3(2840.413, -687.0857, 0.8037109),
        rule = 'boatsOnly',
        showBlip = true,
        points = {
            vector4(2844.461, -681.2176, -0.05566406, 291.9685)
        },
    },
    {
        showBlip = true,
        coords = vector3(2557.055, -599.789, 64.84985),
        rule = 'carOnly',
        points = {
            vector4(2565.086, -593.8022, 65.18677, 99.21259)
        }
    },

    -- [ Laricas ] --
    {
        showBlip = true,
        coords = vector3(-1839.613, -1241.328, 13.00293),
        rule = 'carOnly',
        points = {
            vector4(-1832.308, -1246.233, 12.58167, 354.3307),
            vector4(-1836.462, -1243.727, 12.58167, 354.3307)
        },
    },

    -- [ Telasco ] --
    {
        showBlip = false,
        coords = vector3(-263.0505, 202.9583, 85.37292),
        rule = 'carOnly',
        points = {
            vector4(-264.4484, 197.2615, 85.32239, 277.7953)
        },
        permission = 'mptv.permissao',
        vehicles = { 'mptv_van', 'mptv_moto' }
    },
    -- [MDS] -- 
    {
        showBlip = true,
        coords = vector3(1791.534, 423.0461, 172.9583),
        rule = 'carOnly',
        points = {
            vector4(1788.686, 421.0154, 173.0425, 19.84252)
        },
        permission = 'mds.permissao',
    },
    -- [CDD] -- 
    {
        showBlip = true,
        coords = vector3(1516.075, 1599.073, 113.1919),
        rule = 'carOnly',
        points = {
            vector4(1516.787, 1592.479, 113.0403, 90.70866)
        },
        permission = 'cdd.permissao',
    },
    -- [Juramento] -- 
    {
        showBlip = true,
        coords = vector3(2674.312, -751.3582, 37.90698),
        rule = 'carOnly',
        points = {
            vector4(2674.299, -744.1055, 37.92383, 48.18897)
        },
        permission = 'juramento.permissao',
    },
    -- [Hydra] -- 
    {
        showBlip = true,
        coords = vector3(-838.8659, 7157.631, 99.74573),
        rule = 'carOnly',
        points = {
            vector4(-848.3209, 7165.569, 99.67834, 351.4961)
        },
        permission = 'hydra.permissao',
    },
    -- [Ratinha] -- 
    {
        showBlip = true,
        coords = vector3(3073.583, 2207.393, 1.646118),
        rule = 'boatsOnly',
        points = {
            vector4(3079.583, 2204.268, 1.191162, 189.9213)
        },
        vehicles = { 'dinghy2' },
        permission = 'ima.permissao',
    },
    -- [CosaNostra] -- 
    {
        showBlip = true,
        coords = vector3(3100.062, 5438.294, 23.58459),
        rule = 'carOnly',
        points = {
            vector4(3102.699, 5432.215, 23.58459, 272.126)
        },
        permission = 'cosanostra.permissao',
    },
    -- [Galaxy] -- 
    {
        showBlip =false,
        coords = vector3(-248.9934, -336.4615, 29.95386),
        rule = 'carOnly',
        points = {
            vector4(-256.7473, -336.4615, 29.85278, 8.503937)
        },
        permission = 'galaxy.permissao',
    },
    -- [Dende] -- 
    {
        showBlip = true,
        coords = vector3(2448.277, 3819.956, 43.3158),
        rule = 'carOnly',
        points = {
            vector4(2451.468, 3812.242, 42.3385, 127.5591)
        },
        permission = 'dende.permissao',
    },
    -- [Turano] -- 
    {
        showBlip = true,
        coords = vector3(2058.686, -2.663731, 212.5553),
        rule = 'carOnly',
        points = {
            vector4(2060.097, -5.630764, 212.5385, 286.2992)
        },
        permission = 'turano.permissao',
    },
    -- [Venezza] -- 
    {
        showBlip = true,
        coords = vector3(-474.1846, 51.36264, 52.41467),
        rule = 'carOnly',
        points = {
            vector4(-478.7209, 41.3011, 52.04395, 36.8504)
        },
        permission = 'venezza.permissao',
    },
    -- [Underdogs] -- 
    {
        showBlip = false,
        coords = vector3(152.9407, -1303.345, 29.19556),
        rule = 'carOnly',
        points = {
            vector4(144.5407, -1302.554, 28.90918, 113.3858)
        },
        permission = 'underdogs.permissao',
    },
    -- [Mantem] -- 
    {
        showBlip = true,
        coords = vector3(789.3627, -297.9297, 60.19922),
        rule = 'carOnly',
        points = {
            vector4(783.1517, -299.5385, 59.87915, 124.7244)
        },
        permission = 'mantem.permissao',
    },
    -- [OsVeio] -- 
    {
        showBlip = true,
        coords = vector3(-1536.198, 98.07033, 56.76196),
        rule = 'carOnly',
        points = {
            vector4(-1525.925, 91.7011, 56.526, 260.7874)
        },
        permission = 'osveio.permissao',
    },
    -- [Caixa D`agua] -- 
    {
        showBlip = true,
        coords = vector3(-845.4462, -1841.552, 28.0835),
        rule = 'carOnly',
        points = {
            vector4(-842.6769, -1837.965, 27.69592, 238.1102)
        },
        permission = 'agua.permissao',
    },
    -- [Reciclagem] -- 
    {
        showBlip = true,
        coords = vector3(-631.3978, -1649.209, 25.96045),
        rule = 'carOnly',
        points = {
            vector4(-636.3165, -1656.053, 25.13477, 243.7795),
            vector4(-634.2857, -1651.714, 25.13477, 240.9449),
            vector4(-626.611, -1661.631, 25.13477, 59.52755),
            vector4(-625.6088, -1657.464, 25.13477, 59.52755),
            vector4(-622.9319, -1653.376, 25.13477, 56.69291),
            vector4(-620.5582, -1649.367, 25.13477, 59.52755),
            vector4(-618.5802, -1645.477, 25.13477, 59.52755)
        },
        permission = 'reciclagem.permissao',
    },
    -- [Ciringa] -- 
    {
        showBlip = false,
        coords = vector3(411.7582, 1775.815, 188.3759),
        rule = 'carOnly',
        points = {
            vector4(411.0461, 1770.251, 188.3759, 161.5748),
        },
        permission = 'ciringa.permissao',
    },
    -- [Sindicato] -- 
    {
        showBlip = false,
        coords = vector3(-1140.541, -1971.231, 13.15454),
        rule = 'carOnly',
        points = {
            vector4(-1147.345, -1976.505, 13.15454, 238.1102),
        },
        permission = 'sindicato.permissao',
    },
    -- [trevor] -- 
    {
        showBlip = false,
        coords = vector3(263.578, -3165.917, 5.774414),
        rule = 'carOnly',
        points = {
            vector4(268.0483, -3163.424, 5.774414, 274.9606),
        },
        permission = 'caos.permissao',
    },
    -- [Ratoeira] -- 
    {
        showBlip = false,
        coords = vector3(-1704.672, 942.9231, 177.6088),
        rule = 'carOnly',
        points = {
            vector4(-1700.004, 939.0066, 177.6088, 314.6457)
        },
        permission = 'ratoeira.permissao',
    },
    -- [BennysTunner] --
    {
        showBlip = false,
        coords = vector3(-396.0659, -116.9407, 38.66516),
        rule = 'carOnly',
        points = {
            vector4(-388.589, -116.6505, 38.10913, 300.4724),
            vector4(-386.9143, -119.9077, 38.12598, 300.4724),
            vector4(-384.5143, -122.5319, 38.12598, 300.4724)
        },
        permission = 'bennystunner.permissao',
    },
    -- [Borracharia] --
    {
        showBlip = false,
        coords = vector3(963.1912, -963.9561, 59.104),
        rule = 'heliOnly',
        points = {
            vector4(954.3693, -970.9846, 59.104, 5.669291),

        },
        permission = '+Borracharia.ViceLider',
    },
    {
        showBlip = false,
        coords = vector3(956.6769, -934.022, 59.08716),
        rule = 'carOnly',
        points = {
            vector4(952.3649, -948.2242, 59.104, 354.3307),

        },
        permission = 'mecanica.permissao',
    },
    
    -- [ Paleto ] --
    {
        showBlip = true,
        coords = vector3(-767.7363, 5580.738, 33.59338),
        rule = 'carOnly',
        points = {
           vector4(-772.9978, 5578.312, 32.71716, 87.87402),
           vector4(-774.0791, 5575.319, 32.71716, 87.87402),
           vector4(-773.6703, 5572.431, 32.71716, 87.87402)
        },
    },
    -- [ Tribunal ] --
    {
        showBlip = true,
        coords = vector3(223.9648, -367.5165, 44.24243),
        rule = 'carOnly',
        points = {
           vector4(227.5912, -365.644, 43.73694, 314.6457),
           vector4(231.4549, -367.1868, 43.7876, 325.9843)
        },
    },
    -- [ Barragem ] --
    {
        showBlip = false,
        coords = vector3(1258.193, -81.21758, 61.76636),
        rule = 'carOnly',
        points = {
           vector4(1256.703, -78.68571, 61.61462, 141.7323)
        },
        permission = 'barragem.permissao',
    }, 
    -- [ Dinastia ] -- 
    {
        showBlip = false,
        coords = vector3(1385.815, -730.6813, 67.17505),
        rule = 'carOnly',
        points = {
            vector4(1388.571, -740.7429, 67.07397, 79.37008)
        },
        permission = 'dinastia.permissao',
    }, 
    -- [ Teste ] -- 
    -- {
    --     showBlip = false,
    --     coords = vector3(4977.547, -5699.328, 19.87769),
    --     rule = 'carOnly',
    --     points = {
    --        vector4(4973.934, -5702.98, 19.87769, 127.5591)
    --     },
    -- }, 
    -- [ Ghost ] -- 
    {
        showBlip = false,
        coords = vector3(-2937.27, 38.83517, 11.60437),
        rule = 'carOnly',
        points = {
            vector4(-2939.354, 44.95385, 11.82349, 25.51181)
        },
        permission = 'ghost.permissao',
    }, 
    -- [ Boiadeiras ] -- 
    {
        showBlip = false,
        coords = vector3(1373.288, 1151.393, 113.748),
        rule = 'carOnly',
        points = {
            vector4(1366.47, 1154.281, 113.1919, 76.53543)
        },
        permission = 'boiadeiras.permissao',
    }, 
    -- [ Os Crias ] -- 
    {
        showBlip = false,
        coords = vector3(-3272.941, 527.8286, 12.2616),
        rule = 'carOnly',
        points = {
            vector4(-3278.848, 525.7451, 12.2616, 127.5591)
        },
        permission = 'oscrias.permissao',
    }, 
    -- [ Cupim ] -- 
    {
        showBlip = false,
        coords = vector3(-785.2747, -2563.055, 13.94653),
        rule = 'carOnly',
        points = {
            vector4(-777.3494, -2562.277, 13.94653, 153.0709),
        },
        permission = 'cupim.permissao',
    }, 
    -- [ Morro Mina ] -- 
    {
        showBlip = false,
        coords = vector3(2887.042, 2745.125, 70.03955),
        rule = 'carOnly',
        points = {
            vector4(2884.272, 2742.949, 69.80371, 31.1811),
        },
        permission = 'morromina.permissao',
    }, 
    -- [ Trevor ] -- 
    {
        showBlip = false,
        coords = vector3(171.178, -3184.114, 5.79126),
        rule = 'carOnly',
        points = {
            vector4(163.6088, -3175.385, 5.926025, 274.9606)
        },
        permission = 'caos.permissao',
    }, 
    -- [ Motoclub ] -- 
    {
        showBlip = false,
        coords = vector3(146.5978, 311.8681, 112.1472),
        rule = 'carOnly',
        points = {
            vector4(142.1143, 308.822, 112.1135, 110.5512)
        },
        permission = 'motoclub.permissao',
    }, 
    -- [ Penha ] -- 
    {
        showBlip = false,
        coords = vector3(1320.541, -1030.352, 42.50696),
        rule = 'carOnly',
        points = {
            vector4(1317.758, -1025.393, 42.38904, 107.7165)
        },
        permission = 'penha.permissao',
    }, 
    -- [ Irmandade ] -- 
    {
        showBlip = false,
        coords = vector3(-564.8571, 298.2462, 83.06445),
        rule = 'carOnly',
        points = {
            vector4(-561.5341, 302.1626, 83.16553, 274.9606)
        },
        permission = 'irmandade.permissao',
    }, 
    -- [ Bahamas ] -- 
    {
        showBlip = false,
        coords = vector3(-1372.958, -586.4308, 29.83594),
        rule = 'carOnly',
        points = {
            vector4(-1369.965, -584.8879, 29.7179, 25.51181)
        },
        permission = 'bahamas.permissao',
    }, 
    -- [ Cartel NPN ] -- 
    {
        showBlip = false,
        coords = vector3(1670.677, -2085.877, 100.8916),
        rule = 'carOnly',
        points = {
            vector4(1665.969, -2081.354, 100.3861, 0)
        },
        permission = 'cartelnpn.permissao',
    }, 
    -- [ Los Praca ] -- 
    {
        showBlip = false,
        coords = vector3(-1526.505, 886.233, 181.7539),
        rule = 'carOnly',
        points = {
            vector4(-1534.549, 888.7121, 181.7876, 201.2598)
        },
        permission = 'lospraca.permissao',
    }, 
    -- [ Phoenix ] -- 
    {
        showBlip = false,
        coords = vector3(1317.626, -1682.202, 65.91138),
        rule = 'carOnly',
        points = {
            vector4(1321.556, -1677.402, 65.5575, 161.5748) 
        },
        permission = 'phoenix.permissao',
    }, 
    -- [ Umbrella ] -- 
    {
        showBlip = false,
        coords = vector3(-1553.974, 4881.758, 62.74365),
        rule = 'carOnly',
        points = {
            vector4(-1550.637, 4878.804, 62.40662, 136.063) 
        },
        permission = 'umbrella.permissao',
    }, 
    -- [ La Fronteira ] -- 
    {
        showBlip = false,
        coords = vector3(-1852.892, 4504.154, 23.56775),
        rule = 'carOnly',
        points = {
            vector4(-1850.031, 4500.488, 23.24756, 260.7874)
        },
        permission = 'lafronteira.permissao',
    }, 
    -- [ Aztecas ] -- 
    {
        showBlip = false,
        coords = vector3(-250.7341, 1561.833, 338.2719),
        rule = 'carOnly',
        points = {
            vector4(-255.4681, 1558.681, 337.6989, 167.2441)
        },
        permission = 'aztecas.permissao',
    }, 


    -- [ Medelin Nova ] -- 
    {
        showBlip = false,
        coords = vector3(906.3956, 2043.455, 64.1084),
        rule = 'carOnly',
        points = {
            vector4(901.6879, 2039.895, 63.73779, 53.85827)
        },
        permission = 'medelin.permissao',
    }, 

    -- [ DubaiGang ] -- 
    {
        showBlip = false,
        coords = vector3(-158.7297, -35.32747, 53.08862),
        rule = 'carOnly',
        points = {
            vector4(-164.4132, -32.67692, 52.26306, 155.9055)
        },
        permission = 'dubaigang.permissao',
    }, 
    -- [ Casa Arquiteto ] -- 
    {
        showBlip = false,
        coords = vector3(-1247.288, 835.556, 192.5209),
        rule = 'carOnly',
        points = {
            vector4(-1258.352, 840.8571, 191.6783, 68.03149)
        },
        permission = 'staff.permissao',
    }, 
    -- [ Casa ilha ] -- 
    {
        showBlip = false,
        coords = vector3(4994.637, -5736.369, 19.87769),
        rule = 'carOnly',
        points = {
            vector4(4991.908, -5726.848, 19.87769, 5.669291)
        },
        permission = 'staff.permissao',
    }, 
    -- an4log
    {
        showBlip = false,
        coords = vector3(-779.9341, -3251.789, 14.13184),
        rule = 'carOnly',
        points = {
            vector4(-786.3956, -3250.272, 13.92969, 65.19685)
        },
        permission = 'staff.permissao',
    }, 
    {
        showBlip = true,
        coords = vector3(4974, -5592.923, 24.61243),
        rule = 'carOnly',
        points = {
            vector4(4975.688, -5588.387, 24.15747, 68.03149)
        },
    }, 
    -- [ Comando do norte ] -- 
    {
        showBlip = false,
        coords = vector3(736.5626, 2508.646, 72.93774),
        rule = 'carOnly',
        points = {
            vector4(738.0396, 2513.802, 73.20728, 266.4567)
        },
        permission = 'comandonorte.permissao',
    }, 

    -- [ Mare ] -- 
    {
        showBlip = false,
        coords = vector3(-1152.264, -1735.121, 4.308472),
        rule = 'carOnly',
        points = {
            vector4(-1153.147, -1740.448, 3.684937, 34.01575)
        },
        permission = 'mare.permissao',
    }, 

    -- [ Bras ] -- 
    {
        showBlip = false,
        coords = vector3(1367.182, 3616.589, 35.00879),
        rule = 'carOnly',
        points = {
            vector4(1359.02, 3619.108, 34.87402, 283.4646)
        },
        permission = 'bras.permissao',
    }, 

    -- [ Helipa ] -- 
    {
        showBlip = false,
        coords = vector3(-119.7099, 1938.646, 136.7311),
        rule = 'carOnly',
        points = {
            vector4(-128.5978, 1935.284, 136.7311, 178.5827)
        },
        permission = 'helipa.permissao',
    }, 

    -- [ MonteCristo ] -- 
    {
        showBlip = false,
        coords = vector3(325.1604, -2733.218, 5.976563),
        rule = 'carOnly',
        points = {
            vector4(320.0967, -2729.697, 5.976563, 102.0472) 
        },
        permission = 'montecristo.permissao',
    }, 


    -- [ OsCrias Novas ] -- 
    {
        showBlip = false,
        coords = vector3(-1043.367, -222.9363, 37.8396),
        rule = 'carOnly',
        points = {
            vector4(-1048.193, -220.1275, 37.89014, 274.9606)
        },
        permission = 'oscrias.permissao',
    }, 
    -- [ Comitiva ] -- 
    {
        showBlip = false,
        coords = vector3(-224.7429, -1297.147, 31.28503),
        rule = 'carOnly',
        points = {
            vector4(-225.2967, -1286.888, 31.28503, 212.5984)
        },
        permission = 'comitiva.permissao',
    }, 
    -- [ The Fusion ] -- 
    {
        showBlip = false,
        coords = vector3(360.2374, -25.2923, 82.98022),
        rule = 'carOnly',
        points = {
            vector4(355.2132, -15.75824, 82.99707, 308.9764)
        },
        permission = 'thefusion.permissao',
    }, 
    -- [ Bando Dos Gauchos ] -- 
    {
        showBlip = false,
        coords = vector3(-1095.152, 4952.967, 218.1494),
        rule = 'carOnly',
        points = {
            vector4(-1092.593, 4941.429, 218.3517, 161.5748)
        },
        permission = 'bandodosgauchos.permissao',
    }, 

    -- [ K10 ] -- 
    {
        showBlip = false,
        coords = vector3(-980.4528, -267.1253, 38.3114),
        rule = 'carOnly',
        points = {
            vector4(-972.8967, -270.6198, 38.29456, 229.6063)
        },
        permission = 'k10.permissao',
    }, 

    -- [ Malibu ] --
    {
        coords = vector3(-3208.352, 836.0308, 8.925293),
        rule = 'carOnly',
        points = {
           vector4(-3213.837, 831.6396, 8.925293, 215.4331)
        },
        home = 'Malibu'
    }, 
    -- [ Modern ] --
    {
        coords = vector3(-1748.11, 364.8528, 89.72009),
        rule = 'carOnly',
        points = {
           vector4(-1753.029, 364.1011, 89.60217, 113.3858)
        },
        home = 'Modern'
    },
    -- [ LakeEast ] --
    {
        coords = vector3(-110.0044, 830.4923, 235.7069),
        rule = 'carOnly',
        points = {
           vector4(-107.1033, 838.2593, 235.7576, 0)
        },
        home = 'Lakeeast'
    }, 
    -- [ Marlowe ] --
    {
        coords = vector3(-690.0396, 959.6967, 238.723),
        rule = 'carOnly',
        points = {
           vector4(-689.3538, 969.7187, 238.8411, 19.84252)
        },
        home = 'Marlowe'
    }, 
    -- [ Laranjas ] --
    {
        coords = vector3(-1782.791, 452.5978, 128.2726),
        rule = 'carOnly',
        points = {
            vector4(-1788.87, 456.8571, 127.8513, 90.70866)
        },
        home = 'Laranjas'
    }, 
    -- [ Picture ] --
    {
        coords = vector3(-717.5736, 500.8747, 109.266),
        rule = 'carOnly',
        points = {
            vector4(-712.9714, 489.3099, 108.811, 206.9291)
        },
        home = 'Picture'
    }, 
    -- [ South ] --
    {
        coords = vector3(-824.123, 268.022, 86.18164),
        rule = 'carOnly',
        points = {
            vector4(-824.0703, 275.8022, 86.4176, 340.1575)
        },
        home = 'South'
    }, 
    -- [ CoberturaSaoPaulo ] --
    {
        coords = vector3(-318.0527, -741.666, 28.01611),
        rule = 'carOnly',
        points = {
           vector4(-315.1516, -734.8879, 28.01611, 334.4882) 
        },
        home = 'Coberturasaopaulo'
    },
    -- [ LakeNorth ] --
    {
        coords = vector3(2565.244, 6176.624, 163.7245),
        rule = 'carOnly',
        points = {
            vector4(2570.439, 6179.275, 163.6234, 8.503937)
        },
        home = 'Lakenorth'
    },
    -- [ Lago ] --
    {
        coords = vector3(-128.2022, 1009.371, 235.7238),
        rule = 'carOnly',
        points = {
            vector4(-129.4681, 1002.066, 235.3026, 201.2598)
        },
        home = 'Lago'
    },

    -- [ Island01 ] --
    {
        coords = vector3(-3883.068, -1128.58, 2.168457),
        rule = 'boatsOnly',
        points = {
            vector4(-3884.334, -1131.692, 1.966309, 240.9449)
        },
        home = 'Island01'
    },
    -- [ Island02 ] --
    {
        coords = vector3(-5814.343, 1140.04, 1.393433),
        rule = 'boatsOnly',
        points = {
            vector4(-5804.664, 1143.6, 0.01171875, 272.126)
        },
        home = 'Island02'
    },
    -- [ ZancudoBeach ] --
    {
        coords = vector3(-2521.675, 3743.143, 13.08716),
        rule = 'carOnly',
        points = {
            vector4(-2524.391, 3747.165, 13.17139, 172.9134)
        },
        home = 'ZancudoBeach'
    },
    -- [ Villa ] --
    {
        coords = vector3(-2587.464, 1927.121, 167.2968),
        rule = 'carOnly',
        points = {
            vector4(-2587.147, 1931.182, 166.8755, 277.7953)
        },
        home = 'Villa'
    },
    -- [ Rooftop01 ] --
    {
        coords = vector3(-801.6, 307.1736, 85.97949),
        rule = 'carOnly',
        points = {
            vector4(-798.6594, 304.1143, 85.27185, 175.748)
        },
        home = 'Rooftop01'
    },
    -- [ Majesty ] --
    {
        coords = vector3(579.1121, 769.1341, 203.0015),
        rule = 'carOnly',
        points = {
            vector4(576.4484, 765.0198, 202.5634, 28.34646)
        },
        home = 'Majesty'
    },
    
    -- [ Cayo Perico ] --
    {
        coords = vector3(3923.723, -4712.782, 4.19043),
        rule = 'carOnly',
        points = {
            vector4(3921.073, -4702.246, 4.207275, 291.9685)
        },
    }, 

    -- [ Heli Publico ] --
    {
        coords = vector3(-3417.283, 541.0286, 10.57654),
        rule = 'heliOnly',
        points = {
            vector4(-3430.088, 542.0703, 10.77881, 252.2835)
        }
    },
    {
        coords = vector3(-1123.477, -2877.837, 13.92969),
        rule = 'heliOnly',
        points = {
            vector4(-1112.374, -2883.917, 13.92969, 331.6535)
        }
    },
    {
        coords = vector3(-1156.048, -2859.007, 13.92969),
        rule = 'heliOnly',
        points = {
            vector4(-1145.921, -2864.664, 13.92969, 331.6535)
        }
    },
    {
        coords = vector3(-1187.829, -2840.413, 13.92969),
        rule = 'heliOnly',
        points = {
            vector4(-1178.374, -2845.767, 13.92969, 331.6535)
        }
    },

    -- [ Caçador ] --
    {
        coords = vector3(-672.4088, 5826.369, 17.31653),
        rule = 'carOnly',
        points = {
            vector4(-682.1274, 5826.686, 17.31653, 130.3937) 
        },
        vehicles = { 'mule2' }
    }, 

    -- 
    {
        coords = vector3(-2146.55, 3031.305, 32.80151),
        rule = 'heliOnly',
        permission = 'exercito.permissao',
        points = {
            vector4(-2146.998, 3016.536, 35.73328, 331.6535)
        }
    },

    {
        showBlip = false,
        coords = vector3(-2112.396, 3238.536, 32.80151),
        rule = 'carOnly',
        points = {
            vector4(-2130.686, 3252.949, 32.80151, 90.70866)
        },
        vehicles = {
            'barracks',
            'crusader',
            'cargobob4',
            'valkyrie'
        },
        permission = 'policia.permissao',
    }, 

    -- [ Caminhoneiro ] --
    {
        coords = vector3(1245.547, -3168.646, 5.572144),
        rule = 'carOnly',
        marker = 'truck',
        points = {
            vector4(1245.059, -3155.723, 5.723755, 272.126),
            vector4(1244.875, -3149.314, 5.723755, 272.126),
            vector4(1245.178, -3142.062, 5.723755, 269.2914),
            vector4(1244.967, -3135.534, 5.723755, 269.29),
        },
        vehicles = { 'packer' }
    }, 
    -- [ Lavanderia ] --
    {
        coords = vector3(1121.341, -990.1846, 46.09595),
        rule = 'carOnly',
        points = {
            vector4(1117.886, -984.7912, 46.09595, 2.834646)
        },
        vehicles = { 'pony' }
    },

    -- [ Apartamentos ] --
    {
        coords = vector3(-1459.622, -505.9517, 32.06006),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(-1458.87, -495.5868, 32.66663, 351.4961) },
        points = {},
        home = 'Pierro'
    },
    {
        coords = vector3(-790.3121, 307.9648, 85.69299),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(-796.1671, 303.8374, 85.42346, 181.4173) },
        points = {},
        home = 'Eclipse'
    },
    {
        coords = vector3(124.8791, -1112.993, 29.29675),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(120.4615, -1117.108, 28.89233, 178.5827) },
        points = {},
        home = 'Sachs'
    },
    -- Imperial
    -- Templar
    -- Laundry
    -- Boulevard
    -- Orange
    -- Elkridge
    -- Emissary
    -- Strawberry
    -- Alesandro
    {
        coords = vector3(-263.9736, -959.8681, 31.21753),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(-274.8264, -998.0571, 25.1853, 252.2835) },
        points = {},
        home = 'Alta'
    },
    {
        coords = vector3(-47.57802, -585.9956, 37.94067),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(-23.3934, -625.3582, 35.39636, 252.2835) },
        points = {},
        home = 'Integrity'
    },
    -- Hawick
    {
        coords = vector3(-58.14066, 164.0703, 81.48059),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(-61.18681, 165.4813, 81.07617, 121.8898) },
        points = {},
        home = 'Elgin'
    },
    {
        coords = vector3(-620.9802, 46.21978, 43.58533),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(-642.3297, 57.05934, 43.70325, 85.03937) },
        points = {},
        home = 'Tinsel'
    },
    {
        coords = vector3(335.0374, -71.35384, 73.02197),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(361.9912, -78.85714, 67.00659, 252.2835) },
        points = {},
        home = 'Garden'
    },
    {
        coords = vector3(-1284.237, 297.2967, 64.93408),
        rule = 'carOnly',
        points = { vector4(-1285.727, 294.6857, 64.5802, 59.52755) },
        home = 'Richman'
    },
    {
        coords = vector3(-1207.978, -133.9253, 40.97363),
        rule = 'carOnly',
        points = { vector4(-1206.369, -131.3011, 40.61975, 243.7795) },
        home = 'Crasten'
    },
    {
        coords = vector3(-1878.752, -324.2901, 49.36487),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(-1881.666, -307.7802, 48.96045, 70.86614) },
        points = {},
        home = 'Grasten'
    },
    {
        coords = vector3(-1878.752, -324.2901, 49.36487),
        rule = 'carOnly',
        interior = { id = 'homes', parking = vector4(-1881.666, -307.7802, 48.96045, 70.86614) },
        points = {},
        home = 'Grasten'
    },
    {
        coords = vector3(-1997.842, -304.0615, 48.10107),
        rule = 'carOnly',
        points = { vector4(-1992.396, -303.9561, 47.83154, 238.1102) },
        home = 'Jetty'
    },
    {
        coords = vector3(-1361.552, -1077.956, 3.600708),
        rule = 'carOnly',
        points = { vector4(-1369.16, -1088.914, 3.904053, 28.34646) },
        home = 'Venetian'
    },
    
    {
        coords = vector3(-70.61539, 359.1429, 112.4337),
        rule = 'carOnly',
        points = { vector4(-79.46373, 360.1451, 112.1641, 246.6142) },
        home = 'Gentry'
    },
}

config.rules = {
    ['carOnly'] = {
        ['show_classes'] = nil,
        ['hide_classes'] = { ['planes'] = true, ['helicopters'] = true, ['boats'] = true }
    },
    ['heliOnly'] = {
        ['show_classes'] = { ['helicopters'] = true },
        ['hide_classes'] = nil
    },
    ['planeOnly'] = {
        ['show_classes'] = { ['planes'] = true },
        ['hide_classes'] = nil
    },
    ['boatsOnly'] = {
        ['show_classes'] = { ['boats'] = true },
        ['hide_classes'] = nil
    },
}

config.clonePlates = {
    { rented = 0, service = 0, id = 990099, plate = 'ULC02F17', user_id = 142922, firstname = 'Dario', lastname = 'Cruz', phone = '866-2181', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'LHZ07W25', user_id = 140323, firstname = 'Zara', lastname = 'Pires', phone = '173-2923', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'LRT00X84', user_id = 142922, firstname = 'Elio', lastname = 'Vasconcelos', phone = '178-2767', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'PVG02R92', user_id = 140323, firstname = 'Alba', lastname = 'Teixeira', phone = '210=2088', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'BKE05E30', user_id = 142922, firstname = 'Ciro', lastname = 'Lima', phone = '215-2014', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'FBW09B13', user_id = 140323, firstname = 'Icaro', lastname = 'Barros', phone = '765-2042', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'LNB09X95', user_id = 142922, firstname = 'Eros', lastname = 'Branco', phone = '6242-255', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'VMT03X11', user_id = 140323, firstname = 'Yasmine', lastname = 'Miranda', phone = '615-2969', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'NNM08B44', user_id = 142922, firstname = 'Azura', lastname = 'Sampaio', phone = '615-2969', vehicle = 'Não identificado' },
    { rented = 0, service = 0, id = 990099, plate = 'XHL00W20', user_id = 140323, firstname = 'Yara', lastname = 'Alencar', phone = '060-2490', vehicle = 'Não identificado' },
}

config.cloneRef = {}; for k,v in pairs(config.clonePlates) do config.cloneRef[v.plate] = v; end;
Carman = {
    jobs = {
        default = 1,
    
        ['vip.permissao'] = 2,
        ['capital.permissao'] = 3
    },

    trucks = { [GetHashKey('packer')] = true },

    get_load = vector3(1257.798, -3196.233, 5.875488),

    spawns_load = {
        vector4(1271.143, -3186.699, 5.976563, 90.70866),
        vector4(1271.209, -3192.514, 5.976563, 87.87402),
        vector4(1270.207, -3199.266, 5.976563, 87.87402),
        vector4(1269.481, -3206.242, 5.976563, 87.87402),
        vector4(1268.98, -3214.272, 5.976563, 87.87402),
        vector4(1267.741, -3221.618, 5.976563, 87.87402),
        vector4(1267.16, -3228.461, 5.976563, 87.87402)
    },

    loads = { 'tanker', 'tanker2', 'tvtrailer', 'tr4', 'trailerlogs', 'trailers2', 'trailers3' },

    routes = {
        finish = vector3(1257.56, -3305.881, 5.79126),

        ['tanker'] = vector3(1686.369, 4919.815, 42.06885),
        ['tanker2'] = vector3(1686.369, 4919.815, 42.06885),
        ['tvtrailer'] = vector3(516.6857, 5527.846, 777.9678),
        ['tr4'] = vector3(-346.7341, 7438.681, 6.229248),
        ['trailerlogs'] = vector3(-569.9868, 5344.193, 70.22485),
        ['trailers2'] = vector3(-562.6022, 7379.13, 12.80078),
        ['trailers3'] = vector3(87.24396, 6325.358, 31.23438)
    },

    payment = {
        ['tanker'] = {
            { item = 'cobre', min = 25, max = 30 },
            { item = 'aluminio', min = 20, max = 25 },
            { item = 'ferro', min = 20, max = 25 },
            { item = 'borracha', min = 30, max = 35 },
            { item = 'titanio', min = 1, max = 2 },
            { item = 'plastico', min = 30, max = 35 },
            { item = 'tecido', min = 5, max = 7 },
        },
        ['tanker2'] = {
            { item = 'cobre', min = 25, max = 30 },
            { item = 'aluminio', min = 20, max = 25 },
            { item = 'ferro', min = 20, max = 25 },
            { item = 'borracha', min = 30, max = 35 },
            { item = 'titanio', min = 1, max = 2 },
            { item = 'plastico', min = 30, max = 35 },
            { item = 'tecido', min = 5, max = 7 },
        },
        ['tvtrailer'] = {
            { item = 'cobre', min = 25, max = 30 },
            { item = 'aluminio', min = 20, max = 25 },
            { item = 'ferro', min = 20, max = 25 },
            { item = 'borracha', min = 30, max = 35 },
            { item = 'titanio', min = 1, max = 2 },
            { item = 'plastico', min = 30, max = 35 },
            { item = 'tecido', min = 5, max = 7 },
        },
        ['tr4'] = {
            { item = 'cobre', min = 25, max = 30 },
            { item = 'aluminio', min = 20, max = 25 },
            { item = 'ferro', min = 20, max = 25 },
            { item = 'borracha', min = 30, max = 35 },
            { item = 'titanio', min = 1, max = 2 },
            { item = 'plastico', min = 30, max = 35 },
            { item = 'tecido', min = 5, max = 7 },
        },
        ['trailerlogs'] = {
            { item = 'cobre', min = 25, max = 30 },
            { item = 'aluminio', min = 20, max = 25 },
            { item = 'ferro', min = 20, max = 25 },
            { item = 'borracha', min = 30, max = 35 },
            { item = 'titanio', min = 1, max = 2 },
            { item = 'plastico', min = 30, max = 35 },
            { item = 'tecido', min = 5, max = 7 },
        },
        ['trailers2'] = {
            { item = 'cobre', min = 25, max = 30 },
            { item = 'aluminio', min = 20, max = 25 },
            { item = 'ferro', min = 20, max = 25 },
            { item = 'borracha', min = 30, max = 35 },
            { item = 'titanio', min = 1, max = 2 },
            { item = 'plastico', min = 30, max = 35 },
            { item = 'tecido', min = 5, max = 7 },
        },
        ['trailers3'] = {
            { item = 'cobre', min = 25, max = 30 },
            { item = 'aluminio', min = 20, max = 25 },
            { item = 'ferro', min = 20, max = 25 },
            { item = 'borracha', min = 30, max = 35 },
            { item = 'titanio', min = 1, max = 2 },
            { item = 'plastico', min = 30, max = 35 },
            { item = 'tecido', min = 5, max = 7 },
        },
    }
}
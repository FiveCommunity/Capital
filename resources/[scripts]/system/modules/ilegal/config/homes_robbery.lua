HomesRobbery = {}

HomesRobbery.Require = {
    ['lockpick'] = { name = 'Lockpick', mode = 'use' },
    ['masterpick'] = { name = 'Masterpick', mode = 'use' }
}

HomesRobbery.HomesBlocked = {
    ['Favela'] = true
}

HomesRobbery.RobCooldown = 2400

HomesRobbery.MinPolice = 0

HomesRobbery.CallPolice = 60

HomesRobbery.Itens = {
    { item = 'dinheirosujo', prob = 0.2, min = 100, max = 200 },
    { item = 'lockpick', prob = 0.2, min = 1, max = 1 },
    { item = 'pager', prob = 0.2, min = 1, max = 1 },

    { item = 'pneu', prob = 1, min = 1, max = 1 },

    { item = 'weapon_pistol_mk2', prob = 0.1, min = 1, max = 1 },
    { item = 'weapon_snspistol', prob = 0.5, min = 1, max = 1 },

    { item = 'ammo_5mm', prob = 2, min = 2, max = 5 },
    { item = 'ammo_9mm', prob = 4, min = 2, max = 5 },

    { item = 'equipamento-mergulho', prob = 7, min = 1, max = 1 },
    { item = 'powerbank', prob = 5, min = 1, max = 1 },
    { item = 'emb-tesoura', prob = 15, min = 1, max = 1 },

    { item = 'colar', prob = 15, min = 1, max = 1 },
    { item = 'brincos', prob = 15, min = 1, max = 1 },
    { item = 'pulseira', prob = 15, min = 1, max = 1 },
    { item = 'weapon_knuckle', prob = 15, min = 1, max = 1 },

    { item = 'relogio', prob = 25, min = 1, max = 1 },
    { item = 'chocolate', prob = 25, min = 1, max = 1 },
    { item = 'sabonete', prob = 25, min = 1, max = 1 },
    { item = 'bilhete', prob = 30, min = 1, max = 1 },
    { item = 'weapon_shoes', prob = 40, min = 1, max = 1 },

    { item = 'energetico', prob = 60, min = 1, max = 1 },
    
    { item = 'vibrador', prob = 75, min = 1, max = 1 },
    { item = 'caneca', prob = 75, min = 1, max = 1 },
    { item = 'cigarro', prob = 75, min = 1, max = 1 },
    { item = 'videogame', prob = 75, min = 1, max = 1 },
    { item = 'notebook', prob = 75, min = 1, max = 1 },

    { item = 'alianca-casamento', prob = 80, min = 1, max = 1 },
    { item = 'pendrive', prob = 80, min = 1, max = 1 },
    { item = 'camera', prob = 80, min = 1, max = 1 },
    { item = 'binoculos', prob = 80, min = 1, max = 1 },
}

HomesRobbery.MaxItens = 1

HomesRobbery.getHomes = function()
    return exports.homes:getHomesConfig()
end

HomesRobbery.getHomeInterior = function(homesConfig, homeName)
    local defaults = {
        ['favela'] = 'favela_01',
        ['basic'] = 'simple',
        ['modern'] = 'single',
        ['high'] = 'high_01',
        ['vip'] = 'high_01'
    }
    
    local cacheHomes = exports.homes:cacheHomes()
    local consult = cacheHomes[homeName]
    if (consult) then
        if consult.config.interior and HomesRobbery.interiors[consult.config.interior] then
            return consult.config.interior
        end
    end
    return defaults[ homesConfig[homeName].type ]
end

HomesRobbery.interiors = {
    ['favela_01'] = {
        _door = vector4(-7.806591, 2876.967, 25.82568, 70.86614),
        vector4(-9.494503, 2878.193, 25.82568, 340.1575),
        vector4(-11.57802, 2879.565, 25.82568, 65.19685),
        vector4(-12.14505, 2877.93, 25.82568, 65.19685),
        vector4(-8.980217, 2875.609, 25.82568, 249.4488),
        vector4(-12.21099, 2872.352, 25.82568, 255.1181),
        vector4(-6.263733, 2873.13, 25.82568, 342.9921)
    },
    ['simple'] = {
        _door = vector4(266.1099, -1007.42, -101.0198, 357.1653),
        vector4(265.9648, -999.4022, -99.01465, 269.2914),
        vector4(264.1319, -995.4462, -99.01465, 0),
        vector4(257.0769, -995.6572, -99.01465, 48.18897),
        vector4(259.7275, -1004.004, -99.01465, 181.4173),
        vector4(265.7802, -996.7121, -99.01465, 272.126),
        vector4(262.022, -995.2879, -99.01465, 272.126),
    },
    ['single'] = {
        _door = vector4(346.5363, -1012.945, -99.19995, 5.669291),
        vector4(346.0747, -1001.697, -99.19995, 85.03937),
        vector4(342.7648, -1003.266, -99.19995, 175.748),
        vector4(339.2571, -1003.411, -99.19995, 181.4173),
        vector4(338.2022, -996.6725, -99.19995, 85.03937),
        vector4(345.3099, -995.7099, -99.19995, 269.2914),
        vector4(351.2176, -999.178, -99.19995, 181.4173),
        vector4(351.2967, -993.6, -99.19995, 2.834646),
        vector4(349.2, -994.8, -99.19995, 87.87402)
    },
    ['motel'] = {
        _door = vector4(151.3319, -1007.881, -99.01465, 357.1653),
        vector4(154.8132, -1005.877, -99.01465, 280.6299),
        vector4(151.1868, -1004.585, -99.01465, 93.5433),
        vector4(151.3055, -1003.094, -99.01465, 65.19685),
        vector4(151.7934, -1001.486, -99.01465, 90.70866),
        vector4(154.0615, -1000.668, -99.01465, 2.834646),
    },
    ['high_01'] = {
        _door = vector4(-174.3428, 497.7231, 137.641, 192.7559),
        vector4(-167.222, 496.6681, 137.641, 11.33858),
        vector4(-171.3494, 486.8044, 137.4388, 99.21259),
        vector4(-170.7033, 482.5846, 137.2366, 96.37794),
        vector4(-164.2813, 486.8308, 137.4388, 192.7559),
        vector4(-170.5978, 481.9517, 133.833, 107.7165),
        vector4(-167.5385, 488.1099, 133.833, 11.33858),
        vector4(-165.7714, 495.6791, 133.8499, 14.17323),
        vector4(-162.633, 482.1758, 133.8667, 280.6299),
        vector4(-172.6945, 500.6769, 130.0249, 14.17323),
        vector4(-175.0286, 493.767, 130.0417, 5.669291),
        vector4(-175.1472, 489.7714, 130.0417, 99.21259)
    },
    ['high_02'] = {
        _door = vector4(-174.3428, 497.7231, 137.641, 192.7559),
        vector4(373.622, 423.811, 145.8975, 164.4095),
        vector4(378.6989, 419.4725, 145.8975, 345.8268),
        vector4(370.3648, 412.6813, 145.6952, 79.37008),
        vector4(376.6682, 409.3451, 145.6952, 170.0787),
        vector4(369.2044, 408.2374, 145.493, 79.37008),
        vector4(376.444, 404.9143, 145.493, 257.9528),
        vector4(369.0594, 407.7363, 142.0894, 68.03149),
        vector4(374.5187, 411.9033, 142.0894, 345.8268),
        vector4(376.4703, 404.0044, 142.123, 263.6221),
        vector4(371.1165, 426.1451, 138.2982, 70.86614),
        vector4(377.1033, 428.8747, 138.2982, 164.4095)
    },
}
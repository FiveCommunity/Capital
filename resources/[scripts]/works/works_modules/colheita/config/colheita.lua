Colheita = {
    zones = {
        -- Norte
        ['zone_1'] = {
            vector2(2496.897, 4817.552),
            vector2(2515.503, 4836.119),
            vector2(2530.945, 4852.918),
            vector2(2588.044, 4799.842),
            vector2(2562.316, 4774.154),
            vector2(2556.04, 4775.09),
            vector2(2543.868, 4774.523)
        },
        ['zone_2'] = {
            vector2(2495.895, 4885.121),
            vector2(2456.426, 4843.978),
            vector2(2473.833, 4827.561),
            vector2(2482.55, 4828.154),
            vector2(2491.45, 4826.018),
            vector2(2523.073, 4858.945),

        },

        -- Paleto
        ['zone_3'] = {
            vector2(495.5209, 6457.899),
            vector2(477.4418, 6458.598),
            vector2(477.6, 6462.461),
            vector2(468.8176, 6463.147),
            vector2(468.7385, 6467.591),
            vector2(460.7736, 6467.829),
            vector2(460.4967, 6499.411),
            vector2(461.5385, 6500.044),
            vector2(461.6967, 6504.896),
            vector2(467.7495, 6505.266),
            vector2(468.1978, 6509.815),
            vector2(473.3539, 6510.066),
            vector2(474, 6514.615),
            vector2(480.1582, 6515.354),
            vector2(480.4879, 6519.996),
            vector2(495.9033, 6519.626)
        },
        ['zone_4'] = {
            vector2(550.6418, 6457.319),
            vector2(550.3648, 6519.521),
            vector2(555.7846, 6519.007),
            vector2(555.8637, 6515.077),
            vector2(578.3472, 6513.89),
            vector2(578.3868, 6509.815),
            vector2(594.8307, 6509.512),
            vector2(595.3055, 6456.91),
            vector2(550.4308, 6456.29)
        },

        -- Ilha
        ['zone_5'] = {
            vector2(-1797.771, 7058.505),
            vector2(-1857.824, 6996.541),
            vector2(-1856.387, 6994.681),
            vector2(-1864.048, 6987.257),
            vector2(-1838.123, 6963.007),
            vector2(-1824.646, 6977.301),
            vector2(-1817.815, 6971.578),
            vector2(-1763.895, 7026.646)
        }
    },

    propStages = {
        { model = 'h4_prop_bush_cocaplant_01', offset = vec3(0.0,0.0,0.9) }, -- 1
        { model = 'prop_am_box_wood_01', offset = vec3(0.0,0.0,0.0) }, -- 2
        { model = 'h4_prop_tree_umbrella_sml_01', offset = vec3(0.0,0.0,0.2) }, -- 3
    },

    payment = {
        { prob = 5, item = 'graos-cafe', min = 2, max = 2 },
        { prob = 5, item = 'graos-guarana', min = 2, max = 2 },
        { prob = 5, item = 'camomila', min = 2, max = 2 },
        { prob = 5, item = 'morango', min = 2, max = 2 },
        { prob = 5, item = 'banana', min = 2, max = 2 },
        { prob = 5, item = 'abacaxi', min = 2, max = 2 },
        { prob = 15, item = 'espiga-milho', min = 2, max = 2 },
        { prob = 15, item = 'trigo', min = 1, max = 3 },
        { prob = 10, item = 'erva-mate', min = 2, max = 2 },
        { prob = 15, item = 'tomate', min = 2, max = 2 },
        { prob = 15, item = 'alface', min = 2, max = 2 }
    },

    extraPayment = {
        -- { item = 'folha', min = 2, max = 2 },
        { item = 'casca-semente', min = 2, max = 2 },
    },

    itemsAmount = 1
}
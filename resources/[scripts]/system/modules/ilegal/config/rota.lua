Routes = {
    general = {
        --==============================================================================================================
        -- ARMA
        --==============================================================================================================

        ['Arma'] = {
            name = 'Arma',
            coords = {
                vector3(851.7758, -2894.492, 11.25061),
                vector3(-253.2923, -2591.209, 5.993408),
                vector3(200.0044, -2002.127, 18.84985),
                vector3(-924.7516, -1163.921, 4.813965),
                vector3(-2956.312, 385.6879, 15.00806),
                vector3(-2565.692, 2307.178, 33.20581),
                vector3(-2173.78, 4282.18, 49.11206),
                vector3(-753.9165, 5578.681, 36.69373),
                vector3(-414, 6171.561, 31.47034),
                vector3(1538.875, 6321.917, 25.05054),
                vector3(2029.714, 4980.633, 42.08569),
                vector3(1353.046, 3607.187, 34.90771),
                vector3(318.9363, 268.8396, 104.5143),
                vector3(992.8483, -1527.547, 30.96484),
                vector3(1017.996, -2192.611, 31.6051),
                vector3(632.611, -3015.336, 7.324585),
                vector3(1240.127, -3321.917, 6.0271),
                vector3(1230.646, -2911.24, 13.32312),
            },
            itens = {
                { item = 'clip', quantity = { min = 15, max = 35 } },
                { item = 'culatra', quantity = { min = 15, max = 35 } },
                { item = 'ferrolho', quantity = { min = 15, max = 35 } },
                { item = 'slide', quantity = { min = 15, max = 35 } },
                { item = 'cabo', quantity = { min = 15, max = 35 } },
                { item = 'titanio', quantity = { min = 1, max = 1 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 7000,
                randomFixed = true,
            }
        },

        ['ArmaComTecido'] = {
            name = 'Arma com Tecido',
            coords = {
                vector3(851.7758, -2894.492, 11.25061),
                vector3(-253.2923, -2591.209, 5.993408),
                vector3(200.0044, -2002.127, 18.84985),
                vector3(-924.7516, -1163.921, 4.813965),
                vector3(-2956.312, 385.6879, 15.00806),
                vector3(-2565.692, 2307.178, 33.20581),
                vector3(-2173.78, 4282.18, 49.11206),
                vector3(-740.967, 5571.679, 36.69373),
                vector3(-414, 6171.561, 31.47034),
                vector3(1538.875, 6321.917, 25.05054),
                vector3(2029.714, 4980.633, 42.08569),
                vector3(1353.046, 3607.187, 34.90771),
                vector3(318.9363, 268.8396, 104.5143),
                vector3(992.8483, -1527.547, 30.96484),
                vector3(1017.996, -2192.611, 31.6051),
                vector3(632.611, -3015.336, 7.324585),
                vector3(1240.127, -3321.917, 6.0271),
                vector3(1230.646, -2911.24, 13.32312),
            },
            itens = {
                { item = 'tecido', quantity = { min = 5, max = 10 } },
                { item = 'clip', quantity = { min = 15, max = 35 } },
                { item = 'culatra', quantity = { min = 15, max = 35 } },
                { item = 'ferrolho', quantity = { min = 15, max = 35 } },
                { item = 'slide', quantity = { min = 15, max = 35 } },
                { item = 'cabo', quantity = { min = 15, max = 35 } },
                { item = 'titanio', quantity = { min = 1, max = 1 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 7000,
                randomFixed = true,
            }
        },
        ['Melzinho'] = {
            name = 'Melzinho',
            coords = {
                vector3(851.7758, -2894.492, 11.25061),
                vector3(-253.2923, -2591.209, 5.993408),
                vector3(200.0044, -2002.127, 18.84985),
                vector3(-924.7516, -1163.921, 4.813965),
                vector3(-2956.312, 385.6879, 15.00806),
                vector3(-2565.692, 2307.178, 33.20581),
                vector3(-2173.78, 4282.18, 49.11206),
                vector3(-740.967, 5571.679, 36.69373),
                vector3(-414, 6171.561, 31.47034),
                vector3(1538.875, 6321.917, 25.05054),
                vector3(2029.714, 4980.633, 42.08569),
                vector3(1353.046, 3607.187, 34.90771),
                vector3(318.9363, 268.8396, 104.5143),
                vector3(992.8483, -1527.547, 30.96484),
                vector3(1017.996, -2192.611, 31.6051),
                vector3(632.611, -3015.336, 7.324585),
                vector3(1240.127, -3321.917, 6.0271),
                vector3(1230.646, -2911.24, 13.32312),
            },
            itens = {
                { item = 'mel', quantity = { min = 5, max = 10 } },
                { item = 'embalagem-plastica', quantity = { min = 20, max = 25 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 7000,
                randomFixed = true,
            }
        },

        --==============================================================================================================
        -- MUNICAO
        --==============================================================================================================

        ['Municao'] = {
            name = 'Municao',
            coords = {
                vector3(-1314.923, -406.6418, 36.57581),
                vector3(-680.0571, -924.1187, 23.06226),
                vector3(-8.861534, -1090.932, 26.66809),
                vector3(257.3802, -3062.73, 5.858643),
                vector3(830.2813, -2171.604, 30.27405),
                vector3(857.5385, -1038.527, 33.12158),
                vector3(711.3759, 589.8594, 129.2329),
                vector3(1687.701, 3755.75, 34.55383),
                vector3(3817.332, 4483.068, 6.364136),
                vector3(1723.292, 6417.785, 34.99194),
                vector3(-342.4747, 6097.714, 31.30188),
                vector3(-3169.24, 1093.622, 20.85498),
                vector3(-2213.539, -371.3011, 13.30627),
                vector3(-1154.505, -1571.248, 4.813965),
                vector3(265.5033, -20.42637, 73.8645),
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 20, max = 25 } },
                { item = 'cobre', quantity = { min = 15, max = 20 } },
                { item = 'aluminio', quantity = { min = 15, max = 20 } },
                { item = 'ferro', quantity = { min = 15, max = 20 } },
                { item = 'titanio', quantity = { min = 1, max = 2 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 7000,
                randomFixed = true,
            }
        },

        --==============================================================================================================
        -- DROGAS
        --==============================================================================================================

        ['Maconha'] = {
            name = 'Droga',
            coords = {
                vector3(2243.472, 5154.29, 57.87402),
                vector3(711.244, 4185.271, 41.07471),
                vector3(78.01319, 3732.528, 40.26599),
                vector3(823.6088, 2365.253, 52.46521),
                vector3(1915.873, 3909.257, 33.42493),
                vector3(2589.692, 483.1253, 108.6593),
                vector3(1561.49, -1693.582, 89.19775),
                vector3(390.7121, -1861.701, 26.70178),
                vector3(-775.1208, -2632.167, 13.92969),
                vector3(-1320.237, -1167.244, 4.847656),
                vector3(13.26593, 3732.237, 39.67615),
                vector3(-3275.75, 964.6022, 8.335571),
                vector3(-1091.116, 2715.758, 19.06885),
                vector3(-399.9956, 6377.67, 14.03076),
                vector3(406.0747, 6526.22, 27.74646),
                vector3(33.30989, 6672.831, 32.17798), 
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
                { item = 'seda', quantity = { min = 15, max = 30 } },
                { item = 'folha', quantity = { min = 15, max = 30 } },
                { item = 'casca-semente', quantity = { min = 15, max = 30 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['Viagra'] = {
            name = 'Droga',
            coords = {
                vector3(1125.152, -1010.453, 44.6637),
                vector3(572.0439, 114, 98.2124),
                vector3(-104.5714, -69.36263, 58.85132),
                vector3(-1321.701, -1264.167, 4.578003),
                vector3(-1498.009, -204.6857, 50.88135),
                vector3(-3047.578, 589.9517, 7.779541),
                vector3(-689.4066, 5789.143, 17.31653),
                vector3(125.6703, 6644.07, 31.79053),
                vector3(1700.927, 4857.758, 42.01831),
                vector3(2670.752, 3286.167, 55.22852),
                vector3(2357.552, 2609.631, 47.22485),
                vector3(2696.281, 1613.829, 24.41028),
                vector3(1832.07, -1182.475, 91.53992),
                vector3(1075.451, -2330.585, 30.29089),
                vector3(1054.062, -1952.716, 32.09375),
                vector3(1141.068, -1622.519, 35.41321), 
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
                { item = 'farinha-trigo', quantity = { min = 15, max = 25 } },
                { item = 'eter', quantity = { min = 15, max = 20 } },
                { item = 'sildenafila', quantity = { min = 15, max = 20 } }
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['Farinha'] = {
            name = 'Droga',
            coords = {
                vector3(-393.4813, -2763.692, 5.993408),
                vector3(-940.8659, -2954.083, 13.92969),
                vector3(-1157.67, -1451.67, 4.460083),
                vector3(-1989.864, -325.5824, 44.09082),
                vector3(-2066.413, -312.9495, 13.28943),
                vector3(-3170.242, 1034.426, 20.83813),
                vector3(-1386.633, 4425.996, 50.34216),
                vector3(-567.3626, 5252.954, 70.46082),
                vector3(-553.0417, 6854.36, 25.6908),
                vector3(156.9758, 6657.389, 31.55457),
                vector3(2916.224, 4367.815, 50.46008),
                vector3(2670.739, 3286.193, 55.22852),
                vector3(1980.488, 3049.701, 50.42639),
                vector3(660.1846, 592.8923, 129.2329),
                vector3(523.0286, 198.7121, 104.7333),
                vector3(729.877, -831.2176, 26.38171), 
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
                { item = 'farinha-trigo', quantity = { min = 15, max = 30 } },
                { item = 'folha', quantity = { min = 15, max = 30 } },
                { item = 'casca-semente', quantity = { min = 15, max = 30 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['rape_ayahuasca'] = {
            name = 'Droga',
            coords = {
                vector3(-393.4813, -2763.692, 5.993408),
                vector3(-940.8659, -2954.083, 13.92969),
                vector3(-1157.67, -1451.67, 4.460083),
                vector3(-1989.864, -325.5824, 44.09082),
                vector3(-2066.413, -312.9495, 13.28943),
                vector3(-3170.242, 1034.426, 20.83813),
                vector3(-1386.633, 4425.996, 50.34216),
                vector3(-567.3626, 5252.954, 70.46082),
                vector3(-553.0417, 6854.36, 25.6908),
                vector3(156.9758, 6657.389, 31.55457),
                vector3(2916.224, 4367.815, 50.46008),
                vector3(2670.739, 3286.193, 55.22852),
                vector3(1980.488, 3049.701, 50.42639),
                vector3(660.1846, 592.8923, 129.2329),
                vector3(523.0286, 198.7121, 104.7333),
                vector3(729.877, -831.2176, 26.38171), 
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
                { item = 'farinha-trigo', quantity = { min = 15, max = 30 } },
                { item = 'folha', quantity = { min = 15, max = 30 } },
                { item = 'casca-semente', quantity = { min = 15, max = 30 } },
                { item = 'pena', quantity = { min = 15, max = 30 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },


        ['Metanfetamina'] = {
            name = 'Droga',
            coords = {
                vector3(-393.4813, -2763.692, 5.993408),
                vector3(-940.8659, -2954.083, 13.92969),
                vector3(2243.472, 5154.29, 57.87402),
                vector3(711.244, 4185.271, 41.07471),
                vector3(78.01319, 3732.528, 40.26599),
                vector3(823.6088, 2365.253, 52.46521),
                vector3(1915.873, 3909.257, 33.42493),
                vector3(2589.692, 483.1253, 108.6593),
                vector3(1561.49, -1693.582, 89.19775),
                vector3(390.7121, -1861.701, 26.70178),
                vector3(-775.1208, -2632.167, 13.92969),
                vector3(-1320.237, -1167.244, 4.847656),
                vector3(13.26593, 3732.237, 39.67615),
                vector3(-3275.75, 964.6022, 8.335571),
                vector3(-1091.116, 2715.758, 19.06885),
                vector3(-399.9956, 6377.67, 14.03076),
                vector3(406.0747, 6526.22, 27.74646),
                vector3(33.30989, 6672.831, 32.17798), 
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
                { item = 'folha-papel', quantity = { min = 20, max = 35 } },
                { item = 'efedrina', quantity = { min = 20, max = 35 } },
                { item = 'po-aluminio', quantity = { min = 10, max = 15 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['Bala'] = {
            name = 'Droga',
            coords = {
                vector3(1125.152, -1010.453, 44.6637),
                vector3(572.0439, 114, 98.2124),
                vector3(-104.5714, -69.36263, 58.85132),
                vector3(-1321.701, -1264.167, 4.578003),
                vector3(-1498.009, -204.6857, 50.88135),
                vector3(-3047.578, 589.9517, 7.779541),
                vector3(-689.4066, 5789.143, 17.31653),
                vector3(125.6703, 6644.07, 31.79053),
                vector3(1700.927, 4857.758, 42.01831),
                vector3(2670.752, 3286.167, 55.22852),
                vector3(2357.552, 2609.631, 47.22485),
                vector3(2696.281, 1613.829, 24.41028),
                vector3(1832.07, -1182.475, 91.53992),
                vector3(1075.451, -2330.585, 30.29089),
                vector3(1054.062, -1952.716, 32.09375),
                vector3(1141.068, -1622.519, 35.41321), 
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
                { item = 'folha-papel', quantity = { min = 15, max = 25 } },
                { item = 'efedrina', quantity = { min = 15, max = 20 } },
                { item = 'metileno', quantity = { min = 15, max = 20 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['Heroina'] = {
            name = 'Droga',
            coords = {
                vector3(-393.4813, -2763.692, 5.993408),
                vector3(-940.8659, -2954.083, 13.92969),
                vector3(-1157.67, -1451.67, 4.460083),
                vector3(-1989.864, -325.5824, 44.09082),
                vector3(-2066.413, -312.9495, 13.28943),
                vector3(-3170.242, 1034.426, 20.83813),
                vector3(-1386.633, 4425.996, 50.34216),
                vector3(-567.3626, 5252.954, 70.46082),
                vector3(-553.0417, 6854.36, 25.6908),
                vector3(156.9758, 6657.389, 31.55457),
                vector3(2916.224, 4367.815, 50.46008),
                vector3(2670.739, 3286.193, 55.22852),
                vector3(1980.488, 3049.701, 50.42639),
                vector3(660.1846, 592.8923, 129.2329),
                vector3(523.0286, 198.7121, 104.7333),
                vector3(729.877, -831.2176, 26.38171), 
            },
            itens = {
                { item = 'folha', quantity = { min = 15, max = 25 } },
                { item = 'opio', quantity = { min = 15, max = 25 } },
                { item = 'seringa', quantity = { min = 10, max = 15 } },
                { item = 'agulha', quantity = { min = 10, max = 15 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['Oxy'] = {
            name = 'Droga',
            coords = {
                vector3(1125.152, -1010.453, 44.6637),
                vector3(572.0439, 114, 98.2124),
                vector3(-104.5714, -69.36263, 58.85132),
                vector3(-1321.701, -1264.167, 4.578003),
                vector3(-1498.009, -204.6857, 50.88135),
                vector3(-3047.578, 589.9517, 7.779541),
                vector3(-689.4066, 5789.143, 17.31653),
                vector3(125.6703, 6644.07, 31.79053),
                vector3(1700.927, 4857.758, 42.01831),
                vector3(2670.752, 3286.167, 55.22852),
                vector3(2357.552, 2609.631, 47.22485),
                vector3(2696.281, 1613.829, 24.41028),
                vector3(1832.07, -1182.475, 91.53992),
                vector3(1075.451, -2330.585, 30.29089),
                vector3(1054.062, -1952.716, 32.09375),
                vector3(1141.068, -1622.519, 35.41321), 
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
                { item = 'opio', quantity = { min = 15, max = 25 } },
                { item = 'farinha-trigo', quantity = { min = 15, max = 25 } },
                { item = 'folha', quantity = { min = 15, max = 25 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },
        
        ['Lanca'] = {
            name = 'Droga',
            coords = {
                vector3(2670.804, 3286.18, 55.38025),
                vector3(2931.666, 4485.6, 48.03369),
                vector3(1741.582, 6419.684, 35.02563),
                vector3(1538.941, 6323.446, 24.03955),
                vector3(174.9231, 6642.857, 31.57141),
                vector3(-358.7341, 6061.78, 31.48718),
                vector3(-1490.44, 4981.385, 63.35022),
                vector3(397.6747, 3608.057, 33.30701),
                vector3(260.0703, 3176.743, 42.74292),
                vector3(1716.29, 3294.554, 41.17578),
                vector3(2351.802, 3151.978, 48.21899),
                vector3(2545.029, 2591.921, 37.95752),
                vector3(2601.204, 2804.057, 33.8125),
                vector3(2707.398, 3074.031, 43.06299)
            },
            itens = {
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
                { item = 'opio', quantity = { min = 15, max = 25 } },
                { item = 'eter', quantity = { min = 15, max = 25 } },
                { item = 'metileno', quantity = { min = 15, max = 25 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        --==============================================================================================================
        -- Contrabando
        --==============================================================================================================

        ['BloqueadorMasterpick'] = {
            name = 'Bloqueador e Masterpick',
            coords = {
                vector3(2270.914, 3756.844, 38.41248),
                vector3(905.6967, 3586.47, 33.40808),
                vector3(257.8286, 3091.213, 42.79346),
                vector3(-1102.127, 2721.824, 18.79932),
                vector3(-1512.725, 1516.879, 115.2814),
                vector3(-2016.04, 559.0813, 108.3055),
                vector3(-1579.477, -440.611, 38.15967),
                vector3(-1112.519, -848.5582, 13.44104),
                vector3(-196.0879, 16.72088, 56.30701),
                vector3(-40.00879, -74.70329, 58.54797),
                vector3(548.6506, -172.1538, 54.47034),
                vector3(987.178, -144.4483, 74.26892),
                vector3(2768.809, 1391.077, 24.5282),
                vector3(2427.204, 3082.325, 49.26379),
                vector3(1887.64, 3913.807, 33.00366),
            },
            itens = {
                { item = 'borracha', quantity = { min = 10, max = 15 } },
                { item = 'cobre', quantity = { min = 10, max = 15 } },
                { item = 'plastico', quantity = { min = 10, max = 15 } },
                { item = 'ferro', quantity = { min = 10, max = 15 } },
                { item = 'aluminio', quantity = { min = 10, max = 15 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['flipper'] = {
            name = 'Flipper MK',
            coords = {
                vector3(2270.914, 3756.844, 38.41248),
                vector3(905.6967, 3586.47, 33.40808),
                vector3(257.8286, 3091.213, 42.79346),
                vector3(-1102.127, 2721.824, 18.79932),
                vector3(-1512.725, 1516.879, 115.2814),
                vector3(-2016.04, 559.0813, 108.3055),
                vector3(-1579.477, -440.611, 38.15967),
                vector3(-1112.519, -848.5582, 13.44104),
                vector3(-196.0879, 16.72088, 56.30701),
                vector3(-40.00879, -74.70329, 58.54797),
                vector3(548.6506, -172.1538, 54.47034),
                vector3(987.178, -144.4483, 74.26892),
                vector3(2768.809, 1391.077, 24.5282),
                vector3(2427.204, 3082.325, 49.26379),
                vector3(1887.64, 3913.807, 33.00366),
            },
            itens = {
                { item = 'cobre', quantity = { min = 10, max = 15 } },
                { item = 'aluminio', quantity = { min = 10, max = 15 } },
                { item = 'ferro', quantity = { min = 10, max = 15 } },
                { item = 'titanio', quantity = { min = 10, max = 15 } },
                { item = 'embalagem-plastica', quantity = { min = 10, max = 15 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['mecanica_troll'] = {
            name = 'Sabotagem',
            coords = {
                vector3(2270.914, 3756.844, 38.41248),
                vector3(905.6967, 3586.47, 33.40808),
                vector3(257.8286, 3091.213, 42.79346),
                vector3(-1102.127, 2721.824, 18.79932),
                vector3(-1512.725, 1516.879, 115.2814),
                vector3(-2016.04, 559.0813, 108.3055),
                vector3(-1579.477, -440.611, 38.15967),
                vector3(-1112.519, -848.5582, 13.44104),
                vector3(-196.0879, 16.72088, 56.30701),
                vector3(-40.00879, -74.70329, 58.54797),
                vector3(548.6506, -172.1538, 54.47034),
                vector3(987.178, -144.4483, 74.26892),
                vector3(2768.809, 1391.077, 24.5282),
                vector3(2427.204, 3082.325, 49.26379),
                vector3(1887.64, 3913.807, 33.00366),
            },
            itens = {
                { item = 'borracha', quantity = { min = 3, max = 5 } },
                { item = 'cobre', quantity = { min = 3, max = 5 } },
                { item = 'plastico', quantity = { min = 3, max = 5 } },
                { item = 'ferro', quantity = { min = 3, max = 5 } },
                { item = 'aluminio', quantity = { min = 3, max = 5 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['Nitro'] = {
            name = 'Nitro',
            coords = {
                vector3(2270.914, 3756.844, 38.41248),
                vector3(905.6967, 3586.47, 33.40808),
                vector3(257.8286, 3091.213, 42.79346),
                vector3(-1102.127, 2721.824, 18.79932),
                vector3(-1512.725, 1516.879, 115.2814),
                vector3(-2016.04, 559.0813, 108.3055),
                vector3(-1579.477, -440.611, 38.15967),
                vector3(-1112.519, -848.5582, 13.44104),
                vector3(-196.0879, 16.72088, 56.30701),
                vector3(-40.00879, -74.70329, 58.54797),
                vector3(548.6506, -172.1538, 54.47034),
                vector3(987.178, -144.4483, 74.26892),
                vector3(2768.809, 1391.077, 24.5282),
                vector3(2427.204, 3082.325, 49.26379),
                vector3(1887.64, 3913.807, 33.00366),
            },
            itens = {
                { item = 'gas', quantity = { min = 5, max = 5 } },
                { item = 'ferro', quantity = { min = 5, max = 5 } },
                { item = 'aluminio', quantity = { min = 5, max = 5 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['ChaveNitro'] = {
            name = 'Chave Nitro',
            coords = {
                vector3(2270.914, 3756.844, 38.41248),
                vector3(905.6967, 3586.47, 33.40808),
                vector3(257.8286, 3091.213, 42.79346),
                vector3(-1102.127, 2721.824, 18.79932),
                vector3(-1512.725, 1516.879, 115.2814),
                vector3(-2016.04, 559.0813, 108.3055),
                vector3(-1579.477, -440.611, 38.15967),
                vector3(-1112.519, -848.5582, 13.44104),
                vector3(-196.0879, 16.72088, 56.30701),
                vector3(-40.00879, -74.70329, 58.54797),
                vector3(548.6506, -172.1538, 54.47034),
                vector3(987.178, -144.4483, 74.26892),
                vector3(2768.809, 1391.077, 24.5282),
                vector3(2427.204, 3082.325, 49.26379),
                vector3(1887.64, 3913.807, 33.00366),
            },
            itens = {
                { item = 'gas', quantity = { min = 3, max = 5 } },
                { item = 'ferro', quantity = { min = 3, max = 5 } },
                { item = 'aluminio', quantity = { min = 3, max = 5 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['KitDesmanche'] = {
            name = 'Kit Desmanche',
            coords = {
                vector3(-1041.93, -1492.721, 5.285767),
                vector3(-1838.136, -360.5275, 57.14941),
                vector3(-1453.253, 417.3758, 109.8557),
                vector3(-41.48571, -181.622, 54.26819),
                vector3(455.6308, -1103.67, 29.38098),
                vector3(869.789, -2326.919, 30.59412),
                vector3(2551.174, 348.7253, 108.6088),
                vector3(2471.75, 1596.158, 32.71716),
                vector3(2643.996, 3305.354, 55.70032),
                vector3(2898.739, 4422.224, 48.58972),
                vector3(3310.8, 5176.51, 19.60803),
                vector3(-101.1165, 6506.439, 31.48718),
                vector3(-3055.754, 103.411, 12.34583),
                vector3(-1657.002, -982.9187, 8.166992),
                vector3(-719.1561, -897.8505, 20.41687),
            },
            itens = {
                { item = 'borracha', quantity = { min = 5, max = 15 } },
                { item = 'plastico', quantity = { min = 5, max = 15 } },
                { item = 'cobre', quantity = { min = 5, max = 15 } },
                { item = 'aluminio', quantity = { min = 5, max = 15 } },
                { item = 'ferro', quantity = { min = 5, max = 15 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['CapuzColeteAlgema'] = {
            name = 'Contrabando',
            coords = {
                vector3(689.0637, -689.8945, 26.36487),
                vector3(474.2769, -635.7231, 25.64026),
                vector3(-297.9297, -1044.343, 36.33997),
                vector3(-559.411, -1804.325, 22.6073),
                vector3(-458.8352, -2274.475, 8.504028),
                vector3(-222.0396, -2375.802, 9.312866),
                vector3(661.7538, -2643.389, 8.436646),
                vector3(854.6374, -2112.857, 31.57141),
                vector3(2588.73, 429.5341, 108.6088),
                vector3(1738.286, 3029.064, 63.14795),
                vector3(2531.222, 4114.338, 38.74951),
                vector3(2890.642, 4503.93, 48.08423),
                vector3(1680.976, 6428.519, 32.16113),
                vector3(-248.3209, 6332.729, 32.41394),
                vector3(-3234.29, 1075.675, 11.03149),
                vector3(-1480.339, -335.222, 45.8938),
            },
            itens = {
                { item = 'borracha', quantity = { min = 15, max = 35 } },
                { item = 'plastico', quantity = { min = 15, max = 35 } },
                { item = 'aluminio', quantity = { min = 15, max = 35 } },
                { item = 'ferro', quantity = { min = 15, max = 35 } },
                { item = 'tecido', quantity = { min = 1, max = 2 } },
                { item = 'cobre', quantity = { min = 10, max = 25 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['BombaC4'] = {
            name = 'C4',
            coords = {
                vector3(-941.2088, -1567.793, 5.167725),
                vector3(-2213.552, -371.3407, 13.30627),
                vector3(-3273.956, 982.2066, 8.335571),
                vector3(-2229.956, 3481.517, 30.15601),
                vector3(-841.6616, 5401.082, 34.60437),
                vector3(-238.7868, 6359.697, 31.82422),
                vector3(-101.0637, 6506.479, 31.48718),
                vector3(1590.646, 6461.789, 25.30334),
                vector3(2243.433, 5154.303, 57.87402),
                vector3(2987.96, 3481.662, 72.48279),
                vector3(2663.525, 2891.196, 36.92969),
                vector3(1738.312, 3028.985, 63.14795),
                vector3(1086.923, 243.7451, 81.17725),
                vector3(1099.279, -345.7451, 67.17505),
                vector3(829.0286, -1059.508, 28.06665),
            },
            itens = {
                { item = 'borracha', quantity = { min = 20, max = 25 } },
                { item = 'plastico', quantity = { min = 20, max = 25 } },
                { item = 'cobre', quantity = { min = 15, max = 20 } },
                { item = 'aluminio', quantity = { min = 15, max = 20 } },
                { item = 'ferro', quantity = { min = 15, max = 20 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['PlacaTicket'] = {
            name = 'Placa Clonada e Ticket',
            coords = {
                vector3(-62.65055, -2509.648, 11.33484),
                vector3(-539.8154, -1638.013, 19.87769),
                vector3(-1125.956, -967.2791, 6.616821),
                vector3(-2016.092, 559.2132, 108.3055),
                vector3(-1125.653, 2694.528, 18.79932),
                vector3(-35.52527, 2871.534, 59.6095),
                vector3(699.2703, 3115.094, 44.07397),
                vector3(2392.879, 3320.413, 48.45496),
                vector3(2160.237, 4789.596, 41.95093),
                vector3(2834.98, 2806.892, 57.38538),
                vector3(2589.666, 483.244, 108.6593),
                vector3(2549.459, -314.5187, 93.15747),
                vector3(1890.435, -1019.327, 78.56555),
                vector3(1269.824, -1906.985, 39.42346),
                vector3(974.3077, -1937.301, 32.21167),
                vector3(892.3121, -2171.842, 32.27917),
                vector3(701.8154, -2194.919, 29.54944),
                vector3(557.2352, -2716.576, 7.105469),
            },
            itens = {
                { item = 'borracha', quantity = { min = 10, max = 25 } },
                { item = 'plastico', quantity = { min = 10, max = 25 } },
                { item = 'cobre', quantity = { min = 15, max = 35 } },
                { item = 'aluminio', quantity = { min = 15, max = 35 } },
                { item = 'ferro', quantity = { min = 15, max = 35 } },
                { item = 'folha-papel', quantity = { min = 1, max = 10 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['KitDesmancheDificil'] = {
            name = 'Kit Desmanche',
            coords = {
                vector3(-1041.93, -1492.721, 5.285767),
                vector3(-1838.136, -360.5275, 57.14941),
                vector3(-1453.253, 417.3758, 109.8557),
                vector3(-41.48571, -181.622, 54.26819),
                vector3(455.6308, -1103.67, 29.38098),
                vector3(869.789, -2326.919, 30.59412),
                vector3(2551.174, 348.7253, 108.6088),
                vector3(2471.75, 1596.158, 32.71716),
                vector3(2643.996, 3305.354, 55.70032),
                vector3(2898.739, 4422.224, 48.58972),
                vector3(3310.8, 5176.51, 19.60803),
                vector3(-101.1165, 6506.439, 31.48718),
                vector3(-3055.754, 103.411, 12.34583),
                vector3(-1657.002, -982.9187, 8.166992),
                vector3(-719.1561, -897.8505, 20.41687),
            },
            itens = {
                { item = 'borracha', quantity = { min = 2, max = 5 } },
                { item = 'plastico', quantity = { min = 2, max = 5 } },
                { item = 'cobre', quantity = { min = 2, max = 5 } },
                { item = 'aluminio', quantity = { min = 2, max = 5 } },
                { item = 'ferro', quantity = { min = 2, max = 5 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['Adrenalina'] = {
            name = 'Adrenalina',
            coords = {
                vector3(1125.152, -1010.453, 44.6637),
                vector3(572.0439, 114, 98.2124),
                vector3(-104.5714, -69.36263, 58.85132),
                vector3(-1321.701, -1264.167, 4.578003),
                vector3(-1498.009, -204.6857, 50.88135),
                vector3(-3047.578, 589.9517, 7.779541),
                vector3(-689.4066, 5789.143, 17.31653),
                vector3(125.6703, 6644.07, 31.79053),
                vector3(1700.927, 4857.758, 42.01831),
                vector3(2670.752, 3286.167, 55.22852),
                vector3(2357.552, 2609.631, 47.22485),
                vector3(2696.281, 1613.829, 24.41028),
                vector3(1832.07, -1182.475, 91.53992),
                vector3(1075.451, -2330.585, 30.29089),
                vector3(1054.062, -1952.716, 32.09375),
                vector3(1141.068, -1622.519, 35.41321), 
            },
            itens = {
                { item = 'eter', quantity = { min = 25, max = 30 } },
                { item = 'efedrina', quantity = { min = 25, max = 30 } },
                { item = 'seringa', quantity = { min = 3, max = 7 } },
                { item = 'agulha', quantity = { min = 3, max = 7 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['vaselina'] = {
            name = 'Vaselina',
            coords = {
                vector3(1125.152, -1010.453, 44.6637),
                vector3(572.0439, 114, 98.2124),
                vector3(-104.5714, -69.36263, 58.85132),
                vector3(-1321.701, -1264.167, 4.578003),
                vector3(-1498.009, -204.6857, 50.88135),
                vector3(-3047.578, 589.9517, 7.779541),
                vector3(-689.4066, 5789.143, 17.31653),
                vector3(125.6703, 6644.07, 31.79053),
                vector3(1700.927, 4857.758, 42.01831),
                vector3(2670.752, 3286.167, 55.22852),
                vector3(2357.552, 2609.631, 47.22485),
                vector3(2696.281, 1613.829, 24.41028),
                vector3(1832.07, -1182.475, 91.53992),
                vector3(1075.451, -2330.585, 30.29089),
                vector3(1054.062, -1952.716, 32.09375),
                vector3(1141.068, -1622.519, 35.41321), 
            },
            itens = {
                { item = 'eter', quantity = { min = 15, max = 30 } },
                { item = 'efedrina', quantity = { min = 15, max = 30 } },
                { item = 'seringa', quantity = { min = 1, max = 3 } },
                { item = 'agulha', quantity = { min = 1, max = 3 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['Ticket'] = {
            name = 'Ticket',
            coords = {
                vector3(-62.65055, -2509.648, 11.33484),
                vector3(-539.8154, -1638.013, 19.87769),
                vector3(-1125.956, -967.2791, 6.616821),
                vector3(-2016.092, 559.2132, 108.3055),
                vector3(-1125.653, 2694.528, 18.79932),
                vector3(-35.52527, 2871.534, 59.6095),
                vector3(699.2703, 3115.094, 44.07397),
                vector3(2392.879, 3320.413, 48.45496),
                vector3(2160.237, 4789.596, 41.95093),
                vector3(2834.98, 2806.892, 57.38538),
                vector3(2589.666, 483.244, 108.6593),
                vector3(2549.459, -314.5187, 93.15747),
                vector3(1890.435, -1019.327, 78.56555),
                vector3(1269.824, -1906.985, 39.42346),
                vector3(974.3077, -1937.301, 32.21167),
                vector3(892.3121, -2171.842, 32.27917),
                vector3(701.8154, -2194.919, 29.54944),
                vector3(557.2352, -2716.576, 7.105469),
            },
            itens = {
                { item = 'plastico', quantity = { min = 10, max = 25 } },
                { item = 'ferro', quantity = { min = 15, max = 35 } },
                { item = 'folha-papel', quantity = { min = 1, max = 10 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        ['RaceTablet'] = {
            name = 'Tablet de Corrida',
            coords = {
                vector3(-62.65055, -2509.648, 11.33484),
                vector3(-539.8154, -1638.013, 19.87769),
                vector3(-1125.956, -967.2791, 6.616821),
                vector3(-2016.092, 559.2132, 108.3055),
                vector3(-1125.653, 2694.528, 18.79932),
                vector3(-35.52527, 2871.534, 59.6095),
                vector3(699.2703, 3115.094, 44.07397),
                vector3(2392.879, 3320.413, 48.45496),
                vector3(2160.237, 4789.596, 41.95093),
                vector3(2834.98, 2806.892, 57.38538),
                vector3(2589.666, 483.244, 108.6593),
                vector3(2549.459, -314.5187, 93.15747),
                vector3(1890.435, -1019.327, 78.56555),
                vector3(1269.824, -1906.985, 39.42346),
                vector3(974.3077, -1937.301, 32.21167),
                vector3(892.3121, -2171.842, 32.27917),
                vector3(701.8154, -2194.919, 29.54944),
                vector3(557.2352, -2716.576, 7.105469),
            },
            itens = {
                { item = 'plastico', quantity = { min = 4, max = 10 } },
                { item = 'ferro', quantity = { min = 10, max = 20 } },
                { item = 'aluminio', quantity = { min = 10, max = 20 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 5000,
                randomFixed = true,
            }
        },

        --==============================================================================================================
        -- Attachs
        --==============================================================================================================

        ['Attachs'] = {
            name = 'Attachs',
            coords = {
                vector3(851.7758, -2894.492, 11.25061),
                vector3(-253.2923, -2591.209, 5.993408),
                vector3(200.0044, -2002.127, 18.84985),
                vector3(-924.7516, -1163.921, 4.813965),
                vector3(-2956.312, 385.6879, 15.00806),
                vector3(-2565.692, 2307.178, 33.20581),
                vector3(-2173.78, 4282.18, 49.11206),
                vector3(-414, 6171.561, 31.47034),
                vector3(1538.875, 6321.917, 25.05054),
                vector3(2029.714, 4980.633, 42.08569),
                vector3(1353.046, 3607.187, 34.90771),
                vector3(318.9363, 268.8396, 104.5143),
                vector3(992.8483, -1527.547, 30.96484),
                vector3(1017.996, -2192.611, 31.6051),
            },
            itens = {
                { item = 'borracha', quantity = { min = 20, max = 30 } },
                { item = 'plastico', quantity = { min = 20, max = 30 } },
                { item = 'cobre', quantity = { min = 10, max = 20 } },
                { item = 'aluminio', quantity = { min = 20, max = 35 } },
                { item = 'ferro', quantity = { min = 20, max = 35 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 7000,
                randomFixed = true,
            }
        },
        ['chimas'] = {
            name = 'Chimas',
            coords = {
                vector3(33.2044, 6672.949, 32.17798),
                vector3(1741.596, 6419.855, 35.04248),
                vector3(2584.853, 5061.139, 44.9165),
                vector3(1429.675, 4377.587, 44.59631),
                vector3(22.64176, 3671.789, 39.74353),
                vector3(-2173.82, 4282.167, 49.11206),
                vector3(-1490.492, 4981.49, 63.35022),
                vector3(-841.345, 5401.161, 34.60437)
            },
            itens = {
                { item = 'gtermica', quantity = { min = 20, max = 30 } },
                { item = 'cuia', quantity = { min = 20, max = 30 } },
                { item = 'erva-mate', quantity = { min = 10, max = 20 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 7000,
                randomFixed = true,
            }
        },
        ['grotorante'] = {
            name = 'Grotorante',
            coords = {
                vector3(-1750.325, -696.9626, 9.632935),
                vector3(-1383.824, 267.5472, 61.22705),
                vector3(-685.9121, 223.0154, 81.93555),
                vector3(-174.8176, 219.244, 90.00659),
                vector3(-22.18022, -192.1582, 52.34729),
                vector3(373.5824, -737.9736, 29.26306),
                vector3(446.0176, -1234.734, 29.93701),
                vector3(516.2901, -1617.376, 29.27991),
                vector3(205.6879, -1827.6, 28.01611),
                vector3(-614.7165, -1787.38, 23.68567),
                vector3(-692.0703, -1297.306, 5.100342),
                vector3(-785.4857, -1044.396, 12.96924),
                vector3(-1350.91, -939.666, 9.700317),
                vector3(-1529.367, -908.6638, 10.15527)
            },
            itens = {
                { item = 'sling', quantity = { min = 10, max = 20 } },
                { item = 'granulado', quantity = { min = 10, max = 20 } },
                { item = 'potedechoco', quantity = { min = 10, max = 20 } },
                { item = 'ervac', quantity = { min = 10, max = 20 } },
                { item = 'manteiga', quantity = { min = 10, max = 20 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 7000,
                randomFixed = true,
            }
        },
        ['melgual'] = {
            name = 'Melgual',
            coords = {
                vector3(-1750.325, -696.9626, 9.632935),
                vector3(-1383.824, 267.5472, 61.22705),
                vector3(-685.9121, 223.0154, 81.93555),
                vector3(-174.8176, 219.244, 90.00659),
                vector3(-22.18022, -192.1582, 52.34729),
                vector3(373.5824, -737.9736, 29.26306),
                vector3(446.0176, -1234.734, 29.93701),
                vector3(516.2901, -1617.376, 29.27991),
                vector3(205.6879, -1827.6, 28.01611),
                vector3(-614.7165, -1787.38, 23.68567),
                vector3(-692.0703, -1297.306, 5.100342),
                vector3(-785.4857, -1044.396, 12.96924),
                vector3(-1350.91, -939.666, 9.700317),
                vector3(-1529.367, -908.6638, 10.15527)
            },
            itens = {
                { item = 'gtermica', quantity = { min = 20, max = 30 } },
                { item = 'cuia', quantity = { min = 20, max = 30 } },
                { item = 'erva-mate', quantity = { min = 10, max = 20 } },
                { item = 'mel', quantity = { min = 10, max = 20 } },
                { item = 'farinha-trigo', quantity = { min = 10, max = 20 } },
                { item = 'potedechoco', quantity = { min = 10, max = 20 } },
                { item = 'manteiga', quantity = { min = 10, max = 20 } },
            },
            extras = {
                anim = 'caixa',
                timeout = 7000,
                randomFixed = true,
            }
        },

        -- ['Aviaozinho'] = {
        --     name = 'Aviaozinho',
        --     coords = {
        --         vector3(-1269.666, -1913.934, 5.858643),
        --         vector3(-1811.156, -1225.569, 13.01978),
        --         vector3(-1453.306, 417.2703, 109.8557),
        --         vector3(190.0088, 309.1516, 105.3737),
        --         vector3(143.9604, -689.2879, 33.12158),
        --         vector3(1154.532, -785.3538, 57.58752),
        --         vector3(869.7231, -2326.932, 30.59412),
        --         vector3(-517.4374, -2904.277, 5.993408),
        --         vector3(-1079.143, -2726.202, 14.38464),
        --         vector3(-546.0527, -873.5472, 27.19043),
        --         vector3(313.5428, -174.5275, 58.10986),
        --         vector3(-85.7934, 357.1121, 112.4337),
        --         vector3(-1649.604, 248.7692, 62.38977),
        --         vector3(-191.3802, -1179.02, 23.06226),
        --     },
        --     itens = {
        --         {
        --             item = 'maconha',
        --             quantity = 1,
        --             payment = 2800,
        --             receive = 'dinheirosujo'
        --         },
        --         {
        --             item = 'cocaina',
        --             quantity = 1,
        --             payment = 2800,
        --             receive = 'dinheirosujo'
        --         },
        --         {
        --             item = 'metanfetamina',
        --             quantity = 1,
        --             payment = 2800,
        --             receive = 'dinheirosujo'
        --         },
        --         {
        --             item = 'lanca-perfume',
        --             quantity = 1,
        --             payment = 2800,
        --             receive = 'dinheirosujo'
        --         },
        --     },
        --     texts = {
        --         text = '~b~E~w~ - Entregar',
        --         progress = 'Entregando droga...'
        --     },
        --     extras = {
        --         anim = 'pegar',
        --         drug = true, -- Deixar true somente quando for rota de venda de droga.
        --         police = 70,
        --         timeout = 5000,
        --     }
        -- },
    },

    locations = {
        ['armas'] = { coord = vector3(0,0,0), config = 'Arma', cooldown = 3600, perm = { 'mds.permissao', 'dinastia.permissao', 'staff.permissao' } },
        ['armas_tecido'] = { coord = vector3(1120.747, -1523.763, 34.84033), config = 'ArmaComTecido', cooldown = 3600, perm = { 'comandonorte.permissao', 'ratoeira.permissao', 'staff.permissao' } },
        ['municao'] = { coord = vector3(0,0,0), config = 'Municao', cooldown = 3600, perm = { 'osveio.permissao', 'hydra.permissao', 'staff.permissao', 'palhacos.permissao' } },
        ['farinha'] = { coord = vector3(435.8242, 6453.271, 28.7406), config = 'Farinha', cooldown = 3600, perm = { 'montecristo.permissao', 'mantem.permissao', 'ciringa.permissao', 'umbrella.permissao', 'staff.permissao' } },
        ['viagra'] = { coord = vector3(1137.943, -1621.464, 34.87402), config = 'Viagra', cooldown = 3600, perm = { 'underdogs.permissao', 'boiadeiras.permissao', 'staff.permissao' } },
        ['balinha'] = { coord = vector3(435.8242, 6453.271, 28.7406), config = 'Bala', cooldown = 3600, perm = { 'balinha.permissao', 'staff.permissao' } },
        ['meta'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'Metanfetamina', cooldown = 3600, perm = {  'juramento.permissao', 'cartelnpn.permissao', 'dinastia.permissao', 'staff.permissao', 'observatorio.permissao', 'phoenix.permissao' } },     
        ['erva'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'Maconha', cooldown = 3600, perm = { 'bras.permissao', 'dubaigang.permissao', 'helipa.permissao', 'aztecas.permissao', 'lafronteira.permissao', 'medelin.permissao', 'staff.permissao' } },
        ['heroina'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'Heroina', cooldown = 3600, perm = { 'juramento.permissao', 'mare.permissao', 'penha.permissao', 'cdd.permissao', 'turano.permissao', 'staff.permissao' } },
        ['rape_ayahuasca'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'rape_ayahuasca', cooldown = 3600, perm = { 'wanana.permissao' } },
        ['oxy'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'Oxy', cooldown = 3600, perm = { 'barragem.permissao', 'fundao.permissao', 'staff.permissao' } },
        ['lanca'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'Lanca', cooldown = 3600, perm = { 'bahamas.permissao', 'morromina.permissao', 'dende.permissao', 'staff.permissao' } },
        ['nitro'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'Nitro', cooldown = 3600, perm = { 'bennystunner.permissao', 'staff.permissao' } },
        ['chave-nitro'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'ChaveNitro', cooldown = 3600, perm = { 'staff.permissao' } },
        ['flipper'] = { coord = vector3(198.0132, -2201.895, 6.970703), config = 'flipper', cooldown = 3600, perm = { 'triade.permissao', 'staff.permissao' } },
        ['mecanica_troll'] = { coord = vector3(2507.393, 4209.455, 39.91211), config = 'mecanica_troll', cooldown = 3600, perm = { 'palhacos.permissao', 'staff.permissao' } },
        ['bloq_master'] = { coord = vector3(2507.393, 4209.455, 39.91211), config = 'BloqueadorMasterpick', cooldown = 3600, perm = { 'comitiva.permissao', 'blackout.permissao', 'staff.permissao' } },
        ['c4'] = { coord = vector3(-1137.099, -1452.105, 4.797119), config = 'BombaC4', cooldown = 3600, perm = { 'ghost.permissao', 'caos.permissao', 'lospraca.permissao', 'staff.permissao' } },
        ['colete'] = { coord = vector3(396.2505, 352.1934, 102.5428), config = 'CapuzColeteAlgema', cooldown = 3600, perm = { 'thefusion.permissao', 'medelin.permissao', 'hydra.permissao', 'irmandade.permissao', 'motoclub.permissao', 'olimpo.permissao', 'staff.permissao' } },
        
        
        ['placa_ticket'] = { coord = vector3(0,0,0), config = 'PlacaTicket', cooldown = 3600, perm = { 'bennys.permissao', 'sindicato.permissao', 'staff.permissao' } },
        ['ticket'] = { coord = vector3(0,0,0), config = 'Ticket', cooldown = 3600, perm = { 'bennystunner.permissao', 'staff.permissao' } },
        ['racetablet'] = { coord = vector3(0,0,0), config = 'RaceTablet', cooldown = 3600, perm = { 'staff.permissao' } },
        ['kit_desmanche'] = { coord = vector3(0,0,0), config = 'KitDesmanche', cooldown = 3600, perm = { 'chines.permissao', 'cupim.permissao' } },
        ['kit_desmanche_dificil'] = { coord = vector3(0,0,0), config = 'KitDesmancheDificil', cooldown = 3600, perm = { 'oscrias.permissao' } },
        ['adrenalina'] = { coord = vector3(0,0,0), config = 'Adrenalina', cooldown = 3600, perm = { 'bennystunner.permissao', 'olimpo.permissao', 'cosanostra.permissao', 'staff.permissao' } },
        ['vaselina'] = { coord = vector3(0,0,0), config = 'vaselina', cooldown = 3600, perm = { 'mptv.permissao' } },
        ['wattachs'] = { coord = vector3(0,0,0), config = 'Attachs', cooldown = 3600, perm = { 'k10.permissao', 'legiao.permissao', 'venezza.permissao', 'staff.permissao' } },
        ['chimas'] = { coord = vector3(0,0,0), config = 'chimas', cooldown = 3600, perm = { 'bandodosgauchos.permissao' } },
        ['grotorante'] = { coord = vector3(0,0,0), config = 'grotorante', cooldown = 3600, perm = { 'grotorante.permissao' } },
        ['melgual'] = { coord = vector3(0,0,0), config = 'melgual', cooldown = 3600, perm = { 'melgual.permissao' } },
        ['Melzinho'] = { coord = vector3(0,0,0), config = 'Melzinho', cooldown = 3600, perm = { 'tropical.permissao' } },
    }
}
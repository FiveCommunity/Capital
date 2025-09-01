config = {
    ['generalFuel'] = {

        GalaoPrice = 1500,
        GalaoFuelPrice = 2500,

        FuelDecor = 'FUEL_LEVEL',

        DisableKeys = { 0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323 },

        Classes = {
            [0] = 0.3, -- Compacts
            [1] = 0.3, -- Sedans
            [2] = 0.3, -- SUVs
            [3] = 0.3, -- Coupes
            [4] = 0.3, -- Muscle
            [5] = 0.3, -- Sports Classics
            [6] = 0.3, -- Sports
            [7] = 0.3, -- Super
            [8] = 0.3, -- Motorcycles
            [9] = 0.3, -- Off-road
            [10] = 0.3, -- Industrial
            [11] = 0.3, -- Utility
            [12] = 0.3, -- Vans
            [13] = 0.0, -- Cycles
            [14] = 0.0008, -- Boats
            [15] = 1, -- Helicopters
            [16] = 0.1, -- Planes
            [17] = 0.3, -- Service
            [18] = 0.3, -- Emergency
            [19] = 0.3, -- Military
            [20] = 0.3, -- Commercial
            [21] = 0.3, -- Trains
        },

        FuelUsage = {
            [1.0] = 1.0,
            [0.9] = 0.9,
            [0.8] = 0.8,
            [0.7] = 0.7,
            [0.6] = 0.6,
            [0.5] = 0.5,
            [0.6] = 0.6,
            [0.3] = 0.3,
            [0.2] = 0.2,
            [0.1] = 0.1,
            [0.0] = 0.1,
        },

        vehicleEletrical = {
            [GetHashKey('neon')] = true,
            [GetHashKey('raiden')] = true,
            [GetHashKey('tesla')] = true,
            [GetHashKey('teslaprior')] = true,
            [GetHashKey('cyclone')] = true,
            [GetHashKey('tezeract')] = true,
        }
    },
    
    ['configFuelXeroC'] = {
        blip = {
            name = 'Posto de Combustivel C',
            blipId = 361,
            blipColor = 1,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'xero',
            fuelPumps = {
                {hash = -2007231801, type = 'car', price = 3.5, paymentType = 2}
            },
        }
    },

    ['configFuelXeroC2'] = {
        blip = {
            name = 'Posto de Combustivel C', 
            blipId = 361, 
            blipColor = 1,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'xero',
            fuelPumps = {
                {hash = -469694731, type = 'car', price = 2.0, paymentType = 1}
            },
        }
    },

    ['configFuelXeroCE'] = {
        blip = {
            name = 'Posto de Combustivel C + E',
            blipId = 361,
            blipColor = 17,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'xero',
            fuelPumps = {
                {hash = -2007231801, type = 'car', price = 3, paymentType = 1},
                {hash = -132092731, type = 'eletrical', price = 3, paymentType = 1}
            },
        }
    },

    ['configFuelXeroCE2'] = {
        blip = {
            name = 'Posto de Combustivel C + E',
            blipId = 361,
            blipColor = 17,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'xero',
            fuelPumps = {
                {hash = -469694731, type = 'car', price = 3, paymentType = 1},
                {hash = -132092731, type = 'eletrical', price = 3, paymentType = 1}
            },
        }
    },

    ['configFuelXeroHeli'] = {
        blip = {
            name = 'Posto de Combustivel C',
            blipId = 361,
            blipColor = 38,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'xero',
            fuelPumps = {
                {hash = -469694731, type = 'heli', price = 2.5, paymentType = 1}
            },
        }
    },

    ['configFuelOilC'] = {
        blip = {
            name = 'Posto de Combustivel C',
            blipId = 361,
            blipColor = 1,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'oil',
            fuelPumps = {
                {hash = 1339433404, type = 'car', price = 3, paymentType = 1}
            },
        }
    },

    ['configFuelOilCE'] = {
        blip = {
            name = 'Posto de Combustivel C + E',
            blipId = 361,
            blipColor = 17,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'oil',
            fuelPumps = {
                {hash = 1339433404, type = 'car', price = 3, paymentType = 1},
                {hash = -132092731, type = 'eletrical', price = 3, paymentType = 1}
            },
        }
    },

    ['configFuelLtdC'] = {
        blip = {
            name = 'Posto de Combustivel C',
            blipId = 361,
            blipColor = 1,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'ltd',
            fuelPumps = {
                {hash = 1933174915, type = 'car', price = 3, paymentType = 1}
            },
        }
    },

    ['configFuelLtdC2'] = {
        blip = {
            name = 'Posto de Combustivel C',
            blipId = 361,
            blipColor = 1,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'ltd',
            fuelPumps = {
                {hash = -164877493, type = 'car', price = 2, paymentType = 1}
            },
        }
    },

    ['configFuelLtdCE'] = {
        blip = {
            name = 'Posto de Combustivel C + E',
            blipId = 361,
            blipColor = 17,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'ltd',
            fuelPumps = {
                {hash = 1933174915, type = 'car', price = 3, paymentType = 1},
                {hash = -132092731, type = 'eletrical', price = 3, paymentType = 1}
            },
        }
    },

    ['configFuelGlobeOilC'] = {
        blip = {
            name = 'Posto de Combustivel C',
            blipId = 361,
            blipColor = 1,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'globeoil',
            fuelPumps = {
                {hash = -462817101, type = 'car', price = 2, paymentType = 1}
            },
        }
    },

    ['configFuelGlobeOilC2'] = {
        blip = {
            name = 'Posto de Combustivel C',
            blipId = 361,
            blipColor = 1,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'globeoil',
            fuelPumps = {
                {hash = 1694452750, type = 'car', price = 1.8, paymentType = 1}
            },
        }
    },

    ['configFuelGlobeOilCE'] = {
        blip = {
            name = 'Posto de Combustivel C + E',
            blipId = 361,
            blipColor = 17,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'globeoil',
            fuelPumps = {
                {hash = 1694452750, type = 'car', price = 3, paymentType = 1},
                {hash = -132092731, type = 'eletrical', price = 3, paymentType = 1}
            },
        }
    },

    ['configFuelGlobeOilCE2'] = {
        blip = {
            name = 'Posto de Combustivel C + E',
            blipId = 361,
            blipColor = 17,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'globeoil',
            fuelPumps = {
                {hash = -462817101, type = 'car', price = 3, paymentType = 1},
                {hash = -132092731, type = 'eletrical', price = 3, paymentType = 1}
            },
        }
    },

    ['configPearl'] = {
        blip = {
            name = 'Posto de Combustivel C + E',
            blipId = 361,
            blipColor = 17,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'pearl',
            fuelPumps = {
                {hash = 1767019582, type = 'car', price = 3, paymentType = 1},
                {hash = -132092731, type = 'eletrical', price = 3, paymentType = 1}
            },
        }
    },

    ['configChiliad'] = {
        blip = {
            name = 'Posto de Combustivel C',
            blipId = 361,
            blipColor = 1,
            blipScale = 0.5,
        },  

        configFuel = {
            fuelBrand = 'pearl',
            fuelPumps = {
                {hash = -164877493, type = 'car', price = 3, paymentType = 1},
            },
        }
    },
    
    locs = {
        { showBlip = true, markerDistance = 30.0, coord = vector3(262.34,-1259.98,29.14), heading = 359.29, config = 'configFuelXeroC', id = 1 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(48.36,2777.501,57.88), heading = 359.29, config = 'configFuelXeroC2', id = 2 },
        { showBlip = false, markerDistance = 30.0, coord = vector3(2004.83,3774.01,32.40), heading = 359.29, config = 'configFuelXeroC2', id = 3 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(-97.75,6416.14,31.63), heading = 359.29, config = 'configFuelXeroC2', id = 4 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(-526.30,-1210.94,18.18), heading = 359.29, config = 'configFuelXeroCE', id = 5 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(-2096.90,-317.83,13.01), heading = 359.29, config = 'configFuelXeroCE', id = 6 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(2680.04,3264.54,55.40), heading = 359.29, config = 'configFuelXeroCE2', id = 7 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(-705.99,-1464.65,5.04), heading = 359.29, config = 'configFuelXeroHeli', id = 8 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(-763.76,-1434.84,5.05), heading = 359.29, config = 'configFuelXeroHeli', id = 9 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(174.65,-1561.59,29.26), heading = 359.29, config = 'configFuelOilC', id = 10 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(817.83,-1028.31,26.28), heading = 359.29, config = 'configFuelOilC', id = 11 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(-1437.64,-275.96,46.20), heading = 359.29, config = 'configFuelOilC', id = 12 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(-2555.06,2333.85,33.07), heading = 359.29, config = 'configFuelOilC', id = 13 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(179.90,6604.00,32.04), heading = 359.29, config = 'configFuelOilC', id = 14 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(1208.77,-1402.41,35.22), heading = 359.29, config = 'configFuelOilCE', id = 15 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(2581.34,362.21,108.46), heading = 359.29, config = 'configFuelOilCE', id = 16 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(-66.24,-1762.22,29.25), heading = 359.29, config = 'configFuelLtdC', id = 17 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(1182.01,-330.64,69.31), heading = 359.29, config = 'configFuelLtdC', id = 18 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(-1800.05,804.011,138.65), heading = 359.29, config = 'configFuelLtdC', id = 19 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(1690.35,4928.67,42.23), heading = 359.29, config = 'configFuelLtdC2', id = 20 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(-722.32,-935.76,19.01), heading = 359.29, config = 'configFuelLtdCE', id = 21 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(263.70,2608.21,44.86), heading = 359.29, config = 'configFuelGlobeOilC', id = 22 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(1206.72,2659.00,37.80), heading = 359.29, config = 'configFuelGlobeOilC', id = 23 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(1784.32,3330.55,41.253), heading = 359.29, config = 'configFuelGlobeOilC', id = 24 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(1700.88,6416.93,32.76), heading = 359.29, config = 'configFuelGlobeOilC2', id = 25 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(-315.89,-1471.24,30.54), heading = 359.29, config = 'configFuelGlobeOilCE', id = 26 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(621.03,268.3,103.09), heading = 359.29, config = 'configFuelGlobeOilCE', id = 27 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(1039.88,2670.57,39.55), heading = 359.29, config = 'configFuelGlobeOilCE2', id = 28 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(154.54,6628.83,31.74), heading = 359.29, config = 'configFuelGlobeOilCE2', id = 29 },

        { showBlip = true, markerDistance = 30.0, coord = vector3(-496.9583, 7567.886, 6.515747), heading = 359.29, config = 'configPearl', id = 30 },
        { showBlip = true, markerDistance = 30.0, coord = vector3(358.9319, 5371.714, 671.4768), heading = 0.0, config = 'configChiliad', id = 31 },

        -- Cidade perfeita -- 
        { showBlip = true, markerDistance = 30.0, coord = vector3(-34.06154, -5254.497, 6.448364), heading = 200, config = 'configFuelGlobeOilCE', id = 32 },
    }
}

-- [ Globals ] --

Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

if (IsDuplicityVersion()) then
    vRPclient = Tunnel.getInterface('vRP')
else
    vRPserver = Tunnel.getInterface('vRP')
end
local config = {}

config.blips = {
    -- [ Shopping ] --
    { coords = vector3(-586.9055, -618.4879, 41.42859), sprite = 408, color = 0, nome = 'Agência de Empregos', scale = 0.5 },
    { coords = vector3(-106.3253, -5531.301, 3.516479), sprite = 408, color = 0, nome = 'Empregos Perfeitos', scale = 0.5 },
    { coords = vector3(-525.2308, -594.9626, 41.42859), sprite = 108, color = 48, nome = 'Loja VIP', scale = 0.5 },

    -- [ Hospital ] --
    { coords = vector3(-2037.508, -482.2813, 12.43005), sprite = 153, color = 0, nome = 'Hospital', scale = 0.9 },
    { coords = vector3(1743.125, 3511.556, 36.81177), sprite = 153, color = 0, nome = 'Hospital Norte', scale = 0.9 },
    { coords = vector3(-526.9055, 7377.376, 12.83447), sprite = 153, color = 0, nome = 'Hospital Ilha', scale = 0.9 },
    { coords = vector3(-182.8615, -5122.417, 7.796387), sprite = 153, color = 0, nome = 'Hospital Perfeito', scale = 0.9 },

    -- [ Jurídico ] --
    { coords = vector3(236.4527, -409.4373, 47.91577), sprite = 79, color = 0, nome = 'Tribunal', scale = 0.7 },

    -- [ Mecânica ] -- 
    { coords = vector3(946.1671, -986.1758, 39.45715), sprite = 402, color = 0, nome = 'Borracharia', scale = 0.9 },
    { coords = vector3(1766.954, 3319.859, 41.42859), sprite = 402, color = 0, nome = 'Mecânica do norte', scale = 0.9 },
    { coords = vector3(2700.633, 3499.24, 56.64392), sprite = 402, color = 0, nome = 'Mecânica Bracho', scale = 0.9 },
    { coords = vector3(-353.8154, -117.2044, 51.0498), sprite = 72, color = 0, nome = "Benny's Tunner", scale = 0.7 },
    { coords = vector3(156.6593, -3038.387, 7.02124), sprite = 72, color = 50, nome = "Benny's Custom", scale = 0.7 },
    { coords = vector3(23.70989, -5713.016, 5.976563), sprite = 402, color = 50, nome = "Mecânica Perfeita", scale = 0.7 },

    -- [ Concessionaria ] -- 
    { coords = vector3(-73.05495, 67.85934, 71.72449), sprite = 326, color = 0, nome = 'Concessionária', scale = 0.7 },
    { coords = vector3(-883.7407, 6669.864, 3.415405), sprite = 427, color = 0, nome = 'Roxwood Boats', scale = 0.7 },

    -- [ Policia ] -- 
    { coords = vector3(-1246.536, -2154.171, 14.18237), sprite = 60, color = 0, nome = 'Força Tática', scale = 0.7 },
    { coords = vector3(-1215.178, -2278.022, 14.56995), sprite = 60, color = 0, nome = 'Rota', scale = 0.7 },
    { coords = vector3(-589.6484, -1035.007, 35.04248), sprite = 60, color = 0, nome = 'PMC', scale = 0.7 },
    { coords = vector3(459.2835, -991.1077, 24.89893), sprite = 60, color = 0, nome = 'Policia Civil', scale = 0.7 },
    { coords = vector3(2606.308, 5342.914, 47.59558), sprite = 60, color = 0, nome = 'Policia Federal', scale = 0.7 },
    { coords = vector3(682.2725, 219.9033, 93.10693), sprite = 60, color = 0, nome = 'GCC', scale = 0.7 },
    { coords = vector3(-461.4989, 6014.268, 35.41321), sprite = 60, color = 0, nome = 'BAEP', scale = 0.7 },
    { coords = vector3(-27.96923, -4849.438, 20.06299), sprite = 60, color = 0, nome = 'PCP', scale = 0.7 },

    -- [ Joalheria ] -- 
    { coords = vector3(-631.6747, -237.7451, 38.05859), sprite = 617, color = 30, nome = 'Joalheria', scale = 0.8 },

    -- [ Auto Escola ] --
    { coords = vector3(-41.34066, -214.9846, 45.79272), sprite = 76, color = 0, nome = 'Auto Escola', scale = 0.5 },

    -- [ Laricas ] --
    { coords = vector3(-1815.376, -1191.547, 14.28357), sprite = 77, color = 44, nome = 'Laricas', scale = 0.5 },

    -- [ Pautorante ] --
    { coords = vector3(-1611.349, -982.9187, 13.00293), sprite = 267, color = 44, nome = 'Pautorante', scale = 0.5 },
    -- [ PauNitrante ] --
    { coords = vector3(2050.365, 3680.519, 36.18823), sprite = 643, color = 27, nome = 'PauNitrante', scale = 0.5 },
    -- [ PauNitrante ] --
    { coords = vector3(10.9055, -5704.193, 6.010254), sprite = 643, color = 27, nome = 'Nitros Perfeitos', scale = 0.5 },

    -- [ Teleféricos ] --
    { coords = vector3(444.1187, 5572.114, 784.6404), sprite = 79, color = 0, nome = 'Teleférico', scale = 0.4 },
    { coords = vector3(-744.2242, 5595.719, 42.74292), sprite = 79, color = 0, nome = 'Teleférico', scale = 0.4 },
    
    -- [ Empregos ] --
    { coords = vector3(-512.2022, -1747.371, 19.2373), sprite = 318, color = 2, nome = 'Emprego: Reciclagem', scale = 0.6 },
    { coords = vector3(2441.433, 4767.231, 34.30115), sprite = 387, color = 2, nome = 'Emprego: Ordenha', scale = 0.7 },
    { coords = vector3(2509.49, 4837.635, 35.73328), sprite = 89, color = 21, nome = 'Emprego: Colheita', scale = 0.6 },
    { coords = vector3(390.8571, 6497.881, 27.17358), sprite = 89, color = 21, nome = 'Emprego: Colheita', scale = 0.6 },
    { coords = vector3(-1814.413, 7006.009, 34.45276), sprite = 89, color = 21, nome = 'Emprego: Colheita', scale = 0.6 },
    { coords = vector3(2350.141, 5003.051, 42.84399), sprite = 89, color = 21, nome = 'Emprego: Colheita', scale = 0.6 },
    { coords = vector3(5352, -5331.481, 41.54651), sprite = 89, color = 21, nome = 'Emprego: Colheita', scale = 0.6 },
    { coords = vector3(408.7912, -1635.969, 29.27991), sprite = 477, color = 47, nome = 'Emprego: Impound', scale = 0.6 },
    { coords = vector3(432.9099, 3576.963, 33.22266), sprite = 477, color = 47, nome = 'Emprego: Impound', scale = 0.6 },
    { coords = vector3(2953.2, 2746.55, 43.46741), sprite = 124, color = 30, nome = 'Emprego: Mineradora', scale = 0.6 },
    { coords = vector3(-2082.303, 2548.497, 16.23804), sprite = 89, color = 1, nome = 'Emprego: Caçador', scale = 0.6 },
}

return config
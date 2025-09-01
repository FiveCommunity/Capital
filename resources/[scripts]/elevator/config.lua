config = {}

config.general = {
    ['hospital_01'] = {
        name = 'Elevador Hospital',
        locations = {
            { coord = vector4(306.2637, -591.6, 47.27551, 68.03149), text = 'Andar 2°' },
            { coord = vector4(306.0659, -591.5341, 43.26526, 70.86614), text = 'Térreo' },
        }
    },
    ['hospital_02'] = {
        name = 'Elevador Hospital',
        locations = {
            { coord =vector4(305.0901, -594.0791, 47.27551, 68.03149), text = 'Andar 2°' },
            { coord = vector4(305.4066, -594.2242, 43.26526, 68.03149), text = 'Térreo' },
        }
    },
    ['hospital_03'] = {
        name = 'Elevador Hospital',
        locations = {
            { coord = vector4(329.6703, -582.0264, 74.16772, 252.2835), text = 'Terraço' },
            { coord = vector4(317.0769, -571.4242, 47.27551, 155.9055), text = 'Andar 2°' },
            { coord = vector4(317.0638, -571.4769, 43.26526, 153.0709), text = 'Térreo' },
        }
    },
    ['hospital_04'] = {
        name = 'Elevador Hospital',
        locations = {
            { coord = vector4(330.6066, -579.3362, 74.16772, 260.7874), text = 'Terraço' },
            { coord = vector4(319.7802, -572.334, 47.27551, 155.9055), text = 'Andar 2°' },
            { coord = vector4(319.7143, -572.3077, 43.26526, 155.9055), text = 'Térreo' },
        }
    },

    --[ NOVO HP ]===============================================================
    
    ['hospitalb_01'] = {
        name = 'Elevador Hospital',
        locations = {
            { coord = vector4(-2088.013, -473.0374, 26.41541, 326.0), text = 'Andar 4°' },
            { coord = vector4(-2088.791, -472.3517, 21.81543, 326.0), text = 'Andar 3°' },
            { coord = vector4(-2088.791, -472.3517, 17.21533, 326.0), text = 'Andar 2°' },
            { coord = vector4(-2088.791, -472.3517, 12.43005, 326.0), text = 'Andar 1°' },
        }
    },

    --==========================================================================
    
    ['escritorio_juridico'] = {
        name = 'Elevador Jurídico',
        locations = {
            { coord = vector4(234.4747, -430.3253, 48.08423, 62.36221), text = 'Andar 1°' },
            { coord = vector4(-141.7582, -621.0593, 168.8132, 283.4646), text = 'Andar 2°' },
        }
    },
    ['motel'] = {
        name = 'Elevador Motel',
        locations = {
            { coord = vector4(947.9209, 50.75605, 75.11133, 277.7953), text = 'Cassino - 1° Andar' },
            { coord = vector4(965.1824, 58.50989, 112.5516, 51.02362), text = 'Cassino - 2° Andar' },
            { coord = vector4(129.9429, -1284.897, -84.22046, 175.748), text = 'Motel' },
            { coord = vector4(-611.1033, 7012.404, 24.29236, 232.4409), text = 'Entrada Motel' },
        }
    },
    ['mazebank'] = {
        name = 'Elevador MazeBank',
        locations = {
            { coord = vector4(-84.32967, -821.8681, 36.01978, 348.6614), text = 'Andar 1°' },
            { coord = vector4(-75.38901, -827.1956, 243.3737, 70.86614), text = 'Andar 2°' },
            { coord = vector4(-67.84615, -821.6572, 321.2872, 249.4488), text = 'H' },
        }
    },
    ['coberturasaopaulo'] = {
        name = 'Cobertura São Paulo',
        locations = {
            { coord = vector4(-288.4352, -722.5187, 125.4586, 249.4488), text = 'Cobertura' },
            { coord = vector4(-304.8659, -720.9626, 28.01611, 158.7402), text = 'Terreo' },
        }
    },

    ['thefusion'] = {
        name = 'The Fusion',
        locations = {
            { coord = vector4(380.4659, -15.17802, 82.99707, 36.8504), text = 'Terreo' },
            { coord = vector4(417.5077, -10.87912, 99.64465, 232.4409), text = 'Primeiro andar' },
        }
    },

    ['rooftop01'] = {
        name = 'Rooftop 01',
        locations = {
            { coord = vector4(-788.0439, 319.2, 243.3737, 272.126), text = 'Cobertura' },
            { coord = vector4(-770.5319, 313.0549, 85.69299, 184.252), text = 'Terreo' },
        }
    },
    ['hospitalilhanorte'] = {
        name = 'Hospital Ilha',
        locations = {
            { coord = vector4(-542.6638, 7393.938, 12.83447, 226.7717), text = 'Terreo' },
            { coord = vector4(-547.3978, 7394.927, 8.504028, 53.85827), text = 'Andar -1' },
        }
    },
}

config.location = {
    { coord = vector3(306.2637, -591.6, 47.27551-0.97), config = 'hospital_01' },
    { coord = vector3(306.0659, -591.5341, 43.26526-0.97), config = 'hospital_01' },
    { coord = vector3(305.0901, -594.0791, 47.27551-0.97), config = 'hospital_02' },
    { coord = vector3(305.4066, -594.2242, 43.26526-0.97), config = 'hospital_02' },
    { coord = vector3(329.6703, -582.0264, 74.16772-0.97), config = 'hospital_03' },
    { coord = vector3(317.0769, -571.4242, 47.27551-0.97), config = 'hospital_03' },
    { coord = vector3(317.0638, -571.4769, 43.26526-0.97), config = 'hospital_03' },
    { coord = vector3(330.6066, -579.3362, 74.16772-0.97), config = 'hospital_04' },
    { coord = vector3(319.7802, -572.334, 47.27551-0.97), config = 'hospital_04' },
    { coord = vector3(319.7143, -572.3077, 43.26526-0.97), config = 'hospital_04' },

    { coord = vector3(-2088.013, -473.0374, 26.41541-0.97), config = 'hospitalb_01' },
    { coord = vector3(-2088.791, -472.3517, 21.81543-0.97), config = 'hospitalb_01' },
    { coord = vector3(-2088.791, -472.3517, 17.21533-0.97), config = 'hospitalb_01' },
    { coord = vector3(-2088.791, -472.3517, 12.43005-0.97), config = 'hospitalb_01' },

    { coord = vector3(234.4747, -430.3253, 48.08423-0.97), config = 'escritorio_juridico', perm = { 'juridico.permissao' } },
    { coord = vector3(-141.7582, -621.0593, 168.8132-0.97), config = 'escritorio_juridico', perm = { 'juridico.permissao' } },
    { coord = vector3(224.3604, -426.6593, 48.08423-0.97), config = 'escritorio_juridico', perm = { 'juridico.permissao' } },
    
    { coord = vector3(965.0769, 58.45714, 112.5516-0.97), config = 'motel' },
    { coord = vector3(947.7626, 50.71649, 75.11133-0.97), config = 'motel' },
    { coord = vector3(129.9429, -1284.897, -84.22046-0.97), config = 'motel' },
    { coord = vector3(-611.1033, 7012.404, 24.29236-0.97), config = 'motel' },

    { coord = vector3(-84.32967, -821.8681, 36.01978-0.97), config = 'mazebank' },
    { coord = vector3(-75.38901, -827.1956, 243.3737-0.97), config = 'mazebank' },
    { coord = vector3(-67.84615, -821.6572, 321.2872-0.97), config = 'mazebank' },
    { coord = vector3(-288.4352, -722.5187, 125.4586-0.97), config = 'coberturasaopaulo' },
    { coord = vector3(-304.8659, -720.9626, 28.01611-0.97), config = 'coberturasaopaulo' },
    { coord = vector3(380.4659, -15.17802, 82.99707-0.97), config = 'thefusion', perm = { 'thefusion.permissao' } },
    { coord = vector3(417.5077, -10.87912, 99.64465-0.97), config = 'thefusion', perm = { 'thefusion.permissao' } },
    
    { coord = vector3(-788.0439, 319.2, 243.3737-0.97), config = 'rooftop01', home = 'Rooftop01' },
    { coord = vector3(-770.5319, 313.0549, 85.69299-0.97), config = 'rooftop01', home = 'Rooftop01' },
    
    { coord = vector3(-542.6638, 7393.938, 12.83447-0.97), config = 'hospitalilhanorte' },
    { coord = vector3(-547.3978, 7394.927, 8.504028-0.97), config = 'hospitalilhanorte' },
}

Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
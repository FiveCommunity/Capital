config = {}

config.works = {
    ['Costureira'] = {
        ['coords'] = {
            start = vector3(718.1011, -978.211, 24.10693),
            route = vector3(720.9758, -965.6703, 30.39197)
        },
        ['cams'] = {
            { vector3(720.2769, -959.2747, 30.39197+2.0), -20, 0.0, 145.0 },
            { vector3(717.5472, -963.8242, 31.16699+1.0), -5.0, 0.0, 240.0 },
            { vector3(711.1649, -974.3472, 30.39197+2.0), -5.0, 0.0, 330.0 },
            { vector3(720.633, -983.011, 24.14062+2.0), -20.0, 0.0, 70.0 }
        },
        ['name'] = 'Costureira da Marlinha',
        ['description'] = 'Entrega de roupas',
        ['text'] = 'ENTREGAR', ['blipWithCar'] = false,
        ['requireItem'] = { 
            ['spawn'] = 'caixaroupas',
            ['quantity'] = 1
        },
        ['payment'] = { 
            ['money'] = { ['min'] = 170, ['max'] = 200 },
            ['bonus'] = { ['after'] = 100, ['multiply'] = 1.5 }
        },
        ['anim'] = 'caixa',
        ['vehicle'] = 'bison3',
        ['routes'] = {
            vector3(71.11, -1391.08, 29.38),
            vector3(429.69, -807.53, 29.5),
            vector3(117.38, -234.42, 54.56),
            vector3(-168.71, -300.6, 39.74),
            vector3(-823.55, -1069.39, 11.33),
            vector3(-704.68, -150.48, 37.42),
            vector3(-1180.37, -763.56, 17.33),
            vector3(-1446.38, -241.69, 49.83),
            vector3(-3179.63, 1033.66, 20.87),
            vector3(-1103.3, 2714.41, 19.11),
            vector3(617.43, 2775.93, 42.09),
            vector3(1197.73, 2714.32, 38.23),
            vector3(1698.07, 4822.38, 42.07),
            vector3(6.86, 6508.85, 31.88)
        },
        ['setTimeOut'] = 10000
    },
    -- ['Entregador'] = {
    --     ['coords'] = {
    --         start = vector3(1188.409, -3256.431, 6.0271),
    --         route = vector3(1197.2, -3253.5, 7.1)
    --     },
    --     ['cams'] = {
    --         { vector3(1172.927, -3224.69, 5.824951+6.0), -20.0, 0.0, 230.0 },
    --         { vector3(1194.62, -3253.82, 7.088623+2.0), -25.0, 0.0, 270.0 },
    --         { vector3(1170.831, -3314.677, 5.892334+4.0), -25.0, 0.0, 270.0 },
    --         { vector3(1183.002, -3252.145, 6.0271+4.0), -25.0, 0.0, 270.0 }
    --     },
    --     ['name'] = 'Cedex',
    --     ['description'] = 'Entrega de encomenda',
    --     ['text'] = 'ENTREGAR', ['blipWithCar'] = false,
    --     ['requireItem'] = { 
    --         ['spawn'] = 'encomendapostop',
    --         ['quantity'] = 1
    --     },
    --     ['payment'] = { 
    --         ['money'] = { ['min'] = 75, ['max'] = 130 },
    --         ['bonus'] = { ['after'] = 100, ['multiply'] = 1.0 }
    --     },
    --     ['anim'] = 'caixa',
    --     ['vehicle'] = 'boxville4',
    --     ['routes'] = {
    --         vector3(853.25, -2432.67, 28.08),
    --         vector3(918.5, -1262.36, 25.55),
    --         vector3(1001.28, -510.49, 60.7),
    --         vector3(514.39, 167.61, 99.37),
    --         vector3(-181.99, 219.18, 88.81),
    --         vector3(-43.32, -380.38, 38.12),
    --         vector3(-524.61, -1230.53, 18.46),
    --         vector3(-1247.41, -1198.95, 7.72),
    --         vector3(-522.87, -602.63, 30.45),
    --         vector3(-208.65, 21.01, 56.08),
    --         vector3(-769.01, 469.82, 100.18),
    --         vector3(-1152.45, -202.65, 37.96),
    --     },
    --     ['setTimeOut'] = 10000
    -- },
    -- ['Carteiro'] = {
    --     ['coords'] = {
    --         start = vector3(126.211, 97.47693, 81.96924),
    --         route = vector3(133.1472, 96.55385, 83.48572)
    --     },
    --     ['cams'] = {
    --         { vector3(145.622, 80.05714, 82.79492+6.0), -25.0, 0.0, 30.0 },
    --         { vector3(132.6593, 95.32748-2.0, 83.50256+3.0), -20.0, 0.0, -20.0 },
    --         { vector3(116.1626, 96.47473, 80.73926+3.0), -20.0, 0.0, -20.0 },
    --         { vector3(116.1626, 96.47473, 80.73926+3.0), -20.0, 0.0, -20.0 }
    --     },
    --     ['name'] = 'Capital Gazeta',
    --     ['description'] = 'Entrega de jornal',
    --     ['text'] = 'ENTREGAR', ['blipWithCar'] = false,
    --     ['requireItem'] = { 
    --         ['spawn'] = 'encomendagopostal',
    --         ['quantity'] = 1
    --     },
    --     ['payment'] = { 
    --         ['money'] = { ['min'] = 75, ['max'] = 130 },
    --         ['bonus'] = { ['after'] = 100, ['multiply'] = 1.5 }
    --     },
    --     ['anim'] = 'enviar',
    --     ['vehicle'] = 'boxville2',
    --     ['routes'] = {
    --         vector3(296.75, -230.73, 54.0),
    --         vector3(-378.9, 117.94, 65.82),
    --         vector3(-380.04, 510.49, 119.93),
    --         vector3(540.98, 88.16, 96.3),
    --         vector3(1166.1, -288.78, 69.03),
    --         vector3(1264.01, -513.27, 69.1),
    --         vector3(1185.5, -530.27, 64.84),
    --         vector3(528.07, 101.19, 96.34),
    --         vector3(208.82, -335.17, 44.03),
    --         vector3(-390.07, -235.44, 36.05)
    --     },
    --     ['setTimeOut'] = 10000
    -- },
    -- ['YellowJack'] = {
    --     ['coords'] = {
    --         start = vector3(1990.985, 3054.171, 47.20801),
    --         route = vector3(1987.57, 3051.1, 47.22)
    --     },
    --     ['cams'] = {
    --         { vector3(1989.6, 3077.895, 46.98901+6.0), -10.0, 0.0, 170.0 },
    --         { vector3(1986.488, 3049.371, 47.20801+2.0), -20.0, 0.0, -35.0 },
    --         { vector3(1987.253, 3051.02, 47.20801+2.0), -20.0, 0.0, -230.0 },
    --         { vector3(1995.943, 3058.906, 47.03955+2.0), -20.0, 0.0, -35.0 }

    --     },
    --     ['name'] = 'Yellow Jack',
    --     ['description'] = 'Entrega de bebidas',
    --     ['text'] = 'ENTREGAR', ['blipWithCar'] = false,
    --     ['requireItem'] = { 
    --         ['spawn'] = 'caixabebidas',
    --         ['quantity'] = 1
    --     },
    --     ['payment'] = { 
    --         ['money'] = { ['min'] = 150, ['max'] = 190 },
    --         ['bonus'] = { ['after'] = 1000, ['multiply'] = 1.5 }
    --     },
    --     ['anim'] = 'caixa',
    --     ['vehicle'] = 'boxville',
    --     ['routes'] = {
    --         vector3(1164.76, 2713.7, 38.16),
    --         vector3(-2963.38, 391.99, 15.05),
    --         vector3(-1485.1, -375.12, 40.17),
    --         vector3(-1219.33, -910.01, 12.33),
    --         vector3(1131.38, -984.08, 46.42)
    --     },
    --     ['setTimeOut'] = 10000
    -- },
    -- ['Gas'] = {
    --     ['coords'] = {
    --         start = vector3(923.0242, 3564.989, 33.77881),
    --         route = vector3(914.77, 3567.27, 33.8)
    --     },
    --     ['cams'] = {
    --         { vector3(924.6462, 3548.321, 34.01465+6.0), -20.0, 0.0, 30.0 },
    --         { vector3(920.2286, 3567.336, 33.66077+2.0), -20.0, 0.0, 90.0 },
    --         { vector3(931.9648, 3668.506, 33.59338+2.0), -20.0, 0.0, 140.0 },
    --         { vector3(927.3494, 3573.494, 33.64392+2.0), -20.0, 0.0, 90.0 },
    --     },
    --     ['name'] = 'Chico Gás',
    --     ['description'] = 'Troca de gás',
    --     ['text'] = 'trocar o Gás', ['blipWithCar'] = false,
    --     ['requireItem'] = { 
    --         ['spawn'] = 'botijao-cheio',
    --         ['quantity'] = 1
    --     },
    --     ['payment'] = { 
    --         ['money'] = { ['min'] = 75, ['max'] = 150 },
    --         ['bonus'] = { ['after'] = 10000, ['multiply'] = 1.5 }
    --     },
    --     ['anim'] = 'arrumar',
    --     ['vehicle'] = 'bison2',
    --     ['routes'] = {
    --         vector3(244.88, 2595.25, 45.1),
    --         vector3(1166.54, 2729.19, 38.01),
    --         vector3(2517.16, 2594.1, 37.95),
    --         vector3(2545.42, 374.06, 108.62),
    --         vector3(1173.45, -1490.93, 34.7),
    --         vector3(27.1, -1465.23, 30.41),
    --         vector3(-175.29, -1313.09, 32.3),
    --         vector3(-272.12, -774.26, 32.26),
    --         vector3(-695.91, -374.16, 34.22),
    --         vector3(-1299.14, -389.08, 36.52),
    --         vector3(-2057.49, -301.25, 13.32),
    --         vector3(-3064.14, 633.98, 7.36)
    --     },
    --     ['setTimeOut'] = 20000,
    -- },
    -- ['Pedreiro'] = {
    --     ['coords'] = {
    --         start = vector3(134.4659, -417.7451, 41.1084),
    --         route = vector3(141.59, -379.7, 43.26)
    --     },
    --     ['cams'] = {
    --         { vector3(133.1341, -427.6088, 41.09155+10.0), -10.0, 0.0, 30.0 },
    --         { vector3(135.0066, -377.4857, 43.24829+2.0), -20.0, 0.0, -115.0 },
    --         { vector3(115.7011, -401.4198, 41.26013+6.0), -20.0, 0.0, 20.0 }
    --     },
    --     ['name'] = 'Empreiteira do Valdemar',
    --     ['description'] = 'Subir laje',
    --     ['text'] = 'Consertar', ['blipWithCar'] = false,
    --     ['payment'] = { 
    --         ['money'] = { ['min'] = 13, ['max'] = 15 },
    --         ['bonus'] = { ['after'] = 1000, ['multiply'] = 1.5 }
    --     },
    --     ['anim'] = 'martelo',
    --     ['routes'] = {
    --         vector3(110.13, -381.4, 41.77),
    --         vector3(82.72, -360.5, 42.49),
    --         vector3(72.77, -337.82, 43.23),
    --         vector3(50.01, -348.77, 42.53),
    --         vector3(26.54, -428.71, 39.93),
    --         vector3(36.22, -456.86, 39.93),
    --         vector3(80.03, -422.84, 37.56),
    --         vector3(99.01, -416.17, 37.56),
    --         vector3(83.35, -458.82, 37.56),
    --         vector3(51.92, -411.55, 39.93)
    --     },
    --     ['setTimeOut'] = 10000,
    -- },
    -- ['Eletricista'] = {
    --     ['coords'] = {
    --         start = vector3(736.589, 132.4879, 80.70544),
    --         route = vector3(718.85, 152.68, 80.76)
    --     },
    --     ['cams'] = {
    --         { vector3(769.2659, 148.378, 80.14941+10.0), -20.0, 0.0, 90.0 },
    --         { vector3(716.3209, 148.4967, 80.73926+2.0), -10.0, 0.0, -30.0 },
    --         { vector3(726.1978, 143.7626, 80.73926+2.0), -10.0, 0.0, -30.0 },
    --         { vector3(754.2066, 120.1451, 78.56555+2.0), -10.0, 0.0, 50.0 }
    --     },
    --     ['name'] = 'Enal Eletric',
    --     ['description'] = 'Troca de luz',
    --     ['text'] = 'Consertar', ['blipWithCar'] = false,
    --     ['requireItem'] = { 
    --         ['spawn'] = 'ferramentas',
    --         ['quantity'] = 1
    --     },
    --     ['payment'] = { 
    --         ['money'] = { ['min'] = 50, ['max'] = 70 },
    --         ['bonus'] = { ['after'] = 500000, ['multiply'] = 1.5 }
    --     },
    --     ['vehicle'] = 'utillitruck',
    --     ['anim'] = 'arrumar',
    --     ['routes'] = {
    --         vector3(408.34, 134.42, 101.73),
    --         vector3(-17.47, 77.33, 74.9),
    --         vector3(43.48, -15.27, 69.49),
    --         vector3(49.85, -301.88, 47.48),
    --         vector3(215.66, -651.74, 38.57),
    --         vector3(-106.92, -741.64, 34.7),
    --         vector3(-287.92, -398.2, 30.43),
    --         vector3(-661.8, -210.02, 37.36),
    --         vector3(-525.88, -14.58, 44.46),
    --         vector3(-517.89, -805.88, 30.76),
    --     },
    --     ['setTimeOut'] = 20000,
    -- },
    -- ['Gari'] = {
    --     ['coords'] = {
    --         start = vector3(-304.0483, -1524.976, 27.64539),
    --         route = vector3(-355.2, -1513.424, 27.71277)
    --     },
    --     ['cams'] = {
    --         { vector3(-368.8088, -1534.747, 27.52747+6.0), -20.0, 0.0, -30.0 },
    --         { vector3(-354.7648, -1519.213, 27.71277+2.0), -10.0, 0.0, 0.0 }
    --     },
    --     ['name'] = 'Soluções & Reciclagem',
    --     ['description'] = 'Reciclagem',
    --     ['text'] = 'Varrer', ['blipWithCar'] = false,
    --     ['payment'] = { 
    --         ['money'] = { ['min'] = 40, ['max'] = 60 },
    --         ['bonus'] = { ['after'] = 6, ['multiply'] = 1.5 }
    --     },
    --     ['vehicle'] = 'caddy2',
    --     ['anim'] = 'varrer',
    --     ['routes'] = {
    --         vector3(-539.31, -1215.97, 18.46),
    --         vector3(-787.39, -1142.71, 10.6),
    --         vector3(-1106.66, -1365.58, 5.15), 
    --         vector3(-1236.46, -1458.18, 4.26),
    --         vector3(-1304.34, -1379.3, 4.5),
    --         vector3(-1291.98, -1147.43, 5.6),
    --         vector3(-1138.17, -921.91, 2.65),
    --         vector3(-846.06, -798.53, 19.44),
    --         vector3(-585.9, -750.04, 29.49),
    --         vector3(-331.65, -931.4, 31.09),
    --         vector3(-195.92, -1179.0, 23.08),
    --         vector3(247.08, -791.99, 30.44)
    --     },
    --     ['setTimeOut'] = 5000,
    -- },
}

config.list = {
    { work = 'Costureira', url = 'img/costura.png' },
    -- { work = 'Entregador', url = 'img/cedex.png' },
    -- { work = 'Carteiro', url = 'img/gazeta.png' },
    -- { work = 'YellowJack', url = 'img/yellow.png' },
    -- { work = 'Gas', url = 'img/gas.png' },
    -- { work = 'Pedreiro', url = 'img/pedreiro.png' },
    -- { work = 'Eletricista', url = 'img/eletrecista.png' },
    -- { work = 'Gari', url = 'img/gari.png' }
}
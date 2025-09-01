Proxy = module('vrp', 'lib/Proxy')
Tunnel = module('vrp', 'lib/Tunnel')
vRP = Proxy.getInterface('vRP')

Doors = {
    -- Nova Civil
    { text = true, hash = 2130672747, coord = vector3(452.2813, -1001.09, 25.74133), lock = true, distance = 8.0, open = 8.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 2130672747, coord = vector3(431.4066, -1000.906, 25.72449), lock = true, distance = 8.0, open = 8.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1547307588, other = -1547307588, coord = vector3(456.9363, -972.0527, 30.69519), door_1 = vector3(456.6461, -972.2242, 30.69519), door_2 = vector3(457.5297, -972.1187, 30.69519), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1547307588, other = -1547307588, coord = vector3(441.9033, -998.5319, 30.71204), door_1 = vector3(442.5231, -998.8483, 30.71204), door_2 = vector3(441.3231, -999.0989, 30.71204), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -96679321, coord = vector3(441.2308, -986.3209, 30.77954), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1406685646, coord = vector3(441.1385, -977.7626, 30.77954), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -692649124, other = -692649124, coord = vector3(468.6857, -1014.607, 26.38171), door_1 = vector3(469.3055, -1014.554, 26.38171), door_2 = vector3(467.8945, -1014.343, 26.38171), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -53345114, coord = vector3(476.6505, -1008.145, 26.31433), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -53345114, coord = vector3(477.1253, -1012.167, 26.31433), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -53345114, coord = vector3(480.1582, -1012.048, 26.31433), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -53345114, coord = vector3(483.2044, -1012.141, 26.31433), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -53345114, coord = vector3(486.2637, -1012.352, 26.29749), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -53345114, coord = vector3(484.9319, -1007.723, 26.31433), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -53345114, coord = vector3(481.7407, -1003.991, 26.31433), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1830360419, coord = vector3(464.0835, -996.8571, 26.36487), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1830360419, coord = vector3(464.4264, -975.4681, 26.26379), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -692649124, coord = vector3(464.5055, -983.9209, 43.75391), lock = true, distance = 2.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    
    -- Fronteira
    { text = true, hash = 741314661, coord = vector3(2552.229, 2699.09, 41.79932), lock = true, distance = 10.0, autoLock = 20000, perm = { 'exercito.permissao', 'staff.permissao' } },
    { text = true, hash = 741314661, coord = vector3(2301.679, 3032.163, 46.18018), lock = true, distance = 20.0, autoLock = 20000, perm = { 'exercito.permissao', 'staff.permissao' } },
    { text = true, hash = 741314661, coord = vector3(2008.497, 3097.068, 47.09009), lock = true, distance = 20.0, autoLock = 20000, perm = { 'exercito.permissao', 'staff.permissao' } },
    { text = true, hash = 741314661, coord = vector3(2012.624, 3103.398, 47.07324), lock = true, distance = 20.0, autoLock = 20000, perm = { 'exercito.permissao', 'staff.permissao' } },
    { text = true, hash = 741314661, coord = vector3(228.7121, 2993.96, 42.5238), lock = true, distance = 20.0, autoLock = 20000, perm = { 'exercito.permissao', 'staff.permissao' } },
    { text = true, hash = 741314661, coord = vector3(221.5385, 2993.42, 42.50696), lock = true, distance = 20.0, autoLock = 20000, perm = { 'exercito.permissao', 'staff.permissao' } },

    -- Tsunami
    { text = true, hash = -642608865, coord = vector3(497.9736, 5435.776, 671.3252), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -642608865, coord = vector3(489.3099, 5425.609, 671.5613), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -642608865, coord = vector3(475.0022, 5415.139, 671.5444), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -642608865, coord = vector3(472.2857, 5415.297, 671.5444), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },    
    
    -- [ Celas - Jurídico ] --
    { text = true, hash = 631614199, coord = vector3(261.6527, -423.7582, 47.46082), lock = true, distance = 5.0, autoLock = 20000, perm = { 'juridico.permissao', 'staff.permissao' } },
    { text = true, hash = 631614199, coord = vector3(262.8923, -425.9604, 47.46082), lock = true, distance = 5.0, autoLock = 20000, perm = { 'juridico.permissao', 'staff.permissao' } },
    { text = true, hash = 631614199, coord = vector3(261.6923, -429.1912, 47.46082), lock = true, distance = 5.0, autoLock = 20000, perm = { 'juridico.permissao', 'staff.permissao' } },
    { text = true, hash = 631614199, coord = vector3(260.5846, -432.2374, 47.46082), lock = true, distance = 5.0, autoLock = 20000, perm = { 'juridico.permissao', 'staff.permissao' } },
    
    -- [ Celas - Policia Civil ]
    -- { text = true, hash = 631614199, coord = vector3(461.7626, -993.8901, 24.89893), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 631614199, coord = vector3(461.7626, -998.2418, 24.89893), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 631614199, coord = vector3(461.7495, -1001.921, 24.89893), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1603817716, coord = vector3(488.9143, -1019.855, 28.20142), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    
    -- [ Celas - Policia Militar ]
    { text = true, hash = 1813468651, coord = vector3(-336.7253, -1038.303, 28.31946), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1813468651, coord = vector3(-333.3758, -1039.516, 28.31946), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1813468651, coord = vector3(-330.1187, -1040.571, 28.31946), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1813468651, coord = vector3(-327.1648, -1041.824, 28.31946), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1813468651, coord = vector3(-327.0857, -1045.068, 28.31946), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1813468651, coord = vector3(-330.356, -1043.921, 28.31946), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1813468651, coord = vector3(-333.5868, -1042.668, 28.31946), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1813468651, coord = vector3(-336.7516, -1041.587, 28.31946), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    -- garagem
    { text = true, hash = -1775213343, coord = vector3(-294.7912, -1078.668, 23.02856), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1203688963, coord = vector3(-323.8286, -1076.532, 23.01172), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 1203688963, coord = vector3(-315.4681, -1086.686, 23.01172), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 1203688963, coord = vector3(-307.4373, -1089.613, 23.01172), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },

     -- [ Celas - Policia GCC ]
     { text = true, hash = 631614199, coord = vector3(692.967, 265.3846, 93.78101), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
     { text = true, hash = 631614199, coord = vector3(694.1802, 267.5472, 93.78101), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    
    -- [ Celas - PRFE ]
    { text = true, hash = 631614199, coord = vector3(2602.365, 5338.523, 47.76416), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 631614199, coord = vector3(2605.081, 5339.328, 47.73035), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 631614199, coord = vector3(2607.706, 5340.053, 47.7135), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },

    -- [ JURAMENTO ]
    { text = true, hash = -550347177, coord = vector3(-1146.04, -1991.459, 13.17139), lock = true, distance = 8.0, autoLock = 20000, perm = { 'sindicato.permissao', 'staff.permissao' } },

    -- [ PENITENCIÁRIA ] ===============================================================================================
    { text = false, hash = -1216055941, coord = vector3(1787.776, 2639.552, 46.59045), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'staff.permissao'} },
    { text = true, hash = 741314661, coord = vector3(1622.097, 2584.655, 45.53992), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 741314661, coord = vector3(1651.292, 2632.167, 45.53992), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 741314661, coord = vector3(1663.556, 2606.466, 45.53992), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 741314661, coord = vector3(1796.242, 2616.936, 45.53992), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 741314661, coord = vector3(1818.356, 2608.246, 45.57361), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 741314661, coord = vector3(1845.086, 2608.352, 45.57361), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 741314661, coord = vector3(1798.048, 2530.009, 45.53992), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    { text = true, hash = 741314661, coord = vector3(1775.209, 2535.468, 45.53992), lock = true, distance = 15.0, open = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao'} },
    -- { text = true, hash = 705715602, coord = vector3(1791.56, 2552.057, 45.65784), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -684929024, coord = vector3(1831.398, 2594.07, 46.01172), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -684929024, coord = vector3(1837.147, 2592.079, 46.01172), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 2024969025, coord = vector3(1837.015, 2576.993, 46.01172), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 2024969025, coord = vector3(1843.648, 2577.007, 46.01172), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 705715602, coord = vector3(1818.646, 2594.374, 45.91064), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    -- { text = true, hash = 705715602, coord = vector3(1845.705, 2585.908, 45.65784), lock = true, distance = 5.0, autoLock = 20000, perm = { 'policia.permissao', 'staff.permissao' } },
    -- PREDIO 7 ================================================================
    { text = true, hash = -1033001619, coord = vector3(1753.833, 2499.297, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -286460531, coord = vector3(1772.505, 2493.376, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -2109504629, other = -2109504629, coord = vector3(1772.374, 2493.31, 50.42639), door_1 = vector3(1773.297, 2492.545, 50.40955), door_2 = vector3(1772.149, 2494.615, 50.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1762.101, 2496.198, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    -- { text = true, hash = -1167410167, coord = vector3(1765.16, 2497.965, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1756.154, 2492.743, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1753.187, 2491.002, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1750.154, 2489.327, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1747.081, 2487.547, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1744.075, 2485.807, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1771.965, 2484.316, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1768.919, 2482.523, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1765.912, 2480.835, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1762.853, 2479.094, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1759.925, 2477.327, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1756.853, 2475.561, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1753.78, 2473.873, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    --{ text = true, hash = -1167410167, coord = vector3(1750.8, 2472.105, 45.80957), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1744.062, 2485.741, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1747.055, 2487.547, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1750.114, 2489.275, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1753.108, 2490.963, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1756.075, 2492.703, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1759.094, 2494.457, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1762.193, 2496.211, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1765.108, 2497.912, 50.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1771.912, 2484.277, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1768.932, 2482.536, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1765.886, 2480.796, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1762.932, 2479.134, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1759.859, 2477.38, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1756.866, 2475.587, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1753.833, 2473.833, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1750.774, 2472.132, 50.40955), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    -- PREDIO 6 ================================================================
    { text = true, hash = -1033001619, coord = vector3(1691.196, 2467.24, 45.84326), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -2109504629, other = -2109504629, coord = vector3(1704.356, 2452.853, 50.44324), door_1 = vector3(1703.842, 2451.613, 50.44324), door_2 = vector3(1703.974, 2454.29, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -2109504629, other = -2109504629, coord = vector3(1704.33, 2452.84, 45.84326), door_1 = vector3(1703.881, 2451.653, 45.82642), door_2 = vector3(1703.881, 2454.237, 45.84326), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    
    { text = true, hash = -1167410167, coord = vector3(1689.917, 2460.554, 45.84326), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1686.369, 2460.528, 45.84326), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1682.941, 2460.567, 45.84326), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1679.407, 2460.554, 45.84326), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1675.938, 2460.567, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1696.84, 2460.514, 45.84326), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1700.321, 2460.541, 45.84326), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1699.358, 2445.336, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1695.943, 2445.283, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1692.462, 2445.257, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1688.941, 2445.323, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1685.525, 2445.323, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1681.912, 2445.297, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1678.47, 2445.283, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1675.029, 2445.402, 45.82642), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1700.387, 2460.528, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1696.787, 2460.501, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1693.279, 2460.541, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1689.785, 2460.514, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1686.356, 2460.501, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1682.941, 2460.514, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1679.433, 2460.501, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1675.991, 2460.567, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1699.345, 2445.31, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1695.956, 2445.283, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1692.435, 2445.31, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1688.967, 2445.363, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1685.552, 2445.336, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1681.965, 2445.323, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1678.536, 2445.283, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = -1167410167, coord = vector3(1674.963, 2445.349, 50.44324), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    -- PREDIO 4 ================================================================
    -- { text = true, hash = 241550507, coord = vector3(1588.114, 2553.587, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.141, 2542.127, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.048, 2545.688, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.207, 2549.367, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.18, 2556.62, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 1164059289, coord = vector3(1588.062, 2560.167, 45.97803), lock = true, distance = 5.0, perm = { '+PC.DelegadoDHPP', 'staff.permissao' } },
    { text = true, hash = 1164059289, coord = vector3(1588.207, 2563.925, 45.99487), lock = true, distance = 5.0, perm = { '+PC.DelegadoDHPP', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.127, 2541.996, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.088, 2545.635, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.075, 2549.235, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.101, 2552.901, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.075, 2556.488, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1588.048, 2560.141, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    --{ text = true, hash = 913760512, coord = vector3(1588.022, 2563.793, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.503, 2564.189, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.516, 2560.55, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.477, 2556.976, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.596, 2553.218, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.569, 2549.591, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.569, 2546.057, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.569, 2542.417, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.556, 2564.136, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.609, 2560.51, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.516, 2556.857, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.53, 2553.244, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.635, 2549.539, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.543, 2545.899, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 913760512, coord = vector3(1573.49, 2542.391, 49.93774), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 241550507, coord = vector3(1578.897, 2566.483, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },
    { text = true, hash = 241550507, coord = vector3(1582.76, 2566.47, 45.97803), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao' } },

    -- [ Os Veio ] --
    { text = true, hash = 1219405180, coord = vector3(89.1956, -2564.848, 5.993408), lock = true, distance = 5.0, perm = { 'fundao.permissao', 'staff.permissao'} },
    { text = true, hash = -1023447729, coord = vector3(105.1385, -2538.158, -8.817627), lock = true, distance = 5.0, perm = { 'fundao.permissao', 'staff.permissao'} },
    { text = true, hash = -1116041313, coord = vector3(83.26154, -2540.927, -2.802246), lock = true, distance = 5.0, perm = { 'fundao.permissao', 'staff.permissao'} },
    { text = true, hash = -1156020871, coord = vector3(88.00879, -2542.391, -12.01904), lock = true, distance = 5.0, perm = { 'fundao.permissao', 'staff.permissao'} },
    { text = true, hash = 464151082, coord = vector3(94.81319, -2552.888, -8.817627), lock = true, distance = 5.0, perm = { 'fundao.permissao', 'staff.permissao'} },
    
    -- [ Cupim ] --
    { text = true, hash = -1081024910, coord = vector3(-762.1846, -2584.76, 13.94653), lock = true, distance = 15.0, open = 15.0, perm = { 'cupim.permissao', 'staff.permissao'} },
    { text = true, hash = -1821777087, coord = vector3(-791.5385, -2600.242, 13.94653), door_1 = vector3(-791.7626, -2600.796, 13.94653), door_2 = vector3(-791.2484, -2599.912, 13.94653), lock = true, distance = 5.0, other = -1821777087, perm = { 'cupim.permissao', 'staff.permissao'} },
    { text = true, hash = -1821777087, coord = vector3(-796.5758, -2609.143, 13.94653), door_1 = vector3(-796.9319, -2609.631, 13.94653), door_2 = vector3(-796.4572, -2608.576, 13.94653), lock = true, distance = 5.0, other = -1821777087, perm = { 'cupim.permissao', 'staff.permissao'} },
    
    -- [ Medelin ] --
    { text = true, hash = -945111239, coord = vector3(848.8616, 1923.758, 94.70764), door_1 = vector3(850.8792, 1923.692, 94.70764), door_2 = vector3(846.7648, 1923.943, 94.72449), lock = true, distance = 10.0, other = -945111239, perm = { 'medelin.permissao', 'staff.permissao'} },
    
    -- [ k10 ] --
    { text = true, hash = 662746527, coord = vector3(-1015.925, -266.1494, 39.03589), door_1 = vector3(-1016.031, -266.6374, 39.03589), door_2 = vector3(-1015.279, -265.5033, 39.03589), lock = true, distance = 5.0, other = -10590885, perm = { 'k10.permissao', 'staff.permissao'} },
    { text = true, hash = 1650276170, coord = vector3(-1005.851, -261.9824, 39.03589), door_1 = vector3(-1016.031, -266.6374, 39.03589), door_2 = vector3(-1004.862, -262.8923, 39.03589), lock = true, distance = 5.0, other = 1650276170, perm = { 'k10.permissao', 'staff.permissao'} },
    { text = true, hash = -1693304723, coord = vector3(-999.0198, -269.6571, 39.03589), door_1 = vector3(-998.8483, -268.7604, 39.03589), door_2 = vector3(-999.244, -269.9473, 39.03589), lock = true, distance = 5.0, other = 1930160225, perm = { 'k10.permissao', 'staff.permissao'} },
    { text = true, hash = 1650276170, coord = vector3(-996.1714, -262.7868, 39.03589), door_1 = vector3(-996.1055, -262.0615, 39.03589), door_2 = vector3(-996.9495, -262.8923, 39.03589), lock = true, distance = 5.0, other = 1650276170, perm = { 'k10.permissao', 'staff.permissao'} },
    { text = true, hash = 363383944, coord = vector3(-977.6703, -264.3033, 38.44617), lock = true, distance = 15.0, open = 15.0, perm = { 'k10.permissao', 'staff.permissao'} },
    { text = true, hash = -245685349, coord = vector3(-985.2527, -256.5231, 38.47986), lock = true, distance = 5.0, perm = { 'k10.permissao', 'staff.permissao'} },
    { text = true, hash = -1719935594, coord = vector3(-992.8483, -281.3934, 38.17651), lock = true, distance = 5.0, perm = { 'k10.permissao', 'staff.permissao'} },
    { text = true, hash = -10590885, coord = vector3(-1006.787, -269.644, 44.78174), lock = true, distance = 5.0, perm = { 'k10.permissao', 'staff.permissao'} },

    -- [ Fav Caixa Dágua ] --
    { text = true, hash = 1427451548, coord = vector3(939.2835, -1489.767, 30.24023), lock = true, distance = 5.0, perm = { 'agua.permissao', 'staff.permissao'} },
    
    
    -- [Helipa] --
    { text = true, hash = -945111239, coord = vector3(-286.1934, 1906.444, 161.2139), door_1 = vector3(-284.8352, 1906.958, 161.2139), door_2 = vector3(-287.644, 1906.193, 161.2307), lock = true, distance = 5.0, other = -945111239, perm = { 'helipa.permissao', 'staff.permissao'} },
    
    -- [Wanana] --
    { text = true, hash = 1298348878, coord = vector3(3524.163, 5766.751, 10.86304), door_1 = vector3(3524.703, 5767.464, 10.86304), door_2 = vector3(3523.253, 5766.699, 10.86304), lock = true, distance = 5.0, other = 1298348878, perm = { 'wanana.permissao', 'staff.permissao'} },
    
    -- [Equipe Staff] --
    { text = true, hash = -1574151574, coord = vector3(4982.558, -5710.971, 19.87769), door_1 = vector3(4981.807, -5711.96, 19.87769), door_2 = vector3(4983.574, -5710.338, 19.87769), lock = true, distance = 15.0, open = 15.0,  other = 1215477734, perm = { 'staff.permissao'} },
    { text = true, hash = 1650223031, coord = vector3(-1252.457, 839.3011, 192.5209), lock = true, distance = 15.0, open = 15.0, perm = { 'staff.permissao'} },
    { text = true, hash = 1562405862, coord = vector3(-1236.672, 830.3737, 192.8916), door_1 = vector3(-1237.292, 830.5978, 192.8916), door_2 = vector3(-1236.171, 830.0967, 192.8916), lock = true, distance = 10.0, other = -1987799521, perm = { 'staff.permissao'} },
    { text = true, hash = -1569012942, coord = vector3(-1228.655, 829.0417, 192.8916), door_1 = vector3(-1228.339, 829.6484, 192.8916), door_2 = vector3(-1229.037, 828.3033, 192.8916), lock = true, distance = 10.0, other = 1891139392, perm = { 'staff.permissao'} },
    
    -- [Bando dos Gauchos] --
    -- { text = true, hash = -1599759247, coord = vector3(-1058.809, 4915.965, 211.8645), lock = true, distance = 5.0, perm = { 'bandodosgauchos.permissao', 'staff.permissao'} },
    -- { text = true, hash = -1599759247, coord = vector3(-1056.659, 4920.857, 211.8645), lock = true, distance = 5.0, perm = { 'bandodosgauchos.permissao', 'staff.permissao'} },
    -- { text = true, hash = -1578791031, coord = vector3(-1042.563, 4910.809, 208.3092), door_1 = vector3(-1043.881, 4912.945, 208.3934), door_2 = vector3(-1042.141, 4908.013, 208.3429), lock = true, distance = 10.0, other = -13153749, perm = { 'wanana.permissao', 'staff.permissao'} },
    
    -- [Os Gauchos] --
    { text = true, hash = 1413743677, coord = vector3(2449.134, 4989.297, 46.80371), lock = true, distance = 5.0, perm = { 'blackout.permissao', 'staff.permissao'} },
    { text = true, hash = 1413743677, coord = vector3(2452.681, 4969.859, 46.80371), lock = true, distance = 5.0, perm = { 'blackout.permissao', 'staff.permissao'} },
    { text = true, hash = 1413743677, coord = vector3(2435.802, 4975.503, 46.80371), lock = true, distance = 5.0, perm = { 'blackout.permissao', 'staff.permissao'} },
    { text = true, hash = 1413743677, coord = vector3(2440.47, 4982.281, 46.80371), lock = true, distance = 5.0, perm = { 'blackout.permissao', 'staff.permissao'} },
    { text = true, hash = 1194028902, coord = vector3(2442.25, 4980.527, 51.5553), door_1 = vector3(2441.881, 4981.002, 51.5553), door_2 = vector3(2442.62, 4980.092, 51.5553), lock = true, distance = 5.0, other = 1194028902, perm = { 'blackout.permissao', 'staff.permissao'} },
    { text = true, hash = 1194028902, coord = vector3(2450.875, 4984.958, 51.57214), door_1 = vector3(2450.281, 4985.196, 51.5553), door_2 = vector3(2451.152, 4984.378, 51.57214), lock = true, distance = 5.0, other = 1194028902, perm = { 'blackout.permissao', 'staff.permissao'} },
    
    -- [Exército] --
    { text = true, hash = 569833973, coord = vector3(-1593.389, 2805.046, 16.97949), lock = true, distance = 15.0, perm = { 'exercito.permissao', 'staff.permissao'} },
    { text = true, hash = 569833973, coord = vector3(-1592.202, 2791.78, 16.84473), lock = true, distance = 15.0, perm = { 'exercito.permissao', 'staff.permissao'} },
    { text = true, hash = 569833973, coord = vector3(-2311.793, 3398.822, 30.83008), lock = true, distance = 5.0,  open = 5.0, perm = { 'exercito.permissao', 'staff.permissao'} },
    { text = true, hash = 569833973, coord = vector3(-2308.589, 3385.609, 30.98169), lock = true, distance = 5.0, open = 5.0, perm = { 'exercito.permissao', 'staff.permissao'} },
    
    -- [ The Fusion ] --
    { text = true, hash = 607720026, coord = vector3(390.6593, 0.8439561, 91.92749), door_1 = vector3(390.2769, 0.5538462, 91.92749), door_2 = vector3(391.0022, 1.397802, 91.92749), lock = true, distance = 5.0, other = 607720026, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -973354389, coord = vector3(407.367, -17.12967, 91.92749), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -1140189596, coord = vector3(354.4088, 18.39561, 84.74951), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(430.1407, -7.951645, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(426.1978, -14.32088, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(422.6242, -20.47912, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(416.7165, -29.88132, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(412.0352, -31.10769, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(402.1187, -25.51648, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(396, -22.06154, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(395.8286, -15.36263, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(401.3934, -5.643951, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(404.7297, 0.5802198, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(411.6132, 8.28132, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(421.4374, 2.571429, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },
    { text = true, hash = -807362247, coord = vector3(427.5956, -0.8835106, 99.64465), lock = true, distance = 5.0, perm = { 'thefusion.permissao', 'staff.permissao'} },

    -- [ Motoclub ] --
    { text = true, hash = -1953149158, coord = vector3(134.6374, 323.8945, 116.4103), lock = true, distance = 5.0, perm = { 'motoclub.permissao', 'staff.permissao'} },
    { text = true, hash = 443033731, coord = vector3(139.8462, 324.5802, 112.3663), lock = true, distance = 5.0, perm = { 'motoclub.permissao', 'staff.permissao'} },
    { text = true, hash = -915091986, coord = vector3(143.1165, 318.5538, 112.1304), lock = true, distance = 15.0, open = 5.0, perm = { 'motoclub.permissao', 'staff.permissao'} },
    
    -- [ Reciclagem ] --
    { text = true, hash = 1185512375, coord = vector3(-649.2791, -1639.029, 25.06738), lock = true, distance = 5.0, perm = { 'reciclagem.permissao', 'staff.permissao'} },
    { text = true, hash = 6912002, coord = vector3(-586.2857, -1597.516, 27.00513), lock = true, distance = 5.0, perm = { 'reciclagem.permissao', 'staff.permissao'} },
    { text = true, hash = -1687047623, coord = vector3(-591.0461, -1609.899, 27.00513), lock = true, distance = 5.0, perm = { 'reciclagem.permissao', 'staff.permissao'} },
    { text = true, hash = 1099436502, coord = vector3(-609.9956, -1610.202, 27.02197), door_1 = vector3(-609.3494, -1610.295, 27.02197), door_2 = vector3(-610.6813, -1610.215, 27.02197), lock = true, distance = 5.0, other = -1627599682, perm = { 'reciclagem.permissao', 'staff.permissao'} },
    { text = true, hash = 362975687, coord = vector3(-567.5341, -1601.301, 27.00513), door_1 = vector3(-567.6132, -1600.563, 27.00513), door_2 = vector3(-567.6528, -1601.868, 27.00513), lock = true, distance = 5.0, other = 362975687, perm = { 'reciclagem.permissao', 'staff.permissao'} },

    -- [ Dinastia ] --
    { text = true, hash = -289741770, coord = vector3(-1887.679, 2051.354, 140.9941), door_1 = vector3(-1887.442, 2051.024, 140.9941), door_2 = vector3(-1888.259, 2051.288, 140.9941), lock = true, distance = 5.0, other = -2138601519, perm = { 'dinastia.permissao', 'staff.permissao'} },
    { text = true, hash = 2145182154, coord = vector3(-1880.268, 2071.688, 141.011), door_1 = vector3(-1880.466, 2071.793, 141.011), door_2 = vector3(-1879.793, 2071.78, 140.9941), lock = true, distance = 5.0, other = 1906525527, perm = { 'dinastia.permissao', 'staff.permissao'} },
    { text = true, hash = -351995852, coord = vector3(-1908.607, 2072.598, 140.4044), door_1 = vector3(-1908.04, 2071.569, 140.4044), door_2 = vector3(-1909.991, 2073.059, 140.3707), lock = true, distance = 5.0, other = 1849458349, perm = { 'dinastia.permissao', 'staff.permissao'} },
    { text = true, hash = -351995852, coord = vector3(-1911.125, 2074.76, 140.4213), door_1 = vector3(-1910.545, 2073.706, 140.3876), door_2 = vector3(-1912.391, 2075.209, 140.3876), lock = true, distance = 5.0, other = 1849458349, perm = { 'dinastia.permissao', 'staff.permissao'} },
    { text = true, hash = -289741770, coord = vector3(-1894.035, 2075.037, 140.9941), door_1 = vector3(-1894.009, 2075.42, 140.9941), door_2 = vector3(-1893.508, 2074.84, 140.9941), lock = true, distance = 5.0, other = -2138601519, perm = { 'dinastia.permissao', 'staff.permissao'} },
    { text = true, hash = -351995852, coord = vector3(-1899.6, 2083.543, 140.4213), door_1 = vector3(-1899.705, 2083.938, 140.3876), door_2 = vector3(-1899.178, 2083.319, 140.4044), lock = true, distance = 5.0, other = 1849458349, perm = { 'dinastia.permissao', 'staff.permissao'} },
    { text = true, hash = -351995852, coord = vector3(-1901.96, 2085.679, 140.4044), door_1 = vector3(-1902.198, 2085.877, 140.4044), door_2 = vector3(-1901.776, 2085.521, 140.4044), lock = true, distance = 5.0, other = 1849458349, perm = { 'dinastia.permissao', 'staff.permissao'} },
    { text = true, hash = -666527566, coord = vector3(-1868.532, 2055.771, 140.9941), lock = true, distance = 5.0, perm = { 'dinastia.permissao', 'staff.permissao'} },

    -- [ Ghost ] --
    { text = true, hash = -1576356250, coord = vector3(-3005.196, 78.40879, 11.60437), lock = true, distance = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1576356250, coord = vector3(-2964.198, 52.03517, 11.60437), lock = true, distance = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -728539053, coord = vector3(-2952.976, 49.99121, 11.60437), lock = true, distance = 15.0, open = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = 1693207013, coord = vector3(-2949.376, 56.00439, 11.60437), lock = true, distance = 15.0, open = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1086052218, coord = vector3(-2926.207, 51.73187, 11.03149), lock = true, distance = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1872424165, coord = vector3(-3035.024, 79.1077, 12.81763), lock = true, distance = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1872424165, coord = vector3(-3044.004, 86.37363, 12.81763), lock = true, distance = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1872424165, coord = vector3(-3055.873, 96.61978, 12.81763), lock = true, distance = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1872424165, coord = vector3(-3031.464, 92.08352, 12.34583), lock = true, distance = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -961118275, coord = vector3(-3024.725, 79.85934, 11.60437), door_1 = vector3(-3025.147, 80.79561, 11.60437), door_2 = vector3(-3023.67, 79.56923, 11.60437), lock = true, distance = 5.0, other = -961118275, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1576356250, coord = vector3(-2989.635, 69.28352, 11.60437), door_1 = vector3(-2990.294, 70.12747, 11.60437), door_2 = vector3(-2988.303, 68.91428, 11.60437), lock = true, distance = 5.0, other = -1576356250, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1086052218, coord = vector3(-2944.55, 64.11429, 12.2616), door_1 = vector3(-2944.8, 64.52308, 12.2616), door_2 = vector3(-2943.996, 64.03516, 12.2616), lock = true, distance = 5.0, other = -1740064800, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1872424165, coord = vector3(-2997.996, 55.74066, 12.2616), door_1 = vector3(-2997.745, 55.16044, 12.2616), door_2 = vector3(-2998.681, 55.78022, 12.2616), lock = true, distance = 5.0, other = -1872424165, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -961118275, coord = vector3(-3028.352, 73.84615, 12.90186), door_1 = vector3(-3028.207, 73.3055, 12.90186), door_2 = vector3(-3028.84, 73.88571, 12.90186), lock = true, distance = 5.0, other = -961118275, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = 1314760555, coord = vector3(-2965.385, 24.68572, 7.947998), door_1 = vector3(-2965.873, 24.85715, 7.947998), door_2 = vector3(-2964.791, 24.34286, 7.947998), lock = true, distance = 5.0, other = -856013838 , perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -1740064800, coord = vector3(-2926.971, 52.61539, 14.75537), lock = true, distance = 5.0, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -961118275, coord = vector3(-2989.029, 47.01099, 16.255), door_1 = vector3(-2989.371, 47.19561, 16.255), door_2 = vector3(-2988.567, 46.69451, 16.255), lock = true, distance = 5.0, other = -961118275, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -961118275, coord = vector3(-3025.24, 61.68791, 16.10327), door_1 = vector3(-3025.701, 62.01758, 16.10327), door_2 = vector3(-3024.765, 61.60879, 16.10327), lock = true, distance = 5.0, other = -961118275, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -961118275, coord = vector3(-2995.701, 51.0066, 16.255), door_1 = vector3(-2996.294, 51.21759, 16.255), door_2 = vector3(-2995.292, 50.59781, 16.255), lock = true, distance = 5.0, other = -961118275, perm = { 'ghost.permissao', 'staff.permissao'} },
    { text = true, hash = -961118275, coord = vector3(-2992.154, 49.35825, 16.255), door_1 = vector3(-2992.84, 49.17363, 16.255), door_2 = vector3(-2991.956, 48.63297, 16.255), lock = true, distance = 5.0, other = -961118275, perm = { 'ghost.permissao', 'staff.permissao'} },
    
    
    -- [ South ] --
    { text = true, hash = -449097539, coord = vector3(-818.0835, 270.6725, 86.18164), lock = true, distance = 5.0, home = 'South' },
    { text = true, hash = -449097539, coord = vector3(-830.6373, 272.5055, 86.18164), lock = true, distance = 5.0, home = 'South' },
    { text = true, hash = 1448171236, coord = vector3(-819.1912, 267.8374, 86.38391), lock = true, distance = 5.0, home = 'South' },
    { text = true, hash = -264728216, coord = vector3(-832.6682, 264.0132, 86.18164), lock = true, distance = 5.0, home = 'South' },
    { text = true, hash = 65586107, coord = vector3(-815.9473, 251.011, 79.18896), lock = true, distance = 5.0, home = 'South' },
    { text = true, hash = 65586107, coord = vector3(-818.8615, 257.4725, 79.18896), lock = true, distance = 5.0, home = 'South' },
    { text = true, hash = 65586107, coord = vector3(-832.2989, 259.9121, 79.18896), lock = true, distance = 5.0, home = 'South' },

    -- [ Malibu ] --
    { text = true, hash = 1286535678, coord = vector3(-3134.294, 796.2725, 17.46814), lock = true, distance = 15.0, open = 5.0, home = 'Malibu' },
    { text = true, hash = 308207762, coord = vector3(-3216.923, 816.5275, 8.925293), lock = true, distance = 5.0, home = 'Malibu' },
    { text = true, hash = 1705178895, other = 1705178895, coord = vector3(-3220.813, 838.1802, 8.925293), door_1 = vector3(-3220.325, 838.444, 8.925293), door_2 = vector3(-3221.327, 837.9165, 8.925293), lock = true, distance = 5.0, home = 'Malibu' },
    { text = true, hash = 1705178895, other = 1705178895, coord = vector3(-3198.013, 763.6879, 8.925293), door_1 = vector3(-3198.62, 763.3582, 8.925293), door_2 = vector3(-3197.552, 764.0571, 8.925293), lock = true, distance = 5.0, home = 'Malibu' },
    { text = true, hash = 1705178895, other = 1705178895, coord = vector3(-3214.76, 768.1978, 8.925293), door_1 = vector3(-3214.457, 767.7099, 8.925293), door_2 = vector3(-3215.064, 768.6066, 8.925293), lock = true, distance = 5.0, home = 'Malibu' },
    { text = true, hash = 1705178895, other = 1705178895, coord = vector3(-3215.209, 811.411, 14.06445), door_1 = vector3(-3214.76, 811.6616, 14.06445), door_2 = vector3(-3215.67, 811.0154, 14.06445), lock = true, distance = 5.0, home = 'Malibu' },
    { text = true, hash = 1705178895, other = 1705178895, coord = vector3(-3197.064, 782.7824, 14.06445), door_1 = vector3(-3196.523, 783.1649, 14.06445), door_2 = vector3(-3197.512, 782.5055, 14.06445), lock = true, distance = 5.0, home = 'Malibu' },
    { text = true, hash = 1705178895, other = 1705178895, coord = vector3(-3198.396, 762.0923, 2.758301), door_1 = vector3(-3198.053, 761.578, 2.758301), door_2 = vector3(-3198.673, 762.4747, 2.758301), lock = true, distance = 5.0, home = 'Malibu' },
    { text = true, hash = -425708707, coord = vector3(-3225.653, 791.3406, 8.925293), lock = true, distance = 10.0, open = 5.0, home = 'Malibu' },
    { text = true, hash = 270936785, coord = vector3(-3217.49, 774.3428, 14.0813), lock = true, distance = 10.0, open = 5.0, home = 'Malibu' },

    -- [ Laranjas ] --
    -- { text = true, hash = 724862427, coord = vector3(-1798.22, 469.5692, 133.6813), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = 546378757, other = -1249591818, coord = vector3(-1800.053, 473.1824, 133.6813), door_1 = vector3(-1799.341, 471.9429, 133.6981), door_2 = vector3(-1800.725, 474.3297, 133.6813), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = 1558415341, other = 1558415341, coord = vector3(-1804.971, 436.4835, 128.8286), door_1 = vector3(-1804.576, 436.589, 128.8286), door_2 = vector3(-1805.169, 436.444, 128.8286), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = 1100960097, other = 1100960097, coord = vector3(-1812.949, 446.9143, 128.5084), door_1 = vector3(-1812.91, 446.4, 128.5084), door_2 = vector3(-1812.765, 447.4813, 128.5084), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = 1314286287, other = 1314286287, coord = vector3(-1815.969, 423.389, 128.3063), door_1 = vector3(-1816.747, 423.2571, 128.3063), door_2 = vector3(-1815.165, 423.3231, 128.3063), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = -627047580, other = -627047580, coord = vector3(-1804.8, 428.5319, 128.7274), door_1 = vector3(-1805.156, 428.4923, 128.7274), door_2 = vector3(-1804.444, 428.5319, 128.7274), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = 1100960097, other = 1100960097, coord = vector3(-1816.444, 428.2549, 132.2997), door_1 = vector3(-1816.985, 428.2418, 132.2997), door_2 = vector3(-1815.851, 428.2154, 132.2997), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = 1100960097, other = 1100960097, coord = vector3(-1788.396, 434.8615, 128.3063), door_1 = vector3(-1788.33, 434.3473, 128.3063), door_2 = vector3(-1788.29, 435.4154, 128.3063), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { hash = -1438552720, coord = vector3(-1828.299, 418.1538, 121.3473), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = 1558415341, other = 1558415341, coord = vector3(-1798.207, 409.3319, 113.6637), door_1 = vector3(-1798.431, 409.1472, 113.6637), door_2 = vector3(-1797.917, 409.4506, 113.6637), lock = true, distance = 5.0, home = 'Laranjas' },
    -- { text = true, hash = 1100960097, coord = vector3(-1802.031, 411.244, 128.3063), lock = true, distance = 5.0, home = 'Laranjas' },
    { text = true, hash = -1487710823, coord = vector3(-1804.127, 432.3429, 128.2388), lock = true, distance = 5.0, home = 'Laranjas' },
    { text = true, hash = -1487710823, coord = vector3(-1788.791, 429.8637, 128.2726), lock = true, distance = 5.0, home = 'Laranjas' },
    { text = true, hash = -1184597573, coord = vector3(-1797.125, 427.0286, 123.3187), lock = true, distance = 5.0, home = 'Laranjas' },
    { text = true, hash = 724862427, coord = vector3(-1798.22, 469.5692, 133.6813), lock = true, distance = 5.0, home = 'Laranjas' },
    { text = true, hash = -1249591818, other = 546378757, coord = vector3(-1800.25, 473.0769, 133.6813), door_1 = vector3(-1801.938, 475.0022, 133.6644), door_2 = vector3(-1799.538, 470.6769, 133.6813), lock = true, distance = 5.0, home = 'Laranjas' },
    
    -- [ Lake East ] --
    { text = true, hash = 546378757, other = -1249591818, coord = vector3(-104.5582, 850.3516, 235.6227), door_1 = vector3(-103.4505, 849.811, 235.589), door_2 = vector3(-105.7319, 850.7736, 235.589), lock = true, distance = 5.0, home = 'Lakeeast' },
    { text = true, hash = -303284239, coord = vector3(-92.03077, 821.0505, 235.7238), lock = true, distance = 5.0, home = 'Lakeeast' },
    { text = true, hash = -303284239, coord = vector3(-92.50549, 829.2264, 235.7238), lock = true, distance = 5.0, home = 'Lakeeast' },
    { text = true, hash = 1216366345, coord = vector3(-85.52967, 834.633, 235.9092), lock = true, distance = 5.0, home = 'Lakeeast' },
    { text = true, hash = 752135018, coord = vector3(-97.67473, 815.9868, 235.7406), lock = true, distance = 5.0, home = 'Lakeeast' },
    { text = true, hash = 899688483, coord = vector3(-76.91868, 822.9099, 235.7238), lock = true, distance = 10.0, open = 5.0, home = 'Lakeeast' },
    { text = true, hash = 899688483, coord = vector3(-77.11649, 822.9626, 231.326), lock = true, distance = 10.0, open = 5.0, home = 'Lakeeast' },
    { text = true, hash = -1309269811, coord = vector3(-77.11649, 822.8176, 227.7371), lock = true, distance = 10.0, open = 5.0, home = 'Lakeeast' },
    { hash = -2028162640, coord = vector3(-91.5956, 820.4572, 228.0908), lock = true, distance = 10.0, open = 5.0, home = 'Lakeeast' },

    -- [ Marlowe ] --
    { text = true, hash = 992439939, coord = vector3(-692.611, 984.1846, 238.3524), lock = true, distance = 5.0, home = 'Marlowe' },
    { text = true, hash = 520054040, coord = vector3(-695.8813, 983.2352, 238.3019), lock = true, distance = 15.0, open = 2.0, home = 'Marlowe' },
    { text = true, hash = -1421690152, coord = vector3(-662.2286, 953.1561, 243.9465), lock = true, distance = 5.0, home = 'Marlowe' },
    { text = true, hash = 118134501, coord = vector3(-662.6373, 944.0176, 244.0813), lock = true, distance = 5.0, home = 'Marlowe' },
    { text = true, hash = -206223359, coord = vector3(-617.6967, 939.3231, 243.9465), lock = true, distance = 10.0, open = 5.0, home = 'Marlowe' },
        
    -- [ Picture ] --
    { text = true, hash = -533948079, other = -721607029, coord = vector3(-722.7033, 490.233, 109.6198), door_1 = vector3(-723.2967, 489.9297, 109.6198), door_2 = vector3(-722.1362, 490.5099, 109.6198), lock = true, distance = 5.0, home = 'Picture' },
    { text = true, hash = -533948079, other = -721607029, coord = vector3(-741.4813, 485.3143, 109.704), door_1 = vector3(-741.7187, 485.9077, 109.704), door_2 = vector3(-741.2308, 484.7209, 109.704), lock = true, distance = 5.0, home = 'Picture' },
    { text = true, hash = 1051049560, coord = vector3(-723.6, 502.7473, 109.5692), lock = true, distance = 5.0, home = 'Picture' },

    -- [ Casa Lago ] -- 
    { text = true, hash = -2146494197, other = -2146494197, door_1 = vector3(-112.9187, 986.3472, 235.7406), door_2 = vector3(-112.6286, 985.6088, 235.7406), coord = vector3(-112.7341, 986.0044, 235.7406), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -435821409, other = -435821409, door_1 = vector3(-105.2835, 976.3253, 235.7406), door_2 = vector3(-104.1495, 976.7868, 235.7406), coord = vector3(-104.6901, 976.5363, 235.7406), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -435821409, other = -435821409, door_1 = vector3(-98.2945, 988.8527, 235.7576), door_2 = vector3(-97.12088, 989.2484, 235.7576), coord = vector3(-97.68791, 989.0769, 235.7576), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -435821409, other = -435821409, door_1 = vector3(-68.04395, 988.0352, 234.3927), door_2 = vector3(-67.16043, 987.0725, 234.3927), coord = vector3(-67.63516, 987.4813, 234.3927), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -2146494197, other = -2146494197, door_1 = vector3(-58.64175, 979.767, 232.8594), door_2 = vector3(-57.90329, 980.0703, 232.8594), coord = vector3(-58.21978, 979.8989, 232.8594), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -2146494197, other = -2146494197, door_1 = vector3(-61.93846, 998.334, 234.3927), door_2 = vector3(-62.42637, 998.8879, 234.3927), coord = vector3(-62.14945, 998.5319, 234.3927), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -435821409, other = -435821409, door_1 = vector3(-70.28571, 1008.607, 234.3927), door_2 = vector3(-71.15604, 1009.345, 234.3927), coord = vector3(-70.68132, 1008.963, 234.3927), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -435821409, other = -435821409, door_1 = vector3(-102.9099, 1011.719, 235.7576), door_2 = vector3(-102.6198, 1010.598, 235.7576), coord = vector3(-102.8044, 1011.204, 235.7576), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -435821409, other = -435821409, door_1 = vector3(-110.8088, 999.4813, 235.7406), door_2 = vector3(-111.6923, 999.1517, 235.7406), coord = vector3(-111.1912, 999.3759, 235.7406), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -435821409, other = -435821409, door_1 = vector3(-60.01318, 990.3033, 235.2014), door_2 = vector3(-59.36703, 988.4703, 235.2014), coord = vector3(-59.31428, 989.578, 235.2183), lock = true, distance = 5.0, home = 'Lago' },
    { text = true, hash = -435821409, other = -435821409, door_1 = vector3(-58.06153, 984.989, 235.2014), door_2 = vector3(-57.33626, 982.9451, 235.2014), coord = vector3(-57.2967, 984.0396, 235.2183), lock = true, distance = 5.0, home = 'Lago' },

    -- [ Casa Zancudo ] --
    { text = true, hash = 825488425, coord = vector3(-418.5758, 3045.732, 29.7854), lock = true, distance = 15.0, open = 5.0, home = 'Zancudo' },
    { text = true, hash = 1187994459, coord = vector3(-403.7143, 3038.835, 30.20654), lock = true, distance = 15.0, open = 5.0, home = 'Zancudo' },
    { text = true, hash = 1415203617, coord = vector3(-393.3363, 3044.888, 30.20654), lock = true, distance = 15.0, open = 5.0, home = 'Zancudo' },
    { text = true, hash = 1187994459, coord = vector3(-394.1011, 3037.833, 30.20654), lock = true, distance = 15.0, open = 5.0, home = 'Zancudo' },
    
    -- [ Casa Hugo ] --
    { text = true, hash = 1043264400, other = -1310532874, door_1 = vector3(-835.3714, 7153.147, 99.74573), door_2 = vector3(-834.5143, 7152.527, 99.74573), coord = vector3(-834.8703, 7152.831, 99.74573), lock = true, distance = 5.0, perm = { 'hydra.permissao', 'staff.permissao'} },
    { text = true, hash = 1251463821, other = 89835536, door_1 = vector3(-820.9846, 7161.561, 96.13989), door_2 = vector3(-820.444, 7162.22, 96.13989), coord = vector3(-820.7736, 7161.903, 96.13989), lock = true, distance = 5.0, perm = { 'hydra.permissao', 'staff.permissao'} },
    { text = true, hash = 2073552859, other = 2073552859, door_1 = vector3(-854.3077, 7220.835, 99.64465), door_2 = vector3(-860.8483, 7219.517, 99.62781), coord = vector3(-857.9077, 7220.466, 99.62781), lock = true, distance = 20.0, open = 5.0, perm = { 'hydra.permissao', 'staff.permissao'} },
    { text = true, hash = -174568072, other = -1435355347, door_1 = vector3(-838.7736, 7150.299, 104.5648), door_2 = vector3(-839.5121, 7150.787, 104.5648), coord = vector3(-838.8264, 7150.866, 104.5648), lock = true, distance = 15.0, open = 5.0, perm = { 'hydra.permissao', 'staff.permissao'} },
    { text = true, hash = 1873351783, coord = vector3(-836.0044, 7137.231, 93.8147), lock = true, distance = 15.0, open = 5.0, perm = { 'hydra.permissao', 'staff.permissao'} },
    { text = true, hash = 736699661, coord = vector3(-829.3978, 7153.345, 96.15674), lock = true, distance = 5.0, open = 5.0, perm = { 'hydra.permissao', 'staff.permissao'} },
    { text = true, hash = 736699661, coord = vector3(-844.1802, 7169.802, 96.15674), lock = true, distance = 5.0, open = 5.0, perm = { '+Hydra.Gerente', 'staff.permissao'} },

    -- [ Cobertura SP ] --
    { text = true, hash = 1879668795, coord = vector3(-308.5319, -715.7143, 28.01611), lock = true, distance = 15.0, open = 2.0, home = 'Coberturasaopaulo' },

    -- [ LakeNorth ] --
    { text = true, hash = 736699661, coord = vector3(2557.437, 6191.367, 165.3759), lock = true, distance = 5.0, home = 'Lakenorth' },

    --[ ZancudoBeach]========================================================
    { text = true, hash = 1299623290, coord = vector3(-2555.921, 3735.837, 13.40735), lock = true, distance = 15.0, open = 5.0, home = "ZancudoBeach" },
    { text = true, hash = 841381594, coord = vector3(-2540.91796875, 3756.6840820312, 13.470310211182), lock = true, distance = 5.0, home = "ZancudoBeach" },

    --[ MANSION VILLA ]========================================================
    { text = true, hash = 1068002766, coord = vector3(-2597.539, 1926.554, 167.2968), lock = true, distance = 15.0, open = 5.0, home = "Villa" },
    { text = true, hash = -2037125726, coord = vector3(-2594.743, 1916.677, 167.2968), lock = true, distance = 5.0, home = "Villa" },
    { text = true, hash = 308207762, coord = vector3(-2588.308, 1910.519, 167.4821), lock = true, distance = 5.0, home = "Villa" },
    { text = true, hash = 813813633, coord = vector3(-2599.635, 1900.76, 167.2968), lock = true, distance = 5.0, home = "Villa" },
    { text = true, hash = 813813633, coord = vector3(-2599.754, 1902.527, 163.7413), lock = true, distance = 5.0, home = "Villa" },
    { text = true, hash = -1249591818, other = 546378757, coord = vector3(-2557.833, 1913.235, 168.8806), door_1 = vector3(-2556.658203125, 1915.7164306641, 169.0708770752), door_2 = vector3(-2559.1928710938, 1910.8599853516, 169.0708770752), lock = true, distance = 15.0, open = 5.0, home = "Villa" },

    --[ MANSION MAJESTY ]========================================================
    { text = true, hash = -2112131286, coord = vector3(571.1605, 737.9209, 206.186), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -2112131286, coord = vector3(558.6462, 767.2747, 206.186), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -2112131286, coord = vector3(545.6044, 745.9648, 206.186), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -2112131286, coord = vector3(569.9341, 736.3121, 203.1868), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -1965126495, coord = vector3(594.6198, 760.5626, 202.9509), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -777756890, coord = vector3(584.6242, 765.5341, 203.1531), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -777756890, coord = vector3(566.5714, 763.1077, 203.1699), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -1568354151, coord = vector3(584.334, 777.7451, 202.9509), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -777756890, coord = vector3(577.0945, 757.0549, 203.1868), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -1965126495, coord = vector3(554.4791, 771.9824, 202.9678), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -2112131286, coord = vector3(535.9912, 740.5978, 202.9846), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -2112131286, coord = vector3(536.5978, 746.0835, 202.9846), lock = true, distance = 5.0, home = "Majesty" },
    { text = true, hash = -1483985159, coord = vector3(582.211, 763.4769, 203.1699), lock = true, distance = 15.0, open = 5.0, home = "Majesty" },
    { text = true, hash = -1483985159, coord = vector3(579.9824, 759.7846, 203.1699), lock = true, distance = 15.0, open = 5.0, home = "Majesty" },
    { text = true, hash = -981274479, other = 2021873295, coord = vector3(575.5516, 781.978, 202.9509), door_1 = vector3(582.23022460938, 778.34216308594, 201.93556213379), door_2 = vector3(568.58013916016, 785.48699951172, 201.93153381348), lock = true, distance = 15.0, open = 5.0, home = "Majesty" },

    --[ Island02 ]========================================================
    { text = true, hash = 116180164, other = -415922858, coord = vector3(-5862.58, 1151.367, 7.998535), door_1 = vector3(-5862.778, 1150.694, 7.998535), door_2 = vector3(-5862.778, 1151.934, 7.998535), lock = true, distance = 5.0, home = "Island02" },
    { text = true, hash = 116180164, coord = vector3(-5875.477, 1151.248, 8.183838), lock = true, distance = 15.0, open = 5.0, home = "Island02" },

    --===================================================================================================================================================================
    
    -- [ Tropical ] --
    { text = true, hash = -1047041716, coord = vector3(288.9495, -920.2681, 29.4989), door_1 = vector3(289.2264, -919.5428, 29.4989), door_2 = vector3(288.6593, -921.0066, 29.4989), lock = true, distance = 5.0, other = -1852068057, perm = { 'tropical.permissao', 'staff.permissao'} },
    { text = true, hash = -1276523023, coord = vector3(311.6571, -930.7253, 52.80225), lock = true, distance = 5.0, perm = { 'tropical.permissao', 'staff.permissao'} },
    
    -- [ Bras ] --
    { text = true, hash = -1212951353, coord = vector3(1394.149, 3599.776, 35.00879), door_1 = vector3(1394.875, 3600.079, 35.00879), door_2 = vector3(1393.727, 3599.631, 35.00879), lock = true, distance = 5.0, other = -1212951353, perm = { 'bras.permissao', 'staff.permissao'} },
    { text = true, hash = 1804626822, coord = vector3(1399.385, 3608.347, 38.98535), lock = true, distance = 5.0, perm = { 'bras.permissao', 'staff.permissao'} },
    { text = true, hash = 1804626822, coord = vector3(1387.859, 3614.572, 38.93481), lock = true, distance = 5.0, perm = { 'bras.permissao', 'staff.permissao'} },
    
    -- [ MonteCristo ] --
    { text = true, hash = 1187280133, coord = vector3(307.5297, -2733.27, 6.010254), lock = true, distance = 10.0, perm = { 'montecristo.permissao', 'staff.permissao'} },
    
    -- [ Ciringa ] --
    { text = true, hash = -1085470028, coord = vector3(1437.6, -1491.495, 63.68713), door_1 = vector3(1437.93, -1491.917, 63.61975), door_2 = vector3(1437.178, -1491.508, 63.68713), lock = true, distance = 5.0, other = 406830232, perm = { 'ciringa.permissao', 'staff.permissao'} },
    { text = true, hash = 406830232, coord = vector3(1446.593, -1482.897, 63.68713), door_1 = vector3(1446.343, -1482.343, 63.61975), door_2 = vector3(1446.936, -1482.659, 63.67029), lock = true, distance = 5.0, other = -1085470028, perm = { 'ciringa.permissao', 'staff.permissao'} },

    -- [ Chineses ] --
    { text = true, hash = -2053499160, other = 777250909, door_1 = vector3(-950.6769, -1474.826, 5.656372), door_2 = vector3(-950.6769, -1474.826, 5.656372), coord = vector3(-950.5055, -1475.974, 5.285767), lock = true, distance = 15.0, open = 5.0, perm = { 'chines.permissao', 'staff.permissao'} },
    { text = true, hash = -2023754432, other = -2023754432, door_1 = vector3(-886.233, -1443.851, 2), door_2 = vector3(-884.9802, -1443.521, 2), coord = vector3(-885.5472, -1443.771, 2), lock = true, distance = 5.0, perm = { 'chines.permissao', 'staff.permissao'} },

    -- [ LK ] --
    { text = true, hash = -398766501, other = -398766501, door_1 = vector3(1246.879, 7237.859, 11.30115), door_2 = vector3(1239.851, 7237.899, 11.30115), coord = vector3(1243.49, 7237.068, 8.756836), lock = true, distance = 15.0, open = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = -225321102, other = 71074503, door_1 = vector3(1246.985, 7293.626, 9.953125), door_2 = vector3(1248.422, 7293.574, 9.953125), coord = vector3(1247.697, 7293.376, 9.953125), lock = true, distance = 15.0, open = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = -225321102, coord = vector3(1286.044, 7328.901, 8.672485), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = 71074503, coord = vector3(1224.712, 7335.679, 6.043945), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = 1114904141, coord = vector3(1236.171, 7305.455, 1.528198), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = 1114904141, coord = vector3(1229.064, 7305.692, 1.528198), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = 1114904141, coord = vector3(1236.171, 7315.464, 1.528198), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = 1114904141, coord = vector3(1228.971, 7315.596, 1.528198), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = 1114904141, coord = vector3(1236.303, 7325.459, 1.528198), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    { text = true, hash = 1114904141, coord = vector3(1236.132, 7335.468, 1.528198), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    -- { text = true, hash = -1049302886, other = 1653418708, door_1 = vector3(-3061.648, 416.9275, 6.684204), door_2 = vector3(-3060.343, 420.4879, 6.633667), coord = vector3(-3060.804, 418.6154, 6.650513), lock = true, distance = 15.0, open = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    -- { text = true, hash = -349730013, other = -1918480350, door_1 = vector3(-3277.767, 501.9033, 5.942871), door_2 = vector3(-3276.989, 504.2242, 5.942871), coord = vector3(-3277.556, 503.156, 5.942871), lock = true, distance = 15.0, open = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    -- { text = true, hash = -2082151919, other = -2082151919, door_1 = vector3(-3337.899, 556.0879, 13.94653), door_2 = vector3(-3337.437, 555.2703, 13.94653), coord = vector3(-3337.714, 555.6528, 13.94653), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    -- { text = true, hash = 823886385, other = 823886385, door_1 = vector3(-3306.145, 536.7033, 14.40149), door_2 = vector3(-3305.169, 537.2703, 14.40149), coord = vector3(-3305.552, 536.9011, 14.40149), lock = true, distance = 5.0, perm = { 'legiao.permissao', 'staff.permissao'} },
    
    -- [ Casa Arquiteto ] --
    { text = true, hash = -1886910619, coord = vector3(-1248.752, 842.5187, 192.8916), lock = true, distance = 5.0, perm = { 'staff.permissao' } },

    -- [ Comando do Norte ] --
    { text = true, hash = -1603817716, coord = vector3(746.3077, 2505.6, 72.97144), lock = true, distance = 15.0, open = 5.0, perm = { 'comandonorte.permissao', 'staff.permissao' } },
    { text = true, hash = 1042741067, other = 1042741067, door_1 = vector3(732.1583, 2522.558, 73.49377), door_2 = vector3(732.1583, 2523.903, 73.49377), coord = vector3(732.356, 2523.363, 73.49377), lock = true, distance = 5.0, perm = { 'comandonorte.permissao', 'staff.permissao' } },

    --[ Coringa ]
    -- { text = true, hash = 823886385, coord = vector3(-3268.035, 563.8417, 13.01978), lock = true, distance = 5.0, perm = { 'coringa.permissao', 'staff.permissao'} },

    --[ Bennys ]
    { text = true, hash = -456733639, coord = vector3(154.8396, -3034.391, 7.02124), lock = true, distance = 15.0, open = 5.0, perm = { 'bennys.permissao', 'staff.permissao'} },
    { text = true, hash = -456733639, coord = vector3(154.8528, -3023.96, 7.02124), lock = true, distance = 15.0, open = 5.0, perm = { 'bennys.permissao', 'staff.permissao'} },
    { text = true, hash = -1229046235, coord = vector3(151.3055, -3012.435, 7.223389), lock = true, distance = 5.0, perm = { 'bennys.permissao', 'staff.permissao'} },
    { text = true, hash = -2023754432, coord = vector3(155.1824, -3018.079, 7.038086), lock = true, distance = 5.0, perm = { 'bennys.permissao', 'staff.permissao'} },
    
    --[ Bennys Tunner ]
    { text = true, hash = -124639392, coord = vector3(-356.4132, -133.2132, 39.03589), lock = true, distance = 15.0, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    { text = true, hash = -626684119, coord = vector3(-354.5406, -129.2967, 39.05273), lock = true, distance = 5, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    { text = true, hash = -626684119, coord = vector3(-343.8198, -100.2593, 45.77588), lock = true, distance = 5, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    { text = true, hash = 1589558367, coord = vector3(-345.2044, -104.4264, 45.79272), lock = true, distance = 15.0, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    { text = true, hash = -2051651622, coord = vector3(-346.0088, -143.1165, 45.79272), lock = true, distance = 15.0, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    { text = true, hash = -2051651622, coord = vector3(-334.2462, -146.3209, 45.77588), lock = true, distance = 15.0, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    { text = true, hash = -626684119, coord = vector3(-334.3517, -146.1099, 39.05273), lock = true, distance = 5, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    { text = true, hash = -626684119, coord = vector3(-346.9978, -142.4967, 39.05273), lock = true, distance = 5, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    { text = true, hash = -626684119, coord = vector3(-354.2637, -168.1978, 39.05273), lock = true, distance = 5, open = 2.0, perm = { 'bennystunner.permissao', 'staff.permissao'} },
    
    --[ Bracho ]
    { text = true, hash = -1958316735, coord = vector3(1201.002, 2654.743, 37.8396), lock = true, distance = 5, open = 2.0, perm = { 'bracho.permissao', 'staff.permissao'} },
    { text = true, hash = -1220867800, coord = vector3(2720.888, 3510.857, 56.02051), lock = true, distance = 5, open = 2.0, perm = { 'bracho.permissao', 'staff.permissao'} },

    --[ Mare ]
    { text = true, hash = 1368401976, coord = vector3(-1196.862, -1732.404, 4.594849), lock = true, distance = 5, open = 2.0, perm = { 'mare.permissao', 'staff.permissao'} },
    { text = true, hash = 1368401976, coord = vector3(-1194.448, -1729.714, 11.89087), lock = true, distance = 5, open = 2.0, perm = { 'mare.permissao', 'staff.permissao'} },
    
    --[ Melgual ]
    { text = true, hash = -1671171579, other = -1671171579, door_1 = vector3(115.0813, -1038.171, 29.33044), door_2 = vector3(114.6593, -1039.279, 29.33044), coord = vector3(114.7648, -1038.725, 29.3136), lock = true, distance = 2.0, open = 2.0, perm = { 'melgual.permissao', 'staff.permissao'} },
    { text = true, hash = -1939451382, coord = vector3(127.767, -1028.954, 29.43152), lock = true, distance = 2, open = 2.0, perm = { 'melgual.permissao', 'staff.permissao'} },

    --[ DubaiGang ]
    { text = true, hash = 676238968, coord = vector3(-148.1934, -29.74945, 53.05493), lock = true, distance = 2, open = 2.0, perm = { 'dubaigang.permissao', 'staff.permissao'} },
    { text = true, hash = -418177216, coord = vector3(-158.6242, -31.58242, 53.07178), lock = true, distance = 2, open = 2.0, perm = { 'dubaigang.permissao', 'staff.permissao'} },
    { text = true, hash = 631614199, coord = vector3(-173.8945, -50.42637, 52.80225), lock = true, distance = 2, open = 2.0, perm = { 'dubaigang.permissao', 'staff.permissao'} },
    { text = true, hash = 631614199, coord = vector3(-172.7209, -46.81319, 52.80225), lock = true, distance = 2, open = 2.0, perm = { 'dubaigang.permissao', 'staff.permissao'} },
    { text = true, hash = -418177216, coord = vector3(-168.7385, -43.80659, 52.80225), lock = true, distance = 2, open = 2.0, perm = { 'dubaigang.permissao', 'staff.permissao'} },
    { text = true, hash = -1483471451, coord = vector3(-168.8835, -54.90989, 52.90332), lock = true, distance = 10, open = 5.0, perm = { 'dubaigang.permissao', 'staff.permissao'} },
    
    --[ Telasco ]
    { text = true, hash = -1045015371, coord = vector3(-254.8879, 244.378, 92.0791), lock = true, distance = 3.0, open = 2.0, perm = { 'mptv.permissao', 'staff.permissao'} },
    { text = true, hash = -1045015371, coord = vector3(-257.367, 244.3912, 92.0791), lock = true, distance = 3.0, open = 2.0, perm = { 'mptv.permissao', 'staff.permissao'} },
    { text = true, hash = -1439450138, coord = vector3(-248.822, 216.7648, 92.0791), lock = true, distance = 3.0, open = 3.0, perm = { 'mptv.permissao', 'staff.permissao'} },
    { text = true, hash = 1808123841, coord = vector3(-248.822, 216.7648, 92.0791), lock = true, distance = 3.0, open = 3.0, perm = { 'mptv.permissao', 'staff.permissao'} },
    { text = true, hash = 1808123841, other = 1808123841, door_1 = vector3(-598.0483, -930.4484, 23.85425), door_2 = vector3(-598.1671, -929.2615, 23.85425), coord = vector3(-598.1274, -929.9077, 23.85425), lock = true, distance = 15.0, open = 5.0, perm = { 'mptv.permissao', 'staff.permissao'} },
    

    { text = true, hash = -1663450520, other = -1854854241, door_1 = vector3(-425.8549, 23.20879, 46.23071), door_2 = vector3(-423.8637, 23.03736, 46.26453), coord = vector3(-424.9187, 23.14286, 46.24756), lock = true, distance = 15.0, open = 5.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -1940749042, coord = vector3(-470.1626, 49.75385, 46.23071), lock = true, distance = 3.0, open = 3.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -2010077646, coord = vector3(-453.6659, 9.916484, 35.51428), lock = true, distance = 3.0, open = 3.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -2066395222, coord = vector3(-464.6505, 29.44616, 46.66882), lock = true, distance = 3.0, open = 3.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -1854854241, other = -1663450520, door_1 = vector3(-441.6659, 39.9033, 52.86963), door_2 = vector3(-439.4637, 39.54726, 52.86963), coord = vector3(-440.3473, 39.7055, 52.86963), lock = true, distance = 15.0, open = 5.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -429115342, coord = vector3(-491.6176, 51.29671, 52.39783), lock = true, distance = 3.0, open = 3.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -1204133321, coord = vector3(-477.6659, 54.38242, 52.41467), lock = true, distance = 3.0, open = 3.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -1193319547, coord = vector3(-470.6901, 46.4044, 52.43152), lock = true, distance = 3.0, open = 3.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -2066395222, coord = vector3(-456.7385, 43.34506, 46.23071), lock = true, distance = 3.0, open = 3.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -1854854241, other = -1663450520, door_1 = vector3(-464.0176, 43.45055, 52.86963), door_2 = vector3(-464.1099, 44.65055, 52.86963), coord = vector3(-464.5978, 44.01759, 52.85278), lock = true, distance = 15.0, open = 5.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    { text = true, hash = -752680088, other = 1709680887, door_1 = vector3(-489.3362, 29.22198, 46.31506), door_2 = vector3(-490.6022, 29.27473, 46.31506), coord = vector3(-490.2989, 29.27473, 46.31506), lock = true, distance = 15.0, open = 5.0, perm = { 'venezza.permissao', 'staff.permissao'} },
    
    --[ CDD ] 
    { text = true, hash = 1980234783, coord = vector3(1409.38, 1343.71, 138.1465), lock = true, distance = 3.0, open = 2.0, perm = { 'cdd.permissao', 'staff.permissao'} },
    { text = true, hash = 1980234783, coord = vector3(1414.088, 1337.116, 138.1465), lock = true, distance = 3.0, open = 2.0, perm = { 'cdd.permissao', 'staff.permissao'} },
    { text = true, hash = 1980234783, coord = vector3(1409.565, 1334.809, 141.4154), lock = true, distance = 3.0, open = 2.0, perm = { 'cdd.permissao', 'staff.permissao'} },
    { text = true, hash = 1980234783, coord = vector3(1530.29, 1440.949, 115.3824), lock = true, distance = 3.0, open = 2.0, perm = { 'cdd.permissao', 'staff.permissao'} },
    
    --[ Paunitrante ] 
    { text = true, hash = -54641426, coord = vector3(2048.426, 3680.136, 36.17139), lock = true, distance = 3.0, open = 2.0, perm = { 'empresaspaulo.permissao', 'staff.permissao'} },
    { text = true, hash = -54641426, coord = vector3(2041.596, 3676.101, 36.17139), lock = true, distance = 3.0, open = 2.0, perm = { 'empresaspaulo.permissao', 'staff.permissao'} },

    --[ Pautorante ]
    -- { text = true, hash = -806752263, other = 386432549, door_1 = vector3(-1605.758, -998.1362, 13.20508), door_2 = vector3(-1606.51, -997.0549, 13.20508), coord = vector3(-1606.114, -997.6747, 13.20508), lock = true, distance = 2.0, open = 2.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    -- { text = true, hash = -806752263, other = 386432549, door_1 = vector3(-1609.78, -984.989, 13.20508), door_2 = vector3(-1608.884, -983.8945, 13.20508), coord = vector3(-1609.411, -984.3033, 13.20508), lock = true, distance = 2.0, open = 2.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    -- { text = true, hash = -1635579193, coord = vector3(-1603.437, -977.4594, 13.01978), lock = true, distance = 3.0, open = 2.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    -- { text = true, hash = -626684119, coord = vector3(-1599.376, -979.3582, 13.20508), lock = true, distance = 3.0, open = 2.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    -- { text = true, hash = 1289778077, coord = vector3(-1596.765, -981.6395, 13.20508), lock = true, distance = 3.0, open = 2.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    -- { text = true, hash = 1980817304, other = 1980817304, door_1 = vector3(-1592.637, -999.4681, 13.20508), door_2 = vector3(-1591.925, -999.9561, 13.20508), coord = vector3(-1592.083, -999.4813, 13.20508), lock = true, distance = 2.0, open = 2.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    
    -- [Red Club] --
    { text = true, hash = -1132390101, other = -1132390101, door_1 = vector3(-577.7011, 238.8923, 82.64319), door_2 = vector3(-576.3692, 238.6286, 82.64319), coord = vector3(-577.0813, 238.7604, 82.64319), lock = true, distance = 15.0, open = 5.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    { text = true, hash = 390840000, coord = vector3(-578.8483, 212.5319, 82.64319), lock = true, distance = 5.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    { text = true, hash = 390840000, coord = vector3(-577.9385, 209.3539, 82.64319), lock = true, distance = 5.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    { text = true, hash = 390840000, coord = vector3(-578.4264, 205.0022, 82.64319), lock = true, distance = 5.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    { text = true, hash = 390840000, coord = vector3(-578.822, 200.5714, 82.64319), lock = true, distance = 5.0, perm = { 'grotorante.permissao', 'staff.permissao'} },
    { text = true, hash = 601770753, coord = vector3(-579.9165, 212.6374, 86.23218), lock = true, distance = 5.0, perm = { 'grotorante.permissao', 'staff.permissao'} },

    -- [ Triade Nova ] --
    { text = true, hash = -700013674, other = 1084723221, door_1 = vector3(-3328.404, 544.8923, 17.1311), door_2 = vector3(-3328.009, 544.1143, 17.1311), coord = vector3(-3327.982, 544.6022, 17.1311), lock = true, distance = 15.0, open = 5.0, perm = { '+OsCrias.Gerente', 'staff.permissao'} },
    { text = true, hash = -2082151919, other = -2082151919, door_1 = vector3(-3337.886, 556.2198, 13.94653), door_2 = vector3(-3337.398, 555.3231, 13.94653), coord = vector3(-3337.583, 555.7846, 13.94653), lock = true, distance = 15.0, open = 5.0, perm = { 'oscrias.permissao', 'staff.permissao'} },
    { text = true, hash = -1049302886, other = 1653418708, door_1 = vector3(-3061.648, 416.9275, 6.684204), door_2 = vector3(-3060.343, 420.4879, 6.633667), coord = vector3(-3060.804, 418.6154, 6.650513), lock = true, distance = 15.0, open = 5.0, perm = { 'oscrias.permissao', 'staff.permissao'} },
    { text = true, hash = -349730013, other = -1918480350, door_1 = vector3(-3277.767, 501.9033, 5.942871), door_2 = vector3(-3276.989, 504.2242, 5.942871), coord = vector3(-3277.556, 503.156, 5.942871), lock = true, distance = 15.0, open = 5.0, perm = { 'oscrias.permissao', 'staff.permissao'} },
    { text = true, hash = 823886385, other = 823886385, door_1 = vector3(-3306.145, 536.7033, 14.40149), door_2 = vector3(-3305.169, 537.2703, 14.40149), coord = vector3(-3305.552, 536.9011, 14.40149), lock = true, distance = 5.0, perm = { 'oscrias.permissao', 'staff.permissao'} },
    { text = true, hash = 823886385, coord = vector3(-3267.837, 564.0132, 13.01978), lock = true, distance = 5.0, perm = { 'oscrias.permissao', 'staff.permissao'} },
    
    -- [ Galaxy ] --
    { text = true, hash = -2076287065, other = -374527357, door_1 = vector3(-233.5648, -330.1319, 30.08862), door_2 = vector3(-233.4198, -331.1868, 30.08862), coord = vector3(-233.3275, -330.7121, 30.08862), lock = true, distance = 5.0, open = 2.0, perm = { 'galaxy.permissao', 'staff.permissao'} },
    { text = true, hash = -2076287065, other = -374527357, door_1 = vector3(-233.1429, -333.0725, 30.08862), door_2 = vector3(-232.9451, -334.1934, 30.08862), coord = vector3(-233.1165, -333.5868, 30.08862), lock = true, distance = 5.0, open = 2.0, perm = { 'galaxy.permissao', 'staff.permissao'} },
    { text = true, hash = -1989765534, coord = vector3(-219.7187, -332.0308, 30.05493), lock = true, distance = 3.0, open = 2.0, perm = { 'galaxy.permissao', 'staff.permissao'} },
    { text = true, hash = 1695461688, coord = vector3(-212.7824, -289.3451, 25.45496), lock = true, distance = 3.0, open = 2.0, perm = { 'galaxy.permissao', 'staff.permissao'} },
    { text = true, hash = -1119680854, coord = vector3(-225.033, -280.0879, 29.24609), lock = true, distance = 3.0, open = 2.0, perm = { 'galaxy.permissao', 'staff.permissao'} },
    { text = true, hash = 1695461688, coord = vector3(-228.2242, -281.0637, 29.24609), lock = true, distance = 3.0, open = 2.0, perm = { 'galaxy.permissao', 'staff.permissao'} },
    { text = true, hash = -1555108147, coord = vector3(-213.3099, -292.9978, 29.24609), lock = true, distance = 3.0, open = 2.0, perm = { 'galaxy.permissao', 'staff.permissao'} },
    { text = true, hash = 1695461688, coord = vector3(-209.5253, -316.4044, 28.45422), lock = true, distance = 3.0, open = 2.0, perm = { 'galaxy.permissao', 'staff.permissao'} },
    
    -- [ Underdogs ] --
    { text = true, hash = -1116041313, coord = vector3(128.5978, -1298.242, 29.26306), lock = true, distance = 3.0, open = 2.0, perm = { 'underdogs.permissao', 'staff.permissao'} },
    { text = true, hash = 668467214, coord = vector3(95.35385, -1284.949, 29.26306), lock = true, distance = 3.0, open = 2.0, perm = { 'underdogs.permissao', 'staff.permissao'} },
    { text = true, hash = -495720969, coord = vector3(113.6703, -1296.897, 29.26306), lock = true, distance = 3.0, open = 2.0, perm = { 'underdogs.permissao', 'staff.permissao'} },
    { text = true, hash = -626684119, coord = vector3(99.65276, -1293.349, 29.26306), lock = true, distance = 3.0, open = 2.0, perm = { 'underdogs.permissao', 'staff.permissao'} },
    
    -- [ Bahamas ] --
    { text = true, hash = -224738884, other = 666905606, door_1 = vector3(-1387.411, -586.9978, 30.32458), door_2 = vector3(-1388.624, -587.6835, 30.32458), coord = vector3(-1388.097, -587.3011, 30.30774), lock = true, distance = 5.0, open = 2.0, perm = { 'bahamas.permissao', 'staff.permissao'} },
    { text = true, hash = -2102541881, coord = vector3(-1378.233, -621.9165, 30.30774), lock = true, distance = 3.0, open = 2.0, perm = { 'bahamas.permissao', 'staff.permissao'} },
    { text = true, hash = -2102541881, coord = vector3(-1378.378, -625.2132, 30.30774), lock = true, distance = 3.0, open = 2.0, perm = { 'bahamas.permissao', 'staff.permissao'} },
    
    -- [ Comitiva ] --
    { text = true, hash = -427498890, coord = vector3(-205.622, -1310.374, 31.28503), lock = true, distance = 3.0, open = 2.0, perm = { 'comitiva.permissao', 'staff.permissao'} },
    
    -- [Borracharia] -- 
    { text = true, hash = -1821777087, other = -1821777087, door_1 = vector3(955.3187, -945.0989, 50.32532), door_2 = vector3(955.2396, -944.1758, 50.32532), coord = vector3(955.1209, -944.6769, 50.32532), lock = true, distance = 5.0, open = 2.0, perm = { 'mecanica.permissao', 'staff.permissao'} },
    
    -- [ Cartel NPN ] --
    { text = true, hash = 1033441082, coord = vector3(-1501.345, 856.4572, 181.5853), lock = true, distance = 3.0, open = 2.0, perm = { 'lospraca.permissao', 'staff.permissao'} },
    { text = true, hash = 1033441082, other = 1033441082, door_1 = vector3(-1516.523, 850.8527, 181.5853), door_2 = vector3(-1517.407, 851.1297, 181.5853), coord = vector3(-1516.958, 851.1956, 181.5853), lock = true, distance = 5.0, open = 2.0, perm = { 'lospraca.permissao', 'staff.permissao'} },
    { text = true, hash = 1033441082, coord = vector3(-1520.176, 848.6374, 181.5853), lock = true, distance = 3.0, open = 2.0, perm = { 'lospraca.permissao', 'staff.permissao'} },
    { text = true, hash = 1033441082, other = 1033441082, door_1 = vector3(-1490.927, 851.5253, 181.5853), door_2 = vector3(-1491.073, 852.6725, 181.5853), coord = vector3(-1491.165, 852.0396, 181.5853), lock = true, distance = 5.0, open = 2.0, perm = { 'lospraca.permissao', 'staff.permissao'} },
    { text = true, hash = -1785293089, coord = vector3(-1500.224, 844.7473, 181.5853), lock = true, distance = 3.0, open = 2.0, perm = { 'lospraca.permissao', 'staff.permissao'} },
    
    -- [ Irmandade ] --
    { text = true, hash = 993120320, coord = vector3(-564.3033, 276.3824, 83.11499), lock = true, distance = 3.0, open = 2.0, perm = { 'irmandade.permissao', 'staff.permissao'} },
    { text = true, hash = 993120320, coord = vector3(-561.7055, 293.9736, 87.5802), lock = true, distance = 3.0, open = 2.0, perm = { 'irmandade.permissao', 'staff.permissao'} },
    
    -- [ CosaNostra ] --
    { text = true, hash = 2125964843, coord = vector3(3088.18, 5456.149, 23.60144), lock = true, distance = 3.0, open = 2.0, perm = { 'cosanostra.permissao', 'staff.permissao'} },
    { text = true, hash = -328548271, other = 243434624, door_1 = vector3(3140.677, 5375.183, 26.14575), door_2 = vector3(3143.222, 5376.593, 26.14575), coord = vector3(3142.022, 5375.947, 26.14575), lock = true, distance = 5.0, open = 10.0, perm = { 'cosanostra.permissao', 'staff.permissao'} },

    -- [ Fazenda ] --
    { text = true, hash = -228773386, coord = vector3(1395.653, 1141.859, 114.641), door_1 = vector3(1395.534, 1142.347, 114.641), door_2 = vector3(1395.429, 1141.253, 114.6241), lock = true, distance = 5.0, autoLock = 20000, other = -228773386, perm = { 'boiadeiras.permissao'} },
    { text = true, hash = -52575179, coord = vector3(1390.312, 1132.207, 114.3209), door_1 = vector3(1390.193, 1132.8, 114.3209), door_2 = vector3(1390.141, 1131.666, 114.3209), lock = true, distance = 5.0, autoLock = 20000, other = -1032171637, perm = { 'boiadeiras.permissao'} },
    { text = true, hash = -1032171637, coord = vector3(1400.44, 1128.211, 114.3209), door_1 = vector3(1399.938, 1128.066, 114.3209), door_2 = vector3(1401.033, 1128.053, 114.3209), lock = true, distance = 5.0, autoLock = 20000, other = -52575179, perm = { 'boiadeiras.permissao'} },
    { text = true, hash = -228773386, coord = vector3(1406.927, 1128.013, 114.3209), lock = true, distance = 5.0, autoLock = 20000, perm = { 'boiadeiras.permissao'} },
    { text = true, hash = -52575179, coord = vector3(1409.459, 1147.451, 114.3209), door_1 = vector3(1409.538, 1146.857, 114.3209), door_2 = vector3(1409.525, 1147.938, 114.3209), lock = true, distance = 5.0, autoLock = 20000, other = -1032171637, perm = { 'boiadeiras.permissao'} },
    { text = true, hash = -1032171637, coord = vector3(1408.404, 1160.136, 114.3209), door_1 = vector3(1408.655, 1159.582, 114.3209), door_2 = vector3(1408.484, 1160.519, 114.3209), lock = true, distance = 5.0, autoLock = 20000, other = -52575179, perm = { 'boiadeiras.permissao'} },
    { text = true, hash = -1032171637, coord = vector3(1408.259, 1164.686, 114.3209), door_1 = vector3(1408.642, 1164.29, 114.3209), door_2 = vector3(1408.681, 1165.371, 114.3209), lock = true, distance = 5.0, autoLock = 20000, other = -52575179, perm = { 'boiadeiras.permissao'} },
    { text = true, hash = -52575179, coord = vector3(1390.101, 1162.312, 114.3209), door_1 = vector3(1389.917, 1162.8, 114.3209), door_2 = vector3(1390.022, 1161.811, 114.3209), lock = true, distance = 5.0, autoLock = 20000, other = -1032171637, perm = { 'boiadeiras.permissao'} },

    -- [ Trevor ] --
    { text = true, hash = 390840000, coord = vector3(245.7363, -3156.554, 3.314331), lock = true, distance = 5.0, perm = { 'caos.permissao', 'staff.permissao'} },
    { text = true, hash = 390840000, coord = vector3(254.9275, -3156.646, 3.314331), lock = true, distance = 5.0, perm = { 'caos.permissao', 'staff.permissao'} },
    { text = true, hash = -590422879, coord = vector3(263.2352, -3161.578, 5.774414), lock = true, distance = 5.0, perm = { 'caos.permissao', 'staff.permissao'} },
    { text = true, hash = 279397912, coord = vector3(196.0879, -3167.512, 5.808105), door_1 = vector3(195.7319, -3167.051, 5.79126), door_2 = vector3(195.6, -3168.119, 5.79126), lock = true, distance = 5.0, autoLock = 20000, other = 521593591, perm = { 'caos.permissao', 'staff.permissao'} },

    -- [ Playboy ] --
    { text = true, hash = -1859471240, coord = vector3(-1461.943, 65.8022, 52.92017), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -1859471240, coord = vector3(-1441.477, 172.3385, 55.78467), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -1859471240, coord = vector3(-1434.435, 235.3319, 59.92969), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -1859471240, coord = vector3(-1578.831, 152.9275, 58.66589), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -2125423493, coord = vector3(-1471.16, 68.51868, 53.29089), lock = true, distance = 15.0, open = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -2125423493, coord = vector3(-1613.644, 78.15824, 61.56409), lock = true, distance = 15.0, open = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    -- casa
    { text = true, hash = 1649791195, coord = vector3(-1524.145, 78.94946, 56.77881), lock = true, distance = 15.0, open = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 1649791195, coord = vector3(-1528.325, 78.34286, 56.76196), lock = true, distance = 15.0, open = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 1649791195, coord = vector3(-1534.853, 79.87253, 56.76196), lock = true, distance = 15.0, open = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 1649791195, coord = vector3(-1545.231, 103.767, 56.77881), lock = true, distance = 15.0, open = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 861700718, coord = vector3(-1546.444, 89.56483, 61.3114), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -1344472195, coord = vector3(-1536.462, 130.589, 57.36853), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 861700718, coord = vector3(-1541.486, 91.45055, 53.89746), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -2023754432, coord = vector3(-1546.009, 98.01759, 57.58752), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 530955769, coord = vector3(-1541.103, 78.67253, 56.76196), lock = true, distance = 5.0, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -408054405, coord = vector3(-1495.358, 123.3363, 55.64978), door_1 = vector3(-1494.501, 123.6, 55.64978), door_2 = vector3(-1495.635, 122.4, 55.64978), lock = true, distance = 5.0, other = -1200212239, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = -408054405, coord = vector3(-1502.835, 130.167, 55.64978), door_1 = vector3(-1503.64, 129.8506, 55.64978), door_2 = vector3(-1502.492, 131.1033, 55.64978), lock = true, distance = 5.0, other = -1200212239, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 576007998, coord = vector3(-1509.204, 129.9297, 55.64978), door_1 = vector3(-1509.481, 131.0374, 55.64978), door_2 = vector3(-1508.097, 129.7846, 55.64978), lock = true, distance = 5.0, other = 719372357, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 576007998, coord = vector3(-1511.644, 132.422, 55.64978), door_1 = vector3(-1512.04, 133.2527, 55.64978), door_2 = vector3(-1510.787, 131.9209, 55.64978), lock = true, distance = 5.0, other = 719372357, perm = { 'osveio.permissao', 'staff.permissao'} },
    { text = true, hash = 576007998, coord = vector3(-1514.229, 134.6242, 55.64978), door_1 = vector3(-1514.413, 135.9033, 55.64978), door_2 = vector3(-1512.963, 134.4659, 55.64978), lock = true, distance = 5.0, other = 719372357, perm = { 'osveio.permissao', 'staff.permissao'} },

    --  [ Bunkers ] --
    { text = false, hash = -1200125214, coord = vector3(335.5516, 970.9187, 204.6527), door_1 = vector3(335.4857, 970.4967, 204.6527), door_2 = vector3(335.6967, 971.1297, 204.6527), lock = true, distance = 5.0, other = -1200125214, home = 'ddd' },
    { text = false, hash = -1200125214, coord = vector3(-1578.659, 797.4066, 181.2821), door_1 = vector3(-1578.448, 797.8945, 181.2821), door_2 = vector3(-1579.029, 797.3539, 181.2821), lock = true, distance = 5.0, other = -1200125214, home = 'ddd' },
    { text = false, hash = -1200125214, coord = vector3(2120.743, 27.38901, 212.8418), door_1 = vector3(2120.664, 27.74506, 212.8418), door_2 = vector3(2120.598, 26.95385, 212.8418), lock = true, distance = 5.0, other = -1200125214, home = 'ddd' },
    { text = false, hash = -1200125214, coord = vector3(-751.5824, 1749.534, 195.3348), door_1 = vector3(-751.8198, 1749.165, 195.3348), door_2 = vector3(-751.7275, 1749.758, 195.3348), lock = true, distance = 5.0, other = -1200125214, home = 'ddd' },
    { text = false, hash = -1200125214, coord = vector3(1358.083, 5501.13, 446.1611), door_1 = vector3(1358.176, 5500.694, 446.1611), door_2 = vector3(1357.714, 5501.262, 446.1611), lock = true, distance = 5.0, other = -1200125214, home = 'ddd' },
    { text = false, hash = -1200125214, coord = vector3(-157.1868, 1472.031, 284.4703), door_1 = vector3(-157.5297, 1472.215, 284.4703), door_2 = vector3(-157.1077, 1471.714, 284.4703), lock = true, distance = 5.0, other = -1200125214, home = 'ddd' },
    
    -- [ 77 ] --
    { text = true, hash = -1821777087, coord = vector3(260.0835, -3174.554, 3.22998), lock = true, distance = 5.0, perm = { 'caos.permissao', 'staff.permissao'} },
    { text = true, hash = -1821777087, coord = vector3(259.978, -3164.387, 3.22998), lock = true, distance = 5.0, perm = { 'caos.permissao', 'staff.permissao'} },

    -- [ Alcatraz ] --
    { text = true, hash = 741314661, coord = vector3(3917.815, -8.703293, 10.59338), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    { text = true, hash = 741314661, coord = vector3(3839.657, -0.01318359, 15.93481), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    { text = true, hash = 741314661, coord = vector3(3836.453, -22.89231, 6.70105), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3911.169, 25.42418, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    
    -- { text = true, hash = 298123530, coord = vector3(3909.6, 29.32747, 23.87109), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3907.938, 20.94066, 23.87109), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3904.642, 21.07253, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3906.316, 29.48572, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3897.982, 21.87692, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3899.103, 30.07912, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3894.079, 22.18022, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3895.714, 30.35605, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3890.611, 22.52308, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3890.519, 22.45714, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3894.277, 22.21978, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3897.877, 21.82418, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3904.602, 21.21758, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3907.912, 20.92747, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3909.771, 29.22198, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3906.461, 29.77583, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3899.156, 30.06594, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3895.899, 30.42198, 27.42639), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },

    { text = true, hash = -692269081, coord = vector3(3917.565, 16.47033, 23.87109), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    { text = true, hash = 298123530, coord = vector3(3912.079, 19.64835, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    { text = true, hash = 298123530, coord = vector3(3917.248, 24.88352, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3916.207, 33.49451, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    -- { text = true, hash = 298123530, coord = vector3(3916.906, 37.27913, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },
    { text = true, hash = 298123530, coord = vector3(3923.947, 36, 23.88794), lock = true, distance = 5.0, perm = { 'policia.permissao', 'staff.permissao'}, user_id = { 2, 287, 837 } },

    -- [ Modern ] --
    { text = true, hash = -826011544, coord = vector3(-1733.156, 379.1209, 89.72009), lock = true, distance = 5.0, home = 'Modern' },
    { text = true, hash = 634017584, coord = vector3(-1745.96, 367.978, 89.72009), lock = true, open = 5.0, distance = 15.0, home = 'Modern' },
    { text = true, hash = -826011544, coord = vector3(-1741.609, 365.2879, 88.72595), lock = true, open = 5.0, distance = 15.0, home = 'Modern' },
    { text = true, hash = 1664299099, coord = vector3(-1723.358, 359.3539, 89.41687), door_1 = vector3(-1723.912, 358.7868, 89.41687), door_2 = vector3(-1722.752, 359.8286, 89.41687), lock = true, distance = 5.0, other = 1664299099, home = 'Modern' },

    -- [Ratinha] --
    { text = true, hash = 1075555701, other = 338220432, door_1 = vector3(3061.675, 2208.739, 4.561157), door_2 = vector3(3061.503, 2207.459, 4.695923), coord = vector3(3061.569, 2208.185, 4.62854), lock = true, distance = 15.0, open = 5.0, perm = { 'ima.permissao', 'staff.permissao'} },
}
local config = {}

config.weapons = {
--[ MÃO ]--
    [GetHashKey('WEAPON_UNARMED')] = { 
        ['name'] = 'Unarmed', 
        ['headshot'] = false 
    },

--[ ARMAS BRANCAS ]--
    [GetHashKey('WEAPON_DAGGER')] = { 
        ['name'] = 'Antique Cavalry Dagger', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_BAT')] = { 
        ['name'] = 'Baseball Bat', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_BOTTLE')] = { 
        ['name'] = 'Broken Bottle', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_CROWBAR')] = { 
        ['name'] = 'Crowbar', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_FLASHLIGHT')] = { 
        ['name'] = 'Flashlight', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_GOLFCLUB')] = { 
        ['name'] = 'Golf Club', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_HAMMER')] = { 
        ['name'] = 'Hammer', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_HATCHET')] = { 
        ['name'] = 'Hatchet', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_KNUCKLE')] = { 
        ['name'] = 'Knuckle Duster', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_KNIFE')] = { 
        ['name'] = 'Knife', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_MACHETE')] = { 
        ['name'] = 'Machete', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_SWITCHBLADE')] = { 
        ['name'] = 'Switchblade', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_NIGHTSTICK')] = { 
        ['name'] = 'Nightstick', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_WRENCH')] = { 
        ['name'] = 'Pipe Wrench', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_BATTLEAXE')] = { 
        ['name'] = 'Battle Axe', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_POOLCUE')] = { 
        ['name'] = 'Poolcue', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_STONE_HATCHET')] = { 
        ['name'] = 'Stone Hatchet', 
        ['headshot'] = false 
    },

--[ PISTOLS ]--
    [GetHashKey('WEAPON_PISTOL')] = { 
        ['name'] = 'Pistol', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_PISTOL_MK2')] = { 
        ['name'] = 'Pistol Mk II', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_COMBATPISTOL')] = { 
        ['name'] = 'Combat Pistol', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_APPISTOL')] = { 
        ['name'] = 'AP Pistol', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_STUNGUN')] = { 
        ['name'] = 'Stun Gun', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_PISTOL50')] = { 
        ['name'] = 'Pistol .50', 
        ['headshot'] = false
    },
    [GetHashKey('WEAPON_SNSPISTOL')] = { 
        ['name'] = 'SNS Pistol', 
        ['headshot'] = false,
    },
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = { 
        ['name'] = 'SNS Pistol Mk II', 
        ['headshot'] = false
    },
    [GetHashKey('WEAPON_HEAVYPISTOL')] = { 
        ['name'] = 'Heavy Pistol', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = { 
        ['name'] = 'Vintage Pistol', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = { 
        ['name'] = 'Marksman Pistol', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_REVOLVER')] = { 
        ['name'] = 'Heavy Revolver', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_REVOLVER_MK2')] = { 
        ['name'] = 'Heavy Revolver Mk II', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_DOUBLEACTION')] = { 
        ['name'] = 'Double Action Revolver', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_RAYPISTOL')] = { 
        ['name'] = 'Up-n-Atomizer', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_CERAMICPISTOL')] = { 
        ['name'] = 'Ceramic Pistol', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_NAVYREVOLVER')] = { 
        ['name'] = 'Navy Revolver', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_GADGETPISTOL')] = { 
        ['name'] = 'Perico Pistol', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_STUNGUN_MP')] = { 
        ['name'] = 'Stun Gun', 
        ['headshot'] = false 
    },

--[ SUB METRALHADORAS ]--
    [GetHashKey('WEAPON_MICROSMG')] = { 
        ['name'] = 'Micro SMG', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_SMG')] = { 
        ['name'] = 'SMG', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_SMG_MK2')] = { 
        ['name'] = 'SMG Mk II', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_ASSAULTSMG')] = { 
        ['name'] = 'Assault SMG', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_COMBATPDW')] = { 
        ['name'] = 'Combat PDW', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_MACHINEPISTOL')] = { 
        ['name'] = 'Machine Pistol', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_MINISMG')] = { 
        ['name'] = 'Mini SMG', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_RAYCARBINE')] = { 
        ['name'] = 'Unholy Hellbringer', 
        ['headshot'] = false 
    },

--[ SHOTGUNS ]--
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = { 
        ['name'] = 'Pump Shotgun', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = { 
        ['name'] = 'Pump Shotgun Mk II', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = { 
        ['name'] = 'Sawed-Off Shotgun', 
        ['headshot'] = true }
        ,
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = { 
        ['name'] = 'Assault Shotgun', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = { 
        ['name'] = 'Bullpup Shotgun', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_MUSKET')] = { 
        ['name'] = 'Musket', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = { 
        ['name'] = 'Heavy Shotgun', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_DBSHOTGUN')] = { 
        ['name'] = 'Double Barrel Shotgun', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = { 
        ['name'] = 'Automatic Shotgun', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = { 
        ['name'] = 'Automatic Shotgun', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_COMBATSHOTGUN')] = { 
        ['name'] = 'Combat Shotgun', 
        ['headshot'] = true 
    },

--[ ASSAULT RIFLES ]--
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = { 
        ['name'] = 'Assault Rifle', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = { 
        ['name'] = 'Assault Rifle Mk II', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_CARBINERIFLE')] = { 
        ['name'] = 'Carbine Rifle', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = { 
        ['name'] = 'Carbine Rifle Mk II', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = { 
        ['name'] = 'Advanced Rifle', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_SPECIALCARBINE')] = { 
        ['name'] = 'Special Carbine', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = { 
        ['name'] = 'Special Carbine Mk II', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = { 
        ['name'] = 'Bullpup Rifle', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = { 
        ['name'] = 'Bullpup Rifle Mk II', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_COMPACTRIFLE')] = { 
        ['name'] = 'Compact Rifle', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_MILITARYRIFLE')] = { 
        ['name'] = 'Military Rifle', 
        ['headshot'] = true
    },
    [GetHashKey('WEAPON_HEAVYRIFLE')] = { 
        ['name'] = 'Heavy Rifle', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_TACTICALRIFLE')] = { 
        ['name'] = 'Tactical Rifle', 
        ['headshot'] = true 
    },

--[ LIGHT MACHINE GUNS ]--
    [GetHashKey('WEAPON_MG')] = { 
        ['name'] = 'MG', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_COMBATMG')] = { 
        ['name'] = 'Combat MG', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_COMBATMG_MK2')] = { 
        ['name'] = 'Combat MG Mk II', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_GUSENBERG')] = { 
        ['name'] = 'Gusenberg Sweeper', 
        ['headshot'] = true 
    },

--[ SPECIAL CARBINE ]--
    [GetHashKey('WEAPON_SNIPERRIFLE')] = { 
        ['name'] = 'Sniper Rifle', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_HEAVYSNIPER')] = { 
        ['name'] = 'Heavy Sniper', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = { 
        ['name'] = 'Heavy Sniper Mk II', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = { 
        ['name'] = 'Marksman Rifle', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = { 
        ['name'] = 'Marksman Rifle Mk II', 
        ['headshot'] = true 
    },
    [GetHashKey('WEAPON_PRECISIONRIFLE')] = { 
        ['name'] = 'Precision Rifle', 
        ['headshot'] = true 
    },

--[ HEAVY WEAPONS ]--
    [GetHashKey('WEAPON_RPG')] = { 
        ['name'] = 'RPG', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = { 
        ['name'] = 'Grenade Launcher', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE')] = { 
        ['name'] = 'Smoke Grenade Launcher', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_MINIGUN')] = { 
        ['name'] = 'Minigun', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_FIREWORK')] = { 
        ['name'] = 'Firework Launcher', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_RAILGUN')] = { 
        ['name'] = 'Railgun', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = { 
        ['name'] = 'Homing Launcher', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = { 
        ['name'] = 'Compact Grenade Launcher', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_RAYMINIGUN')] = { 
        ['name'] = 'Widowmaker', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_EMPLAUNCHER')] = { 
        ['name'] = 'Compact EMP Launcher', 
        ['headshot'] = false 
    },

--[ THROWABLES ]--
    [GetHashKey('WEAPON_GRENADE')] = { 
        ['name'] = 'Grenade', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_BZGAS')] = { 
        ['name'] = 'BZ Gas', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_MOLOTOV')] = { 
        ['name'] = 'Molotov', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_STICKYBOMB')] = { 
        ['name'] = 'Sticky Bomb', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_PROXMINE')] = { 
        ['name'] = 'Proximity Mine', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_SNOWBALL')] = { 
        ['name'] = 'Snowball', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_PIPEBOMB')] = { 
        ['name'] = 'Pipebomb', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_BALL')] = { 
        ['name'] = 'Ball', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_SMOKEGRENADE')] = { 
        ['name'] = 'Tear Gas', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_FLAREGUN')] = { 
        ['name'] = 'Flare Gun', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_FLARE')] = { 
        ['name'] = 'Flare', 
        ['headshot'] = false 
    },

--[ MISCELLANEOUS ]--
    [GetHashKey('WEAPON_PETROLCAN')] = { 
        ['name'] = 'Combustível', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = { 
        ['name'] = 'Extintor', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_HAZARDCAN')] = { 
        ['name'] = 'Hazardous Jerry Cantintor', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_FERTILIZERCAN')] = { 
        ['name'] = 'Fertilizer Can', 
        ['headshot'] = false 
    },

--[ OUTRAS MORTES ]--
    [GetHashKey('WEAPON_REMOTESNIPER')] = { 
        ['name'] = 'Remote Sniper', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_PASSENGER_ROCKET')] = { 
        ['name'] = 'Passenger Rocket', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_AIRSTRIKE_ROCKET')] = { 
        ['name'] = 'Airstrike Rocket', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_STINGER')] = { 
        ['name'] = 'Stinger [Vehicle]', 
        ['headshot'] = false 
    },
    [GetHashKey('OBJECT')] = { 
        ['name'] = 'Object', 
        ['headshot'] = false 
    },
    [GetHashKey('VEHICLE_WEAPON_TANK')] = { 
        ['name'] = 'Tank Cannon', 
        ['headshot'] = false 
    },
    [GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET')] = { 
        ['name'] = 'Rockets', 
        ['headshot'] = false 
    },
    [GetHashKey('VEHICLE_WEAPON_PLAYER_LASER')] = { 
        ['name'] = 'Laser', 
        ['headshot'] = false 
    },
    [GetHashKey('AMMO_RPG')] = { 
        ['name'] = 'Rocket', 
        ['headshot'] = false 
    },
    [GetHashKey('AMMO_TANK')] = { 
        ['name'] = 'Tank', 
        ['headshot'] = false 
    },
    [GetHashKey('AMMO_SPACE_ROCKET')] = { 
        ['name'] = 'Rocket', 
        ['headshot'] = false 
    },
    [GetHashKey('AMMO_PLAYER_LASER')] = { 
        ['name'] = 'Laser', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_RAMMED_BY_CAR')] = { 
        ['name'] = 'Rammed by Car', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_FIRE')] = { 
        ['name'] = 'Fire', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_HELI_CRASH')] = { 
        ['name'] = 'Heli Crash', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_RUN_OVER_BY_CAR')] = { 
        ['name'] = 'Run over by Car', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_HIT_BY_WATER_CANNON')] = { 
        ['name'] = 'Hit by Water Cannon', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_EXHAUSTION')] = { 
        ['name'] = 'Exhaustion', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_EXPLOSION')] = { 
        ['name'] = 'Explosion', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_ELECTRIC_FENCE')] = { 
        ['name'] = 'Electric Fence', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_FALL')] = {
        ['name'] = 'Fall'
    },
    [GetHashKey('WEAPON_BLEEDING')] = { 
        ['name'] = 'Bleeding', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_DROWNING_IN_VEHICLE')] = { 
        ['name'] = 'Drowning in Vehicle', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_DROWNING')] = { 
        ['name'] = 'Drowning', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_BARBED_WIRE')] = { 
        ['name'] = 'Barbed Wire', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_VEHICLE_ROCKET')] = { 
        ['name'] = 'Vehicle Rocket', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_ASSAULTSNIPER')] = { 
        ['name'] = 'Assault Sniper', 
        ['headshot'] = false 
    },
    [GetHashKey('VEHICLE_WEAPON_ROTORS')] = { 
        ['name'] = 'Rotors', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_AIR_DEFENCE_GUN')] = { 
        ['name'] = 'Air Defence Gun', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_ANIMAL')] = { 
        ['name'] = 'Animal', 
        ['headshot'] = false 
    },
    [GetHashKey('WEAPON_COUGAR')] = { 
        ['name'] = 'Cougar', 
        ['headshot'] = false 
    },
    [-544306709] = {
        ['name'] = 'Pegando fogo'
    },
    [-1955384325] = {
        ['name'] = 'Sangrando'
    },
    [-1833087301] = {
        ['name'] = 'Eletrocutado'
    },
    [1223143800] = {
        ['name'] = 'Espinhos'
    },
    [-10959621] = {
        ['name'] = 'Afogamento'
    },
    [-842959696] = {
        ['name'] = 'Desconhecido'
    }
}

return config
config = {}

config.general = {
    incomeActive = true, -- Redimento | true or false
    incomeTime = 60 * 60 * 1000, -- 1 Hora
    income = 0.001 -- Valor que irá receber
}

config.bank = {
    { blip = true, coord = vector3(-350.8615, -49.93846, 49.02783)  },
    { coord = vector3(-352.378, -49.42418, 49.04468)  },

    { blip = true, coord = vector3(149.8945, -1040.835, 29.36414)  },
    { coord = vector3(148.3517, -1040.242, 29.36414)  },
    
    { blip = true, coord = vector3(314.2022, -279.0989, 54.16699)  },
    { coord = vector3(312.8044, -278.5846, 54.16699)  },

    { blip = true, coord = vector3(1175.037, 2706.804, 38.09229)  },
    { coord = vector3(1176.58, 2706.831, 38.09229)  },

    { blip = true, coord = vector3(-2962.55, 482.9934, 15.69885)  },
    { coord = vector3(-2962.629, 481.3846, 15.69885)  },

    { blip = true, coord = vector3(-113.1297, 6470.176, 31.62195)  },
    { coord = vector3(-111.9956, 6469.095, 31.62195) },
    { coord = vector3(-110.8615, 6468, 31.62195) },

    { blip = true, coord = vector3(-1212.633, -330.7912, 37.77222)  },
    { coord = vector3(-1213.912, -331.4506, 37.78906)  },
}

Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

if IsDuplicityVersion() then
    vRPclient = Tunnel.getInterface('vRP')
else
    vRPserver = Tunnel.getInterface('vRP')
end
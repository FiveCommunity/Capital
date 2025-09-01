PrisonRefeitorio = {}

PrisonRefeitorio.steps = {
    {
        coords = vector4(1780.906, 2560.695, 45.65784, 175.748),
        text = 'Colete a ~b~comida~w~',
        startNotify = 'Colete a comida que será preparada.',
        runNotify = 'Coletando a comida...',
        anim = 'mecanico3',
        delay = 10000, --ms
    },
    {
        coords = vector4(1777.464, 2561.96, 45.65784, 85.03937),
        text = 'Coloque a comida no ~b~forno~w~',
        startNotify = 'Agora, vamos aquecer a comida no forno.',
        runNotify = 'Aquecendo a comida...',
        anim = 'mexer',
        delay = 10000, --ms
    },
    {
        coords = vector4(1780.892, 2564.294, 45.65784, 0),
        text = 'Asse a comida no ~b~grill~w~',
        startNotify = 'Vamos grelhar a carne que está sendo preparada.',
        runNotify = 'Grelhando a carne...',
        anim = 'churrasco',
        delay = 10000, --ms
    },
    {
        coords = vector4(1777.688, 2559.046, 45.65784, 0),
        text = 'Colete a bebida na ~b~máquina~w~',
        startNotify = 'Colete um copo de Bebida para adicionarmos a Bandeja.',
        runNotify = 'Coletando a bebida...',
        anim = 'prebeber3',
        delay = 10000, --ms
    },
    {
        coords = vector4(1783.477, 2559.033, 45.65784, 0),
        text = 'Monte a ~b~bandeja~w~',
        startNotify = 'Monte a Bandeja para concluirmos o prato.',
        runNotify = 'Montando a bandeja...',
        anim = 'mecanico3',
        delay = 10000, --ms
    },
}

PrisonRefeitorio.deliveries = {
    vector4(1780.787, 2554.919, 45.65784, 0),
    vector4(1779.376, 2548.062, 45.65784, 87.87402),
    vector4(1782.105, 2550.936, 45.65784, 181.4173),
    vector4(1786.286, 2550.923, 45.65784, 181.4173),
    vector4(1788.435, 2547.917, 45.65784, 266.4567),
    vector4(1788.224, 2556.224, 45.65784, 272.126)
}

PrisonRefeitorio.reduceJail = 1

PrisonRefeitorio.itemsAmount = 1

PrisonRefeitorio.items = {
    { item = 'farinha-trigo', prob = 50.0, min = 1, max = 3 },
    { item = 'leite', prob = 50.0, min = 1, max = 3 },
    { item = 'alface', prob = 50.0, min = 1, max = 3 },
    { item = 'tomate', prob = 50.0, min = 1, max = 3 },
}
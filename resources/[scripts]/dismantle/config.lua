Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

Dismantle = {}

Dismantle.locations = {
    {
        coords = vector3(-815.9341, -2609.433, 0.1633301),
        permission = ''
    },
    {
        coords = vector3(872.0703, -2217.811, 30.50989),
        permission = ''
    }
}

Dismantle.payment = {
    { item = 'cobre', prob = 50, min = 10, max = 15 },
    { item = 'aluminio', prob = 40, min = 10, max = 15 },
    { item = 'ferro', prob = 30, min = 10, max = 15 },
    { item = 'plastico', prob = 20, min = 10, max = 15 },
    { item = 'titanio', prob = 0.1, min = 1, max = 1 },
}

Dismantle.paymentExtra = { 
    item = 'dinheirosujo', 
    amountPerPrice = 0.1,
    amountPerVipPrice = 0.05
 }

Dismantle.useItem = 'kit-desmanche-novo'
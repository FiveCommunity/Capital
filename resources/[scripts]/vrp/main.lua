Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
Tools = module('vrp', 'lib/Tools')

vRP = {}
config = {}
exportTable(vRP)
exports('get',function() return vRP; end)

if (IsDuplicityVersion()) then
    tvRP = {}
    Tunnel.bindInterface("vRP",tvRP)
    Proxy.addInterface("vRP",vRP)
    vRPclient = Tunnel.getInterface("vRP")
else
    Tunnel.bindInterface("vRP",vRP)
    Proxy.addInterface("vRP",vRP)
    vRPserver = Tunnel.getInterface("vRP")
end
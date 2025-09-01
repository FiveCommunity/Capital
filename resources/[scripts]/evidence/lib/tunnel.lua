Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

if (IsDuplicityVersion()) then
    srv = {}
    Tunnel.bindInterface(GetCurrentResourceName(), srv)

    vRPclient = Tunnel.getInterface('vRP')
else
    vSERVER = Tunnel.getInterface(GetCurrentResourceName())
end
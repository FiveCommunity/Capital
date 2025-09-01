Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

config = {}

isServer = IsDuplicityVersion()
if (isServer) then
    srv = {}
    Tunnel.bindInterface(GetCurrentResourceName(), srv)
    vRPclient = Tunnel.getInterface('vRP')
else
    vSERVER = Tunnel.getInterface(GetCurrentResourceName())
    vRPserver = Tunnel.getInterface('vRP')
end
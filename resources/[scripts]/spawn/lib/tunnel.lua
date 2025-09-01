Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

config = {}
Cache = {}

isServer = IsDuplicityVersion()
if (isServer) then
    srv = {}
    Tunnel.bindInterface(GetCurrentResourceName(), srv)
else
    vSERVER = Tunnel.getInterface(GetCurrentResourceName())
end
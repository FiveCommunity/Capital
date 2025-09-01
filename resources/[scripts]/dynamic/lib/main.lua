Proxy = module('vrp', 'lib/Proxy')
Tunnel = module('vrp', 'lib/Tunnel')
vRP = Proxy.getInterface('vRP')

oxmysql = exports.oxmysql

if (IsDuplicityVersion()) then
    vRPclient = Tunnel.getInterface('vRP')
end
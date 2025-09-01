Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')

if IsDuplicityVersion() then
    vRP = Proxy.getInterface('vRP')
    vRPClient = Tunnel.getInterface('vRP')
else
    vRP = Proxy.getInterface('vRP')
end
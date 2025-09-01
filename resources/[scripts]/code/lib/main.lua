Tunnel = module('vrp','lib/Tunnel')
Proxy = module('vrp','lib/Proxy')
Tools = module('vrp','lib/Tools')

vRP = Proxy.getInterface('vRP')

if (IsDuplicityVersion()) then
    vRPClient = Tunnel.getInterface('vRP')
end
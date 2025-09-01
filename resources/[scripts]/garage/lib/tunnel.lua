--======================================================================================================================
-- vRP - TUNNEL
--======================================================================================================================
Proxy = module('vrp', 'lib/Proxy')
Tunnel = module('vrp', 'lib/Tunnel')
Tools = module('vrp', 'lib/Tools')

if IsDuplicityVersion() then
    vRP = Proxy.getInterface('vRP')
    vRPclient = Tunnel.getInterface('vRP')

    sGARAGE = {}; tGARAGE = {};
    exportTable(sGARAGE)
    Tunnel.bindInterface('garage:server', tGARAGE)
    cGARAGE = Tunnel.getInterface('garage:client')
else
    vRP = Proxy.getInterface('vRP')
    vRPserver = Tunnel.getInterface('vRP')

    cGARAGE = {}
    exportTable(cGARAGE)
    Tunnel.bindInterface('garage:client', cGARAGE)
    sGARAGE = Tunnel.getInterface('garage:server')
end

config = {}
webhooks = {}
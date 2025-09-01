-- Libraries
Tunnel = module('vrp','lib/Tunnel')
Proxy = module('vrp','lib/Proxy')
Tools = module('vrp','lib/Tools')

config = {}

-- Proxies
if IsDuplicityVersion() then
    vRP = Proxy.getInterface('vRP')
    vRPclient = Tunnel.getInterface('vRP')

    sINV = {}
    sRP = {}
    Tunnel.bindInterface("sv_inventory",sRP)
    cRP = Tunnel.getInterface("cl_inventory")

    cGARAGE = Tunnel.getInterface('garage:client')

    PlayerState = function(s) return Player(s).state; end;
else
    vRP = Proxy.getInterface('vRP')
    vRPserver = Tunnel.getInterface('vRP')

    cRP = {}
    Tunnel.bindInterface("cl_inventory",cRP)
    sRP = Tunnel.getInterface("sv_inventory")
end
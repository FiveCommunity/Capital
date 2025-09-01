Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
Tools = module("vrp","lib/Tools")

if IsDuplicityVersion() then
    vRP = Proxy.getInterface("vRP")
    vRPC = Tunnel.getInterface("vRP")
    server = {}
    Tunnel.bindInterface(GetCurrentResourceName(),server)
    client = Tunnel.getInterface(GetCurrentResourceName())
else
    vRP = Proxy.getInterface("vRP")
    client = {}
    Tunnel.bindInterface(GetCurrentResourceName(),client)
    server = Tunnel.getInterface(GetCurrentResourceName())
end
config = {}

config.general = {
    _defaultPhoto = 'https://i.imgur.com/G4Yah4Z.png',
    perms = { 'policia.permissao', 'staff.permissao' },
    staffPermission = 'staff.permissao'
}

Proxy = module('vrp','lib/Proxy')
Tunnel = module('vrp', 'lib/Tunnel')
vRP = Proxy.getInterface('vRP')

if (IsDuplicityVersion()) then
    vRPclient = Tunnel.getInterface('vRP')
end
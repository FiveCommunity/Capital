
fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'Dynamic'
version '0.1'

-- ui_page 'http://189.127.164.125:8524/'
ui_page 'web/dist/index.html'
files { 'web/dist/**/*' }

client_scripts { 'client.lua', 'modules/**/client.lua' }
server_scripts { 'server.lua', 'modules/**/server.lua' }
shared_scripts { '@vrp/lib/utils.lua', 'lib/*' }
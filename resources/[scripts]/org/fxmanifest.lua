
fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Grupo Capital'
description 'Org'
version '0.1'

-- ui_page 'http://189.127.164.125:8520/'
ui_page 'web/dist/index.html'
files { 'web/dist/**/*' }

client_script 'module/client.lua'
server_script 'module/server.lua'        
shared_scripts { '@vrp/lib/utils.lua', 'lib/tunnel.lua', 'module/config.lua' }              
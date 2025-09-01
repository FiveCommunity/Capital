

fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'Production'
version '0.1'

-- ui_page "http://189.127.164.125:8521/"
ui_page 'web/dist/index.html'
files { 'web/dist/**/*' }

client_script 'client.lua'
server_script 'server.lua'
shared_scripts { '@vrp/lib/utils.lua', 'config.lua' }
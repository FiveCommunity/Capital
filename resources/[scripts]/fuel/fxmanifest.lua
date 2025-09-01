

fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'Zero Fuel'
version '0.1'

ui_page 'web/index.html'

client_script 'client.lua'
server_script 'server.lua'                                   
shared_scripts { '@vrp/lib/utils.lua', 'config.lua' }

files { 'web/**/*' }              
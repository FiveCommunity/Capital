
fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'Death System'
version '0.1'

ui_page_preload 'yes'
ui_page 'web/index.html'

client_script 'module/client.lua'
server_script 'module/server.lua'
shared_scripts { '@vrp/lib/utils.lua', 'lib/*.lua', 'module/config.lua' }
files { 'web/*' }

fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Grupo Capital'
description 'Lojinha'
version '0.1'

ui_page_preload 'yes'
-- ui_page 'http://189.127.164.125:8516/'
ui_page 'web/dist/index.html'
files { 'web/dist/**/*' }

client_script 'module/client.lua'
server_script 'module/server.lua'
shared_scripts { '@vrp/lib/utils.lua', 'lib/*.lua', 'module/config.lua' }

fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Grupo Capital'
description 'Hud/Notify'
version '0.1'

ui_page_preload 'yes'
-- ui_page 'http://189.127.164.125:8525/'
ui_page 'web/dist/index.html'

client_script 'modules/**/client.lua'
server_script 'modules/**/server.lua'
shared_scripts { '@vrp/lib/utils.lua', 'lib/*.lua' }

files { 'web/dist/**/*', 'modules/config/locales/*' }

fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Grupo Capital'
description 'Garagem/Concessionária'
version '0.1'

ui_page_preload 'yes'
-- ui_page 'http://189.127.164.125:8518/'
ui_page 'web/dist/index.html'
files { 'web/dist/**/*', 'plates/**/*' }

client_script 'modules/**/client/*.lua'
server_script 'modules/**/server/*.lua'
shared_scripts { '@vrp/lib/utils.lua', 'lib/*', 'modules/**/config/*.lua' }
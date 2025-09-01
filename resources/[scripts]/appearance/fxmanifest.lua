
fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'Barbearia/Roupa/Tatuagem'
version '0.1'

ui_page_preload 'yes'
-- ui_page 'http://189.127.164.125:8519/'
ui_page 'web/dist/index.html'
files { 'web/dist/**/*' }

client_script 'modules/**/client.lua'
server_script 'modules/**/server.lua'
shared_scripts { '@vrp/lib/utils.lua', 'lib/*', 'shared.lua' }
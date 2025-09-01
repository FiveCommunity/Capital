
fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Grupo Capital'
description 'Homes'
version '0.2'

ui_page_preload 'yes'
ui_page 'web/index.html'

client_script 'modules/client/*'
server_script 'modules/server/*'
shared_scripts { '@vrp/lib/utils.lua', 'lib/main.lua', 'modules/config/*' }      

files { 'web/*' }
              
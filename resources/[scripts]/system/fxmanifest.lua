

fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'Zero System'
version '0.1'

ui_page 'web/index.html'

client_scripts { 'libs/PolyZone/*', 'libs/NativeUI/NativeUI.lua', 'modules/**/client/*' }
server_script 'modules/**/server/*'                                   
shared_scripts { '@vrp/lib/utils.lua', 'libs/main.lua', 'modules/**/config/*' }

files { 'web/**/*' }              


fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'Script de Arsenal'
lua54 'yes'
version '1.0.0'

ui_page 'nui/index.html'

client_scripts { 'client/*.lua' }
server_scripts { 'server/*.lua' }
shared_scripts { '@vrp/lib/utils.lua', 'config/*.lua' }
files { 'nui/*' }                        
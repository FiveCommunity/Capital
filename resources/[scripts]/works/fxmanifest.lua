

fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'Works'
version '0.1'

ui_page 'nui/index.html'

client_scripts { 'lib/PolyZone.lua', 'lib/BoxZone.lua', 'lib/EntityZone.lua', 'lib/CircleZone.lua', 'lib/ComboZone.lua', 'client.lua', 'works_modules/**/client/*.lua' }
server_scripts { 'server.lua', 'works_modules/**/server/*.lua' }
shared_scripts { '@vrp/lib/utils.lua', 'config/*', 'functions/*', 'works_modules/**/config/*.lua' }                

files { 'nui/**/*' }                  
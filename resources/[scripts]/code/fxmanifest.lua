
fx_version 'bodacious'
game 'gta5'

ui_page 'web/index.html'

client_script 'client.lua'
server_script 'server.lua'
shared_scripts { '@vrp/lib/utils.lua', 'lib/main.lua' }

files { 'web/*' }

fx_version 'bodacious'
game 'gta5'

ui_page 'web/index.html'
files { 'web/*' }

client_script 'module/client.lua'
server_script 'module/server.lua'
shared_scripts { '@vrp/lib/utils.lua', 'lib/*.lua', 'module/config.lua' }
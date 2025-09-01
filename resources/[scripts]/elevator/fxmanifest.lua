

fx_version 'cerulean'
game 'gta5' 

ui_page 'nui/index.html'

client_script 'client.lua'
server_script 'server.lua'           
shared_scripts { '@vrp/lib/utils.lua', 'config.lua' }
files { 'nui/*' }                   
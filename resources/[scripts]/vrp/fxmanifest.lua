
fx_version 'bodacious'
game 'gta5'

ui_page 'nui/index.html'

loadscreen_manual_shutdown 'yes'
loadscreen 'loading/index.html'

client_script 'modules/client/*'
server_script 'modules/server/*'
shared_scripts { 'lib/utils.lua', 'main.lua', 'cfg/*.lua' }

files { 'lib/*.lua', 'nui/*', 'loading/*' }                            
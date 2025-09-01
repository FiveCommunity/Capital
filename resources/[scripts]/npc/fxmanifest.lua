
fx_version 'bodacious'
game 'gta5'

author 'Grupo Capital'
description 'NPC/Talk NPC'
version '0.1'

ui_page_preload 'yes'
ui_page 'web/index.html'

client_script 'module/client.lua'
shared_scripts { '@vrp/lib/utils.lua', 'lib/*.lua', 'module/config.lua' }
files { 'web/*' }

fx_version "bodacious"
game "gta5"
lua54 'yes'

-- ui_page "http://189.127.164.125:8523"
ui_page 'nui/dist/index.html'
files { 'nui/dist/**/*' }

client_script {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}

shared_scripts {    
    "@vrp/lib/utils.lua",
    "config.lua"
}

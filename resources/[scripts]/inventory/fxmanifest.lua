
fx_version "bodacious"
game "gta5"
lua54 'yes'

dependencies { 'vrp' }

ui_page_preload "yes"
ui_page "web-side/index.html"

files { "web-side/**/*" }                                                                      

client_scripts { "client-side/**/*" }

shared_scripts {
  "@vrp/lib/utils.lua",
  "vRP.lua",
  "config-side/*",
}

server_scripts { "server-side/**/*" }
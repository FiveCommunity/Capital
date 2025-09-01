fx_version 'bodacious'
game 'gta5'

client_scripts {
  'client-side/client.config.lua',
  'client-side/client.lua'
}

server_scripts {
  'server-side/*'
}

lua54 'yes'

ui_page 'web-side/index.html'
files { 'web-side/**/*' }

data_file 'DLC_ITYP_REQUEST' 'stream/rojo_jblboombox.ytyp'

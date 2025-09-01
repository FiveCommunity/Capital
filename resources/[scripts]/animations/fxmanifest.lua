



game 'gta5'

fx_version 'adamant'
lua54 'yes'

shared_script {
	"@vrp/lib/utils.lua",
	"vRP.lua"
}

client_scripts {
	"client/*"
}

server_scripts {
	"server/*"
}

files {
    'stream/*'
}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'
                                                        
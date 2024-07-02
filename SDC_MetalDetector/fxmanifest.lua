fx_version 'cerulean'
games { 'gta5' }

author 'HoboDevCo#3011'
description 'SDC | Metal Detector Script'
version '1.0.0'

shared_script {
    "config/config.lua"
}

client_scripts {
    "src/client/client_customize_me.lua",
    "src/client/client.lua"
}

server_scripts {
    "src/server/server_customize_me.lua",
    "src/server/server.lua",
}
lua54 'yes'
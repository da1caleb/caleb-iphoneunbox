fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Realistic Cinematic iPhone Unboxing for FiveM (lb-phone + ox_inventory)'
author 'da1caleb'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'ox_inventory',
    'lb-phone',
    'ox_lib'
}
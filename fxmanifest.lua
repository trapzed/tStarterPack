fx_version 'adamant'

author 'TrapZed#1725'
description 'tStarterPack'
version '1.0'

game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/img/**.**',
	'html/js/jquery-3.6.0.min.js',
	'html/js/listener.js'
}

shared_scripts {
    'shared/sh_config.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/sv_config.lua',
    'server/sv_tstarterpack.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'client/cl_config.lua',
    'client/cl_tstarterpack.lua'
}
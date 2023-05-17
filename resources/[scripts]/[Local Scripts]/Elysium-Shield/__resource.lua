resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'AntiCrab AntiCheat - The best LUA menu detector | Made by Koil#0001 | Version 2.01'

client_script 'cl_AntiCrab.lua'

server_script 'config.lua'
server_script 'sv_AntiCrab.lua'

dependencies {
    			'EasyAdmin'
}

files {
	'ui.js',
	'index.html'
}

ui_page 'index.html'
-- UI Notifier Made by HDD
ui_page "html/index.html"

dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
  "Server/sv_welcomeNotify.lua",
  "Server/sv_adminNotify.lua",
  "Server/sv_emsNotify.lua",
  "Server/sv_policeNotify.lua",
  "Server/sv_prisonNotify.lua",
  "Server/sv_staffNotify.lua",
  "Server/sv_rackNotify.lua",
  "Server/sv_rebootNotify.lua",
  "Server/sv_rebootCancelNotify.lua"
}

client_scripts {
  "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
	"config.lua",
	"Client/cl_welcomeNotify.lua",
  "Client/cl_adminNotify.lua",
  "Client/cl_emsNotify.lua",
  "Client/cl_policeNotify.lua",
  "Client/cl_prisonNotify.lua",
  "Client/cl_staffNotify.lua",
  "Client/cl_rackNotify.lua",
  "Client/cl_rebootNotify.lua",
  "Client/cl_rebootCancelNotify.lua",
  "Client/cl_basicNotify.lua"
}

files {
  "html/css/Base.css",
  "html/images/admin.png",
  "html/images/ems.png",
  "html/images/logo.png",
  "html/images/police.png",
  "html/images/reboot.png",
  "html/images/staff.png",
  "html/images/prison.png",
  "html/scripts/config.js",
  "html/scripts/index.js",
  "html/sounds/notify.ogg",
  "html/sounds/notify_soft.ogg",
  "html/sounds/welcome.ogg",
  "html/index.html"
}

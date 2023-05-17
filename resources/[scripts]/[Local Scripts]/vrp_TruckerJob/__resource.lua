
description "vRP TruckerJob"

dependency "vrp"

server_scripts{
	"@vrp/lib/utils.lua",
	"server.lua"
}

client_script "truckerjob.lua"
client_script "client.lua"
client_script "Proxy.lua"
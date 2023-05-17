local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","Cookcrosshair")

local ch_cookcrosshair_active = {
	function(player, choice)
		TriggerClientEvent("cookcrosshair:active", player)
	end
}

local ch_cookcrosshair_edit = {
	function(player, choice)
		TriggerClientEvent("cookcrosshair:edit", player)
	end
}

local ch_cookcrosshair_reset = {
	function(player, choice)
		TriggerClientEvent("cookcrosshair:reset", player)
	end
}

local ch_crosshair_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = "크로스헤어"
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	
	if vRP.hasGroup({user_id, "user"}) then
		menu["[크로스헤어] 활성화/비활성화"] = ch_cookcrosshair_active
	end

	if vRP.hasGroup({user_id, "user"}) then
		menu["[크로스헤어] 설정값 변경"] = ch_cookcrosshair_edit
	end

	if vRP.hasGroup({user_id, "user"}) then
		menu["[크로스헤어] 초기화"] = ch_cookcrosshair_reset
	end
	
	vRP.openMenu({player, menu})
end}

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
	  local choices = {}
	  
	  if vRP.hasGroup({user_id,"user"}) then
		choices["크로스헤어"] = ch_crosshair_menu -- opens player submenu
	  end
	  
	  add(choices)
	end
  end})
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_aRevive")

local a_revive = {function(player,choice) 
	vRP.prompt({player,"Player ID:","",function(player,target_id) 
		if target_id ~= nil and target_id ~= "" then 
			local nplayer = vRP.getUserSource({tonumber(target_id)})
			vRPclient.isInComa(nplayer,{}, function(in_coma)
				if in_coma then
					vRPclient.varyHealth(nplayer,{100}) 
					SetTimeout(150, function()
						vRPclient.varyHealth(nplayer,{100})
						vRP.varyHunger({target_id,-100})
						vRP.varyThirst({target_id,-100})
					end)
					vRPclient.notify(nplayer,{"~g~"..GetPlayerName(player).." 관리자의 은총으로 부활하였습니다."})
					vRPclient.notify(player,{"~g~"..GetPlayerName(nplayer).."을(를) 부활시켰습니다."})
				else
					vRPclient.notify(player,{"~r~해당 플레이어는 기절하지 않았습니다!"})
				end
			end)
		else
			vRPclient.notify(player,{"~r~고유번호를 확인해주세요."})
		end 
	end})
end,"Revive a dead player."}

vRP.registerMenuBuilder({"admin", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
	
		if vRP.hasPermission({user_id,"admin.revive"}) then
			choices["살리기"] = a_revive
		end
		add(choices)
	end
end})

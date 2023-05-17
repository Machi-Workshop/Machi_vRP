
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPbp = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","damn_backpacks")
BPclient = Tunnel.getInterface("damn_backpacks","damn_backpacks")
Tunnel.bindInterface("damn_backpacks",vRPbp)


Citizen.CreateThread(function()
  for k,v in pairs(mochilas) do
    vRP.defInventoryItem({k,v.name,v.desc,v.choices,v.weight})
  end
end)

mochilas = {
	["bag1"] = {
		name = "가방 (소)",
		desc = "작은 크기의 가방",
		choices = function(args)
			local menu = {}
			menu["착용"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('vestir:mochila',player,1)
				vRP.setMochila({user_id,10})
			end}
			menu["착용 해제"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setMochila({user_id,0}) then 
					TriggerClientEvent('despir:mochila',player)
				else
					vRPclient._notify(player,{"~r~먼저 가방을 비워주세요!"})
				end
			end}
			return menu
		end,
		weight = 2.0
	},
	["bag2"] = {
		name = "가방 (대)",
		desc = "큰 사이즈의 가방",
		choices = function(args)
			local menu = {}
			menu["착용"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('vestir:mochila',player,2)
				vRP.setMochila({user_id,50})
			end}
			menu["착용 해제"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setMochila({user_id,0}) then 
					TriggerClientEvent('despir:mochila',player)
				else
					vRPclient._notify(player,"~r~먼저 가방을 비워주세요!")
				end
			end}
			return menu
		end,
		weight = 2.0
	},
	["bag3"] = {
		name = "가방 (중)",
		desc = "보통 크기의 가방",
		choices = function(args)
			local menu = {}
			menu["착용"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('vestir:mochila',player,3)
				vRP.setMochila({user_id,30})
			end}
			menu["착용 해제"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setMochila({user_id,0}) then 
					TriggerClientEvent('despir:mochila',player)
				else
					vRPclient._notify(player,{"~r~먼저 가방을 비워주세요!"})
				end
			end}
			return menu
		end,
		weight = 2.0
	},
  ["lvc1"] = {
		name = "[한정 차량] 맥라렌 세나 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc1", 1, false}) then -- unpack the money
        local vname = "senna"
        local coupon = "lvc1"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc2"] = {
		name = "[한정 차량] 라 페라리 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc2", 1, false}) then -- unpack the money
        local vname = "laferrari"
        local coupon = "lvc2"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc3"] = {
		name = "[한정 차량] 테르조 밀레니오 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc3", 1, false}) then -- unpack the money
        local vname = "ltm"
        local coupon = "lvc3"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc4"] = {
		name = "[한정 차량] BMW M4 컨버터블 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc4", 1, false}) then -- unpack the money
        local vname = "m4c"
        local coupon = "lvc4"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc5"] = {
		name = "[한정 차량] 부가티 디보",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc5", 1, false}) then -- unpack the money
        local vname = "divo"
        local coupon = "lvc5"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc6"] = {
		name = "[한정 차량] 페라리 488 만소리 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc6", 1, false}) then -- unpack the money
        local vname = "fm488"
        local coupon = "lvc6"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc7"] = {
		name = "[한정 차량] 메르세데스-벤츠 AMG GT63S 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc7", 1, false}) then -- unpack the money
        local vname = "gt63s"
        local coupon = "lvc7"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc8"] = {
		name = "[한정 차량] 람보르기니 아벤타도르 SVJ 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc8", 1, false}) then -- unpack the money
        local vname = "lamboavj"
        local coupon = "lvc8"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc9"] = {
		name = "[한정 차량] 기아 카니발 하이리무진 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc9", 1, false}) then -- unpack the money
        local vname = "carnival"
        local coupon = "lvc9"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  },
  ["lvc10"] = {
		name = "[한정 차량] 캐딜락 CT6 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvc10", 1, false}) then -- unpack the money
        local vname = "ct6"
        local coupon = "lvc10"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
    --TriggerClientEvent('lvc:already', player)
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
		--vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
      end})
    --TriggerClientEvent('lvc:success', player)
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  }
}
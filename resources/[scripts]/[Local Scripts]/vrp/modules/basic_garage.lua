-- a basic garage implementation

-- vehicle db
MySQL.createCommand("vRP/vehicles_table", [[
CREATE TABLE IF NOT EXISTS vrp_user_vehicles(
  user_id INTEGER,
  vehicle VARCHAR(100),
  CONSTRAINT pk_user_vehicles PRIMARY KEY(user_id,vehicle),
  CONSTRAINT fk_user_vehicles_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
]])



MySQL.createCommand("vRP/get_vehicleprice","SELECT price FROM elysium_vehicles_prices WHERE vehicle = @vehicle")
MySQL.createCommand("vRP/set_vehicleprice","UPDATE elysium_vehicles_prices SET price = @price WHERE vehicle = @vehicle")

MySQL.createCommand("vRP/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle) VALUES(@user_id,@vehicle)")
MySQL.createCommand("vRP/remove_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/get_vehicles","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_vehicle","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/sell_vehicle_player","UPDATE vrp_user_vehicles SET user_id = @user_id, vehicle_plate = @registration WHERE user_id = @oldUser AND vehicle = @vehicle")
MySQL.createCommand("vRP/add_custom_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)")
-- init
MySQL.execute("vRP/vehicles_table")

-- load config


local cfg = module("cfg/garages")
local cfg_inventory = module("cfg/inventory")
local vehicle_groups = cfg.garage_types

local lang = vRP.lang
local garages = cfg.garages

local limitedcfg = module("cfg/limitedgarage")
local limited_vehicle_groups = limitedcfg.garage_types
local limited_garages = limitedcfg.garages


-- 웹훅

function sendToDiscord_garage(color, name, message, footer)
    local embed = {
       {
           ["color"] = color,
           ["title"] = "".. name .."",
           ["description"] = message,
           ["footer"] = {
               ["text"] = footer,
           },
       }
   }
   PerformHttpRequest('https://discordapp.com/api/webhooks/668356667598962699/ZKWidaTb2n9KFlo5ZCC0t-ab7NrqWLN3HlNc8YvakS1fkdq9nmQBU6nM6Thmn9h3lo_0', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
 end
 
 
 
-- 쉼표

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

-- 시세 확인

function vRP.getVehiclePrice(vehicle, cbr)
  local task = Task(cbr)
  MySQL.query("vRP/get_vehicleprice", {vehicle = vehicle}, function(rows,affected)
    task({rows[1].price})
  end)
end

-- 로그 By 키아#7777

function vRP.log(file,info)
  file = io.open(file, "a")
  if file then
   file:write(os.date("[%Y/%m/%d] %H:%M:%S").." -> "..info.."#")
  end
  file:close()
end


-- 차량 거래 기록

function vRP.vehiclelog(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." | "..info.."\n")
  end
  file:close()
end




-- 일반 차고 메뉴

local garage_menus = {}

for group,vehicles in pairs(vehicle_groups) do
  local veh_type = vehicles._config.vtype or "default"

  local menu = {
    name=lang.garage.title({group}),
    css={top = "75px", header_color="rgba(255,125,0,0.75)"}
  }
  garage_menus[group] = menu

  menu[lang.garage.owned.title()] = {function(player,choice)
    local user_id = vRP.getUserId(player)
      if user_id ~= nil then
      -- init tmpdata for rents
      local tmpdata = vRP.getUserTmpTable(user_id)
      if tmpdata.rent_vehicles == nil then
      tmpdata.rent_vehicles = {}
      end


      -- build nested menu
      local kitems = {}
      local submenu = {name=lang.garage.title({lang.garage.owned.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
      submenu.onclose = function()
        vRP.openMenu(player,menu)
      end

      local choose = function(player, choice)
        local vname = kitems[choice]
        if vname then
          -- spawn vehicle
          local vehicle = vehicles[vname]
          if vehicle then
            vRP.closeMenu(player)
            TriggerEvent('ply_garages:CheckForSpawnBasicVeh', user_id, vname)
          end
        end
      end
      
      -- get player owned vehicles
        MySQL.query("vRP/get_vehicles", {user_id = user_id}, function(pvehicles, affected)
        -- add rents to whitelist
        for k,v in pairs(tmpdata.rent_vehicles) do
          if v then -- check true, prevent future neolua issues
            table.insert(pvehicles,{vehicle = k})
          end
        end

        for k,v in pairs(pvehicles) do
          local vehicle = vehicles[v.vehicle]
          if vehicle then
            submenu[vehicle[1]] = {choose,vehicle[3]}
            kitems[vehicle[1]] = v.vehicle
          end
        end

        vRP.openMenu(player,submenu)
      end)
    end
  end,lang.garage.owned.description()}


  menu[lang.garage.buy.title()] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then

      -- build nested menu
      local kitems = {}
      local submenu = {name=lang.garage.title({lang.garage.buy.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
      submenu.onclose = function()
        vRP.openMenu(player,menu)
      end

      local choose = function(player, choice)
        local vname = kitems[choice]
        if vname then
          -- buy vehicle
          local vehicle = vehicles[vname]
          local tax = math.ceil(vehicle[2]/100*8)
          local buyprice = math.ceil(vehicle[2]+tax) -- 이벤트 없을때
          --local buyprice = math.ceil((vehicle[2]+tax)/100*50) -- 이벤트 O
          
            vRP.prompt(player,"차량을 정말 구매하시겠습니까? 'Y' 'N'","",function(player,id)
              if id == "Y" then
              if vehicle and vRP.tryFullPayment(user_id,buyprice) then
      --vRP.setWhitelisted(id,false)
      --vRPclient.notify(player,{"un-whitelisted user "..id})
              TriggerEvent('veh_SR:CheckMoneyForBasicVeh', user_id, vname, buyprice, veh_type)
              vRPclient.notify(player,{"엘리시움 소비세 8% 별도"})
              MySQL.execute("vRP/add_tax", {statecoffers = tax})
              vRP.closeMenu(player)
              else
              vRPclient.notify(player,{lang.money.not_enough()})
              end
              else if id == "N" then
              vRPclient.notify(player,{"구매가 취소되었습니다."})
              vRP.closeMenu(player)
            else
              vRPclient.notify(player,{"구매가 취소되었습니다."})
              vRP.closeMenu(player)
            end
          end
          
    end)
        end
      end
      
      -- get player owned vehicles (indexed by vehicle type name in lower case)
      MySQL.query("vRP/get_vehicles", {user_id = user_id}, function(_pvehicles, affected)
        local pvehicles = {}
        for k,v in pairs(_pvehicles) do
          pvehicles[string.lower(v.vehicle)] = true
        end

        -- for each existing vehicle in the garage group
        for k,v in pairs(vehicles) do
          if k ~= "_config" and pvehicles[string.lower(k)] == nil then -- not already owned
            local tax = math.ceil(v[2]/100*8)
            --submenu[v[1]] = {choose,lang.garage.buy.info({"소비세 포함\n" ..math.ceil((v[2]+tax)/100*50).."",v[3]})} -- 이벤트 있을때
            submenu[v[1]] = {choose,lang.garage.buy.info({"소비세 포함\n" ..math.ceil(v[2]+tax).."",v[3]})} -- 이벤트 없을때
            kitems[v[1]] = k
          end
        end

        vRP.openMenu(player,submenu)
      end)
    end
  end,lang.garage.buy.description()}




  menu[lang.garage.sell.title()] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then

      -- build nested menu
      local kitems = {}
      local submenu = {name=lang.garage.title({lang.garage.sell.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
      submenu.onclose = function()
      vRP.openMenu(player,menu)
      end

      local choose = function(player, choice)
        local vname = kitems[choice]
        if vname then
          -- sell vehicle
          local vehicle = vehicles[vname]
          if vehicle then
            local price = math.ceil(vehicle[2]*cfg.sell_factor)

            MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
              if #rows > 0 then -- has vehicle
                vRP.prompt(player,"차량을 정말 판매하시겠습니까? 'Y' 'N'","",function(player,id)
                if id == "Y" then
      --vRP.setWhitelisted(id,false)
      --vRPclient.notify(player,{"un-whitelisted user "..id})

                vRP.giveMoney(user_id,price)
                MySQL.execute("vRP/remove_vehicle", {user_id = user_id, vehicle = vname})
                vRPclient.notify(player,{"판매가 완료되었습니다."})
                vRPclient.notify(player,{lang.money.received({price})})
                vRP.closeMenu(player)
              else if id == "N" then
              vRPclient.notify(player,{"판매가 취소되었습니다."})
            else
              vRPclient.notify(player,{"판매가 취소되었습니다."})
            end
            end
                  end)
              else
                vRPclient.notify(player,{lang.common.not_found()})
              end
            end)
          end
        end
      end
      
      -- get player owned vehicles (indexed by vehicle type name in lower case)
      MySQL.query("vRP/get_vehicles", {user_id = user_id}, function(_pvehicles, affected)
        local pvehicles = {}
        for k,v in pairs(_pvehicles) do
          pvehicles[string.lower(v.vehicle)] = true
        end

        -- for each existing vehicle in the garage group
        for k,v in pairs(pvehicles) do
          local vehicle = vehicles[k]
          if vehicle then -- not already owned
            local price = math.ceil(vehicle[2]*cfg.sell_factor)
            submenu[vehicle[1]] = {choose,lang.garage.buy.info({price,vehicle[3]})}
            kitems[vehicle[1]] = k
          end
        end

        vRP.openMenu(player,submenu)
      end)
    end
  end,lang.garage.sell.description()}


 

  menu[lang.garage.store.title()] = {function(player,choice)
    vRPclient.despawnGarageVehicle(player,{veh_type,15}) 
  end, lang.garage.store.description()}
end

-- 한정 판매 차량 차고

local limited_garage_menus = {}

for group,vehicles in pairs(limited_vehicle_groups) do
  local veh_type = vehicles._config.vtype or "default"

  local menu = {
    --name=lang.garage.title({group}),
    name="한정 판매 차고",
    css={top = "75px", header_color="rgba(255,0,0,0.75)"}
  }
  limited_garage_menus[group] = menu

  menu[lang.garage.owned.title()] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      -- init tmpdata for rents
      local tmpdata = vRP.getUserTmpTable(user_id)
      if tmpdata.rent_vehicles == nil then
        tmpdata.rent_vehicles = {}
      end


      -- build nested menu
      local kitems = {}
      local submenu = {name=lang.garage.title({lang.garage.owned.title()}), css={top="75px",header_color="rgba(255,125,0,0.75)"}}
      submenu.onclose = function()
        vRP.openMenu(player,menu)
      end

      local choose = function(player, choice)
        local vname = kitems[choice]
        if vname then
          -- spawn vehicle
          local vehicle = vehicles[vname]
          if vehicle then
            vRP.closeMenu(player)
            TriggerEvent('ply_garages:CheckForSpawnBasicVeh', user_id, vname)
          end
        end
      end
      
      -- get player owned vehicles
      MySQL.query("vRP/get_vehicles", {user_id = user_id}, function(pvehicles, affected)
        -- add rents to whitelist
        for k,v in pairs(tmpdata.rent_vehicles) do
          if v then -- check true, prevent future neolua issues
            table.insert(pvehicles,{vehicle = k})
          end
        end

        for k,v in pairs(pvehicles) do
          local vehicle = vehicles[v.vehicle]
          if vehicle then
            submenu[vehicle[1]] = {choose,vehicle[3]}
            kitems[vehicle[1]] = v.vehicle
          end
        end

        vRP.openMenu(player,submenu)
      end)
    end
  end,lang.garage.owned.description()}





  menu[lang.garage.store.title()] = {function(player,choice)
    vRPclient.despawnGarageVehicle(player,{veh_type,15}) 
  end, lang.garage.store.description()}
end

local function build_client_garages(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(garages) do
      local gtype,x,y,z = table.unpack(v)

      local group = vehicle_groups[gtype]
      if group then
        local gcfg = group._config

        -- enter
        local garage_enter = function(player,area)
          local user_id = vRP.getUserId(source)
          if user_id ~= nil and vRP.hasPermissions(user_id,gcfg.permissions or {}) then
            local menu = garage_menus[gtype]
            if menu then
              vRP.openMenu(player,menu)
            end
          end
        end

        -- leave
        local garage_leave = function(player,area)
          vRP.closeMenu(player)
        end

        vRPclient.addBlip(source,{x,y,z,gcfg.blipid,gcfg.blipcolor,lang.garage.title({gtype})})
        if gtype == "Ultimate" then
        vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,255,0,255,125,150})
        vRP.setArea(source,"vRP:garage"..k,x,y,z,1,1.5,garage_enter,garage_leave)
        else
        vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125,150})
        vRP.setArea(source,"vRP:garage"..k,x,y,z,1,1.5,garage_enter,garage_leave)
        end
      end
    end
  end
end

local function build_client_limited_garages(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(limited_garages) do
      local gtype,x,y,z = table.unpack(v)

      local group = limited_vehicle_groups[gtype]
      if group then
        local gcfg = group._config

        -- enter
        local limited_garage_enter = function(player,area)
          local user_id = vRP.getUserId(source)
          if user_id ~= nil and vRP.hasPermissions(user_id,gcfg.permissions or {}) then
            local menu = limited_garage_menus[gtype]
            if menu then
              vRP.openMenu(player,menu)
            end
          end
        end

        -- leave
        local limited_garage_leave = function(player,area)
          vRP.closeMenu(player)
        end

        vRPclient.addBlip(source,{x,y,z,gcfg.blipid,gcfg.blipcolor,lang.garage.title({gtype})})
        --vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125,150})
        vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,255,0,0,125,150})
        vRP.setArea(source,"vRP:garage"..k,x,y,z,1,1.5,limited_garage_enter,limited_garage_leave)
      end
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    build_client_garages(source)
    build_client_limited_garages(source)
  end
end)


-- VEHICLE MENU

-- define vehicle actions
-- action => {cb(user_id,player,veh_group,veh_name),desc}
local veh_actions = {}

-- open trunk
veh_actions[lang.vehicle.trunk.title()] = {function(user_id,player,vtype,name)
  local chestname = "u"..user_id.."veh_"..string.lower(name)
  local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

  -- open chest
  vRPclient.vc_openDoor(player, {vtype,5})
  vRP.openChest(player, chestname, max_weight, function()
    vRPclient.vc_closeDoor(player, {vtype,5})
  end)
end, lang.vehicle.trunk.description()}

-- detach trailer
veh_actions[lang.vehicle.detach_trailer.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_detachTrailer(player, {vtype})
end, lang.vehicle.detach_trailer.description()}

-- detach towtruck
veh_actions[lang.vehicle.detach_towtruck.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_detachTowTruck(player, {vtype})
end, lang.vehicle.detach_towtruck.description()}

-- detach cargobob
veh_actions[lang.vehicle.detach_cargobob.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_detachCargobob(player, {vtype})
end, lang.vehicle.detach_cargobob.description()}

-- lock/unlock
veh_actions[lang.vehicle.lock.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_toggleLock(player, {vtype})
end, lang.vehicle.lock.description()}

-- engine on/off
veh_actions[lang.vehicle.engine.title()] = {function(user_id,player,vtype,name)
  vRPclient.vc_toggleEngine(player, {vtype})
end, lang.vehicle.engine.description()}

local function ch_vehicle(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- check vehicle
    vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
      if ok then
        -- build vehicle menu
        vRP.buildMenu("vehicle", {user_id = user_id, player = player, vtype = vtype, vname = name}, function(menu)
          menu.name=lang.vehicle.title()
          menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}

          for k,v in pairs(veh_actions) do
            menu[k] = {function(player,choice) v[1](user_id,player,vtype,name) end, v[2]}
          end

          vRP.openMenu(player,menu)
        end)
      else
        vRPclient.notify(player,{lang.vehicle.no_owned_near()})
      end
    end)
  end
end

-- ask trunk (open other user car chest)
local function ch_asktrunk(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRPclient.notify(player,{lang.vehicle.asktrunk.asked()})
      vRP.request(nplayer,lang.vehicle.asktrunk.request(),15,function(nplayer,ok)
        if ok then -- request accepted, open trunk
          vRPclient.getNearestOwnedVehicle(nplayer,{7},function(ok,vtype,name)
            if ok then
              local chestname = "u"..nuser_id.."veh_"..string.lower(name)
              local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

              -- open chest
              local cb_out = function(idname,amount)
                vRPclient.notify(nplayer,{lang.inventory.give.given({vRP.getItemName(idname),amount})})
              end

              local cb_in = function(idname,amount)
                vRPclient.notify(nplayer,{lang.inventory.give.received({vRP.getItemName(idname),amount})})
              end

              vRPclient.vc_openDoor(nplayer, {vtype,5})
              vRP.openChest(player, chestname, max_weight, function()
                vRPclient.vc_closeDoor(nplayer, {vtype,5})
              end,cb_in,cb_out)
            else
              vRPclient.notify(player,{lang.vehicle.no_owned_near()})
              vRPclient.notify(nplayer,{lang.vehicle.no_owned_near()})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end)
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end

-- repair nearest vehicle
local function ch_repair(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- anim and repair
    if vRP.tryGetInventoryItem(user_id,"repairkit",1,true) then
      vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_WELDING"},false})
      SetTimeout(15000, function()
        vRPclient.fixeNearestVehicle(player,{7})
        vRPclient.stopAnim(player,{false})
      end)
    end
  end
end

-- replace nearest vehicle
local function ch_replace(player,choice)
  vRPclient.replaceNearestVehicle(player,{7})
end

vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    -- add vehicle entry
    local choices = {}
    choices[lang.vehicle.title()] = {ch_vehicle}

    -- add ask trunk
    choices[lang.vehicle.asktrunk.title()] = {ch_asktrunk}

    -- add repair functions
    if vRP.hasPermission(user_id, "vehicle.repair") then
      choices[lang.vehicle.repair.title()] = {ch_repair, lang.vehicle.repair.description()}
    end

    if vRP.hasPermission(user_id, "vehicle.replace") then
      choices[lang.vehicle.replace.title()] = {ch_replace, lang.vehicle.replace.description()}
    end

    add(choices)
  end
end)



--sell vehicle
veh_actions[lang.vehicle.sellTP.title()] = {function(playerID,player,vtype,name)
	if playerID ~= nil then
		vRPclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"근처 플레이어 : " .. usrList .. "","",function(player,user_id) 
					user_id = user_id
					if user_id ~= nil and user_id ~= "" then 
						local target = vRP.getUserSource(tonumber(user_id))
						if target ~= nil then
              
           
              
              vRP.getVehiclePrice(name, function(price)    -- 시세 확인
              if price == nil then price = 0 end  -- 시세 확인
              
              
              
							vRP.prompt(player,"가격을 적어주세요. (현재 시세 "..comma_value(price).."$) :",price,function(player,amount) -- 가격 표기
								if (tonumber(amount)) and (tonumber(amount) > 0) then
                  if (tonumber(amount)) < 400000000000 then -- 5천억 제한
                    local pricemaximum = tonumber(price/100*120)
                    local priceminimum = tonumber(price/100*80)
                    if price == 0 or (tonumber(amount)) >= priceminimum then -- 시세보다 20% 낮을때
                    if price == 0 or (tonumber(amount)) <= pricemaximum then -- 시세보다 20% 높을때
									MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = name}, function(pvehicle, affected)
										if #pvehicle > 0 then
                    vRPclient.notify(player,{"~r~상대방이 이미 이 차량을 가지고 있습니다!"})
										else
											local tmpdata = vRP.getUserTmpTable(playerID)
											-- 렌트카 확인 부분
                      if tmpdata.rent_vehicles[name] == true then
												vRPclient.notify(player,{"~r~렌트 차량은 판매할 수 없습니다!"})
												return
											else
												vRP.request(target,GetPlayerName(player).." 님께서 " ..name.. " 차량을 "..amount.."$에 판매하였습니다.", 30, function(target,ok)
													if ok then
														local pID = vRP.getUserId(target)
														local money = vRP.getMoney(pID)
														if (tonumber(money) >= tonumber(amount)) then
															vRPclient.despawnGarageVehicle(player,{vtype,15})
															vRP.getUserIdentity(pID, function(identity)
                              MySQL.execute("vRP/remove_vehicle", {user_id = playerID, vehicle = name})
                              --MySQL.execute("vRP/sell_vehicle_player", {user_id = user_id, oldUser = playerID, vehicle = name}) 
                              end)
                              TriggerEvent('veh_SR:CheckMoneyForBasicVeh', pID, name, amount, vtype)
                            local tax = math.ceil(amount/100*3)
                              MySQL.execute("vRP/add_tax", {statecoffers = tax})
															vRP.giveMoney(playerID, amount-tax)
															vRP.setMoney(pID,money-amount)
															vRPclient.notify(player,{"~g~차량을 ".. GetPlayerName(target).."님에게 "..comma_value(amount).."$에 성공적으로 판매하였습니다!"})
															vRPclient.notify(player,{"자동차 이전세 3% 공제"})
															vRPclient.notify(target,{"~g~"..GetPlayerName(player).."의 차량을 " ..comma_value(amount).. "$에 성공적으로 구매하였습니다."})
                              vRP.vehiclelog("vehiclelog.txt",""..GetPlayerName(player).." ("..playerID..") 님께서 "..GetPlayerName(target).." ("..pID..") 님에게 "..name.." 차량을 "..comma_value(amount).."$에 판매하였습니다.")
                              MySQL.execute("vRP/set_vehicleprice", {vehicle = name, price = amount})
                              
                              if name == "ltm" then names = "람보르기니 테르조 밀레니오"
                              elseif name == "e60" then names = "BMW M5 E60 하츠네 미쿠"
                              elseif name == "db11" then names = "애스턴 마틴 DB11 얼티메이트-튜닝"
                              elseif name == "bexp" then names = "벤틀리 EXP-10 스피드 6"
                              elseif name == "divo" then names = "부가티 디보 2019"
                              elseif name == "arrinera" then names = "페라리 엔조"
                              elseif name == "enzo" then names = "아리에나 후사랴 2017"
                              elseif name == "senna" then names = "멕라렌 세나 2019"
                              elseif name == "ltm" then names = "람보르기니 테르조 밀레니오"
                              elseif name == "pista" then names = "페라리 488 피스타 2019"
                              elseif name == "f1" then names = "멕라렌 F1 1993"
                              elseif name == "rt70" then names = "둠 닷지 차저 1970 (Furious 7)"
                              elseif name == "laferrari" then names = "라 페라리 2015"
                              elseif name == "fxxk" then names = "페라리 FXX-K"
                              elseif name == "mx5326" then names = "마쯔다 MX5 스탠스 2016"
                              elseif name == "granlb" then names = "2013 마세라티 그란투리스모 MC스트라달레 리버티워크"
                              elseif name == "vulcan" then names = "애스턴 마틴 벌칸 2016"
                              elseif name == "lamboavj" then names = "람보르기니 아벤타도르 SVJ 2019"
                              elseif name == "rmodveneno" then names = "람보르기니 베네노 LP750-4"
                              elseif name == "aventadors" then names = "람보르기니 아벤타도르 S 로드스터 2018"
                              elseif name == "g500" then names = "메르세데스-벤츠 G500 4x4 브라버스"
                              elseif name == "ssc" then names = "SSC 얼티메이트 에어로"
                              elseif name == "ts1" then names = "젠보 TS1 GT 2018"
                              elseif name == "bnteam" then names = "벤틀리 컨티넨탈 GT Breitling Jet Team"
                              elseif name == "mv720" then names = "멕라렌 720S Vorsteiner 2018"
                              elseif name == "f12m" then names = "페라리 F12 Stallone by Mansory 2013"
                              elseif name == "m8gte" then names = "BMW M8 GTB"
                              elseif name == "lbperfs" then names = "람보르기니 우라칸 퍼포만테 스파이더 2018 리버티 워크"
                              elseif name == "f430s" then names = "페라리 F430 스쿠데리아"
                              elseif name == "f40" then names = "페라리 F40"
                              elseif name == "lb750sv" then names = "람보르기니 아벤타도르 LP750 SV 리버티 워크"
                              elseif name == "ct6" then names = "캐딜락 CT6 2017"
                              elseif name == "m850" then names = "BMW M850i 2019"
                              elseif name == "gt63s" then names = "메르세데스-벤츠 AMG GT63S 2019"
                              elseif name == "gtr2020" then names = "닛산 2020 컨셉 비전 GT"
                              elseif name == "apollo" then names = "아폴로 엔텐사 이모지온"
                              elseif name == "mig" then names = "페라리 엔조 & 겜발라 MIG-U1"
                              elseif name == "supersport" then names = "부가티 베이론 슈퍼 스포츠"
                              elseif name == "x5m" then names = "BMW X5M 2019"
                              elseif name == "f80" then names = "페라리 F80 2016"
                              elseif name == "amggtsmansory" then names = "메르세데스 AMG GT S 만소리"
                              elseif name == "rmodlp570" then names = "람보르기니 가야르도 LP570-4 슈퍼레제라"
                              elseif name == "avj" then names = "람보르기니 아벤타도르 J 스피드스터 2012"
                              elseif name == "cresta" then names = "토요타 크레스타 JZX100 버텍스"
                              elseif name == "mi8" then names = "BMW I8 쿠페 MANSAUG"
                              elseif name == "fm488" then names = "페라리 488 만소리 시라쿠사 4XX"
                              elseif name == "scuderiag" then names = "스쿠데리아 글리켄하우스 SCG003"
                              elseif name == "mustang19" then names = "포드 머스탱 GT 2019"
                              elseif name == "tr22" then names = "테슬라 로드스터 2020"
                              elseif name == "rrmansory" then names = "롤스로이스 던 만소리 2018"
                              elseif name == "m4c" then names = "BMW M4 컨버터블"
                              elseif name == "huraperfospy" then names = "람보르기니 우라칸 퍼포만테 스파이더"
                              elseif name == "pd458wb" then names = "프라이어 디자인 페라리 458 와일드바디"
                              elseif name == "por4s" then names = "포르쉐 911 카브리올레 카레라 4S 2020"
                              elseif name == "bati" then names = "미니 모토"
                              elseif name == "18S65" then names = "메르세데스-벤츠 S65 AMG 2018"
                              elseif name == "pragar1" then names = "프라가 R1"
                              elseif name == "scaldarsi" then names = "마이바흐 엠페러"
                              elseif name == "rmodm4gts" then names = "BMW M4 GTS 리버티 워크"
                              elseif name == "mvisiongt" then names = "메르세데스-벤츠 AMG 비전 GT"
                              elseif name == "bac2" then names = "백 모노"
                              elseif name == "jes" then names = "코닉세그 제스코 2020"
                              elseif name == "sc18" then names = "람보르기니 SC18 알스톤 2019"
                              elseif name == "rx7cwest" then names = "마쯔다 RX7 C-웨스트"
                              elseif name == "nismo20" then names = "닛산 GT-R 니스모 2020"
                              elseif name == "alpha6" then names = "쉐보레 카마로 SS 알파 식스 디자인 2016"
                              elseif name == "p2" then names = "맥라렌 P1 GT-R 에디션"
                              elseif name == "lp670" then names = "람보르기니 무르시엘라고 LP670-4 2010"
                              elseif name == "carnival" then names = "기아 카니발"
                              elseif name == "trezor1" then names = "르노 트레조"
                              elseif name == "rxf7" then names = "마쯔다 RX-F7 BLS BN-Sport"
                              elseif name == "schafter2" then names = "포드 토러스 SHO 2010"
                              elseif name == "dune2" then names = "백 투더 퓨처 - 드로리안 타임 머신"
                              elseif name == "eq900" then names = "제네시스 EQ900"
                              elseif name == "str20" then names = "포르쉐 911 스피드스터 2020"
                              elseif name == "alfieri" then names = "마세라티 알페리 2014"
                              elseif name == "750lix19" then names = "BMW 750Li X드라이브 2019"
                              elseif name == "alpha" then names = "메르세데스-벤츠 CLA 45 AMG 리무진"
                              elseif name == "arrow" then names = "메르세데스-벤츠 실버 라이트닝"
                              elseif name == "protopolice" then names = "알파인 비젼 그란 투리스모 콘셉트 2015"
                              elseif name == "sportrs" then names = "르노 스포츠 RS"
                              elseif name == "semaford" then names = "포드 F350 세마 빌드 2020"
                              --elseif name == "lambc" then names = "★ 람보르기니 셀레스티얼"
                              --elseif name == "egoista" then names = "★ 람보르기니 에고이스타"
                              --elseif name == "f8t" then names = "페라리 F8 트리뷰토 2020"
                              elseif name == "f60" then names = "페라리 F60 아메리카"
                              elseif name == "rollsghostewb" then names = "롤스로이스 고스트 EWB"
                              elseif name == "g90" then names = "제네시스 G90"
                              elseif name == "camarotf5" then names = "쉐보레 카마로 TF5"
                              elseif name == "jv90" then names = "엔타라 JV90"
                              elseif name == "cognoscenti" then names = "메르세데스-벤츠 마이바흐 S600 풀만"
                              elseif name == "pro1" then names = "메르세데스-벤츠 AMG 프로젝트 원 "
                              elseif name == "600lt" then names = "맥라렌 600LT 2019"
                              elseif name == "r820" then names = "아우디 R8 2020"
                              elseif name == "bmm" then names = "벤틀리 뮬산 뮬리너 2013"
                              elseif name == "sian" then names = "람보르기니 시안 2020"
                              elseif name == "hvrod" then names = "할리-데이비슨 V-ROD 나이트 ROD 스페셜"
                              elseif name == "filthynsx" then names = "아쿠라 NSX 리버티워크"
                              elseif name == "mbc" then names = "메르세데스-벤츠 컨셉"
                              --elseif name == "bugatticentodieci" then names = "★ 부가티 센토디에치"
                              elseif name == "z4alchemist" then names = "BMW Z4 알케미스트"
                              elseif name == "porter" then names = "현대 포터"
                              elseif name == "964RWBH" then names = "포르쉐 911 (964) 터보 후니건&RWB"
                              elseif name == "lavoi" then names = "부가티 라 부아튀르 느와르"
                              elseif name == "sibal" then names = "국제차량제작 시발자동차"
                              elseif name == "it18" then names = "이탈디자인 제로우노 2017"
                              
                              else
                              names = ""
                              end
                              if names ~= "" then
                              TriggerClientEvent("chatMessage", -1, "시세 변동 알림", { 0, 255, 255 }, "^*^5"..names.."^0 차량의 시세가 변동되었습니다. ^9(현재 시세 : "..comma_value(amount).."$)^0")  
                              end
                              
                              local my_name = GetPlayerName(player)
                              local my_id = vRP.getUserId(player)
                              
                              sendToDiscord_garage(16711680, "ElysiumRP 차량 거래 기록", "[ 판매자 닉네임 : "..my_name.." ]\n\n[ 판매자 고유번호 : "..my_id.."번 ]\n\n[ 구매자 닉네임 : "..GetPlayerName(target).." ]\n\n[ 구매자 고유번호 : "..pID.."번 ]\n\n[ 판매 차량 이름 : "..name.." ]\n\n[ 판매 가격 : "..comma_value(amount).."$ ]", os.date("거래일시 : %Y년 %m월 %d일 %H시 %M분 %S초"))
                              
                              
                              
                              
                              
                              
														else
															vRPclient.notify(player,{"~r~".. GetPlayerName(target).."님께서 그만한 돈을 가지고 있지 않습니다."})
															vRPclient.notify(target,{"~r~당신은 그만한 돈을 가지고 있지 않습니다!"})
														end
                            
													else
														vRPclient.notify(player,{"~r~"..GetPlayerName(target).." has refused to buy the car."})
														vRPclient.notify(target,{"~r~You have refused to buy "..GetPlayerName(player).."'s car."})
													end
												end)
											end
											vRP.closeMenu(player)
										end
									end) 
                else
                  vRPclient.notify(player,{"~r~시세보다 최대 20%까지 높게 거래 가능합니다!\n최대 가능 금액\n".. comma_value(pricemaximum) .."$"})
                  vRPclient.notify(player,{"~y~최대 가능 금액 :\n".. comma_value(pricemaximum) .."$"})
              end
            else
              vRPclient.notify(player,{"~r~시세보다 최대 20%까지 낮게 거래 가능합니다!\n최소 가능 금액\n".. comma_value(priceminimum) .."$"})
              vRPclient.notify(player,{"~y~최소 가능 금액 :\n".. comma_value(priceminimum) .."$"})
              end
                else
                  vRPclient.notify(player,{"~r~4,000억 이상은 거래할 수 없습니다!"})
                end
								else
									vRPclient.notify(player,{"~r~차량 가격은 숫자여야 합니다!"})
								end
							end)
            
            
            
            
          end)    -- 시세 확인
        
        
        
        
						else
							vRPclient.notify(player,{"~r~접속 중이지 않거나 없는 고유번호 입니다."})
						end
					else
						vRPclient.notify(player,{"~r~고유번호를 입력해주세요."})
					end
				end)
			else
				vRPclient.notify(player,{"~r~근처에 플레이어가 없습니다."})
			end
		end)
	end
end, lang.vehicle.sellTP.description()}







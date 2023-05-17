--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")

vRPbm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_basic_menu")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
vRPbsC = Tunnel.getInterface("vRP_barbershop","vRP_basic_menu")
Tunnel.bindInterface("vrp_basic_menu",vRPbm)

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

function vRP.prslog(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end

-- LOG FUNCTION
function vRPbm.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end
-- MAKE CHOICES
--toggle service
local choice_service = {function(player,choice)
  local user_id = vRP.getUserId({player})
  local service = "emsservice"
  if user_id ~= nil then
    if vRP.hasGroup({user_id,service}) then
	  vRP.removeUserGroup({user_id,service})
--	  if vRP.hasMission({player}) then
--		vRP.stopMission({player})
	 -- end
    vRPclient.notify(player,{"~r~더 이상 호출을 받지 않습니다."})
	else
	  vRP.addUserGroup({user_id,service})
    vRPclient.notify(player,{"~g~지금부터 호출을 받을 수 있습니다."})
	end
  end
end, "엘리시움 의료국 호출 ON/OFF"}

-- teleport waypoint
local choice_tptowaypoint = {function(player,choice)
  TriggerClientEvent("TpToWaypoint", player)
end, "Teleport to map blip."}

-- fix barbershop green hair for now
local ch_fixhair = {function(player,choice)
    local custom = {}
    local user_id = vRP.getUserId({player})
    vRP.getUData({user_id,"vRP:head:overlay",function(value)
	  if value ~= nil then
	    custom = json.decode(value)
        vRPbsC.setOverlay(player,{custom,true})
	  end
	end})
end, "Fix the barbershop bug for now."}

--toggle blips
local ch_blips = {function(player,choice)
  TriggerClientEvent("showBlips", player)
end, "Toggle blips."}

local spikes = {}
local ch_spikes = {function(player,choice)
	local user_id = vRP.getUserId({player})
	BMclient.isCloseToSpikes(player,{},function(closeby)
		if closeby and (spikes[player] or vRP.hasPermission({user_id,"admin.spikes"})) then
		  BMclient.removeSpikes(player,{})
		  spikes[player] = false
		elseif closeby and not spikes[player] and not vRP.hasPermission({user_id,"admin.spikes"}) then
		  vRPclient.notify(player,{"~r~You can carry only one set of spikes!"})
		elseif not closeby and spikes[player] and not vRP.hasPermission({user_id,"admin.spikes"}) then
		  vRPclient.notify(player,{"~r~You can deploy only one set of spikes!"})
		elseif not closeby and (not spikes[player] or vRP.hasPermission({user_id,"admin.spikes"})) then
		  BMclient.setSpikesOnGround(player,{})
		  spikes[player] = true
		end
	end)
end, "Toggle spikes."}

local ch_sprites = {function(player,choice)
  TriggerClientEvent("showSprites", player)
end, "Toggle sprites."}

local ch_deleteveh = {function(player,choice)
  BMclient.deleteVehicleInFrontOrInside(player,{5.0})
end, "Delete nearest car."}

--client function
local ch_crun = {function(player,choice)
  vRP.prompt({player,"Function:","",function(player,stringToRun) 
    stringToRun = stringToRun or ""
	TriggerClientEvent("RunCode:RunStringLocally", player, stringToRun)
  end})
end, "Run client function."}

--server function
local ch_srun = {function(player,choice)
  vRP.prompt({player,"Function:","",function(player,stringToRun) 
    stringToRun = stringToRun or ""
	TriggerEvent("RunCode:RunStringRemotelly", stringToRun)
  end})
end, "Run server function."}

--police weapons // comment out the weapons if you dont want to give weapons.
local police_weapons = {}
police_weapons["Equip"] = {function(player,choice)
    vRPclient.giveWeapons(player,{{
	  ["WEAPON_COMBATPISTOL"] = {ammo=200},
	  ["WEAPON_PUMPSHOTGUN"] = {ammo=200},
	  ["WEAPON_NIGHTSTICK"] = {ammo=200},
	  ["WEAPON_STUNGUN"] = {ammo=200}
	}, true})
	BMclient.setArmour(player,{100,true})
end}

--store money
local choice_store_money = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local amount = vRP.getMoney({user_id})
    if vRP.tryPayment({user_id, amount}) then -- unpack the money
      vRP.giveInventoryItem({user_id, "money", amount, true})
    end
  end
end, "Store your money in your inventory."}

--medkit storage
local emergency_medkit = {}
emergency_medkit["Take"] = {function(player,choice)
	local user_id = vRP.getUserId({player}) 
	vRP.giveInventoryItem({user_id,"medkit",25,true})
	vRP.giveInventoryItem({user_id,"pills",25,true})
end}

--heal me
local emergency_heal = {}
emergency_heal["Heal"] = {function(player,choice)
	local user_id = vRP.getUserId({player}) 
	vRPclient.setHealth(player,{1000})
end}

--loot corpse
local choice_loot = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId({nplayer})
      if nuser_id ~= nil then
        vRPclient.isInComa(nplayer,{}, function(in_coma)
          if in_coma then
			local revive_seq = {
			  {"amb@medic@standing@kneel@enter","enter",1},
			  {"amb@medic@standing@kneel@idle_a","idle_a",1},
			  {"amb@medic@standing@kneel@exit","exit",1}
			}
        vRPbm.logInfoToFile("lootlog.txt",user_id .. " 가 ".. nuser_id .. "을 루팅하였음")
  			vRPclient.playAnim(player,{false,revive_seq,false}) -- anim
            SetTimeout(15000, function()
              local ndata = vRP.getUserDataTable({nuser_id})
              if ndata ~= nil then
			    if ndata.inventory ~= nil then -- gives inventory items
				  vRP.clearInventory({nuser_id})
                  for k,v in pairs(ndata.inventory) do 
			        vRP.giveInventoryItem({user_id,k,v.amount,true})
	              end
				end
			  end
			  local nmoney = vRP.getMoney({nuser_id})
			  if vRP.tryPayment({nuser_id,nmoney}) then
			    vRP.giveMoney({user_id,nmoney})
			  end
            end)
			vRPclient.stopAnim(player,{false})
          else
            vRPclient.notify(player,{lang.emergency.menu.revive.not_in_coma()})
          end
        end)
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end,"가까이 있는 시체의 인벤토리를 루팅합니다."}

-- hack player
local ch_hack = {function(player,choice)
  -- get nearest player
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{25},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId({nplayer})
        if nuser_id ~= nil then
          -- prompt number
		  local nbank = vRP.getBankMoney({nuser_id})
          local amount = math.floor(nbank*0.01)
		  local nvalue = nbank - amount
		  if math.random(1,100) == 1 then
			vRP.setBankMoney({nuser_id,nvalue})
            vRPclient.notify(nplayer,{"Hacked ~r~".. amount .."$."})
		    vRP.giveInventoryItem({user_id,"dirty_money",amount,true})
		  else
            vRPclient.notify(nplayer,{"~g~Hacking attempt failed."})
            vRPclient.notify(player,{"~r~Hacking attempt failed."})
		  end
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end,"Hack closest player."}

-- mug player
local ch_mug = {function(player,choice)
  -- get nearest player
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId({nplayer})
        if nuser_id ~= nil then
          -- prompt number
		  local nmoney = vRP.getMoney({nuser_id})
          local amount = nmoney
		  if math.random(1,3) == 1 then
            if vRP.tryPayment({nuser_id,amount}) then
              vRPclient.notify(nplayer,{"Mugged ~r~"..amount.."$."})
		      vRP.giveInventoryItem({user_id,"dirty_money",amount,true})
            else
              vRPclient.notify(player,{lang.money.not_enough()})
            end
		  else
            vRPclient.notify(nplayer,{"~g~Mugging attempt failed."})
            vRPclient.notify(player,{"~r~Mugging attempt failed."})
		  end
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end, "Mug closest player."}

-- drag player
local ch_drag = {function(player,choice)
  -- get nearest player
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId({nplayer})
        if nuser_id ~= nil then
		  vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
			if handcuffed then
				TriggerClientEvent("dr:drag", nplayer, player)
			else
				vRPclient.notify(player,{"Player is not handcuffed."})
			end
		  end)
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end, "Drag closest player."}

-- player check
local choice_player_check = {function(player,choice)
  vRPclient.getNearestPlayer(player,{5},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(nplayer,{lang.police.menu.check.checked()})
      vRPclient.getWeapons(nplayer,{},function(weapons)
        -- prepare display data (money, items, weapons)
        local money = vRP.getMoney({nuser_id})
        local items = ""
        local data = vRP.getUserDataTable({nuser_id})
        if data and data.inventory then
          for k,v in pairs(data.inventory) do
            local item_name = vRP.getItemName({k})
            if item_name then
              items = items.."<br />"..item_name.." ("..v.amount..")"
            end
          end
        end

        local weapons_info = ""
        for k,v in pairs(weapons) do
          weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
        end

        vRPclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info})})
        -- request to hide div
        vRP.request({player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
          vRPclient.removeDiv(player,{"police_check"})
        end})
      end)
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end, lang.police.menu.check.description()}

-- player store weapons
local store_weapons_cd = {}
function storeWeaponsCooldown()
  for user_id,cd in pairs(store_weapons_cd) do
    if cd > 0 then
      store_weapons_cd[user_id] = cd - 1
	end
  end
  SetTimeout(1000,function()
	storeWeaponsCooldown()
  end)
end
storeWeaponsCooldown()
local choice_store_weapons = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if (store_weapons_cd[user_id] == nil or store_weapons_cd[user_id] == 0) and user_id ~= nil then
    store_weapons_cd[user_id] = 5
    vRPclient.getWeapons(player,{},function(weapons)
      for k,v in pairs(weapons) do
        -- convert weapons to parametric weapon items
        vRP.giveInventoryItem({user_id, "wbody|"..k, 1, true})
        if v.ammo > 0 then
          vRP.giveInventoryItem({user_id, "wammo|"..k, v.ammo, true})
        end
      end
      -- clear all weapons
      vRPclient.giveWeapons(player,{{},true})
    end)
  else
    vRPclient.notify(player,{"~r~You are already storing your weapons."})
  end
end, lang.police.menu.store_weapons.description()}

-- armor item
vRP.defInventoryItem({"body_armor","Body Armor","Intact body armor.",
function(args)
  local choices = {}

  choices["Equip"] = {function(player,choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      if vRP.tryGetInventoryItem({user_id, "body_armor", 1, true}) then
		BMclient.setArmour(player,{100,true})
        vRP.closeMenu({player})
      end
    end
  end}

  return choices
end,
5.00})

-- store armor
local choice_store_armor = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    BMclient.getArmour(player,{},function(armour)
      if armour > 95 then
        vRP.giveInventoryItem({user_id, "body_armor", 1, true})
        -- clear armor
	    BMclient.setArmour(player,{0,false})
	  else
	    vRPclient.notify(player, {"~r~Damaged armor can't be stored!"})
      end
    end)
  end
end, "Store intact body armor in inventory."}

local unjailed = {}
function jail_clock(target_id,timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
	  vRPclient.notify(target, {"~r~남은 구금 시간 : " .. timer .. "분"})
      vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(timer)})
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
		  end
		end
		vRP.setHunger({tonumber(target_id), 0})
		vRP.setThirst({tonumber(target_id), 0})
	    jail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	  BMclient.loadFreeze(target,{false,true,true})
	  SetTimeout(2000,function()
		BMclient.loadFreeze(target,{false,false,false})
	  end)
	  --vRPclient.teleport(target,{425.7607421875,-978.73425292969,30.709615707397}) -- teleport to outside jail
	  vRPclient.teleport(target,{1849.1353759766,2603.740234375,45.585269927979}) -- teleport to outside jail
	  vRPclient.setHandcuffed(target,{false})
      vRPclient.notify(target,{"~b~자유를 얻었습니다."})
	  vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(-1)})
    end
  end
end

-- dynamic jail
local ch_jail = {function(player,choice) 
  vRPclient.getNearestPlayers(player,{15},function(nplayers) 
	local user_list = ""
    for k,v in pairs(nplayers) do
	  user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
    end 
	if user_list ~= "" then
	  vRP.prompt({player,"근처 플레이어 :" .. user_list,"",function(player,target_id) 
	    if target_id ~= nil and target_id ~= "" then 
	      vRP.prompt({player,"구금 시간 :","10",function(player,jail_time)
			if jail_time ~= nil and jail_time ~= "" then 
	          local target = vRP.getUserSource({tonumber(target_id)})
			  if target ~= nil then
		        if tonumber(jail_time) > 120 then
  			      jail_time = 120
		        end
		        if tonumber(jail_time) < 1 then
		          jail_time = 1
		        end
		  
          vRPclient.isHandcuffed(target,{}, function(handcuffed)  
          if handcuffed then
					BMclient.loadFreeze(target,{false,true,true})
					SetTimeout(2000,function()
					  BMclient.loadFreeze(target,{false,false,false})
					end)
				    vRPclient.teleport(target,{1641.5477294922,2570.4819335938,45.564788818359}) -- teleport to inside jail
				    vRPclient.notify(target,{"~r~자유를 잃었습니다."})
				    vRPclient.notify(player,{"~b~고유번호 "..target_id.."을(를) 구금하였습니다."})
				    vRP.setHunger({tonumber(target_id),0})
				    vRP.setThirst({tonumber(target_id),0})
				    jail_clock(tonumber(target_id),tonumber(jail_time))
					local user_id = vRP.getUserId({player})
					vRPbm.logInfoToFile("jailLog.txt",user_id .. " 가 "..target_id.." 를 " .. jail_time .. " 분간 구금하였습니다.")
			      else
				    vRPclient.notify(player,{"~r~수갑을 채워야 합니다!"})
			      end
			    end) 
			  else
				vRPclient.notify(player,{"~r~고유번호를 확인해주세요."})
			  end
			else
			  vRPclient.notify(player,{"~r~구금시간을 설정해주세요."})
			end
	      end})
        else
          vRPclient.notify(player,{"~r~구금할 고유번호가 존재하지 않거나 접속 중이 아닙니다."})
        end 
	  end})
    else
      vRPclient.notify(player,{"~r~근처에 플레이어가 없습니다!"})
    end 
  end)
end,"근처의 유저를 구금합니다."}

-- dynamic unjail
local ch_unjail = {function(player,choice) 
	vRP.prompt({player,"Player ID:","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
		vRP.getUData({tonumber(target_id),"vRP:jail:time",function(value)
		  if value ~= nil then
		  custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId({player})
			  if tonumber(custom) > 0 or vRP.hasPermission({user_id,"admin.easy_unjail"}) then
	            local target = vRP.getUserSource({tonumber(target_id)})
				if target ~= nil then
	              unjailed[target] = tonumber(target_id)
				  vRPclient.notify(player,{"~g~Target will be released soon."})
				  vRPclient.notify(target,{"~g~누군가 당신을 구금에서 해제하였습니다."})
				  vRPbm.logInfoToFile("jailLog.txt",user_id .. " freed "..target_id.." from a " .. custom .. " minutes sentence")
				else
				  vRPclient.notify(player,{"~r~That ID seems invalid."})
				end
			  else
				vRPclient.notify(player,{"~r~Target is not jailed."})
			  end
			end
		  end
		end})
      else
        vRPclient.notify(player,{"~r~No player ID selected."})
      end 
	end})
end,"구금을 해제합니다."}

-- (server) called when a logged player spawn to check for vRP:jail in user_data
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
  local target = vRP.getUserSource({user_id})
  SetTimeout(35000,function()
    local custom = {}
    vRP.getUData({user_id,"vRP:jail:time",function(value)
	  if value ~= nil then
	    custom = json.decode(value)
	    if custom ~= nil then
		  if tonumber(custom) > 0 then
			BMclient.loadFreeze(target,{false,true,true})
			SetTimeout(2000,function()
      BMclient.loadFreeze(target,{false,false,false})
			end)
            vRPclient.setHandcuffed(target,{false})
            vRPclient.teleport(target,{1641.5477294922,2570.4819335938,45.564788818359}) -- teleport inside jail
            vRPclient.notify(target,{"~r~구금을 끝마치세요."})
			vRP.setHunger({tonumber(user_id),0})
			vRP.setThirst({tonumber(user_id),0})
			vRPbm.logInfoToFile("jailLog.txt",user_id.." has been sent back to jail for " .. custom .. " minutes to complete his sentence")
      jail_clock(tonumber(user_id),tonumber(custom))
		  end
	    end
	  end
	end})
  end)
end)

-- dynamic fine
local ch_fine = {function(player,choice) 
  vRPclient.getNearestPlayers(player,{15},function(nplayers) 
	local user_list = ""
    for k,v in pairs(nplayers) do
	  user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
    end 
	if user_list ~= "" then
	  vRP.prompt({player,"가까운 플레이어:" .. user_list,"",function(player,target_id) 
	    if target_id ~= nil and target_id ~= "" then 
	      vRP.prompt({player,"금액:","0",function(player,fine)
			if fine ~= nil and fine ~= "" then 
	          vRP.prompt({player,"벌금 사유:","",function(player,reason)
			    if reason ~= nil and reason ~= "" then 
	              local target = vRP.getUserSource({tonumber(target_id)})
				  if target ~= nil then
		            --if tonumber(fine) > 1000000 then
  			        --  fine = 1000000
		            --end
		            if tonumber(fine) < 100 then
		              fine = 100
		            end
		            if vRP.tryFullPayment({tonumber(target_id), tonumber(fine)}) then
                      local user_id = vRP.getUserId({player})
                      local tax = math.ceil(fine/100*90)
                      vRP.insertPoliceRecord({tonumber(target_id), lang.police.menu.fine.record({reason,fine})})
                      vRPclient.notify(player,{lang.police.menu.fine.fined({reason,fine})})
                      vRPclient.notify(target,{lang.police.menu.fine.notify_fined({reason,fine})})
                      vRPclient.notify(player,{"벌금의 10% 지급"})
                      vRP.giveBankMoney({user_id, math.ceil(fine/100*10)})
                      vRP.addTax({tax})
                      vRPbm.logInfoToFile("fineLog.txt",user_id .. " fined "..target_id.." the amount of " .. fine .. " for ".. reason)
                      vRP.closeMenu({player})
                    else
                      vRPclient.notify(player,{lang.money.not_enough()})
                    end
				  else
					vRPclient.notify(player,{"~r~That ID seems invalid."})
				  end
				else
				  vRPclient.notify(player,{"~r~You can't fine for no reason."})
				end
	          end})
			else
			  vRPclient.notify(player,{"~r~Your fine has to have a value."})
			end
	      end})
        else
          vRPclient.notify(player,{"~r~No player ID selected."})
        end 
	  end})
    else
      vRPclient.notify(player,{"~r~No player nearby."})
    end 
  end)
end,"Fines a nearby player."}

-- improved handcuff
local ch_handcuff = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.toggleHandcuff(nplayer,{})
	  local user_id = vRP.getUserId({player})
	  vRPbm.logInfoToFile("jailLog.txt",user_id .. " 가 ".. nuser_id .. "에게 수갑을 채웠음.")
      vRP.closeMenu({nplayer})
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end,lang.police.menu.handcuff.description()}

-- admin god mode
local gods = {}
function task_god()
  SetTimeout(10000, task_god)

  for k,v in pairs(gods) do
    vRP.setHunger({v, 0})
    vRP.setThirst({v, 0})

    local player = vRP.getUserSource({v})
    if player ~= nil then
      vRPclient.setHealth(player, {200})
    end
  end
end
task_god()

local ch_godmode = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    if gods[player] then
	  gods[player] = nil
	  vRPclient.notify(player,{"~r~Godmode deactivated."})
	else
	  gods[player] = user_id
	  vRPclient.notify(player,{"~g~Godmode activated."})
	end
  end
end, "Toggles admin godmode."}

local player_lists = {}
local ch_userlist = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    if player_lists[player] then -- hide
      player_lists[player] = nil
      vRPclient.removeDiv(player,{"user_list"})
    else -- show
      local content = "<span class=\"id\">ID</span><span class=\"pseudo\">NICKNAME</span><span class=\"name\">ROLEPLAY NAME</span><span class=\"job\">PROFESSION</span>"
      --local content = "<span class=\"id\">ID</span><span class=\"pseudo\">NICKNAME</span><span class=\"name\">ROLEPLAY NAME</span>"
      local count = 0
	  local users = vRP.getUsers({})
      for k,v in pairs(users) do
        count = count+1
        local source = vRP.getUserSource({k})
        vRP.getUserIdentity({k, function(identity)
		  if source ~= nil then
            content = content.."<br /><span class=\"id\">"..k.."</span><span class=\"pseudo\">"..vRP.getPlayerName({source}).."</span>"
            if identity then
              content = content.."<span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span><span class=\"job\">"..vRP.getUserGroupByType({k,"job"}).."</span>"
              --content = content.."<span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span>"
            end
          end
		  
          -- check end
          count = count-1
          if count == 0 then
            player_lists[player] = true
            local css = [[
              .div_user_list{ 
                margin: auto; 
				text-align: left;
                padding: 8px; 
                width: 650px; 
                margin-top: 100px; 
                background: rgba(50,50,50,0.0); 
                color: white; 
                font-weight: bold; 
                font-size: 1.1em;
              } 
              .div_user_list span{ 
				display: inline-block;
				text-align: center;
              } 
              .div_user_list .id{ 
                color: rgb(255, 255, 255);
                width: 45px; 
              }
              .div_user_list .pseudo{ 
                color: rgb(66, 244, 107);
                width: 145px; 
              }
              .div_user_list .name{ 
                color: rgb(92, 170, 249);
                width: 295px; 
              }
			  .div_user_list .job{ 
                color: rgb(247, 193, 93);
                width: 145px; 
			  }
            ]]
            vRPclient.setDiv(player,{"user_list", css, content})
          end
		end})
      end
    end
  end
end, "Toggles Userlist."}

function vRPbm.chargePhoneNumber(user_id,phone)
  local player = vRP.getUserSource({user_id})
  local directory_name = vRP.getPhoneDirectoryName({user_id, phone})
  if directory_name == "unknown" then
	directory_name = phone
  end
  vRP.prompt({player,"Amount to be charged to "..directory_name..":","0",function(player,charge)
	if charge ~= nil and charge ~= "" and tonumber(charge)>0 then 
	  vRP.getUserByPhone({phone, function(target_id)
		if target_id~=nil then
			if charge ~= nil and charge ~= "" then 
	          local target = vRP.getUserSource({target_id})
			  if target ~= nil then
				vRP.getUserIdentity({user_id, function(identity)
				  local my_directory_name = vRP.getPhoneDirectoryName({target_id, identity.phone})
				  if my_directory_name == "unknown" then
				    my_directory_name = identity.phone
				  end
			      local text = "~b~" .. my_directory_name .. "~w~ is charging you ~r~$" .. charge .. "~w~ for his services."
				  vRP.request({target,text,600,function(req_player,ok)
				    if ok then
					  local target_bank = vRP.getBankMoney({target_id}) - tonumber(charge)
					  local my_bank = vRP.getBankMoney({user_id}) + tonumber(charge)
		              if target_bank>0 then
					    vRP.setBankMoney({user_id,my_bank})
					    vRP.setBankMoney({target_id,target_bank})
					    vRPclient.notify(player,{"You charged ~y~$"..charge.." ~w~from ~b~"..directory_name .."~w~ for your services."})
						vRPclient.notify(target,{"~b~"..my_directory_name.."~w~ charged you ~r~$"..charge.."~w~ for his services."})
					    --vRPbm.logInfoToFile("mchargeLog.txt",user_id .. " mobile charged "..target_id.." the amount of " .. charge .. ", user bank post-payment for "..user_id.." equals $"..my_bank.." and for "..user_id.." equals $"..target_bank)
					    vRP.closeMenu({player})
                      else
                        vRPclient.notify(target,{lang.money.not_enough()})
                        vRPclient.notify(player,{"~b~" .. directory_name .. "~w~ tried to, but~r~ can't~w~ pay for your services."})
                      end
				    else
                      vRPclient.notify(player,{"~b~" .. directory_name .. "~r~ refused~w~ to pay for your services."})
				    end
				  end})
				end})
			  else
			    vRPclient.notify(player,{"~r~You can't make charges to offline players."})
			  end
			else
			  vRPclient.notify(player,{"~r~Your charge has to have a value."})
			end
		else
		  vRPclient.notify(player,{"~r~That phone number seems invalid."})
		end
	  end})
	else
	  vRPclient.notify(player,{"~r~The value has to be bigger than 0."})
	end
  end})
end

function vRPbm.payPhoneNumber(user_id,phone)
  local player = vRP.getUserSource({user_id})
  local directory_name = vRP.getPhoneDirectoryName({user_id, phone})
  if directory_name == "unknown" then
	directory_name = phone
  end
  vRP.prompt({player,directory_name.."에게 보낼 금액을 입력하세요 :","",function(player,transfer)
	if transfer ~= nil and transfer ~= "" and tonumber(transfer)>0 then 
    if tonumber(transfer) < 10000000000 then
      
	  vRP.getUserByPhone({phone, function(target_id)
    local susuryo = tonumber(transfer/100*2)
    local my_bank = vRP.getBankMoney({user_id}) - tonumber(transfer) - susuryo
		if target_id ~= nil then
    if my_bank >= 0 then
      local target = vRP.getUserSource({target_id})
			if target ~= nil then
			  vRP.setBankMoney({user_id,my_bank})
        vRPclient.notify(player,{"~g~"..transfer.."$~w~를 "..directory_name.."에게 송금하였습니다.\n~r~수수료 2% 공제"})
			  local target_bank = vRP.getBankMoney({target_id}) + tonumber(transfer)
        vRP.AddToCompany({1,tonumber(susuryo)})
			  vRP.setBankMoney({target_id,math.ceil(target_bank)})
			  vRPbm.logInfoToFile("moneyLog.txt","고유번호 "..user_id .. "이(가) "..target_id.."에게 " .. transfer .. "$를 송금 하였음. 고유번호 "..user_id.."의 계좌 잔액은 "..my_bank.."$이며 고유번호 "..user_id.." 의 계좌 잔액은"..target_bank.."$")
			  vRP.getUserIdentity({user_id, function(identity)
		        local my_directory_name = vRP.getPhoneDirectoryName({target_id, identity.phone})
			    if my_directory_name == "unknown" then
		          my_directory_name = identity.phone
			    end
              --vRPclient.notify(target,{"~g~"..transfer.."$~w~를 "..my_directory_name.."부터 송금받았습니다.\n~r~수수료 2% 공제"})
              vRPclient.notify(target,{"~g~"..transfer.."$~w~를 "..my_directory_name.."부터 송금받았습니다."})
			  end})
              vRP.closeMenu({player})
        

    
        
			else
			  vRPclient.notify(player,{"~r~접속중인 플레이어에게만 송금 가능합니다."})
			end
    else
      vRPclient.notify(player,{lang.money.not_enough()})
    end
		else
		  vRPclient.notify(player,{"~r~계좌번호(전화번호)를 찾을 수 없습니다."})
		end
  end})
    else
      vRPclient.notify(player,{"~r~100억 이상은 송금할 수 없습니다!"})
    end
	else
	  vRPclient.notify(player,{"~r~0원은 송금할 수 없습니다!"})
	end
  

  
  
  
  end})
end

-- mobilepay
local ch_mobilepay = {function(player,choice) 
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = lang.phone.directory.title()
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	menu["> 계좌번호를 입력하세요."] = {
	  -- payment function
	  function(player,choice) 
	    vRP.prompt({player,"전화번호 (계좌) :","",function(player,phone)
	      if phone ~= nil and phone ~= "" then 
		    vRPbm.payPhoneNumber(user_id,phone)
		  else
		    vRPclient.notify(player,{"~r~You have to digit a phone number."})
		  end
	    end})
	  end,""}
	local directory = vRP.getPhoneDirectory({user_id})
	for k,v in pairs(directory) do
	  menu[k] = {
	    -- payment function
	    function(player,choice) 
		  vRPbm.payPhoneNumber(user_id,v)
	    end
	  ,v} -- number as description
	end
	vRP.openMenu({player, menu})
end,"돈을 송금합니다."}

-- mobilecharge
local ch_mobilecharge = {function(player,choice) 
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = lang.phone.directory.title()
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	menu[">Type Number"] = {
	  -- payment function
	  function(player,choice) 
	    vRP.prompt({player,"Phone Number:","",function(player,phone)
	      if phone ~= nil and phone ~= "" then 
		    vRPbm.chargePhoneNumber(user_id,phone)
		  else
		    vRPclient.notify(player,{"~r~You have to digit a phone number."})
		  end
	    end})
	  end,"Type the phone number manually."}
	local directory = vRP.getPhoneDirectory({user_id})
	for k,v in pairs(directory) do
	  menu[k] = {
	    -- payment function
	    function(player,choice) 
		  vRPbm.chargePhoneNumber(user_id,v)
	    end
	  ,v} -- number as description
	end
	vRP.openMenu({player, menu})
end,"Charge money trough phone."}

-- spawn vehicle
local ch_spawnveh = {function(player,choice) 
	vRP.prompt({player,"Vehicle Model:","",function(player,model)
	  if model ~= nil and model ~= "" then 
	    BMclient.spawnVehicle(player,{model})
	  else
		vRPclient.notify(player,{"~r~You have to type a vehicle model."})
	  end
	end})
end,"Spawn a vehicle model."}

local ch_loan = {function(player,choice) 
  vRP.prompt({player,"대상 고유번호","",function(player,v)
        v = parseInt(v)
        if v ~= nil then
          local user_id = vRP.getUserId({tonumber(player)})
          local loanlimit = vRP.getLoanLimit({tonumber(v)})
            if user_id ~= nil then
              vRP.prompt({player,"대출 금액 (현재 고객 대출한도: "..loanlimit.." $)","",function(player,loan)
                if loan ~= nil then
                  local target = vRP.getUserSource({tonumber(v)})
                    if target ~= nil then
                          vRP.request({target,"금융설계사 ".. GetPlayerName(player).."님께서 이자 6% ".. loan .."$ 대출 계약을 요청합니다.", 30, function(target,ok)
                          if ok then
                            local ll = tonumber(vRP.getLoanLimit({tonumber(v)}))
                            local CR = tonumber(vRP.getCR({tonumber(v)}))
                            local loanper = tonumber(loan)/100*6
                            local AL = tonumber(vRP.getLoan({tonumber(v)}))
                            if (tonumber(loan) <= tonumber(ll)) then
                            --vRP.setLoan({v,math.ceil(tonumber(AL)+tonumber(loan)+loanper)})
                            vRP.setLoan({v,math.ceil(tonumber(AL)+tonumber(loan))})
                            vRP.setLoanLimit({v,loanlimit-loan})
                            vRP.setCR({v,CR+0.10})
                            vRP.giveBankMoney({v,tonumber(loan)})
                            vRPclient.notify(player,{"~g~고객이 대출 계약을 수락하였습니다!"})
                            vRPclient.notify(target,{"~g~대출 계약을 수락하였습니다!"})
                            vRPclient.notifyPicture(target,{"CHAR_BANK_MAZE",1,"엘리시움 중앙은행",false,"대출금 지급 : ~g~"..loan.."$"})
                            vRPclient.notify(target,{"대출금 중도 및 전액상환은 ATM에서 가능합니다."})
                            vRPclient.notify(target,{"대출로 인하여 신용등급이 \n~r~하락~w~하였습니다!\n~r~(0.10 포인트)"})
                            
                            else
                            vRPclient.notify(player,{"~r~고객의 대출한도가 부족합니다."})
                            vRPclient.notify(target,{"~r~대출한도가 부족합니다!"})
                            end
                          else
														vRPclient.notify(player,{"~r~고객이 대출 계약 요청을 거절하였습니다."})
														vRPclient.notify(target,{"~r~대출 계약 요청을 거절하였습니다."})
													end
												end})
                    else
                    end
                else
                vRPclient.notify(player,{"~r~대출 실패"})
                end   
          
              end})
            end
        else
                vRPclient.notify(player,{"~r~대출 실패"})
        end     
  end})
end,"대출을 계약합니다."}

local ch_loanlimitedit = {function(player,choice) 
vRP.prompt({player,"대상 고유번호 (대출한도 기준 이내 수정 요망)","",function(player,v)
      v = parseInt(v)
        if v ~= nil then
          local user_id = vRP.getUserId({player})
          local loanlimit = tonumber(vRP.getLoanLimit({tonumber(v)}))
          local CR1 = tonumber(vRP.getCR({tonumber(v)}))
          local CR2 = math.ceil(CR1 * 10^2 - 0.5 ) / 10^2
            if user_id ~= nil then
              vRP.prompt({player,"변경할 대출한도 (현재 고객 대출한도/신용등급 : "..loanlimit.."$ "..CR2.." 등급)","",function(player,newloanlimit)
                if newloanlimit then
                  
                          vRP.setLoanLimit({v,math.ceil(tonumber(newloanlimit))})
                          vRPclient.notify(player,{"고객의 대출한도를 \n"..newloanlimit.."$로 수정하였습니다."})
                        --end
                      --end
                      
                else
              vRPclient.notify(player,{"~r~조회 실패"})
                end   
          
              end})
            end
        else
        vRPclient.notify(player,{"~r~조회 실패"})
        end     
  end})
end,"대출한도를 조정합니다."}

local ch_CRedit = {function(player,choice) 
vRP.prompt({player,"대상 고유번호","",function(player,v)
      v = parseInt(v)
        if v ~= nil then
          local user_id = vRP.getUserId({player})
          local CR1 = tonumber(vRP.getCR({tonumber(v)}))
          local CR2 = math.ceil(CR1 * 10^2 - 0.5 ) / 10^2
            if user_id ~= nil then
              vRP.prompt({player,"변경할 신용등급 (현재 고객 신용등급 : "..CR2.." 등급)","",function(player,newcr)
                if newcr then
                          vRP.setCR({v,tonumber(newcr)})
                          vRPclient.notify(player,{"고객의 신용등급을 \n"..newcr.." 등급으로 수정하였습니다."})
                        --end
                      --end
                else
              vRPclient.notify(player,{"~r~조회 실패"})
                end   
              end})
            end
        else
        vRPclient.notify(player,{"~r~조회 실패"})
        end     
  end})
end,"신용등급을 조정합니다."}

local ch_CRcheck = {function(player,choice) 
	vRP.prompt({player,"Vehicle Model:","",function(player,target_id)
    if target_id ~= nil and target_id ~= "" then
      local checkCR1 = vRP.getCR({tonumber(target_id)})
      local checkCR2 = math.ceil( checkCR1 * 10^2 - 0.5 ) / 10^2
      vRPclient.notify(player,{"조회하신 고객의 신용등급은\n~y~"..checkCR2.." 등급 ~w~ 입니다."})
      else
      vRPclient.notify(player,{"~r~조회 실패"})
      end
	end})
end,"신용등급 조회합니다."}

local ch_loanlimitcheck = {function(player,choice) 
	vRP.prompt({player,"Vehicle Model:","",function(player,target_id)
    if target_id ~= nil and target_id ~= "" then
      local loanlimit = vRP.getLoanLimit({tonumber(target_id)})
      vRPclient.notify(player,{"조회하신 고객의 대출한도은\n~y~" ..math.ceil(loanlimit).." $~w~ 입니다."})
      else
      vRPclient.notify(player,{"~r~조회 실패"})
      end
	end})
end,"대출한도를 조회합니다."}

local ch_loancheck = {function(player,choice) 
	vRP.prompt({player,"Vehicle Model:","",function(player,target_id)
    if target_id ~= nil and target_id ~= "" then
      local loan = vRP.getLoan({tonumber(target_id)})
      vRPclient.notify(player,{"조회하신 고객의 기대출은\n~y~" ..loan.." $~w~ 입니다."})
      else
      vRPclient.notify(player,{"~r~조회 실패"})
      end
	end})
end,"기대출을 조회합니다."}

local ch_prsaw1 = {function(player,choice) 
	vRP.prompt({player,"영장발부 사유 :","",function(player,reason)
    if reason ~= nil and reason ~= "" then
      local user_id = vRP.getUserId({player})
      vRP.giveInventoryItem({user_id,"aw1",1,true})
      vRP.prslog("prslog.txt"," " .. user_id .. " 구속영장 | " ..reason)
      vRPclient.notify(player,{"구속영장이 발부되었습니다. 인벤토리를 확인하세요."})
      else
      vRPclient.notify(player,{"~r~발부 실패"})
      end
	end})
end,"구속영장을 발부합니다."}

local ch_prsaw2 = {function(player,choice) 
	vRP.prompt({player,"영장발부 사유 :","",function(player,reason)
    if reason ~= nil and reason ~= "" then
      local user_id = vRP.getUserId({player})
      vRP.giveInventoryItem({user_id,"aw2",1,true})
      vRP.prslog("prslog.txt"," " .. user_id .. " 체포영장 | " ..reason)
      vRPclient.notify(player,{"체포영장이 발부되었습니다. 인벤토리를 확인하세요."})
      else
      vRPclient.notify(player,{"~r~발부 실패"})
      end
	end})
end,"체포영장을 발부합니다."}

local ch_prsaw3 = {function(player,choice) 
	vRP.prompt({player,"영장발부 사유 :","",function(player,reason)
    if reason ~= nil and reason ~= "" then
      local user_id = vRP.getUserId({player})
      vRP.giveInventoryItem({user_id,"aw3",1,true})
      vRP.prslog("prslog.txt"," " .. user_id .. " 수색영장 | " ..reason)
      vRPclient.notify(player,{"수색영장이 발부되었습니다. 인벤토리를 확인하세요."})
      else
      vRPclient.notify(player,{"~r~발부 실패"})
      end
	end})
end,"수색영장을 발부합니다."}

local ch_company1 = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if vRP.hasPermission({user_id,"elysium.company.akh.executive"}) then
  vRP.getUserCompany({1, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.mzh.executive"}) then
  vRP.getUserCompany({3, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.emm.executive"}) then
  vRP.getUserCompany({6731, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end
if vRP.hasPermission({user_id,"elysium.company.housebeer.executive"}) then
  vRP.getUserCompany({14, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end
if vRP.hasPermission({user_id,"elysium.company.taxi.executive"}) then
  vRP.getUserCompany({4728, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end
if vRP.hasPermission({user_id,"elysium.company.ia.executive"}) then
  vRP.getUserCompany({3168, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end
if vRP.hasPermission({user_id,"elysium.company.sb.executive"}) then
  vRP.getUserCompany({2040, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end
if vRP.hasPermission({user_id,"elysium.company.palace.executive"}) then
  vRP.getUserCompany({3298, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end
if vRP.hasPermission({user_id,"elysium.company.cbs.executive"}) then
  vRP.getUserCompany({2878, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end
if vRP.hasPermission({user_id,"elysium.company.casino.executive"}) then
  vRP.getUserCompany({281, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.ems.executive"}) then
  vRP.getUserCompany({119, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.jungmunpa.executive"}) then
  vRP.getUserCompany({9, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.khg.executive"}) then
  vRP.getUserCompany({83, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.esp.executive"}) then
  vRP.getUserCompany({888, function(company)
  if company ~= nil then
  name = htmlEntities.encode(company.name)
  capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 자산 :",capital.."$",function(player,reason)
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

end,"회사 자산을 확인합니다."}




local ch_company2 = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if vRP.hasPermission({user_id,"elysium.company.akh"}) then
  local company_id = 1
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
      vRPclient.notify(player,{"~r~입금 완료."})
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.mzh"}) then
  local company_id = 3
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
      vRPclient.notify(player,{"~r~입금 완료."})
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.emm"}) then
  local company_id = 6731
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.housebeer"}) then
  local company_id = 14
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  
  if vRP.hasPermission({user_id,"elysium.company.ia"}) then
  local company_id = 3168
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.taxi"}) then
  local company_id = 4728
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.sb"}) then
  local company_id = 2040
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.palace"}) then
  local company_id = 3298
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.cbs"}) then
  local company_id = 2878
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.casino"}) then
  local company_id = 281
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.ems"}) then
  local company_id = 119
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.jungmunpa"}) then
  local company_id = 9
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.khg"}) then
  local company_id = 83
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end
  
  if vRP.hasPermission({user_id,"elysium.company.esp"}) then
  local company_id = 888
  vRP.getUserCompany({company_id, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에 얼마를 입금하시겠습니까? :","",function(player,price)
    if price ~= nil then
    vRP.prompt({player,name.." 자금의 출처는 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    if vRP.tryDepositToCompany({user_id,company_id,tonumber(price)}) then
      vRPclient.notify(player,{"~r~입금 완료."})
      vRP.prslog("companylog.txt",name.." ".. price .."$ 입금 | ".. reason .." | 고유번호 ".. user_id)
    else
      vRPclient.notify(player,{"~r~입금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~자금 출처를 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~정확한 금액을 입력해주세요."})
    end
	end})
  else
  --vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
    end})
  end

end,"법인 계좌에 입금합니다."}



local ch_company3 = {function(player,choice)
  local user_id = vRP.getUserId({player})
  
  if vRP.hasPermission({user_id,"elysium.company.akh.executive"}) then
  local withdrawcompanyid = 1
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .. " | "..user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.mzh.executive"}) then
  local withdrawcompanyid = 3
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .. " | "..user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.emm.executive"}) then
  local withdrawcompanyid = 6731
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.housebeer.executive"}) then
  local withdrawcompanyid = 14
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.ia.executive"}) then
  local withdrawcompanyid = 3168
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.taxi.executive"}) then
  local withdrawcompanyid = 4728
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.sb.executive"}) then
  local withdrawcompanyid = 2040
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.palace.executive"}) then
  local withdrawcompanyid = 3298
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.cbs.executive"}) then
  local withdrawcompanyid = 2878
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.casino.executive"}) then
  local withdrawcompanyid = 281
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

  if vRP.hasPermission({user_id,"elysium.company.ems.executive"}) then
  local withdrawcompanyid = 119
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.jungmunpa.executive"}) then
  local withdrawcompanyid = 9
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.khg.executive"}) then
  local withdrawcompanyid = 83
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end

if vRP.hasPermission({user_id,"elysium.company.esp.executive"}) then
  local withdrawcompanyid = 888
  vRP.getUserCompany({withdrawcompanyid, function(company)
  if company ~= nil then
  local name = htmlEntities.encode(company.name)
  local capital = htmlEntities.encode(company.capital)
  vRP.prompt({player,name.." 계좌에서 얼마를 출금하시겠습니까? :","",function(player,price)
    if price ~= nil and tonumber(price) <= tonumber(capital) then
    vRP.prompt({player,name.." 사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil or reason == "" then
    if vRP.tryWithdrawToCompany({user_id,withdrawcompanyid,tonumber(price)}) then
      vRP.prslog("companylog.txt",name.." ".. price .."$ 출금 | ".. reason .." | ".. user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
    end
	end})
  else
  vRPclient.notify(player,{"~r~회사를 소유하고 있지 않습니다."})
  end
end})
end
end,"법인 계좌에서 출금합니다."}


local ch_president1 = {function(player,choice)
  local user_id = vRP.getUserId({player})
  vRP.getTax({function(tax)
  alltax = tonumber(tax.statecoffers)
  if alltax ~= nil then
  vRP.prompt({player,"국고 :",alltax.."$",function(player,reason)
	end})
  else
  
  end
end})
end,"정부 예산을 확인합니다."}

local ch_president2 = {function(player,choice)
  local user_id = vRP.getUserId({player})
  vRP.getTax({function(tax)
  alltax = tonumber(tax.statecoffers)
  vRP.prompt({player,"국고에서 얼마를 출금하시겠습니까? 최대 $"..alltax.." :","",function(player,price)
    if price ~= nil and tonumber(price) <= alltax then
    vRP.prompt({player,"사용 목적은 어떻게 됩니까? :","",function(player,reason)
    if reason ~= nil then
    if vRP.tryWithdrawToTax({user_id,tonumber(price)}) then
      vRP.prslog("taxlog.txt","총리부 국고 | ".. price .."$ 출금 | ".. reason .. " | "..user_id)
      vRPclient.notify(player,{"~r~출금 완료."})
    else
      vRPclient.notify(player,{"~r~출금 실패."})
    end
    else
    vRPclient.notify(player,{"~r~사용 목적을 정확히 입력해주세요."})
    end
    end})
    else
    vRPclient.notify(player,{"~r~국고가 부족하거나 잘못된 금액입니다."})
    end
	end})
end})
end,"정부 예산을 출금합니다."}


-- lockpick vehicle
local ch_lockpickveh = {function(player,choice) 
	BMclient.lockpickVehicle(player,{20,true}) -- 20s to lockpick, allow to carjack unlocked vehicles (has to be true for NoCarJack Compatibility)
end,"Lockpick closest vehicle."}

-- dynamic freeze
local ch_freeze = {function(player,choice) 
	local user_id = vRP.getUserId({player})
	if vRP.hasPermission({user_id,"admin.bm_freeze"}) then
	  vRP.prompt({player,"Player ID:","",function(player,target_id) 
	    if target_id ~= nil and target_id ~= "" then 
	      local target = vRP.getUserSource({tonumber(target_id)})
		  if target ~= nil then
		    vRPclient.notify(player,{"~g~You un/froze that player."})
		    BMclient.loadFreeze(target,{true,true,true})
		  else
		    vRPclient.notify(player,{"~r~That ID seems invalid."})
		  end
        else
          vRPclient.notify(player,{"~r~No player ID selected."})
        end 
	  end})
	else
	  vRPclient.getNearestPlayer(player,{10},function(nplayer)
        local nuser_id = vRP.getUserId({nplayer})
        if nuser_id ~= nil then
		  vRPclient.notify(player,{"~g~You un/froze that player."})
		  BMclient.loadFreeze(nplayer,{true,false,false})
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      end)
	end
end,"Freezes a player."}



-- lockpicking item
vRP.defInventoryItem({"lockpicking_kit","Lockpicking Kit","Used to lockpick vehicles.", -- add it for sale to vrp/cfg/markets.lua if you want to use it
function(args)
  local choices = {}

  choices["Lockpick"] = {function(player,choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      if vRP.tryGetInventoryItem({user_id, "lockpicking_kit", 1, true}) then
		BMclient.lockpickVehicle(player,{20,true}) -- 20s to lockpick, allow to carjack unlocked vehicles (has to be true for NoCarJack Compatibility)
        vRP.closeMenu({player})
      end
    end
  end,"Lockpick closest vehicle."}

  return choices
end,
5.00})

-- ADD STATIC MENU CHOICES // STATIC MENUS NEED TO BE ADDED AT vRP/cfg/gui.lua
vRP.addStaticMenuChoices({"police_weapons", police_weapons}) -- police gear
vRP.addStaticMenuChoices({"emergency_medkit", emergency_medkit}) -- pills and medkits
vRP.addStaticMenuChoices({"emergency_heal", emergency_heal}) -- heal button

-- REMEMBER TO ADD THE PERMISSIONS FOR WHAT YOU WANT TO USE
-- CREATES PLAYER SUBMENU AND ADD CHOICES


local ch_loan_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = "LOAN"
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	
    if vRP.hasPermission({user_id,"elysium.bankjob"}) then
      menu["기대출 조회"] = ch_loancheck
    end
    
    if vRP.hasPermission({user_id,"elysium.bankjob"}) then
      menu["대출한도 조회"] = ch_loanlimitcheck
    end
    
    if vRP.hasPermission({user_id,"elysium.bankjob"}) then
      menu["신용등급 조회"] = ch_CRcheck
    end
    
    if vRP.hasPermission({user_id,"elysium.bankjob"}) then
      menu["대출한도 조정"] = ch_loanlimitedit
    end
    
    if vRP.hasPermission({user_id,"elysium.bankjob"}) then
      menu["신용등급 조정"] = ch_CRedit
    end
  
    if vRP.hasPermission({user_id,"elysium.bankjob"}) then
      menu["대출 계약"] = ch_loan
    end
	
	vRP.openMenu({player, menu})
end}



local ch_company_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
  local menu = {}
  
  
  
  if vRP.hasPermission({user_id,"elysium.company.akh"}) then
  companyid = 1
  end
  if vRP.hasPermission({user_id,"elysium.company.mzh"}) then
  companyid = 3
  end
  if vRP.hasPermission({user_id,"elysium.company.emm"}) then
  companyid = 6731
  end
  if vRP.hasPermission({user_id,"elysium.company.housebeer"}) then
  companyid = 14
  end
  if vRP.hasPermission({user_id,"elysium.company.ia"}) then
  companyid = 3168
  end
  if vRP.hasPermission({user_id,"elysium.company.sb"}) then
  companyid = 2040
  end
  if vRP.hasPermission({user_id,"elysium.company.palace"}) then
  companyid = 3298
  end
  if vRP.hasPermission({user_id,"elysium.company.cbs"}) then
  companyid = 4912
  end
  if vRP.hasPermission({user_id,"elysium.company.casino"}) then
  companyid = 281
  end
  if vRP.hasPermission({user_id,"elysium.company.taxi"}) then
  companyid = 4728
  end
  if vRP.hasPermission({user_id,"elysium.company.ems"}) then
  companyid = 119
  end
  if vRP.hasPermission({user_id,"elysium.company.jungmunpa"}) then
  companyid = 9
  end
  if vRP.hasPermission({user_id,"elysium.company.khg"}) then
  companyid = 83
  end
  if vRP.hasPermission({user_id,"elysium.company.esp"}) then
  companyid = 888
  end





  vRP.getUserCompany({companyid, function(company)
    menu.name = company.name
    menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	
    if vRP.hasPermission({user_id,"elysium.company.ceo"}) then
      menu["법인 계좌 조회"] = ch_company1
    end
    
    if vRP.hasPermission({user_id,"elysium.company"}) then
      menu["법인 계좌 입금"] = ch_company2
    end
    
    if vRP.hasPermission({user_id,"elysium.company.ceo"}) then
      menu["법인 계좌 출금"] = ch_company3
    end
    vRP.openMenu({player, menu})
    end})
end}


local ch_prs_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = "검찰"
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	
    if vRP.hasPermission({user_id,"elysium.prsjob"}) then
      menu["구속영장 발부"] = ch_prsaw1
    end
    
    if vRP.hasPermission({user_id,"elysium.prsjob"}) then
      menu["체포영장 발부"] = ch_prsaw2
    end
    
    if vRP.hasPermission({user_id,"elysium.prsjob"}) then
      menu["수색영장 발부"] = ch_prsaw3
    end
	
	vRP.openMenu({player, menu})
end}


local ch_president_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = "엘리시움 총리부"
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	
    if vRP.hasPermission({user_id,"elysium.president"}) then
      menu["예산 조회"] = ch_president1
    end
    
    if vRP.hasPermission({user_id,"elysium.president"}) then
      menu["예산 출금"] = ch_president2
    end
	
	vRP.openMenu({player, menu})
end}


local ch_player_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = "Player"
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	
    --if vRP.hasPermission({user_id,"player.store_money"}) then
    --  menu["인벤토리에 돈 저장"] = choice_store_money -- transforms money in wallet to money in inventory to be stored in houses and cars
    --end
	
    if vRP.hasPermission({user_id,"player.fix_haircut"}) then
      menu["Fix Haircut"] = ch_fixhair -- just a work around for barbershop green hair bug while I am busy
    end
	
    if vRP.hasPermission({user_id,"player.userlist"}) then
      menu["접속 유저 목록"] = ch_userlist -- a user list for players with vRP ids, player name and identity names only.
    end
	
    if vRP.hasPermission({user_id,"player.store_weapons"}) then
      menu["Store weapons"] = choice_store_weapons -- store player weapons, like police store weapons from vrp
    end
	
    if vRP.hasPermission({user_id,"player.store_armor"}) then
      menu["Store armor"] = choice_store_armor -- store player armor
    end
	
    if vRP.hasPermission({user_id,"player.check"}) then
      menu["Inspect"] = choice_player_check -- checks nearest player inventory, like police check from vrp
    end
	
	vRP.openMenu({player, menu})
end}

-- REGISTER MAIN MENU CHOICES
vRP.registerMenuBuilder({"main", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}
	
    if vRP.hasPermission({user_id,"player.player_menu"}) then
      choices["플레이어"] = ch_player_menu -- opens player submenu
    end
    
    --[[
    if vRP.hasPermission({user_id,"elysium.bankjob"}) then
      choices["*금융업"] = ch_loan_menu -- opens player submenu
    end
    --]]
    
    if vRP.hasPermission({user_id,"elysium.prsjob"}) then
      choices["*검찰"] = ch_prs_menu -- opens player submenu
    end
    
    if vRP.hasPermission({user_id,"elysium.president"}) then
      choices["*총리부"] = ch_president_menu -- opens player submenu
    end
    
    if vRP.hasPermission({user_id,"elysium.company"}) then
      choices["*회사"] = ch_company_menu -- opens player submenu
    end
    
    if vRP.hasPermission({user_id,"toggle.service"}) then
      choices["*호출 ON/OFF"] = choice_service -- toggle the receiving of missions
    end
	
    if vRP.hasPermission({user_id,"player.loot"}) then
      choices["루팅"] = choice_loot -- take the items of nearest player in coma
    end
	
    if vRP.hasPermission({user_id,"mugger.mug"}) then
      choices["Mug"] = ch_mug -- steal nearest player wallet
    end
	
    if vRP.hasPermission({user_id,"hacker.hack"}) then
      choices["해킹"] = ch_hack --  1 in 100 chance of stealing 1% of nearest player bank
    end
	
    if vRP.hasPermission({user_id,"carjacker.lockpick"}) then
      choices["Lockpick"] = ch_lockpickveh -- opens a locked vehicle
    end
    

	
    add(choices)
  end
end})

-- RESGISTER ADMIN MENU CHOICES
vRP.registerMenuBuilder({"admin", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}
	
	if vRP.hasPermission({user_id,"admin.deleteveh"}) then
      choices["*차량 삭제"] = ch_deleteveh -- Delete nearest vehicle (Fixed pull request https://github.com/Sighmir/vrp_basic_menu/pull/11/files/419405349ca0ad2a215df90cfcf656e7aa0f5e9c from benjatw)
	end
	
	if vRP.hasPermission({user_id,"admin.spawnveh"}) then
      choices["*차량 소환"] = ch_spawnveh -- Spawn a vehicle model
	end
	
	if vRP.hasPermission({user_id,"admin.godmode"}) then
      choices["Godmode"] = ch_godmode -- Toggles admin godmode (Disable the default admin.god permission to use this!) 
	end
	
    if vRP.hasPermission({user_id,"player.blips"}) then
      choices["Blips"] = ch_blips -- turn on map blips and sprites
    end
	
    if vRP.hasPermission({user_id,"player.sprites"}) then
      choices["Sprites"] = ch_sprites -- turn on only name sprites
    end
	
    if vRP.hasPermission({user_id,"admin.crun"}) then
      choices["Crun"] = ch_crun -- run any client command, any GTA V client native http://www.dev-c.com/nativedb/
    end
	
    if vRP.hasPermission({user_id,"admin.srun"}) then
      choices["Srun"] = ch_srun -- run any server command, any GTA V server native http://www.dev-c.com/nativedb/
    end

	if vRP.hasPermission({user_id,"player.tptowaypoint"}) then
      choices["TpToWaypoint"] = choice_tptowaypoint -- teleport user to map blip
	end
	
	if vRP.hasPermission({user_id,"admin.easy_unjail"}) then
      choices["UnJail"] = ch_unjail -- Un jails chosen player if he is jailed (Use admin.easy_unjail as permission to have this in admin menu working in non jailed players)
    end
	
	if vRP.hasPermission({user_id,"admin.spikes"}) then
      choices["Spikes"] = ch_spikes -- Toggle spikes
    end
	
	if vRP.hasPermission({user_id,"admin.bm_freeze"}) then
      choices["Freeze"] = ch_freeze -- Toggle freeze
    end
	
    add(choices)
  end
end})

-- REGISTER POLICE MENU CHOICES
vRP.registerMenuBuilder({"police", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}
	
    if vRP.hasPermission({user_id,"police.store_money"}) then
      choices["Store money"] = choice_store_money -- transforms money in wallet to money in inventory to be stored in houses and cars
    end
	
	if vRP.hasPermission({user_id,"police.easy_jail"}) then
      choices["구금 하기"] = ch_jail -- Send a nearby handcuffed player to jail with prompt for choice and user_list
    end
	
	if vRP.hasPermission({user_id,"police.easy_unjail"}) then
      choices["구금 해제하기"] = ch_unjail -- Un jails chosen player if he is jailed (Use admin.easy_unjail as permission to have this in admin menu working in non jailed players)
    end
	
	if vRP.hasPermission({user_id,"police.easy_fine"}) then
      choices["벌금 부여하기"] = ch_fine -- Fines closeby player
    end
	
	if vRP.hasPermission({user_id,"police.easy_cuff"}) then
      choices["수갑 채우기"] = ch_handcuff -- Toggle cuffs AND CLOSE MENU for nearby player
    end
	
	if vRP.hasPermission({user_id,"police.spikes"}) then
      choices["스파이크 설치"] = ch_spikes -- Toggle spikes
    end
	
    if vRP.hasPermission({user_id,"police.drag"}) then
      choices["끌고 가기"] = ch_drag -- Drags closest handcuffed player
    end
	
	if vRP.hasPermission({user_id,"police.bm_freeze"}) then
      choices["Freeze"] = ch_freeze -- Toggle freeze
    end
	
    add(choices)
  end
end})

-- REGISTER PHONE MENU CHOICES
-- TO USE THIS FUNCTION YOU NEED TO HAVE THE ORIGINAL vRP UPDATED TO THE LASTEST VERSION
vRP.registerMenuBuilder({"phone", function(add) -- phone menu is created on server start, so it has no permissions.
    local choices = {} -- Comment the choices you want to disable by adding -- in front of them.
	
    choices["*토스"] = ch_mobilepay -- transfer money through phone
    --choices["M이체요청"] = ch_mobilecharge -- charge money through phone
	
    add(choices)
end})

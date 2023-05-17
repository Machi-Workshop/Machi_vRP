-- define some basic inventory items

local items = {}

local function play_eat(player)
  local seq = {
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
  }

  vRPclient.playAnim(player,{true,seq,false})
end

local function play_drink(player)
  local seq = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq,false})
end

-- gen food choices as genfunc
-- idname
-- ftype: eat or drink
-- vary_hunger
-- vary_thirst
local function gen(ftype, vary_hunger, vary_thirst)
  local fgen = function(args)
    local idname = args[1]
    local choices = {}
    local act = "Unknown"
    if ftype == "eat" then act = "먹기" elseif ftype == "drink" then act = "마시기" end
    local name = vRP.getItemName(idname)

    choices[act] = {function(player,choice)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,idname,1,false) then
          if vary_hunger ~= 0 then vRP.varyHunger(user_id,vary_hunger) end
          if vary_thirst ~= 0 then vRP.varyThirst(user_id,vary_thirst) end

          if ftype == "drink" then
            vRPclient.notify(player,{"~b~"..name.." 마심."})
            play_drink(player)
          elseif ftype == "eat" then
            vRPclient.notify(player,{"~o~"..name.." 먹음."})
            play_eat(player)
          end

          vRP.closeMenu(player)
        end
      end
    end}

    return choices
  end

  return fgen
end



-- DRINKS --

items["water"] = {"생수","", gen("drink",0,-25),0.5}
items["milk"] = {"우유","", gen("drink",0,-5),0.5}
items["coffee"] = {"커피","", gen("drink",0,-10),0.2}
items["tea"] = {"홍차","", gen("drink",0,-15),0.2}
items["icetea"] = {"아이스티","", gen("drink",0,-20), 0.5}
items["orangejuice"] = {"오렌지 주스","", gen("drink",0,-25),0.5}
items["cocacola"] = {"코카-콜라","", gen("drink",0,-35),0.3}
items["redbull"] = {"레드불","", gen("drink",0,-40),0.3}
items["lemonade"] = {"레몬에이드","", gen("drink",0,-45),0.3}
items["vodka"] = {"보드카","", gen("drink",15,-65),0.5}
items["elixir"] = {"파워 엘릭서","", gen("drink",-100,-100),0}

--FOOD

-- create Breed item
items["bread"] = {"빵","", gen("eat",-10,0),0.5}
items["donut"] = {"도넛","", gen("eat",-15,0),0.2}
items["tacos"] = {"타코벨","", gen("eat",-20,0),0.2}
items["sandwich"] = {"샌드위치","", gen("eat",-25,0),0.5}
items["kebab"] = {"케밥","", gen("eat",-45,0),0.85}
items["pdonut"] = {"고급 도넛","", gen("eat",-25,0),0.5}
items["tofu"] = {"두부","", gen("eat",-25,0),0.5}
items["pizza"] = {"도미노피자","", gen("eat",-70,0),1.0}
items["catfish"] = {"메기","", gen("eat",10,15),0.3}
items["bass"] = {"베스","", gen("eat",10,15),0.3}

return items

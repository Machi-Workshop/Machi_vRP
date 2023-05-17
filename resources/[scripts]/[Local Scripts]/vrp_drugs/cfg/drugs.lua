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


local cfg = {}

--[[
TO MAKE A DRUG ADD IT TO cfg.drugs LIKE SO:
  ["itemid"] = {
    name = "Name", -- item name
    desc = "Some description.", -- item description
    choices = function(args) -- create choices
	  local menu = {} -- creates menu
      menu["Choice"] = {function(player,choice) -- menu choice function
  	    local user_id = vRP.getUserId({player}) -- get user id
  	    if user_id ~= nil then -- check user_id not nil
  	      if vRP.tryGetInventoryItem({user_id,"itemid",1,false}) then -- get item
            -- vRP.varyHunger({user_id,30}) -- optional
            -- vRP.varyThirst({user_id,-70}) -- optional
  		    -- vRPclient.varyHealth(player,{10}) -- optional
  		    vRPclient.notify(player,{"~g~Smoking weed."}) -- notify use
  		    local seq = { -- this should be the sequence of animation
  		    }
  		    vRPclient.playAnim(player,{true,seq,false}) -- play animation sequence
  		    SetTimeout(10000,function() -- here a timeout to for effect to start
  		      Dclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false}) -- start movement effect, check client.lua for info about the function
  		      Dclient.playScreenEffect(player, {"DMT_flight", 120}) -- start screen effect, check client.lua for info about the function
  		    end)
  		    SetTimeout(120000,function() -- here a timeout for movement effect to end, screen effect has timer on function
  			  Dclient.resetMovement(player,{false}) -- stop movement effect
  		    end)
  		    vRP.closeMenu({player}) -- close menu
  		  end
  	    end
  	  end}
	  return menu -- return choices
    end,
	weight = 0.1 -- item weight
  },
]]

cfg.drugs= {
  ["testtest"] = {
    name = "돔 페리뇽 로제",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["Smoke"] = {function(player,choice)
  	    local user_id = vRP.getUserId({player})
  	    if user_id ~= nil then
  	      if vRP.tryGetInventoryItem({user_id,"weed",1,false}) then
  		    vRPclient.varyHealth(player,{25})
  		    vRPclient.notify(player,{"~g~Smoking weed."})
  		    local seq = {
  		      {"mp_player_int_uppersmoke","mp_player_int_smoke_enter",1},
  		      {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
  		      {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
  		      {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
  		      {"mp_player_int_uppersmoke","mp_player_int_smoke_exit",1}
  		    }
  		    vRPclient.playAnim(player,{true,seq,false})
  		    SetTimeout(10000,function()
  		      Dclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false})
  		      Dclient.playScreenEffect(player, {"DMT_flight", 120})
  		    end)
  		    SetTimeout(120000,function()
  			  Dclient.resetMovement(player,{false})
  		    end)
  		    vRP.closeMenu({player})
  		  end
  	    end
  	  end}
	  return menu
    end,
	weight = 0.1
},

  ["soju1"] = {
    name = "참이슬",
    desc = "소주",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"soju1",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            --vRPclient.notify(player,{"~b~Drinking Sighmirnoff."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
  end,
weight = 0.5
},
["soju2"] = {
    name = "처음처럼",
    desc = "소주",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"soju2",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            --vRPclient.notify(player,{"~b~Drinking Sighmirnoff."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 0.5
},
["beer1"] = {
    name = "카스",
    desc = "맥주",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"beer1",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            --vRPclient.notify(player,{"~b~Drinking Sighmirnoff."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 0.5
},
["beer2"] = {
    name = "하이트",
    desc = "맥주",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"beer2",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            --vRPclient.notify(player,{"~b~Drinking Sighmirnoff."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 0.5
},
["beer3"] = {
    name = "피츠",
    desc = "맥주",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"beer3",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            --vRPclient.notify(player,{"~b~Drinking Sighmirnoff."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 0.5
},
  ["adb"] = {
    name = "아르망 드 브리냑",
    desc = "초고가 샴페인",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"adb",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~아르망 드 브리냑~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 3.2
  },
  ["dom"] = {
    name = "돔 페리뇽",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"dom",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~돔 페리뇽~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 3.2
  },
    ["absol"] = {
    name = "앱솔루트 보드카",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"absol",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~앱솔루트 보드카~w~를 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 2.5
},
    ["xrated"] = {
    name = "X-RATED",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"xrated",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~X-RATED~w~를 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 2.5
  },
    ["jager"] = {
    name = "예거마이스터",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"jager",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~예거마이스터~w~를 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 2.5
},
    ["moet"] = {
    name = "모엣 & 샹동",
    desc = "샤도네이 화이트 와인",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"moet",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~모엣 & 샹동~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 2.5
},


-- 삼합회 중국 바이주


["laimao1935"] = {
    name = "라이마오 1935년산",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"laimao1935",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~라이마오 1935년산~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
  },
  ["maotai1992"] = {
    name = "한띠 마오타이 1992년산",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"maotai1992",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~한띠 마오타이 1992년산~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
  },
["laimao1930"] = {
    name = "라이마오 1930년산",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"laimao1930",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~라이마오 1930년산~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
},
["fenjiu"] = {
    name = "펀지우",
    desc = "분주(汾酒)",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"fenjiu",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~펀지우~w~를 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
},
["maotai1956"] = {
    name = "마오타이 1956년산",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"maotai1956",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~마오타이 1956년산~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
},
["maotai1953"] = {
    name = "바퀴표 마오타이 1953년산",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"maotai1953",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~바퀴표 마오타이 1953년산~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
},
["maotai1958"] = {
    name = "우싱 마오타이 1958년산",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"maotai1958",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~우싱 마오타이 1958년산~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
  },
["wuliangye"] = {
    name = "우량예 1960년산",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"wuliangye",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~우량예 1960년산~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
  },
["guojiao"] = {
    name = "궈자오1573",
    desc = "",
    choices = function(args)
	  local menu = {}
      menu["마시기"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          if vRP.tryGetInventoryItem({user_id,"guojiao",1,false}) then
            vRP.varyHunger({user_id,30})
            vRP.varyThirst({user_id,-70})
  		    vRPclient.varyHealth(player,{10})

            vRPclient.notify(player,{"~b~궈자오1573~w~을 마셨습니다."})
            local seq = {
              {"mp_player_intdrink","intro_bottle",1},
              {"mp_player_intdrink","loop_bottle",1},
              {"mp_player_intdrink","outro_bottle",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
			SetTimeout(5000,function()
			  Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
			  Dclient.playScreenEffect(player, {"Rampage", 120})
			  SetTimeout(120000,function()
			    Dclient.resetMovement(player,{false})
			  end)
			end)
            vRP.closeMenu({player})
          end
        end
      end}
	  return menu
    end,
	weight = 1.5
},
 ["weed"] = {
    name = "대마초",
    desc = "",
    choices = function(args)
     local menu = {}
      menu["피우기"] = {function(player,choice)
         local user_id = vRP.getUserId({player})
         if user_id ~= nil then
           if vRP.tryGetInventoryItem({user_id,"weed",1,false}) then
            vRPclient.varyHealth(player,{25})
            vRPclient.notify(player,{"~g~대마를 피운다."})
            local seq = {
              {"mp_player_int_uppersmoke","mp_player_int_smoke_enter",1},
              {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
              {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
              {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
              {"mp_player_int_uppersmoke","mp_player_int_smoke_exit",1}
            }
            vRPclient.playAnim(player,{true,seq,false})
            SetTimeout(10000,function()
              Dclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false})
              Dclient.playScreenEffect(player, {"DMT_flight", 120})
            end)
            SetTimeout(120000,function()
             Dclient.resetMovement(player,{false})
            end)
            vRP.closeMenu({player})
          end
         end
       end}
     return menu
    end,
   weight = 0.10
},
["cocaine"] = {
  name = "코카인",
  desc = "",
  choices = function(args)
  local menu = {}
    menu["마시기"] = {function(player,choice)
      local user_id = vRP.getUserId({player})
      if user_id ~= nil then
        if vRP.tryGetInventoryItem({user_id,"cocaine",1,false}) then
          vRP.varyHunger({user_id,30})
          vRP.varyThirst({user_id,-70})
        vRPclient.varyHealth(player,{10})

          vRPclient.notify(player,{"~b~코카인~w~을 마셨습니다."})
          local seq = {
            {"mp_player_intdrink","intro_bottle",1},
            {"mp_player_intdrink","loop_bottle",1},
            {"mp_player_intdrink","outro_bottle",1}
          }
          vRPclient.playAnim(player,{true,seq,false})
    SetTimeout(5000,function()
      Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
      Dclient.playScreenEffect(player, {"Rampage", 120})
      SetTimeout(120000,function()
        Dclient.resetMovement(player,{false})
      end)
    end)
          vRP.closeMenu({player})
        end
      end
    end}
  return menu
  end,
weight = 0.2
},
["lsd"] = {
  name = "LSD",
  desc = "",
  choices = function(args)
  local menu = {}
    menu["투여한다"] = {function(player,choice)
      local user_id = vRP.getUserId({player})
      if user_id ~= nil then
        if vRP.tryGetInventoryItem({user_id,"lsd",1,false}) then
          vRP.varyHunger({user_id,30})
          vRP.varyThirst({user_id,-70})
        vRPclient.varyHealth(player,{10})

          vRPclient.notify(player,{"~b~LSD~w~을 몸에 투하했습니다."})
          local seq = {
            {"mp_player_intdrink","intro_bottle",1},
            {"mp_player_intdrink","loop_bottle",1},
            {"mp_player_intdrink","outro_bottle",1}
          }
          vRPclient.playAnim(player,{true,seq,false})
    SetTimeout(5000,function()
      Dclient.playMovement(player,{"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false})
      Dclient.playScreenEffect(player, {"Rampage", 120})
      SetTimeout(120000,function()
        Dclient.resetMovement(player,{false})
      end)
    end)
          vRP.closeMenu({player})
        end
      end
    end}
  return menu
  end,
weight = 0.1
},
}

return cfg

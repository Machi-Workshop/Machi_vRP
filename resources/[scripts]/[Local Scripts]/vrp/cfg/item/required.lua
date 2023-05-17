
local items = {}

items["medkit"] = {"의료 도구","Used to reanimate unconscious people.",nil,0.3}
items["dirty_money"] = {"검은 돈","Illegally earned money.",nil,0}
items["parcels"] = {"택배 소포","누군가의 소포다.",nil,0.10}
items["repairkit"] = {"수리 도구","Used to repair vehicles.",nil,0.5}



items["limitedavatar1"] = {"[아바타] 2B","횟수 제한 없이 사용 가능합니다.",function(args)
  local choices = {}
  local idname = args[1]

  choices["아바타 교체"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
            if vRP.CheckInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local custom = "2B"
            TriggerClientEvent("setCustomPeds", source, custom)
            end
          vRP.closeMenu(player)
    end
  end}

  return choices
end,0}

items["limitedavatar2"] = {"[아바타] A2","횟수 제한 없이 사용 가능합니다.",function(args)
  local choices = {}
  local idname = args[1]

  choices["아바타 교체"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
            if vRP.CheckInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local custom = "A2"
            TriggerClientEvent("setCustomPeds", source, custom)
            end
          vRP.closeMenu(player)
    end
  end}

  return choices
end,0}

items["limitedavatar3"] = {"[아바타] Ada Wong","횟수 제한 없이 사용 가능합니다.",function(args)
  local choices = {}
  local idname = args[1]

  choices["아바타 교체"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
            if vRP.CheckInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local custom = "AdaCasualB"
            TriggerClientEvent("setCustomPeds", source, custom)
            end
          vRP.closeMenu(player)
    end
  end}

  return choices
end,0}


items["aw2"] = {"체포 영장","엘리시움 대검찰청",function(args)
  local choices = {}
  local idname = args[1]

  choices["영장 사용"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "엘리시움 대검찰청에서 발부된 ^1체포 영장^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
            end
          vRP.closeMenu(player)
    end
  end}

  return choices
end,0}

items["aw1"] = {"구속 영장","엘리시움 대검찰청",function(args)
  local choices = {}
  local idname = args[1]

  choices["영장 사용"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "엘리시움 대검찰청에서 발부된 ^1구속 영장^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
            end
          vRP.closeMenu(player)
    end
  end}

  return choices
end,0}

items["aw3"] = {"수색 영장","엘리시움 대검찰청",function(args)
  local choices = {}
  local idname = args[1]

  choices["영장 사용"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "엘리시움 대검찰청에서 발부된 ^1수색 영장^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
            end
          vRP.closeMenu(player)
    end
  end}

  return choices
end,0}

items["elysiumid1"] = {"공무원증","엘리시움 총리부",function(args)
  local choices = {}
  local idname = args[1]
  choices["보여주기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "엘리시움 총리부에서 발급된 ^4공무원증^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
            end
          vRP.closeMenu(player)
    end
  end}
  return choices
end,0}

items["elysiumid2"] = {"경찰공무원증","엘리시움 경찰청",function(args)
  local choices = {}
  local idname = args[1]
  choices["보여주기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "엘리시움 경찰청에서 발급된 ^4경찰공무원증^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
            end
          vRP.closeMenu(player)
    end
  end}
  return choices
end,0}

items["elysiumid3"] = {"공무원증","엘리시움 의료국",function(args)
  local choices = {}
  local idname = args[1]
  choices["보여주기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "엘리시움 의료국에서 발급된 ^4공무원증^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
            end
          vRP.closeMenu(player)
    end
  end}
  return choices
end,0}

items["elysiumid4"] = {"공무원증","엘리시움 대검찰청",function(args)
  local choices = {}
  local idname = args[1]
  choices["보여주기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "엘리시움 대검찰청에서 발급된 ^4공무원증^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
            end
          vRP.closeMenu(player)
    end
  end}
  return choices
end,0}

-- money
items["money"] = {"돈","묶어둔 돈.",function(args)
  local choices = {}
  local idname = args[1]

  choices["묶음 해제"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
      vRP.prompt(player, "How much to unpack ? (max "..amount..")", "", function(player,ramount)
        ramount = parseInt(ramount)
        if vRP.tryGetInventoryItem(user_id, idname, ramount, true) then -- unpack the money
          vRP.giveMoney(user_id, ramount)
          vRP.closeMenu(player)
        end
      end)
    end
  end}

  return choices
end,0}

items["randommoney2"] = {"크리스마스 선물 상자","최소 10,000$부터 5,000,000$까지 랜덤!",function(args)
  local choices = {}
  local idname = args[1]

  choices["상자 열기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
        --  local randommoneys = math.random(10,15000)
        local randommoneys2 = {
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        100000,
        100000,
        100000,
        100000,
        100000,
        300000,
        300000,
        300000,
        5000000
        }
local randommoneys2Count = 29
local randommoneys2Pos = math.random(randommoneys2Count)
          vRPclient.notify(player,{"두구두구두구..."}) 
          Citizen.Wait(3000)
          vRPclient.notify(player,{"앗! ~g~" .. randommoneys2[randommoneys2Pos] .. "$가 상자에서 나왔습니다!"})
          vRP.giveMoney(user_id, randommoneys2[randommoneys2Pos])
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["randommoney3"] = {"레벨업 보상 상자","최소 10,000$부터 5,000,000$까지 랜덤!",function(args)
  local choices = {}
  local idname = args[1]

  choices["사용하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
        --  local randommoneys = math.random(10,15000)
        local randommoneys2 = {
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        100000,
        100000,
        100000,
        100000,
        100000,
        300000,
        300000,
        300000,
        5000000
        }
local randommoneys2Count = 29
local randommoneys2Pos = math.random(randommoneys2Count)
          vRPclient.notify(player,{"두구두구두구..."}) 
          Citizen.Wait(3000)
          vRPclient.notify(player,{"앗! ~g~" .. randommoneys2[randommoneys2Pos] .. "$가 상자에서 나왔습니다!"})
          vRP.giveMoney(user_id, randommoneys2[randommoneys2Pos])
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["newyear"] = {"새해 랜덤 쿠키","최소 10,000$부터 5,000,000$까지 랜덤!",function(args)
  local choices = {}
  local idname = args[1]

  choices["사용하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
        --  local randommoneys = math.random(10,15000)
        local randommoneys2 = {
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        100000,
        100000,
        100000,
        100000,
        100000,
        300000,
        300000,
        300000,
        5000000
        }
local randommoneys2Count = 29
local randommoneys2Pos = math.random(randommoneys2Count)
          vRPclient.notify(player,{"두구두구두구..."}) 
          Citizen.Wait(3000)
          vRPclient.notify(player,{"앗! ~g~" .. randommoneys2[randommoneys2Pos] .. "$가 쿠키에서 나왔습니다!"})
          vRP.giveMoney(user_id, randommoneys2[randommoneys2Pos])
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["newyear2"] = {"2019 설날 랜덤 복권","최소 10,000$부터 5,000,000$까지 랜덤!",function(args)
  local choices = {}
  local idname = args[1]

  choices["사용하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
        --  local randommoneys = math.random(10,15000)
        local randommoneys2 = {
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        10000,
        100000,
        100000,
        100000,
        100000,
        100000,
        300000,
        300000,
        300000,
        5000000
        }
local randommoneys2Count = 29
local randommoneys2Pos = math.random(randommoneys2Count)
          vRPclient.notify(player,{"두구두구두구..."}) 
          Citizen.Wait(3000)
          vRPclient.notify(player,{"앗! ~g~" .. randommoneys2[randommoneys2Pos] .. "$가 복권에서 나왔습니다!"})
          vRP.giveMoney(user_id, randommoneys2[randommoneys2Pos])
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}


items["newseason"] = {"새학기 랜덤 복권","최소 100,000$부터 50,000,000$까지 랜덤!",function(args)
  local choices = {}
  local idname = args[1]

  choices["사용하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
        --  local randommoneys = math.random(10,15000)
        local randommoneys2 = {
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        5000000,
        5000000,
        5000000,
        5000000,
        5000000,
        10000000,
        10000000,
        50000000
        }
local randommoneys2Count = 60
local randommoneys2Pos = math.random(randommoneys2Count)
          vRPclient.notify(player,{"두구두구두구..."}) 
          Citizen.Wait(3000)
          vRPclient.notify(player,{"앗! ~g~" .. randommoneys2[randommoneys2Pos] .. "$가 복권에서 나왔습니다!"})
          vRP.giveMoney(user_id, randommoneys2[randommoneys2Pos])
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["chuseoks"] = {"추석 송편","최소 100,000$부터 50,000,000$까지 랜덤 지급!",function(args)
  local choices = {}
  local idname = args[1]

  choices["먹기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
        --  local randommoneys = math.random(10,15000)
        local randommoneys2 = {
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        5000000,
        5000000,
        5000000,
        5000000,
        5000000,
        10000000,
        10000000,
        50000000
        }
local randommoneys2Count = 60
local randommoneys2Pos = math.random(randommoneys2Count)
          vRPclient.notify(player,{"두구두구두구..."}) 
          Citizen.Wait(3000)
          vRPclient.notify(player,{"앗! ~g~" .. randommoneys2[randommoneys2Pos] .. "$가 송편에서 나왔습니다!"})
          vRP.giveMoney(user_id, randommoneys2[randommoneys2Pos])
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}


items["hottimerandom"] = {"즉석 복권","최소 100,000$부터 50,000,000$까지 랜덤!",function(args)
  local choices = {}
  local idname = args[1]

  choices["사용하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
        --  local randommoneys = math.random(10,15000)
        local randommoneys2 = {
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        100000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        500000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        1000000,
        5000000,
        5000000,
        5000000,
        5000000,
        5000000,
        10000000,
        10000000,
        50000000
        }
local randommoneys2Count = 60
local randommoneys2Pos = math.random(randommoneys2Count)
          vRPclient.notify(player,{"앗! ~g~" .. randommoneys2[randommoneys2Pos] .. "$가 복권에서 나왔습니다!"})
          vRP.giveMoney(user_id, randommoneys2[randommoneys2Pos])
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}




-- 광부 시스템

items["ouro"] = {"먼지에 쌓인 광물","먼지를 털어 어떤 광물인지 감정할 수 있다.",function(args)
  local choices = {}
  local idname = args[1]

  choices["먼지 털기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
        --  local randommoneys = math.random(10,15000)
          local ouros = math.random(0,1000)
          if ouros <= 3 then
          vRPclient.notify(player,{"먼지를 털어 ~b~다이아몬드~w~를 획득하였습니다."})
          vRP.giveInventoryItem(user_id, "diamond", 1, false)
          vRP.closeMenu(player)
          elseif ouros > 3 and ouros <= 10 then
          vRPclient.notify(player,{"먼지를 털어 ~b~백금~w~을 획득하였습니다."})
          vRP.giveInventoryItem(user_id, "platinum", 1, false)
          vRP.closeMenu(player)
          elseif ouros > 10 and ouros <= 20 then
          vRPclient.notify(player,{"먼지를 털어 ~b~금~w~을 획득하였습니다."})
          vRP.giveInventoryItem(user_id, "gold", 1, false)
          vRP.closeMenu(player)
          elseif ouros > 20 and ouros <= 120 then
          vRPclient.notify(player,{"먼지를 털어 ~b~은~w~을 획득하였습니다."})
          vRP.giveInventoryItem(user_id, "silver", 1, false)
          vRP.closeMenu(player)
          elseif ouros > 120 and ouros <= 280 then
          vRPclient.notify(player,{"먼지를 털어 ~b~철~w~을 획득하였습니다."})
          vRP.giveInventoryItem(user_id, "iron", 1, false)
          vRP.closeMenu(player)
          elseif ouros > 280 and ouros <= 630 then
          vRPclient.notify(player,{"먼지를 털어 ~b~구리~w~를 획득하였습니다."})
          vRP.giveInventoryItem(user_id, "copper", 1, false)
          vRP.closeMenu(player)
          else
          vRPclient.notify(player,{"먼지를 털어 ~b~석탄~w~을 획득하였습니다."})
          vRP.giveInventoryItem(user_id, "coal", 1, false)
          vRP.closeMenu(player)
          end
      end
    end
  end}

  return choices
end,0}

items["diamond"] = {"[광부] 다이아몬드","<판매 하기>를 통해 10,000,000$로 즉시 판매 가능",function(args)
  local choices = {}
  local idname = args[1]

  choices["판매 하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
          vRP.giveMoney(user_id, 10000000)
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["platinum"] = {"[광부] 백금","<판매 하기>를 통해 5,000,000$로 즉시 판매 가능",function(args)
  local choices = {}
  local idname = args[1]

  choices["판매 하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
          vRP.giveMoney(user_id, 5000000)
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["gold"] = {"[광부] 금","<판매 하기>를 통해 1,500,000$로 즉시 판매 가능",function(args)
  local choices = {}
  local idname = args[1]

  choices["판매 하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
          vRP.giveMoney(user_id, 1500000)
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["silver"] = {"[광부] 은","<판매 하기>를 통해 500,000$로 즉시 판매 가능",function(args)
  local choices = {}
  local idname = args[1]

  choices["판매 하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
          vRP.giveMoney(user_id, 500000)
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["iron"] = {"[광부] 철","<판매 하기>를 통해 200,000$로 즉시 판매 가능",function(args)
  local choices = {}
  local idname = args[1]

  choices["판매 하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
          vRP.giveMoney(user_id, 200000)
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["copper"] = {"[광부] 구리","<판매 하기>를 통해 120,000$로 즉시 판매 가능",function(args)
  local choices = {}
  local idname = args[1]

  choices["판매 하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
          vRP.giveMoney(user_id, 120000)
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}

items["coal"] = {"[광부] 석탄","<판매 하기>를 통해 100,000$로 즉시 판매 가능",function(args)
  local choices = {}
  local idname = args[1]

  choices["판매 하기"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)

        if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
          vRP.giveMoney(user_id, 100000)
          vRP.closeMenu(player)
      end
    end
  end}

  return choices
end,0}



-- money binder
items["money_binder"] = {"Money binder","Used to bind 1000$ of money.",function(args)
  local choices = {}
  local idname = args[1]

  choices["Bind money"] = {function(player,choice,mod) -- bind the money
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local money = vRP.getMoney(user_id)
      if money >= 1000 then
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) and vRP.tryPayment(user_id,1000) then
          vRP.giveInventoryItem(user_id, "money", 1000, true)
          vRP.closeMenu(player)
        end
      else
        vRPclient.notify(player,{vRP.lang.money.not_enough()})
      end
    end
  end}

  return choices
end,0}

-- parametric weapon items
-- give "wbody|WEAPON_PISTOL" and "wammo|WEAPON_PISTOL" to have pistol body and pistol bullets

local get_wname = function(weapon_id)
  local name = string.gsub(weapon_id,"WEAPON_","")
  name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
  return name
end

--- weapon body
local wbody_name = function(args)
  return get_wname(args[2]).." body"
end

local wbody_desc = function(args)
  return ""
end

local wbody_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args,"|")

  choices["Equip"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, fullidname, 1, true) then -- give weapon body
        local weapons = {}
        weapons[args[2]] = {ammo = 0}
        vRPclient.giveWeapons(player, {weapons})

        vRP.closeMenu(player)
      end
    end
  end}

  return choices
end

local wbody_weight = function(args)
  return 0.75
end

items["wbody"] = {wbody_name,wbody_desc,wbody_choices,wbody_weight}

--- weapon ammo
local wammo_name = function(args)
  return get_wname(args[2]).." ammo"
end

local wammo_desc = function(args)
  return ""
end

local wammo_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args,"|")

  choices["Load"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, fullidname)
      vRP.prompt(player, "Amount to load ? (max "..amount..")", "", function(player,ramount)
        ramount = parseInt(ramount)

        vRPclient.getWeapons(player, {}, function(uweapons)
          if uweapons[args[2]] ~= nil then -- check if the weapon is equiped
            if vRP.tryGetInventoryItem(user_id, fullidname, ramount, true) then -- give weapon ammo
              local weapons = {}
              weapons[args[2]] = {ammo = ramount}
              vRPclient.giveWeapons(player, {weapons,false})
              vRP.closeMenu(player)
            end
          end
        end)
      end)
    end
  end}

  return choices
end

local wammo_weight = function(args)
  return 0.01
end

items["wammo"] = {wammo_name,wammo_desc,wammo_choices,wammo_weight}

local supressor_choices = {}
supressor_choices["장착하기"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.CheckInventoryItem(user_id,"supressor",1) then
      TriggerClientEvent('alex:supp', player)
    end
  end
end}

local flash_choices = {}
flash_choices["장착하기"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.CheckInventoryItem(user_id,"flash",1) then
      TriggerClientEvent('alex:flashlight', player)
    end
  end
end}

local yusuf_choices = {}
yusuf_choices["장착하기"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.CheckInventoryItem(user_id,"yusuf",1) then
      TriggerClientEvent('alex:yusuf', player)
    end
  end
end}

items["supressor"] = {"[파츠] 소음기","",function(args) return supressor_choices end,0.1}
items["flash"] = {"[파츠] 플래시","",function(args) return flash_choices end,0.1}
items["yusuf"] = {"[파츠] 총기 스킨","",function(args) return yusuf_choices end,0.1}


return items



local items = {}

local function play_drink(player)
  local seq = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq,false})
end

local pills_choices = {}
pills_choices["Take"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"pills",1) then
      vRPclient.varyHealth(player,{25})
      vRPclient.notify(player,{"~g~진통제를 먹었습니다."})
      play_drink(player)
      vRP.closeMenu(player)
    end
  end
end}

local kits_choices = {}
kits_choices["사용"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"kits",1) then
      vRPclient.varyHealth(player,{500})
      vRPclient.notify(player,{"~g~의료용 키트를 사용하였습니다."})
      --play_drink(player)
      vRP.closeMenu(player)
    end
  end
end}

local function play_smoke(player)
  local seq2 = {
    {"mp_player_int_uppersmoke","mp_player_int_smoke_enter",1},
    {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
    {"mp_player_int_uppersmoke","mp_player_int_smoke_exit",1}
  }

  vRPclient.playAnim(player,{true,seq2,false})
end

local smoke_choices = {}
smoke_choices["피우기"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"weed",1) then
	  vRP.varyHunger(user_id,(20))
      vRPclient.notify(player,{"~g~대마초를 폈습니다."})
      play_smoke(player)
      vRP.closeMenu(player)
    end
  end
end}

local cigar1_choices = {}
cigar1_choices["*흡연"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"cigar1",1) then
      vRPclient.notify(player,{"~g~말보로 레드를 피우는 중..."})
      vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_AA_SMOKE"},false})
      Citizen.Wait(15000)
      vRPclient.stopAnim(player,{true}) -- upper
      vRPclient.stopAnim(player,{false}) -- full
      --play_smoke(player)
      vRP.closeMenu(player)
    end
  end
end}

local cigar2_choices = {}
cigar2_choices["*흡연"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"cigar2",1) then
      vRPclient.notify(player,{"~g~마일드 세븐을 피우는 중..."})
      vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_AA_SMOKE"},false})
      Citizen.Wait(15000)
      vRPclient.stopAnim(player,{true}) -- upper
      vRPclient.stopAnim(player,{false}) -- full
      vRP.closeMenu(player)
    end
  end
end}

local function play_smell(player)
  local seq3 = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq3,false})
end

local smell_choices = {}
smell_choices["Take"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"cocaine",1) then
	  vRP.varyThirst(user_id,(20))
      vRPclient.notify(player,{"~g~ smell cocaine."})
      play_smell(player)
      vRP.closeMenu(player)
    end
  end
end}

local function play_lsd(player)
  local seq4 = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq4,false})
end

local lsd_choices = {}
lsd_choices["Take"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"lsd",1) then
	  vRP.varyThirst(user_id,(20))
      vRPclient.notify(player,{"~g~ Taking lsd."})
      play_lsd(player)
      vRP.closeMenu(player)
    end
  end
end}

items["pills"] = {"진통제","타이레놀!",function(args) return pills_choices end,0.1}
items["kits"] = {"의료용 키트","배그?",function(args) return kits_choices end,0.3}
--items["weed"] = {"대마초","예쁘게 잘 말려있는 대마초.",function(args) return smoke_choices end,0.10}
--items["cocaine"] = {"코카인","소량의 코카인.",function(args) return smell_choices end,0.2}
--items["lsd"] = {"LSD","소량의 LSD.",function(args) return lsd_choices end,0.1}
items["cigar1"] = {"말보로 레드","담배.",function(args) return cigar1_choices end,0.1}
items["cigar2"] = {"마일드 세븐","담배.",function(args) return cigar2_choices end,0.1}
items["Medical Weed"] = {"의료용 대마","Used by Doctors."}
items["Presents"] = {"선물","Given to Children."}

return items
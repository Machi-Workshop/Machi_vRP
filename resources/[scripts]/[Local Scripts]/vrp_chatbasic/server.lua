
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_Chatbasic")

--Private Messages
TriggerEvent('es:addCommand', 'pm', function(source, args, user)
if(GetPlayerName(tonumber(args[2])) or GetPlayerName(tonumber(args[3])))then
local player = tonumber(args[2])
table.remove(args, 2)
table.remove(args, 1)

TriggerEvent("es:getPlayerFromId", player, function(target)
TriggerClientEvent('chatMessage', player, "PM", {214, 214, 214}, "^2 From ^5"..GetPlayerName(source).. " [" .. source .. "]: ^7" ..table.concat(args, " "))
TriggerClientEvent('chatMessage', source, "PM", {214, 214, 214}, "^3 Sent to ^5"..GetPlayerName(player).. ": ^7" ..table.concat(args, " "))
end)
else
TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
end
end, function(source, args, user)
TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

--[[AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message,1,string.len("/"))=="/" then
		--ne doit rien se passer c'est une commande
	else
		TriggerClientEvent("sendProximityMessage", -1, source, name, message)
	end
	CancelEvent()
end)]]--





AddEventHandler('chatMessage', function(source, name, message)
  sm = stringsplit(message, " ");
  local user_id = vRP.getUserId({source})
  local name = GetPlayerName(source)
  if string.sub(message,1,string.len("/"))=="/" then
    if sm[1] == "/me" then
		--TriggerClientEvent('chatMessage', -1, "🕺 " .. name .."의 행동 ", { 255, 255, 255 }, string.sub(message,5))
    TriggerClientEvent("sendProximityMessageMe", -1, source, name, string.sub(message,5))
    vRP.log("chatlog.txt",user_id .. " | " .. name .. "이(가) ".. string.sub(message,5) .. "")
    CancelEvent()
    end
    if sm[1] == "/st" then
		CancelEvent()
		--TriggerClientEvent('chatMessage', -1, "🕺 " .. name .."의 행동 ", { 255, 255, 255 }, string.sub(message,5))
    TriggerClientEvent("sendProximityMessageSt", -1, source, name, string.sub(message,5))
    vRP.log("chatlog.txt",user_id .. " | " .. name .. "의 상태 : ".. string.sub(message,5) .. "")
    end
    if sm[1] == "/th" then
		--TriggerClientEvent('chatMessage', -1, "🕺 " .. name .."의 행동 ", { 255, 255, 255 }, string.sub(message,5))
    TriggerClientEvent("sendProximityMessageTh", -1, source, name, string.sub(message,5))
    vRP.log("chatlog.txt",user_id .. " | " .. name .. "의 생각 : ".. string.sub(message,5) .. "")
    CancelEvent()
    end
    if sm[1] == "/jp" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"language.japanese"}) then
    TriggerClientEvent("sendProximityMessageJp", -1, source, name, string.sub(message,4))
    vRP.log("chatlog.txt","일본어 IC | " .. user_id .. " | " .. name .. ": ".. string.sub(message,4) .. "")
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 ~b~일본어~r~를 말할 줄 모릅니다!"})
    CancelEvent()
    end
    end
    if sm[1] == "/cn" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"language.chinese"}) then
    TriggerClientEvent("sendProximityMessageCn", -1, source, name, string.sub(message,4))
    vRP.log("chatlog.txt","중국어 IC | " .. user_id .. " | " .. name .. ": ".. string.sub(message,4) .. "")
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 ~b~중국어~r~를 말할 줄 모릅니다!"})
    CancelEvent()
    end
    end
    if sm[1] == "/s" then
		CancelEvent()
    TriggerClientEvent("sendProximityMessageSh", -1, source, name, string.sub(message,3))
    vRP.log("chatlog.txt","외치기 | " .. user_id .. " | " .. name .. ": ".. string.sub(message,3) .. " ! ! !")
    end
    if sm[1] == "/pm1" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"police.megaphone"}) then
    TriggerClientEvent("sendProximityMessagePm1", -1, source, name, string.sub(message,3)) 
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
    CancelEvent()
    end
  end
    if sm[1] == "/pm" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"police.megaphone"}) then
    TriggerClientEvent("sendProximityMessagePolice", -1, source, name, string.sub(message,4)) 
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
    CancelEvent()
    end
    end
    if sm[1] == "/oo" then
		CancelEvent()
		TriggerClientEvent("sendProximityMessageB", -1, source, name, string.sub(message,4))
    vRP.log("chatlog.txt","근처 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,4) .. "")
    end
    if sm[1] == "/ooc" then
    local user_id = vRP.getUserId({source})
      if vRP.hasPermission({user_id,"chatrules.admin"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 관 리 자 | " .. name, { 255, 0, 0 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      
      elseif vRP.hasPermission({user_id,"chatrules.testadmin"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 임 시 관 리 자 | " .. name, { 238, 134, 147 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"chatrules.hostingadmin"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 관 리 팀 장 | " .. name, { 0, 251, 255 }, string.sub(message,5)) --226,0,255
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"chatrules.superadmin"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | 최 고 관 리 자 | " .. name, { 255, 0, 0 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"chatrules.newbiehelper"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 뉴비 도우미 | " .. name, { 169, 255, 0 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"chatrules.engineer"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 개 발 자 | " .. name, { 255, 255, 0 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"chatrules.designer"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 디 자 이 너 | " .. name, { 137, 219, 236 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"ultimate.paycheck"}) and vRP.hasPermission({user_id,"regular.chat"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^6 Ultimate^9 | ^4정기 후원^9 | " .. name, { 200, 200, 200 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"vip.paycheck"}) and vRP.hasPermission({user_id,"regular.chat"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^3 V I P^9 | ^4정기 후원^9 | " .. name, { 200, 200, 200 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"ultimate.paycheck"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^6 Ultimate^9 | " .. name, { 200, 200, 200 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"vip.paycheck"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^3 V I P^9 | " .. name, { 200, 200, 200 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      elseif vRP.hasPermission({user_id,"regular.chat"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^4 정기 후원^9 | " .. name, { 200, 200, 200 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else
      CancelEvent()
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | " .. name, { 200, 200, 200 }, string.sub(message,5))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      end
    end
    if sm[1] == "/o" then
    local user_id = vRP.getUserId({source})
      if vRP.hasPermission({user_id,"chatrules.admin"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 관 리 자 | " .. name, { 255, 0, 0 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
	  else if vRP.hasPermission({user_id,"chatrules.testadmin"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 임 시 관 리 자 | " .. name, { 238, 134, 147 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
	  else if vRP.hasPermission({user_id,"chatrules.hostingadmin"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 관 리 팀 장 | " .. name, { 0, 251, 255 }, string.sub(message,4)) --226,0,255
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else if vRP.hasPermission({user_id,"chatrules.superadmin"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 최 고 관 리 자 | " .. name, { 255, 0, 0 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else if vRP.hasPermission({user_id,"chatrules.newbiehelper"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 뉴비 도우미 | " .. name, { 169, 255, 0 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else if vRP.hasPermission({user_id,"chatrules.engineer"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 개 발 자 | " .. name, { 255, 255, 0 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
	        else if vRP.hasPermission({user_id,"chatrules.designer"}) then
      TriggerClientEvent('chatMessage', -1, "^*🌎 전체 O O C | " .. user_id .. " | 디 자 이 너 | " .. name, { 137, 219, 236 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else if vRP.hasPermission({user_id,"ultimate.paycheck"}) and vRP.hasPermission({user_id,"regular.chat"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^6 Ultimate^9 | ^4정기 후원^9 | " .. name, { 200, 200, 200 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else if vRP.hasPermission({user_id,"vip.paycheck"}) and vRP.hasPermission({user_id,"regular.chat"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^3 V I P^9 | ^4정기 후원^9 | " .. name, { 200, 200, 200 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else if vRP.hasPermission({user_id,"ultimate.paycheck"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^6 Ultimate^9 | " .. name, { 200, 200, 200 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else if vRP.hasPermission({user_id,"vip.paycheck"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^3 V I P^9 | " .. name, { 200, 200, 200 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else if vRP.hasPermission({user_id,"regular.chat"}) then
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | ^4 정기 후원^9 | " .. name, { 200, 200, 200 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      else
      CancelEvent()
      TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. user_id .. " | " .. name, { 200, 200, 200 }, string.sub(message,4))
      vRP.log("chatlog.txt","전체 O O C | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
      end
      end
      end
      end
      end
      end
      end
      end
      end
      end
      end
      end
      end
    if sm[1] == "/twit" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "🔷 Twitter | " .. name .."님의 트윗 ", { 85, 172, 238 }, string.sub(message,6))
    vRP.log("chatlog.txt","트위터 | " .. user_id .. " | " .. name .. ": ".. string.sub(message,6) .. "")
    end
    if sm[1] == "/t" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "🔷 Twitter | " .. name .."님의 트윗 ", { 85, 172, 238 }, string.sub(message,4))
    vRP.log("chatlog.txt","트위터 | " .. user_id .. " | " .. name .. ": ".. string.sub(message,6) .. "")
    end
    if sm[1] == "/ad" then
    TriggerClientEvent('chatMessage', -1, "AD | " .. name .."님의 광고 ", { 255, 100, 100 }, string.sub(message,5))
    vRP.log("chatlog.txt","광고 | " .. user_id .. " | " .. name .. ": ".. string.sub(message,5) .. "")
    vRP.tryFullPayment({user_id,50000})
    vRPclient.notify(source,{"~r~광고 비용 $50,000"})
    end
    if sm[1] == "/ems" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"chatrules.emssnr"}) then
    TriggerClientEvent("chatMessage", -1, "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다. ", { 255, 100, 0 }, string.sub(message,5)) 
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 메딕이 아닙니다!"})
    CancelEvent()
    end
  end
      if sm[1] == "/ems" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"chatrules.paramedic"}) then
    TriggerClientEvent("chatMessage", -1, "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다. ", { 255, 100, 0 }, string.sub(message,5)) 
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 메딕이 아닙니다!"})
    CancelEvent()
    end
  end
      if sm[1] == "/ems" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"chatrules.lieutenant"}) then
    TriggerClientEvent("chatMessage", -1, "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다. ", { 255, 100, 0 }, string.sub(message,5)) 
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 메딕이 아닙니다!"})
    CancelEvent()
    end
  end
      if sm[1] == "/ems" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"chatrules.emscheif2"}) then
    TriggerClientEvent("chatMessage", -1, "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다. ", { 255, 100, 0 }, string.sub(message,5)) 
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 메딕이 아닙니다!"})
    CancelEvent()
    end
  end
      if sm[1] == "/ems" then
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"chatrules.emscheif1"}) then
    TriggerClientEvent("chatMessage", -1, "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다. ", { 255, 100, 0 }, string.sub(message,5)) 
    CancelEvent()
    else
    vRPclient.notify(source,{"~r~당신은 메딕이 아닙니다!"})
    CancelEvent()
    end
  end
    if sm[1] == "/police" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.lspd1"}) then
  TriggerClientEvent("chatMessage", -1, "👮 112 긴급 전화 신고 시 사유를 작성하지 않으시면 출동하지 않습니다. 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/police" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.lspd2"}) then
  TriggerClientEvent("chatMessage", -1, "👮 112 긴급 전화 신고 시 사유를 작성하지 않으시면 출동하지 않습니다. 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/police" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.lspd3"}) then
  TriggerClientEvent("chatMessage", -1, "👮 112 긴급 전화 신고 시 사유를 작성하지 않으시면 출동하지 않습니다. 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/police" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.lspd4"}) then
  TriggerClientEvent("chatMessage", -1, "👮 112 긴급 전화 신고 시 사유를 작성하지 않으시면 출동하지 않습니다. 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/police" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.lspd5"}) then
  TriggerClientEvent("chatMessage", -1, "👮 112 긴급 전화 신고 시 사유를 작성하지 않으시면 출동하지 않습니다. 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/police" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.lspd0"}) then
  TriggerClientEvent("chatMessage", -1, "👮 112 긴급 전화 신고 시 사유를 작성하지 않으시면 출동하지 않습니다. 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/police" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.poldirector"}) then
  TriggerClientEvent("chatMessage", -1, "👮 112 긴급 전화 신고 시 사유를 작성하지 않으시면 출동하지 않습니다. 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/police" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.policecaptain"}) then
  TriggerClientEvent("chatMessage", -1, "👮 112 긴급 전화 신고 시 사유를 작성하지 않으시면 출동하지 않습니다. 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/pol" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.polch"}) then
  TriggerClientEvent("chatMessage", -1, "👮 엘리시움 공화국 112 통합 관제 센터 🚔 ", { 52, 152, 219 }, string.sub(message,5)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
    if sm[1] == "/polair" then
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"chatrules.polch"}) then
  TriggerClientEvent("chatMessage", -1, "👮 엘리시움 공화국 112 항공 순찰 센터 🚔 ", { 52, 152, 219 }, string.sub(message,8)) 
  CancelEvent()
  else
  vRPclient.notify(source,{"~r~당신은 경찰이 아닙니다!"})
  CancelEvent()
  end
end
if sm[1] == "/ae" then
local user_id = vRP.getUserId({source})
if vRP.hasPermission({user_id,"chatrules.aec"}) then
TriggerClientEvent("chatMessage", -1, "✈️ 에어 엘리시움 ✈️ ", { 0, 251, 255 }, string.sub(message,4)) 
CancelEvent()
else
vRPclient.notify(source,{"~r~당신은 항공사 사람이 아닙니다!"})
CancelEvent()
end
end
    if sm[1] == "/sr" then
		CancelEvent()
    end
    if sm[1] == "/fix" then
		CancelEvent()
    end
    else
    TriggerClientEvent("sendProximityMessage", -1, source, name, message)
    vRP.log("chatlog.txt","일반 IC | " .. user_id .. " | " .. name .. ": ".. string.sub(message,0) .. "")
    end
  	CancelEvent()
end)

--[[ ME COMMAND (/me [Message]) Outcomes: Name Message (All in purple)
TriggerEvent('es:addCommand', 'me', function(source, args, user)
    table.remove(args, 1)
    local pname = GetPlayerName(source)
    TriggerClientEvent("sendProximityMessageMe", -1, source, pname, table.concat(args, " "))
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

-- DO COMMAND (/do [Message]) Outcomes: Action: *Name Message
TriggerEvent('es:addCommand', 'do', function(source, args, user)
	table.remove(args, 1)
	local pname = GetPlayerName(source)
	TriggerClientEvent("sendProximityMessageDo", -1, source, pname, table.concat(args, " "))
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

TriggerEvent('es:addCommand', 'b', function(source, args, user)
    table.remove(args, 1)
    local pname = GetPlayerName(source)
    TriggerClientEvent("sendProximityMessageB", -1, source, pname, table.concat(args, " "))
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)]]--

--end Eventhandlers

--functions


function vRP.log(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
--end Functions
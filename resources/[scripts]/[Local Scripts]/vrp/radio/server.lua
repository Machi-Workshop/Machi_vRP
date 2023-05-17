RegisterServerEvent("chatCommandEntered")
RegisterServerEvent('chatMessageEntered')
AddEventHandler("chatMessage", function(p, color, msg)
    if msg:sub(1, 1) == "/" then
        fullcmd = stringSplit(msg, " ")
        cmd = fullcmd[1]
        
        if cmd == "/radio" then
        	if not fullcmd[2] then
        		TriggerClientEvent("chatMessage", p, "^1Usage", {0, 0, 0}, "^1/radio URL")
	        else
	        	TriggerClientEvent("playradio", p, fullcmd[2])
        	end

        	CancelEvent()
        elseif cmd == "/volume" then
        	if not fullcmd[2] then
        		TriggerClientEvent("chatMessage", p, "^1Usage", {0, 0, 0}, "^1/volume (0.0 - 1.0)")
	        else
	        	TriggerClientEvent("changevolume", p, fullcmd[2])
        	end

        	CancelEvent()
          
        elseif cmd == "/moff" then
	        TriggerClientEvent("stopradio", p)
        	CancelEvent()
          
        elseif cmd == "/mon" then
	        TriggerClientEvent("playradio", p, 'http://fireworkmen.mooo.com:8000/stream.ogg')
        	CancelEvent()
        end
    end
end)

function stringSplit(inputstr, sep)
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

local choice_radioon = {function(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    TriggerClientEvent("playradio", player, 'http://fireworkmen.mooo.com:8000/stream.ogg')
    CancelEvent()
  end
end, "ASUKA.FM을 재생합니다."}

local choice_radiooff = {function(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    TriggerClientEvent("stopradio", player)
    CancelEvent()
  end
end, "ASUKA.FM을 종료합니다."}

-- 아스카FM
--[[vRP.registerMenuBuilder("main", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local choices = {}

  if vRP.hasPermission(user_id,"player.phone") then
      choices["*ASUKA.FM"] = {function(player,choice)
          vRP.buildMenu("radio", {player = player}, function(menu)
          menu.name = "Radio"
          menu.css = {top="75px",header_color="rgba(0,125,255,0.75)"}

          if vRP.hasPermission(user_id,"player.phone") then
            menu["1. ASUKA.FM 켜기"] = choice_radioon
          end

          if vRP.hasPermission(user_id,"player.phone") then
            menu["2. ASUKA.FM 끄기"] = choice_radiooff
          end
          vRP.openMenu(player,menu)
        end)
      end}
    end

    add(choices)
  end
end)--]]
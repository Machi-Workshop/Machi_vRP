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
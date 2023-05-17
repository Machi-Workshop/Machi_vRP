-- CONFIG --

-- Ping Limit
pingLimit = 500

-- CODE --

RegisterServerEvent("checkMyPingBro")
AddEventHandler("checkMyPingBro", function()
	ping = GetPlayerPing(source)
	if ping >= pingLimit then
		DropPlayer(source, "핑이 너무 높습니다! 서버 핑 제한: " .. pingLimit .. " 현재 핑: " .. ping .. " ")
	end
end)
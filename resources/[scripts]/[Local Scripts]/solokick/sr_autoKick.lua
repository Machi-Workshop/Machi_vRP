RegisterServerEvent('sendSessionPlayerNumber')
AddEventHandler('sendSessionPlayerNumber', function(clientPlayerNumber, name, id)
	serverPlayerNumber = countPlayer()
	if(clientPlayerNumber < serverPlayerNumber) then
		if(clientPlayerNumber == 1) then -- if player are solo
			local reason = '솔로 세션' -- reason of kick (solo session detected)
			local msg = name .. " 킥 당하셨습니다., 확인하세요.: " .. serverPlayerNumber .. " 플레이어, CLIENT SEE: " .. clientPlayerNumber -- console message (example : client see 1/24 players , server see 24/24 players)
			RconPrint('AUTOKICK: ' .. msg .. "\n") -- console title message (AUTOKICK : console message)
			TriggerClientEvent('chatMessage', -1, '솔로 세션킥', { 0, 0x99, 255 },  "^2"..name .. " ^0(^4" ..id .. "^0) ^1님이 퇴장 되셨습니다. : ^2" .. reason) -- In game chat message (example: John Doe (ID) was kicked for Auto-Kick Session solo détectée)
			DropPlayer(id, reason) -- kick player
		end
	end
end)

function countPlayer() -- count all players
	Count = 0
	for _ in pairs(GetPlayers()) do
		Count = Count + 1
	end
	return Count
end
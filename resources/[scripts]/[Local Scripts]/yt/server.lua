local screenssCoords
local screenssAngle
local screenssNet
local clientCounts = 0
local everyoneAllowed = false -- If true, everyone is allowed and you do not need to add steam/ip identifiers. If false, you need to add steam/ip identifiers so they can use the command.

local allowed =  
{
	"steam:110000103ec69c4" -- Enter your steam ids and ips as such. DO NOT forget the commas and do not add a comma at the end.
}	


-- 화면생성
-- 모든 클라이언트에게 화면에 대해 알립니다.
RegisterNetEvent('youtube:createscreenss')
AddEventHandler('youtube:createscreenss', function (netId, coords, angle)
    print('Server received netId', netId)
    screenssCoords = coords
    screenssAngle = angle
    screenssNet = netId

		print('Persist screenss meta', json.encode(screenssCoords), screenssAngle, screenssNet)

    TriggerClientEvent('youtube:createscreenss', -1, netId)
end)

-- Player loaded into game
RegisterNetEvent('hardcap:playerActivated')
AddEventHandler('hardcap:playerActivated', function ()
    clientCounts = clientCounts + 1
    if screenssNet then
				-- 처음으로 들어온 사람
				-- 이전 위치에서 화면을 생성하라고 클라이언트에게 알립니다.
        if clientCounts == 1 then
            TriggerClientEvent('youtube:init', source, screenssCoords, screenssAngle)
						print('Recreate screenss', json.encode(screenssCoords), screenssAngle, screenssNet)
				-- 클라이언트에게 화면 존재 여부를 알립니다.
        else
            TriggerClientEvent('youtube:createscreenss', source, screenssNet)
        end
    end
end)

--플레이어가 서버를 나갈때
AddEventHandler('playerDropped', function()
    clientCounts = clientCounts - 1
end)
AddEventHandler('chatMessage', function(source, n, msg) -- Checks messages
	local Message = string.lower(msg) -- Lowers entire msg to lower case (in case user has Caps Lock or something)
	if Message == "/delgun on" then -- Checks if the message says this
		CancelEvent() -- Stops message from going thru
		local identifier = GetPlayerIdentifiers(source)[1] -- Gets identifier (steam id or ip of player)
		if everyoneAllowed == true then -- Checks if the variable in the config is true
			TriggerClientEvent('ObjectDeleteGunOn', source) -- Triggers ObjectDeleteGunOn client event
		else -- if not
			if checkAllowed(identifier) then -- Refers to function checkAllowed() (look below) with the variable identifier
				TriggerClientEvent('ObjectDeleteGunOn', source) -- Triggers ObjectDeleteGunOn client event
			else -- if not
				TriggerClientEvent('noPermissions', source) -- Triggers noPermissions client event
			end
		end
	elseif Message == "/delgun off" then -- Checks if message says /delobjgun off
		CancelEvent()  -- Stops message from going thru
		TriggerClientEvent('ObjectDeleteGunOff', source) -- Triggers ObjectDeleteGunOff client event
	end
end)

function checkAllowed(id) -- function checkAllowed(). id is just a returned value (forgot what the actual word is xD)
	for k, v in pairs(allowed) do -- for repeat to go thru the allowed table. k = key and v = value
		if id == v then -- checks if id is equal to v
			
			return true -- returns true if id is equal to v
		end
	end
	
	return false -- in case nothing is in the array, just a fail safe so it returns false basically
end
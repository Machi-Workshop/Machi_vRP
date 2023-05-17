-- Remember to use the cop group or this won't work
-- K > Admin > Add Group > User ID > cop

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_bank")

local banks = {
	--["fleeca"] = {
	--	position = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 },
	--	reward = 10000 + math.random(100000,200000),
	--	nameofbank = "Fleeca Bank",
	--	lastrobbed = 0
	--},
	--["fleeca2"] = {
	--	position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
	--	reward = 10000 + math.random(100000,200000),
	--	nameofbank = "Fleeca Bank (Highway)",
	--	lastrobbed = 0
	--},
	--["blainecounty"] = {
	--	position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
	--	reward = 10000 + math.random(100000,200000),
	--	nameofbank = "Blaine County Savings",
	--	lastrobbed = 0
	--}
	--["fleeca3"] = {
		--position = { ['x'] = -1212.2568359375, ['y'] = -336.128295898438, ['z'] = 36.7907638549805 },
		--reward = 30000 + math.random(100000,200000),
		--nameofbank = "Fleeca Bank (Vinewood Hills)",
		--lastrobbed = 0
	--},
	--["fleeca4"] = {
		--position = { ['x'] = -354.452575683594, ['y'] = -53.8204879760742, ['z'] = 48.0463104248047 },
		--reward = 30000 + math.random(100000,200000),
		--nameofbank = "Fleeca Bank (Burton)",
		--lastrobbed = 0
	--},
	--["fleeca5"] = {
		--position = { ['x'] = 309.967376708984, ['y'] = -283.033660888672, ['z'] = 53.1745223999023 },
		--reward = 30000 + math.random(100000,200000),
		--nameofbank = "Fleeca Bank (Alta)",
		--lastrobbed = 0
	--},
	--["fleeca6"] = {
		--position = { ['x'] = 1176.86865234375, ['y'] = 2711.91357421875, ['z'] = 38.097785949707 },
		--reward = 30000 + math.random(100000,200000),
		--nameofbank = "Fleeca Bank (Desert)",
		--lastrobbed = 0
	--},
	["pacific"] = {
		position = { ['x'] = 255.001098632813, ['y'] = 225.855895996094, ['z'] = 101.005694274902 },
		reward = 88000000 + math.random(200000,22000000),
		nameofbank = "퍼시픽 스탠다드 은행 (바인우드 시내)",
		lastrobbed = 0
	}
}

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_bank:toofar')
AddEventHandler('es_bank:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, '속보 ', {255, 0, 0}, "은행 강도가 취소되었습니다. ^2" .. banks[robb].nameofbank)
	end
end)

RegisterServerEvent('es_bank:playerdied')
AddEventHandler('es_bank:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:playerdiedlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, '속보 ', {255, 0, 0}, "은행 강도가 취소되었습니다. ^2" .. banks[robb].nameofbank)
	end
end)

RegisterServerEvent('es_bank:rob')
AddEventHandler('es_bank:rob', function(robb)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local cops = vRP.getUsersByGroup({"cop"}) -- remember to use the cop group or this won't work - K > Admin > Add Group > User ID > cop
  if vRP.hasGroup({user_id,"cop"}) then
    vRPclient.notify(player,{"~r~Cops can't rob banks."})
  else
    if #cops >= 0 then -- change 2 to the minimum amount online necessary
	  if banks[robb] then
		  local bank = banks[robb]

		  if (os.time() - bank.lastrobbed) < 1000 and bank.lastrobbed ~= 0 then
			  TriggerClientEvent('chatMessage', player, 'ROBBERY', {255, 0, 0}, "This has already been robbed recently. Please wait another: ^2" .. (2400 - (os.time() - bank.lastrobbed)) .. "^0 seconds.")
			  return
		  end
		  TriggerClientEvent('chatMessage', -1, '속보 ', {255, 0, 0}, "^0" .. bank.nameofbank .. " 에서 강도가 발생하였습니다! ")
		  TriggerClientEvent('chatMessage', -1, '속보 ', {255, 0, 0}, "^0" .. bank.nameofbank .. " 에서 강도가 발생하였습니다! ")
		  TriggerClientEvent('chatMessage', -1, '속보 ', {255, 0, 0}, "^0" .. bank.nameofbank .. " 에서 강도가 발생하였습니다! ")
		  TriggerClientEvent('chatMessage', player, 'SYSTEM', {255, 0, 0}, "당신은 ^2" .. bank.nameofbank .. "^0 에서 강도를 시작하였습니다. 빨간 비콘에서 너무 멀리 떨어지지 마세요.")
		  TriggerClientEvent('chatMessage', player, 'SYSTEM', {255, 0, 0}, "^1 10 ^0분간 체포, 사망하지 않고 현 지점을 점령하면 보상이 주어집니다!")
		  TriggerClientEvent('es_bank:currentlyrobbing', player, robb)
		  banks[robb].lastrobbed = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(100, function()
			  if(robbers[savedSource])then
				  if(user_id)then
					  vRP.giveInventoryItem({user_id,"dirty_money",bank.reward,true})
					  TriggerClientEvent('chatMessage', -1, '속보 ', {255, 0, 0}, " 충격. 경찰은 무얼 하고 있었나? ^2" .. bank.nameofbank .. "^0 에서 은행 강도를 성공한 일당.")
					  TriggerClientEvent('es_bank:robberycomplete', savedSource, bank.reward)
				  end
			  end
		  end)		
	  end
    else
      vRPclient.notify(player,{"~r~접속 중인 경찰이 충분하지 않습니다."})
    end
	end
end)
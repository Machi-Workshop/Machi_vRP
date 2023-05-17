local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPcs = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_casino")
vRPCasinoC = Tunnel.getInterface("vRP_casino","vRP_casino")
Tunnel.bindInterface("vRP_casino",vRPcs)

rouletteBetters = {}
slotMachinesBetters = {}

barbutPlayers = {}

math.randomseed(GetGameTimer())

rouletteBets = {
	{"그린", "<font color='green'>그린</font>에 배팅합니다.<br>승률: <font color='red'>2.7%</font><br>보상: <font color='yellow'>x5</font>", 10, 0},
	{"레드", "<font color='red'>레드</font>에 배팅합니다.<br>승률: <font color='green'>48.65%</font><br>보상: <font color='yellow'>x2</font>", 2, 1},
	{"블랙", "<font color='grey'>블랙</font>에 배팅합니다.<br>승률: <font color='green'>48.65%</font><br>보상: <font color='yellow'>x2</font>", 2, 2}
}

tokenDealer = {
	{1115.9162597656,219.98297119141,-49.435131072998}, -- 칩 파는 곳
	{1117.8908691406,219.82646179199,-50.44}
}

barbutDealer = {
	{1152.8199462891,265.7580871582,-52.340843200684},
	{1148.0003662109,270.57577514648,-52.34086227417},
	{1151.1707763672,267.40530395508,-52.840843200684},
	{1149.5241699219,269.15036010742,-52.84086227417}
}

roulettes = {
	{1147.1450195313,260.29107666016,-51.84086227417},
	{1142.3041992188,265.16168212891,-51.84086227417},
	{1145.6312255859,261.84237670898,-51.84},
	{1145.6312255859,261.84237670898,-51.84}
}

local casinoCasier_menu = {name="Casino Cashier",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
local casinoRoulette_menu = {name="Roulette",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
local casinoBarbut_menu = {name="Throw Craps",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
local casinoBarbut1v1_menu = {name="Throw Craps 1v1",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function casinolog(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end

casinoBarbut1v1_menu["🎲1:1 주사위 게임 생성 🎲"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if((barbutPlayers[user_id].oponent == 0) and (barbutPlayers[user_id].cota == 0)) or (barbutPlayers[user_id] == nil) then
		vRP.prompt({player, "Stake:", "How many chips should each player bet", function(player, chips)
			if(chips ~= "" and chips ~= nil)then
				if(tonumber(chips))then
					chips = math.ceil(tonumber(chips))
					if(chips > 0) and (chips <= 50)then
						if vRP.tryGetInventoryItem({user_id,"elcato",chips,false}) then
							barbutPlayers[user_id] = {oponent = 0, cota = chips}
							vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~You created a Craps match with the stake of ~y~"..chips.." Chips"})
							vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~Wait for someone to join your match!"})
							vRP.closeMenu({player})
							SetTimeout(15000, function()
								if(barbutPlayers[user_id].cota ~= 0)then
									vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~The Craps match has ended! No one joined your match!"})
									barbutPlayers[user_id] = {oponent = 0, cota = 0}
									casinoBarbut1v1_menu[GetPlayerName(player)] = nil
									vRP.giveInventoryItem({user_id,"elcato",chips,false})
								end
							end)

							casinoBarbut1v1_menu[GetPlayerName(player)] = {function(thePlayer, choice)
								local pID = vRP.getUserId({thePlayer})
								if(pID == user_id)then
									vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~r~Nu poti sa iti accepti propria cerere de barbut!"})
								else
									if(barbutPlayers[pID].cota ~= 0) and (barbutPlayers[pID].oponent == 0)then
										if vRP.tryGetInventoryItem({pID,"elcato",chips,false}) then
											casinoBarbut1v1_menu[GetPlayerName(player)] = nil
											vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~g~You accepted ~r~"..GetPlayerName(player).."'s Craps match!"})
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~"..GetPlayerName(thePlayer).." ~g~accepted your Craps match!"})
											vRP.closeMenu({thePlayer})
											barbutPlayers[user_id] = {oponent = pID, cota = chips}
											vRPcs.doBarbut1v1(player)
										end
									else
										vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~r~This Craps match is expired!"})
									end
								end
							end, "Opponent: <font color='red'>"..GetPlayerName(player).." ["..user_id.."]</font><br>Stake: <font color='green'>"..chips.." Chips</font><br>Potential Winning: <font color='green'>"..(chips*2).." Chips</font>"}
						else
							vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You don't have enough Chips!"})
						end
					else
						vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You need to add a Chips number between 0 and 99!"})
					end
				else
					vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You need to enter a number of Chips!"})
				end
			else
				vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You need to enter a number of Chips!"})
			end
		end})
	else
		vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You already have a Craps match active! Wait till someone joins your match!"})
	end
end, "Create a 'Throw Craps' match"}

casinoBarbut_menu["Throw Craps"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Stake (Chips):", "", function(player, tokenNr)
			if(tokenNr ~= "" and tokenNr ~= nil)then
				if(tonumber(tokenNr))then
					tokenNr = math.ceil(tonumber(tokenNr))
					if(tokenNr > 0) and (tokenNr <= 50)then
						if vRP.tryGetInventoryItem({user_id,"elcato",tokenNr,false}) then
							vRP.closeMenu({player})
							local whoIsFirst = math.random(1, 2)
							local brokerRoll = math.random(1, 6)
							local brokerRoll2 = math.random(1, 6)
							local playerRoll = math.random(1, 6)
							local playerRoll2 = math.random(1, 6)
							local totalBroker = tonumber(brokerRoll + brokerRoll2)
							local totalPlayer = tonumber(playerRoll + playerRoll2)
							if(whoIsFirst == 1)then
								SetTimeout(1000, function()
									vRPclient.notify(player, {"~g~딜러의 주사위\n~p~(~y~"..brokerRoll.."~r~ , ~y~"..brokerRoll2.."~p~) ~b~("..totalBroker..")"})
									SetTimeout(1000, function()
										vRPclient.notify(player, {"~g~당신의 주사위\n~p~(~y~"..playerRoll.."~r~ , ~y~"..playerRoll2.."~p~) ~b~("..totalPlayer..")"})
										if(totalBroker < totalPlayer)then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~You won this hand! You won ~y~"..(tokenNr*2).." Chips"})
											vRP.giveInventoryItem({user_id,"elcato",tokenNr*2,false})
                      casinolog("moneylog.txt"," " .. user_id .. " | " .. tokenNr*2 .. "개 주사위로 부터 획득")
										elseif(totalPlayer < totalBroker)then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You lost this hand!"})
										elseif((brokerRoll == playerRoll) and (brokerRoll2 == playerRoll2))then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..tokenNr.." Chips"})
											vRP.giveInventoryItem({user_id,"elcato",tokenNr,false})
										elseif((brokerRoll == playerRoll2) and (brokerRoll2 == playerRoll))then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..tokenNr.." Chips"})
											vRP.giveInventoryItem({user_id,"elcato",tokenNr,false})
										elseif (totalPlayer == totalBroker)then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..tokenNr.." Chips"})
											vRP.giveInventoryItem({user_id,"elcato",tokenNr,false})
										end
									end)
								end)
							else
								SetTimeout(1000, function()
									vRPclient.notify(player, {"~g~당신의 주사위\n~p~(~y~"..playerRoll.."~r~ , ~y~"..playerRoll2.."~p~) ~b~("..totalPlayer..")"})
									SetTimeout(1000, function()
										vRPclient.notify(player, {"~g~딜러의 주사위\n~p~(~y~"..brokerRoll.."~r~ , ~y~"..brokerRoll2.."~p~) ~b~("..totalBroker..")"})
										if(totalBroker < totalPlayer)then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~You won this hand! You won ~y~"..(tokenNr*2).." Chips"})
											vRP.giveInventoryItem({user_id,"elcato",tokenNr*2,false})
                       casinolog("moneylog.txt"," " .. user_id .. " | " .. tokenNr*2 .. "개 주사위로 부터 획득")
										elseif(totalPlayer < totalBroker)then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You lost this hand!"})
										elseif((brokerRoll == playerRoll) and (brokerRoll2 == playerRoll2))then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..tokenNr.." Chips"})
											vRP.giveInventoryItem({user_id,"elcato",tokenNr,false})
										elseif((brokerRoll == playerRoll2) and (brokerRoll2 == playerRoll))then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..tokenNr.." Chips"})
											vRP.giveInventoryItem({user_id,"elcato",tokenNr,false})
										elseif (totalPlayer == totalBroker)then
											vRPclient.notify(player, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..tokenNr.." Chips"})
											vRP.giveInventoryItem({user_id,"elcato",tokenNr,false})
										end
									end)
								end)
							end
						else
							vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You don't have enough Chips!"})
						end
					else
						vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You need to add a Chips number between 0 and 50!"})
					end
				else
					vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You need to enter a number of Chips!"})
				end
			else
				vRPclient.notify(player, {"[다이아몬드 카지노]\n ~r~You need to enter a number of Chips!"})
			end
		end})
	end
end, "Play 'Throw Craps' with the Broker"}

for i, v in pairs(rouletteBets) do
	casinoRoulette_menu[v[1]] = {function(player, choice)
		local user_id = vRP.getUserId({player})
		if(user_id ~= nil and user_id ~= "")then
			if(rouletteBetters[user_id] ~= nil)then
				vRPclient.notify(player, {"~r~이미 룰렛 플레이 중입니다!"})
			else
				vRP.prompt({player, "얼만큼의 칩을 배팅하시겠습니까?", "1", function(player, tokenNr)
					if(tokenNr ~= "" and tokenNr ~= nil)then
						if(tonumber(tokenNr))then
							tokenNr = math.ceil(tonumber(tokenNr))
							if(tokenNr > 0) and (tokenNr <= 50)then
								if vRP.tryGetInventoryItem({user_id,"elcato",tokenNr,false}) then
									if(v[4] == 1)then
										vRPCasinoC.startRoulette(player, {"레드", tokenNr, 2})
										vRPclient.notify(player, {"~y~칩 "..tokenNr.."개~w~를 ~r~레드~w~에 배팅하였습니다."})
									elseif(v[4] == 2)then
										vRPCasinoC.startRoulette(player, {"블랙", tokenNr, 2})
                    vRPclient.notify(player, {"~y~칩 "..tokenNr.."개~w~를 ~c~블랙~w~에 배팅하였습니다."})
									elseif(v[4] == 0)then
										vRPCasinoC.startRoulette(player, {"그린", tokenNr, 5})
                    vRPclient.notify(player, {"~y~칩 "..tokenNr.."개~w~를 ~g~그린~w~에 배팅하였습니다."})
									end
									rouletteBetters[user_id] = true
								else
									vRPclient.notify(player, {"~r~카지노 칩이 부족합니다!"})
								end
							else
								vRPclient.notify(player, {"~r~카지노 칩은 최대 50개까지 배팅 가능합니다!"})
							end
						else
							vRPclient.notify(player, {"~r~정확한 갯수를 입력해주세요!"})
						end
					else
						vRPclient.notify(player, {"~r~정확한 갯수를 입력해주세요!"})
					end
				end})
			end
		end
	end, v[2]}
end

casinoCasier_menu["칩 구매"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "얼만큼의 칩을 구매하시겠습니까?", "", function(player, tokenNr)
			if(tokenNr ~= "" and tokenNr ~= nil)then
				if(tonumber(tokenNr))then
					tokenNr = math.ceil(tonumber(tokenNr))
					if(tokenNr > 0) and (tokenNr <= 50)then
            if vRP.AddToCompany({281,tonumber(tokenNr*1000000)}) then
              local tax = tonumber(tokenNr*80000)
              vRP.addTax({tax})
              -- 택스 넣어야함
              -- 로그 기록 넣어야함
              local totalPrice = tokenNr * 1080000
						if(vRP.tryFullPayment({user_id, totalPrice}))then
              casinolog("moneylog.txt"," " .. user_id .. " | " .. tokenNr .. "개 구매")
							vRPclient.notify(player, {"~r~"..totalPrice.."$ 줌"})
							vRPclient.notify(player, {"~y~카지노 칩 "..tokenNr.."개 받음"})
							vRP.giveInventoryItem({user_id,"elcato",tokenNr,false})
							vRP.closeMenu({player})
						else
							vRPclient.notify(player, {"~r~돈이 부족합니다!"})
						end
					else
						vRPclient.notify(player, {"~r~한번에 최대 50개 까지 구매 가능합니다!"})
					end
          end
				else
					vRPclient.notify(player, {"~r~정확한 갯수를 입력해주세요!"})
				end
			else
				vRPclient.notify(player, {"~r~정확한 갯수를 입력해주세요!"})
			end
		end})
	end
end, "소비세 포함 <font color='red'>1,080,000$</font>"}

casinoCasier_menu["칩 판매"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "얼만큼의 칩을 판매하시겠습니까?", "", function(player, tokenNr)
			if(tokenNr ~= "" and tokenNr ~= nil)then
				if(tonumber(tokenNr))then
					tokenNr = tonumber(tokenNr)
					if(tokenNr > 0) and (tokenNr <= 1000)then
						if vRP.tryGetInventoryItem({user_id,"elcato",tokenNr,false}) then
							local tokensValue = math.floor(tokenNr * (1000000 - (1000000 * 0.10)))
              if vRP.tryWithdrawToCompany({user_id,281,tonumber(tokenNr * 900000)}) then
              -- 로그 기록
              casinolog("moneylog.txt"," " .. user_id .. " | " .. tokenNr .. "개 판매")
							--vRP.giveMoney({user_id, tokensValue})
							vRPclient.notify(player, {"~y~카지노 칩 "..tokenNr.."개 줌"})
							vRPclient.notify(player, {"~g~"..tokensValue.."$ 받음"})
							vRP.closeMenu({player})
              end
						else
							vRPclient.notify(player, {"~r~카지노 칩의 갯수가 모자랍니다!"})
						end
					else
						vRPclient.notify(player, {"~r~한번에 최대 1000개 까지 판매 가능합니다!"})
					end
				else
					vRPclient.notify(player, {"~r~정확한 갯수를 입력해주세요!"})
				end
			else
				vRPclient.notify(player, {"~r~정확한 갯수를 입력해주세요!"})
			end
		end})
	end
end, "수수료 제외 <font color='red'>900,000$</font> "}

function vRPcs.spawnTokenDealer(thePlayer)
	local casCasier_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.openMenu({player, casinoCasier_menu})
		end
	end

	local casCasier_leave = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.closeMenu({player})
		end
	end

	for i, v in pairs(tokenDealer) do
		if(i == 1)then
			vRPCasinoC.createCasinoText(thePlayer,{v[1], v[2], v[3]+0.7, "~b~칩 환전소"})
			vRP.setArea({thePlayer,"vRP:cashier:"..i,v[1], v[2], v[3],1.7,1.5,casCasier_enter,casCasier_leave})

    else
      vRPCasinoC.createCasinoNPCs(thePlayer,{"A_M_Y_business_01",v[1], v[2], v[3], 80.9213104248, ""})
		end
	end
end

function vRPcs.payRouletteWinnings(winnings, timesby)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if user_id ~= "" and user_id ~= nil then
		local amountToPay = (winnings-1) * (timesby-1)
		vRP.giveInventoryItem({user_id,"elcato",amountToPay,false})
		vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~g~축하드립니다! ~y~칩 "..amountToPay.."개 획득"})
    casinolog("moneylog.txt"," " .. user_id .. " | " .. amountToPay .. "개 룰렛으로 부터 획득")
		rouletteBetters[user_id] = nil
	end
end

function vRPcs.didntWinRoulette()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if user_id ~= "" and user_id ~= nil then
		rouletteBetters[user_id] = nil
	end
end

function vRPcs.spawnTheRoulettes(thePlayer)
	local casRoulette_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.openMenu({player, casinoRoulette_menu})
		end
	end

	local casRoulette_leave = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.closeMenu({player})
		end
	end

	for i, v in pairs(roulettes)do
    if (i == 1) then
		vRPCasinoC.createCasinoText(thePlayer,{v[1], v[2], v[3], "~r~다이아몬드 룰렛"})
		vRP.setArea({thePlayer,"vRP:casino:roulette:"..i,v[1], v[2], v[3],1,1.5,casRoulette_enter, casRoulette_leave})
    elseif (i == 2) then
    vRPCasinoC.createCasinoText(thePlayer,{v[1], v[2], v[3], "~r~다이아몬드 룰렛"})
		vRP.setArea({thePlayer,"vRP:casino:roulette:"..i,v[1], v[2], v[3],1,1.5,casRoulette_enter, casRoulette_leave})
    elseif (i == 3) then
    vRPCasinoC.createCasinoNPCs(thePlayer,{"S_M_M_MovPrem_01",1145.6312255859,261.84237670898,-52.84,220.94094848633, "룰렛 딜러1"})
    elseif (i == 4) then
    vRPCasinoC.createCasinoNPCs(thePlayer,{"S_M_M_MovPrem_01",1143.9876708984,263.61251831055,-52.840,40.84,"룰렛 딜러2"})
    --{1145.6312255859,261.84237670898,-51.84},
	--{1145.6312255859,261.84237670898,-51.84}
    end
	end
end


function vRPcs.spawnTheBarbut(thePlayer)
	local casBarbut_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.openMenu({player, casinoBarbut_menu})
		end
	end

	local casBarbut1v1_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.openMenu({player, casinoBarbut1v1_menu})
		end
	end

	local casBarbut_leave = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.closeMenu({player})
		end
	end

	for i, v in pairs(barbutDealer) do
		if(i == 1)then
			vRPCasinoC.createCasinoText(thePlayer,{v[1], v[2], v[3]+0.7, "~p~Throw Craps 1v1"})
			vRP.setArea({thePlayer,"vRP:casino:barbut:mk:2",v[1], v[2], v[3]+0.2,2.3,1.5,casBarbut1v1_enter,casBarbut_leave})
		elseif(i == 2)then
			vRPCasinoC.createCasinoText(thePlayer,{v[1], v[2], v[3]+0.7, "~p~Throw Craps 1v1"})
			vRP.setArea({thePlayer,"vRP:casino:barbut:mk:3",v[1], v[2], v[3]+0.2,2.3,1.5,casBarbut1v1_enter,casBarbut_leave})
		elseif(i == 3)then
			vRPCasinoC.createCasinoNPCs(thePlayer,{"S_M_M_MovPrem_01",v[1], v[2], v[3], 220.94094848633, "주사위 딜러1"})
			vRP.setArea({thePlayer,"vRP:casino:barbut:npc:2",v[1], v[2], v[3],2.0, 1.5, casBarbut_enter, casBarbut_leave})
		elseif(i == 4)then
			vRPCasinoC.createCasinoNPCs(thePlayer,{"S_M_M_MovPrem_01",v[1], v[2], v[3], 40.94094848633, "주사위 딜러2"})
			vRP.setArea({thePlayer,"vRP:casino:barbut:npc:3",v[1], v[2], v[3],2.0, 1.5, casBarbut_enter, casBarbut_leave})
		end
	end
end

function vRPcs.spinSlotMachine(amount, a, b, c)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if(slotMachinesBetters[user_id] == nil)then
		if vRP.tryGetInventoryItem({user_id,"elcato",amount,false}) then
			slotMachinesBetters[user_id] = true
			vRPCasinoC.checkWinSlotmachine(thePlayer, {tonumber(amount),tostring(a),tostring(b),tostring(c)})
		else
			vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n~r~칩을 그만큼 가지고 있지 않습니다!"})
		end
	else
		vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n~r~이미 플레이 중 입니다!"})
	end
end

function vRPcs.winSlotMachine(reward)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if(reward > 0)then
		reward = reward-1
		vRP.giveInventoryItem({user_id,"elcato",reward,false})
		slotMachinesBetters[user_id] = nil
		vRPclient.notify(thePlayer, {"~y~카지노 칩 "..reward.."개 받음"})
	end
end

function vRPcs.lostSlotMachine()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	slotMachinesBetters[user_id] = nil
end

function vRPcs.doBarbut1v1(thePlayer)
	local user_id = vRP.getUserId({thePlayer})
	local opponentID = barbutPlayers[user_id].oponent
	if(opponentID ~= 0)then
		local theOpponent = vRP.getUserSource({opponentID})

		local opponentRoll = math.random(1, 6)
		local opponentRoll2 = math.random(1, 6)
		local playerRoll = math.random(1, 6)
		local playerRoll2 = math.random(1, 6)
		local totalOpponent = tonumber(opponentRoll + opponentRoll2)
		local totalPlayer = tonumber(playerRoll + playerRoll2)

		local winnings = barbutPlayers[user_id].cota
		SetTimeout(1000, function()
			vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~g~Your Hand: ~p~(~y~"..playerRoll.."~r~ , ~y~"..playerRoll2.."~p~) ~b~("..totalPlayer..")"})
			vRPclient.notify(theOpponent, {"[다이아몬드 카지노]\n ~g~Opponent's Hand: ~p~(~y~"..playerRoll.."~r~ , ~y~"..playerRoll2.."~p~) ~b~("..totalPlayer..")"})
			SetTimeout(1000, function()
				vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~g~Opponent's Hand: ~p~(~y~"..opponentRoll.."~r~ , ~y~"..opponentRoll2.."~p~) ~b~("..totalOpponent..")"})
				vRPclient.notify(theOpponent, {"[다이아몬드 카지노]\n ~g~Your Hand: ~p~(~y~"..opponentRoll.."~r~ , ~y~"..opponentRoll2.."~p~) ~b~("..totalOpponent..")"})
				if(totalOpponent < totalPlayer)then
					vRPclient.notify(theOpponent, {"[다이아몬드 카지노]\n ~r~You lost this hand!"})
					vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~g~You won this hand! You received ~y~"..(winnings*2).." Chips"})
					vRP.giveInventoryItem({user_id,"elcato",winnings*2,false})
				elseif(totalPlayer < totalOpponent)then
					vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~r~You lost this hand!"})
					vRPclient.notify(theOpponent, {"[다이아몬드 카지노]\n ~g~You won this hand! You received ~y~"..(winnings*2).." Chips"})
					vRP.giveInventoryItem({opponentID,"elcato",winnings*2,false})
				elseif((opponentRoll == playerRoll) and (opponentRoll2 == playerRoll2))then
					vRPclient.notify(theOpponent, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..winnings.." Chips"})
					vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..winnings.." Chips"})
					vRP.giveInventoryItem({user_id,"elcato",winnings,false})
					vRP.giveInventoryItem({opponentID,"elcato",winnings,false})
				elseif((opponentRoll == playerRoll2) and (opponentRoll2 == playerRoll))then
					vRPclient.notify(theOpponent, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..winnings.." Chips"})
					vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..winnings.." Chips"})
					vRP.giveInventoryItem({user_id,"elcato",winnings,false})
					vRP.giveInventoryItem({opponentID,"elcato",winnings,false})
				elseif (totalPlayer == totalOpponent)then
					vRPclient.notify(theOpponent, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..winnings.." Chips"})
					vRPclient.notify(thePlayer, {"[다이아몬드 카지노]\n ~g~This hand was a draw! You received back ~y~"..winnings.." Chips"})
					vRP.giveInventoryItem({user_id,"elcato",winnings,false})
					vRP.giveInventoryItem({opponentID,"elcato",winnings,false})
				end
			end)
		end)
		barbutPlayers[user_id] = {oponent = 0, cota = 0}
	end
end

AddEventHandler("vRP:playerLeave", function(user_id, source)
	rouletteBetters[user_id] = nil
	slotMachinesBetters[user_id] = nil
	barbutPlayers[user_id] = nil
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	SetTimeout(1500, function()
		vRPcs.spawnTheRoulettes(source)
		vRPcs.spawnTokenDealer(source)
		vRPcs.spawnTheBarbut(source)
		rouletteBetters[user_id] = nil
		slotMachinesBetters[user_id] = nil
		barbutPlayers[user_id] = {oponent = 0, cota = 0}
		vRPclient.setNamedBlip(source, {"vRP:casino:blip", 926.05487060546,43.760063171386,80.899948120118, 214, 2, "Casino"})
	end)
end)

AddEventHandler('chatMessage', function(source, name, msg)
	cm = stringsplit(msg, " ");
	if cm[1] == "/casino" then
	CancelEvent()
    vRPcs.spawnTheRoulettes(source)
		vRPcs.spawnTokenDealer(source)
		vRPcs.spawnTheBarbut(source)
  end
	end)

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

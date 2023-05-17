local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_bk")



AddEventHandler('chatMessage', function(source, name, msg)
	cm = stringsplit(msg, " ");
	if cm[1] == "/c" then
	CancelEvent()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local s = source
    local bkLvl = cm[2]
    if vRP.hasPermission({user_id,"police.vehicle"}) then
    if not bkLvl then
        TriggerClientEvent("Fax:ShowInfo", source, "~y~코드 지정 요망. ~n~~s~1, 2, 3, 99")
    elseif bkLvl == "1" then
        TriggerClientEvent("Fax:BackupReq", -1, bkLvl, s)
    elseif bkLvl == "2" then
        TriggerClientEvent("Fax:BackupReq", -1, bkLvl, s)
    elseif bkLvl == "3" then
        TriggerClientEvent("Fax:BackupReq", -1, bkLvl, s)
    elseif bkLvl == "99" then
        TriggerClientEvent("Fax:BackupReq", -1, bkLvl, s)
    elseif bkLvl ~= "1" or bkLvl ~= "2" or bkLvl ~= "3" or bkLvl ~= "99" then
        TriggerClientEvent("Fax:ShowInfo", source, "~y~올바르지 않은 코드")
    end
  else
    TriggerClientEvent("Fax:ShowInfo", source, "~r~당신은 경찰이 아닙니다.")
	end
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
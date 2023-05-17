local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_stationaryRadars")

RegisterServerEvent('cobrarMulta')
AddEventHandler('cobrarMulta', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local multa = 880000
	if vRP.hasPermission({user_id,"no.camera"}) then
        vRPclient.notify(player,{"~r~경찰 및 EMS는 벌금이 부과되지 않습니다."})    		
	else
	vRP.tryFullPayment({user_id,multa})
  vRP.addTax({multa})
end
end)

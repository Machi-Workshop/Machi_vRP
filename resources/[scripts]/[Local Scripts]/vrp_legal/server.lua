local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_legal")

RegisterServerEvent("desempregado")
AddEventHandler("desempregado", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "실업자"})
  vRP.stopMission({source})
	vRPclient.notify(source,{"~r~직업을 잃었습니다."})
  end
end)

RegisterServerEvent("pescador")
AddEventHandler("pescador", function()
  local source = source
  local user_id = vRP.getUserId({source})
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "어부"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~어부~w~가 되셨습니다."})
  end
end)

RegisterServerEvent("taxi")
AddEventHandler("taxi", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "택시"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~택시~w~가 되셨습니다."})
  end
end)

RegisterServerEvent("mecanico")
AddEventHandler("mecanico", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "정비공"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~정비공~w~이 되셨습니다."})
  end
end)

RegisterServerEvent("transportador")
AddEventHandler("transportador", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "트럭 기사"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~트럭 기사~w~가 되셨습니다."})
  end
end)

RegisterServerEvent("onibus")
AddEventHandler("onibus", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "버스 기사"})
  vRP.stopMission({source})
	vvRPclient.notify(source, {"~g~버스 기사~w~가 되셨습니다."})
  end
end)

RegisterServerEvent("eletricista")
AddEventHandler("eletricista", function()
  local source = source
  local user_id = vRP.getUserId({source})

  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "Eletricista"})
	vRPclient._notify(source, {"Agora você é um Eletricista"})
  end
end)

RegisterServerEvent("motoboy")
AddEventHandler("motoboy", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "배달부 LV.1"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~배달부~w~가 되셨습니다."})
  end
end)

RegisterServerEvent("mineradima")
AddEventHandler("mineradima", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "광부"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~광부~w~가 되셨습니다."})
  end
end)

RegisterServerEvent("mineraouro")
AddEventHandler("mineraouro", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "택배"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~택배 기사~w~가 되셨습니다."})
  end
end)

RegisterServerEvent("mineracobre")
AddEventHandler("mineracobre", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "의료수송원"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~의료수송원~w~이 되셨습니다."})
  end
end)

RegisterServerEvent("garimpeiro")
AddEventHandler("garimpeiro", function()
  local source = source
  local user_id = vRP.getUserId({source})
  
  if vRP.hasGroup({user_id, "user"}) then
	vRP.addUserGroup({user_id, "피자배달부"})
  vRP.stopMission({source})
	vRPclient.notify(source, {"~g~피자배달부~w~가 되셨습니다."})
  end
end)
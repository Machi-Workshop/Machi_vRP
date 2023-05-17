local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_fixcar")

AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/fix" then
	  local user_id = vRP.getUserId({source})
	  local player = vRP.getUserSource({user_id})
	  if vRP.hasGroup({user_id,"LSPD 시보"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
	  elseif vRP.hasGroup({user_id,"LSPD 순경"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
	  elseif vRP.hasGroup({user_id,"LSPD 경장"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
	  elseif vRP.hasGroup({user_id,"LSPD 경사"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
	  elseif vRP.hasGroup({user_id,"LSPD 경위"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
	  elseif vRP.hasGroup({user_id,"LSPD 경감"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
	  elseif vRP.hasGroup({user_id,"경찰서장"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
	  elseif vRP.hasGroup({user_id,"경찰청장"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);	  
	  elseif vRP.hasGroup({user_id,"EMS 구급대원 인턴"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"EMS 구급대원"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"EMS 전문의"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"EMS 병원장"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"의료국장"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"경찰특공대원"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"경찰특공대장"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"국가정보원장"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"국가정보원 감찰관"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"LSPD 경정"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
	  end
	end
end)
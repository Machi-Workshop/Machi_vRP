-- Import vRP Module
local Proxy = module("vrp", "lib/Proxy");
local vRP = Proxy.getInterface("vRP");

-- Reboot Cancel Noticement
if CONFIG.rebootNotice == true then
  -- Reboot Noticement Enabled
  local rebootCommand = CONFIG.rebootNoticeCancelCommand or "rnotice";
  RegisterCommand(rebootCommand, function (source, args, rawCommand)
    local user_id = vRP.getUserId({source});
    if vRP.hasPermission({user_id, CONFIG.rebootNoticePermission}) == true then
      -- Has Reboot Permission
      TriggerClientEvent("real:rebootNoticeCancel", -1, {
        username = GetPlayerName(source),
      });
    end
  end, false);
end

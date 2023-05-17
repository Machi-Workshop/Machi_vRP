-- Import vRP Module
local Proxy = module("vrp", "lib/Proxy");
local vRP = Proxy.getInterface("vRP");

-- Admin Noticement
if CONFIG.adminNotice == true then
  -- Admin Noticement Enabled
  local adminCommand = CONFIG.adminNoticeCommand or "anotice";
  RegisterCommand(adminCommand, function (source, args, rawCommand)
    local user_id = vRP.getUserId({source});
    if vRP.hasPermission({user_id, CONFIG.adminNoticePermission}) == true then
      -- Has Admin Permission
      TriggerClientEvent("real:adminNotice", -1, {
        username = GetPlayerName(source),
        content = table.concat(args, " "),
      });
    end
  end, false);
end

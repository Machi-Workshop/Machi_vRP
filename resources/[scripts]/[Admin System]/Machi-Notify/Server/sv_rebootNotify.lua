-- Import vRP Module
local Proxy = module("vrp", "lib/Proxy");
local vRP = Proxy.getInterface("vRP");

local GLOBAL_REBOOT_ENABLED = false;
local GLOBAL_REBOOT_TIME = 0;

-- Reboot Noticement
if CONFIG.rebootNotice == true then
  -- Reboot Noticement Enabled
  local rebootCommand = CONFIG.rebootNoticeCommand or "rnotice";
  RegisterCommand(rebootCommand, function (source, args, rawCommand)
    local user_id = vRP.getUserId({source});
    if vRP.hasPermission({user_id, CONFIG.rebootNoticePermission}) == true then
      -- Has Reboot Permission
      TriggerClientEvent("real:rebootNotice", -1, {
        username = GetPlayerName(source),
        rebootNotifyTime = args[1]
      });

      GLOBAL_REBOOT_ENABLED = true;
      GLOBAL_REBOOT_TIME = args[1] * 60;

      -- Create Reboot Thread
      Citizen.CreateThread(function ()
        while true do
          Citizen.Wait(1000);
          if GLOBAL_REBOOT_ENABLED == true then
            -- Reboot Enabled
            if GLOBAL_REBOOT_TIME <= 0 then
              -- Reboot Trigered
              Citizen.Wait(5000);
              for _, v in ipairs(GetPlayers()) do
                vRP.kick({v, CONFIG.rebootKickMessage});
              end
            else
              -- Set Rebooting Time
              GLOBAL_REBOOT_TIME = GLOBAL_REBOOT_TIME - 1;
            end
          else
            -- Reboot Stopped
            break;
          end
        end
      end);
    end
  end, false);

  -- Add PlayerConnecting Handler
  AddEventHandler("playerConnecting", function(playerName, setKickReason, d)
    d.defer();
    d.update("[리얼월드] 리부팅이 진행될 예정인지 확인 중입니다.");
    Citizen.Wait(2000);

    if GLOBAL_REBOOT_ENABLED == true then
      d.presentCard([==[{"$schema": "http://adaptivecards.io/schemas/adaptive-card.json","type": "AdaptiveCard","version": "1.0","body": [{"type": "TextBlock","size": "Medium","weight": "Bolder","text": "서버가 리부팅 될 예정입니다."},{"type": "TextBlock","text": "그래도 연결하시겠습니까?","wrap": true}],"actions": [{"id": "connect","type": "Action.Submit","title": "연결하기","data": {"connect": true}},{"id": "wait","type": "Action.Submit","title": "기다리기","data": {"connect": false}}]}]==],
        function(data, rawData)
          if data.connect == true then
            d.done();
          else
            d.done(CONFIG.rebootKickMessage);
          end
        end);
    else
      d.done();
    end
  end)
end

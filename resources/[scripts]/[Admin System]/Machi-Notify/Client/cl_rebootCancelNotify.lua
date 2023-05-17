-- Reboot Notice Module
-- 
RegisterNetEvent("real:rebootNoticeCancel");
AddEventHandler("real:rebootNotice", function(noticeObject)
  -- Reboot Notice
  SendNUIMessage({
    type = "REBOOT_CANCEL_MESSAGE",
  });
end);

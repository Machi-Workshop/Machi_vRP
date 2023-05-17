-- Reboot Notice Module
-- 
RegisterNetEvent("real:rebootNotice");
AddEventHandler("real:rebootNotice", function(noticeObject)
  -- Reboot Notice
  SendNUIMessage({
    type = "REBOOT_MESSAGE",
    rebootNotifyTime = noticeObject.rebootNotifyTime,
  });
end);

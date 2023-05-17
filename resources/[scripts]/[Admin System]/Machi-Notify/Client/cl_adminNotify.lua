-- Admin Notice Module
-- 
RegisterNetEvent("real:adminNotice");
AddEventHandler("real:adminNotice", function(noticeObject)
  -- Admin Notice
  SendNUIMessage({
    type = "ADMIN_MESSAGE",
    username = noticeObject.username,
    content = noticeObject.content,
  });
end);

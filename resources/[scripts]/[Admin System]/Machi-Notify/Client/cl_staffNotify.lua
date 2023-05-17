-- Staff Notice Module
-- 
RegisterNetEvent("real:staffNotice");
AddEventHandler("real:staffNotice", function(noticeObject)
  -- Staff Notice
  SendNUIMessage({
    type = "STAFF_MESSAGE",
    username = noticeObject.username,
    content = noticeObject.content,
  });
end);

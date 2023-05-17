-- EMS Notice Module
-- 
RegisterNetEvent("real:emsNotice");
AddEventHandler("real:emsNotice", function (noticeObject)
  -- EMS Notice
  SendNUIMessage({
    type = "EMS_MESSAGE",
    username = noticeObject.username,
    content = noticeObject.content,
  });
end)
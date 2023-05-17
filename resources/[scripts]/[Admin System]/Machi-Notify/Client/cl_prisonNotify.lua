-- Prison Notice Module
-- 
RegisterNetEvent("real:prisonNotice");
AddEventHandler("real:prisonNotice", function (noticeObject)
  -- Prison Notice
  SendNUIMessage({
    type = "PRISON_MESSAGE",
    username = noticeObject.username,
    content = noticeObject.content,
  });
end)

-- Police Notice Module
-- 
RegisterNetEvent("real:policeNotice");
AddEventHandler("real:policeNotice", function (noticeObject)
  -- Police Notice
  SendNUIMessage({
    type = "POLICE_MESSAGE",
    username = noticeObject.username,
    content = noticeObject.content,
  });
end)

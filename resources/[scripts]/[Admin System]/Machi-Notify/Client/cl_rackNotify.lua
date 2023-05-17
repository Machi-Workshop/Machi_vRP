-- Rack Notice Module
-- 
RegisterNetEvent("real:rackNotice");
AddEventHandler("real:rackNotice", function (noticeObject)
  -- Rack Notice
  SendNUIMessage({
    type = "RACK_MESSAGE",
    username = noticeObject.username,
    content = noticeObject.content,
  });
end)

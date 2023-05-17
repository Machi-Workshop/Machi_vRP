-- Basic Notice Module for 3rd-Party Libs
--
-- 기타 라이브러리들의 UI 연동을 위해 제공된 클라이언트 이벤트입니다.
-- Optional 옵션들은 제공하지 않으면 기본 값으로 제공됩니다.
-- [!] 이 클라이언트 이벤트에서 생성된 공지는 제거가 불가능하니, 주의하시기 바랍니다.
-- [!] 별도 권한 확인을 하지 않으므로, 서버 단에서 확인 후 이벤트 전송 바랍니다.
--
RegisterNetEvent("real:basicNotice")
AddEventHandler("real:basicNotice", function (noticeObject)
  -- Basic Message Event
  SendNUIMessage({
    type = "ON_ADD_NOTIFY",
    notify = {
      -- Required
      theme = noticeObject.theme,
      icon = noticeObject.icon,
      title = noticeObject.title,
      content = noticeObject.content,
      author = noticeObject.author,
      appName = noticeObject.appName,
      -- Disabled: Due to UI Changes
      appIcon = noticeObject.appIcon,
      -- Optional
      audio = noticeObject.audio,
      time = noticeObject.time,
    }
  });
end)

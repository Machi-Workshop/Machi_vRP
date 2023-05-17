-- 레이븐 UI 공지 설정 파일
-- 각 공지를 비활성화 하거나, 활성화 할 수 있습니다.
-- 또한 공지 별 사용되는 명령어를 수정할 수 있으며, 필요한 권한 또한 수정할 수 있습니다.

CONFIG = {
  -- 첫 접속 시 공지
  welcomeNotice = true,

  -- 관리자 공지
  adminNotice = true,
  adminNoticeCommand = "관리자",
  adminNoticePermission = "admin.notice",

  -- 리부팅 공지
  rebootNotice = true,
  rebootNoticeCommand = "리붓",
  rebootNoticeCancelCommand = "리붓정지",
  rebootNoticePermission = "admin.notice",

  -- 리부팅 진행 중 새 접속 차단 여부
  checkNewConnectionWhileReboot = true,
  -- 리부팅 진행 안내
  rebootKickMessage = "< MACHI > 서버가 리부팅 됩니다. 잠시후 다시 접속 시도 부탁드립니다.",
}
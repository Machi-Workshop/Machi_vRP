local cfg = {}

--[[
Developed by Leo SHK
Version 1.1

cmd - chat call command
display - visual display in the chat
anonymous - invisible nickname (true or false)
userdb - true show firstname and lastname from database, false show steam/fivem nickname
permission - create permission and insert to group in vrp/cfg/group.lua
]]--

--standard chat, for users who do not have groups (permission)
cfg.chatuserdefault = {display = "시 민 |", userdb = true, r = 255, g = 255, b = 255}

cfg.chatcmd = {
  {cmd = "/twitter", display= "@twitter | ", anonymous = false, userdb = true, permission ="chatcmd.function", r =  7, g = 206, b = 246},
  {cmd = "/anon", display= "@anonymous | ", anonymous = true, userdb = false, permission = "chatcmd.function", r =  129, g = 154, b = 151},
  {cmd = "/!", display= "💡공지💡", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 0, b = 0},
  {cmd = "/news", display= "긴급속보", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 0, b = 0},
  {cmd = "/cop", display= "🛰️ 엘리시움 위성 경찰 시스템 🛰️ ", anonymous = true, userdb = false, permission = "admin.menu", r = 120, g = 150, b = 255 },
  {cmd = "!!", display= "^_💬 관 리 자 | O O C | YoJeong^r^*", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 0, b = 0},
  {cmd = "@@", display= "^_💬 총 관 리 자 | O O C | Asuka^r^*", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 0, b = 0},
  {cmd = "##", display= "시 민 | 1 | Asuka^r^*", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 255, b = 255},
  {cmd = "==", display= "^_💬 개 발 자 | O O C | Rolex^r^*", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 255, b = 0},
  --{cmd = "$$", display= "삼합회 | 실장 ^0| 2813 | gantoo", anonymous = true, userdb = false, permission = "admin.menu", r =  0, g = 0, b = 0},
  --{cmd = "##", display= "^1중^2고^3차^4 딜^5러^0 | 1 | Kirara Asuka", anonymous = true, userdb = false, permission = "admin.menu", r =  0, g = 255, b = 0},
  {cmd = "$$", display= "^5바 텐 더^0 | 1 | Asuka", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 255, b = 255},
  {cmd = "%%", display= "L S P D | 경사 | 2164 | master", anonymous = true, userdb = false, permission = "admin.menu", r =  90, g = 150, b = 255},
  {cmd = "/ems", display= "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다.", anonymous = true, userdb = false, permission = "chatrules.emscheif1", r =  255, g = 100, b = 0},
  {cmd = "/ems", display= "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다.", anonymous = true, userdb = false, permission = "chatrules.emscheif2", r =  255, g = 100, b = 0},
  {cmd = "/ems", display= "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다. ", anonymous = true, userdb = false, permission = "chatrules.lieutenant", r =  255, g = 100, b = 0},
  {cmd = "/ems", display= "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다. ", anonymous = true, userdb = false, permission = "chatrules.paramedic", r =  255, g = 100, b = 0},
  {cmd = "/ems", display= "🔥 응급상황엔 EMS 불러주세요. 다만 중복신고, 구급대원 재촉 시 출동하지 않습니다. ", anonymous = true, userdb = false, permission = "chatrules.emssnr", r =  255, g = 100, b = 0},
  --{cmd = "##", display= "하느님 | 1 | Kanagawa Ruka ", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 0, b = 0},
  --{cmd = "%%", display= "公道 Blacklist | ", anonymous = true, userdb = false, permission = "admin.menu", r =  255, g = 0, b = 0},
}

cfg.chatgroups = {
  {display = "시 민 | 백수 |", userdb = true, permission = "citizen.paycheck", r = 255, g = 255, b = 255 },
  {display = "시 민 | ^3택시^7 |", userdb = true, permission = "chatrules.uber", r = 255, g = 255, b = 255 },
  {display = "시 민 | 정비공 |", userdb = true, permission = "chatrules.mechanic", r = 255, g = 255, b = 255 },
  --{display = "현대해상 정비공 |", userdb = true, permission = "chatrules.mechanic2", r = 255, g = 255, b = 255 },
  {display = "시 민 | 딜리버리 |", userdb = true, permission = "chatrules.delivery", r = 255, g = 255, b = 255 },
  {display = "시 민 | 택배 |", userdb = true, permission = "chatrules.ups", r = 255, g = 255, b = 255 },
  {display = "총 리 부 | 경호원 |", userdb = true, permission = "pa.paycheck", r = 255, g = 204, b = 51 }, 
  {display = "총 리 부 | 비서실장 |", userdb = true, permission = "ps.paycheck", r = 255, g = 204, b = 51 }, 
  {display = "N I S | 감찰관 |", userdb = true, permission = "chatrules.nis2", r = 90, g = 150, b = 255 },
  {display = "N I S | 국가정보원장 |", userdb = true, permission = "chatrules.nis1", r = 90, g = 150, b = 255 },
  {display = "L S P D | 시보 |", userdb = true, permission = "chatrules.lspd0", r = 90, g = 150, b = 255 },
  {display = "L S P D | 순경 |", userdb = true, permission = "chatrules.lspd1", r = 90, g = 150, b = 255 },
  {display = "L S P D | 경장 |", userdb = true, permission = "chatrules.lspd2", r = 90, g = 150, b = 255 },
  {display = "L S P D | 경사 |", userdb = true, permission = "chatrules.lspd3", r = 90, g = 150, b = 255 },
  {display = "L S P D | 경위 |", userdb = true, permission = "chatrules.lspd4", r = 90, g = 150, b = 255 },
  {display = "L S P D | 경감 |", userdb = true, permission = "chatrules.lspd5", r = 90, g = 150, b = 255 },
  --{display = "경 찰 청 | LSIA Police", userdb = true, permission = "chatrules.police1", r = 90, g = 150, b = 255 },
  {display = "L S P D | 서장 |", userdb = true, permission = "chatrules.policecaptain", r = 0, g = 150, b = 255 },
  {display = "L S P D | 청장 |", userdb = true, permission = "chatrules.poldirector", r = 0, g = 150, b = 255 },
  {display = "S W A T | 경찰특공대 |", userdb = true, permission = "SWAT.cloakroom", r = 120, g = 150, b = 255 },
  {display = "경 찰 청 | IAA |", userdb = true, permission = "chatrules.iaa", r = 120, g = 150, b = 255 },
  {display = "법 무 부 | 교도관 |", userdb = true, permission = "chatrules.prisonofficer", r = 120, g = 150, b = 255 },
  {display = "변 호 사 |", userdb = true, permission = "Lawyer.paycheck", r = 255, g = 204, b = 100 },
  {display = "E M S | 의료국장 |", userdb = true, permission = "chatrules.emscheif1", r = 51, g = 255, b = 102 },
  {display = "E M S | 병원장 |", userdb = true, permission = "chatrules.emscheif2", r = 51, g = 255, b = 102 },
  {display = "E M S | 전문의 |", userdb = true, permission = "chatrules.lieutenant", r = 51, g = 255, b = 102 },
  {display = "E M S | 구급대원 |", userdb = true, permission = "chatrules.paramedic", r = 51, g = 255, b = 102 },
  {display = "E M S | 인턴 |", userdb = true, permission = "chatrules.emssnr", r = 51, g = 255, b = 102 },
  {display = "A E | 기장 |", userdb = true, permission = "chatrules.airlinepilot", r = 95, g = 232, b = 239 },
  {display = "A E | 부기장 |", userdb = true, permission = "chatrules.airlinecopilot", r = 95, g = 232, b = 239 },
  {display = "A E | 승무원 |", userdb = true, permission = "chatrules.airlineFA", r = 95, g = 232, b = 239 },
  {display = "A E | 관제사 |", userdb = true, permission = "chatrules.atc", r = 95, g = 232, b = 239 },
  {display = "A E | 대 표 |", userdb = true, permission = "chatrules.aec", r = 25, g = 200, b = 255 },
  {display = "시티투어 | 소속기사 |", userdb = true, permission = "chatrules.ect3", r = 25, g = 200, b = 255 },
  {display = "시티투어 | 팀장 |", userdb = true, permission = "chatrules.ect2", r = 25, g = 200, b = 255 },
  {display = "시티투어 | 대표 |", userdb = true, permission = "chatrules.ect1", r = 25, g = 200, b = 255 },
  {display = "D J |", userdb = true, permission = "chatrules.dj", r = 0, g = 255, b = 255 },
  {display = "총 리 부 | 총리 |", userdb = true, permission = "chatrules.president", r = 255, g = 204, b = 51 }, --총 리 부 | 👑 총리 👑 
  {display = "마피아 | 조직원 |", userdb = true, permission = "chatrules.blood1", r = 200, g = 0, b = 160 },
  {display = "마피아 | 행동대장 |", userdb = true, permission = "chatrules.blood2", r = 200, g = 0, b = 160 },
  {display = "마피아  | 대부 |", userdb = true, permission = "chatrules.godfather", r = 200, g = 0, b = 160 },
  {display = "삼합회 | 회장 ^0|", userdb = true, permission = "chatrules.shh4", r = 150, g = 150, b = 150 },
  {display = "삼합회 | 부회장 ^0|", userdb = true, permission = "chatrules.shh3", r = 150, g = 150, b = 150 },
  {display = "삼합회 | 전무이사 ^0|", userdb = true, permission = "chatrules.shh5", r = 150, g = 150, b = 150 },
  {display = "삼합회 | 상무이사 ^0|", userdb = true, permission = "chatrules.shh6", r = 150, g = 150, b = 150 },
  {display = "삼합회 | 실장 ^0|", userdb = true, permission = "chatrules.shh2", r = 150, g = 150, b = 150 },
  {display = "삼합회 | 조직원 ^0|", userdb = true, permission = "chatrules.shh1", r = 150, g = 150, b = 150 },
  {display = "시미즈카이 | 회장 ^0|", userdb = true, permission = "chatrules.ykz1", r = 200, g = 0, b = 0 },
  {display = "시미즈카이 | 사모님 ^0|", userdb = true, permission = "chatrules.ykz10", r = 200, g = 0, b = 0 },
  {display = "시미즈카이 | 총무 ^0|", userdb = true, permission = "chatrules.ykz11", r = 200, g = 0, b = 0 },
  {display = "시미즈카이 | 부회장 ^0|", userdb = true, permission = "chatrules.ykz12", r = 200, g = 0, b = 0 },
  {display = "시미즈카이 | 조장 ^0|", userdb = true, permission = "chatrules.ykz2", r = 200, g = 0, b = 0 },
  {display = "시미즈카이 | 행동대장 ^0|", userdb = true, permission = "chatrules.ykz3", r = 200, g = 0, b = 0 },
  {display = "시미즈카이 | 조직원 ^0|", userdb = true, permission = "chatrules.ykz4", r = 200, g = 0, b = 0 },
}

cfg.ad = {
  --{display = "[자동공지]", text = "엘리시움에서는 주민등록증의 성 / 이름으로 플레이하게 됩니다.", r = 255, g = 255, b = 255},
  
}

return cfg

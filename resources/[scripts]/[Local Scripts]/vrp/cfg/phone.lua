
local cfg = {}

-- size of the sms history
cfg.sms_history = 15

-- maximum size of an sms
cfg.sms_size = 500

-- duration of a sms position marker (in seconds)
cfg.smspos_duration = 300

-- define phone services
-- blipid, blipcolor (customize alert blip)
-- alert_time (alert blip display duration in seconds)
-- alert_permission (permission required to receive the alert)
-- alert_notify (notification received when an alert is sent)
-- notify (notification when sending an alert)
cfg.services = {
  ["112 긴급"] = {
    blipid = 304,
    blipcolor = 38,
    alert_time = 30, -- 5 minutes
    alert_permission = "police.service",
    alert_notify = "~r~경찰 알림 :~n~~s~",
    notify = "~b~경찰을 호출했습니다.",
    answer_notify = "~b~경찰이 출발했습니다."
  },
  ["119 긴급"] = {
    blipid = 153,
    blipcolor = 1,
    alert_time = 30, -- 5 minutes
    alert_permission = "emergency.service",
    alert_notify = "~r~긴급 알림 :~n~~s~",
    notify = "~b~구급대원을 호출했습니다.",
    answer_notify = "~b~구급대원이 출발했습니다."
  },
  ["택시"] = {
    blipid = 198,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "uber.service",
    alert_notify = "~y~택시 알림 :~n~~s~",
    notify = "~y~택시 기사를 호출했습니다.",
    answer_notify = "~y~택시 기사가 출발했습니다."
  },
  ["메이즈보험사 호출"] = {
    blipid = 446,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "repair.service",
    alert_notify = "~y~보험사 알림 :~n~~s~",
    notify = "~y~보험사를 호출했습니다.",
    answer_notify = "~y~보험사가 출발 했습니다."
  },
  ["물건 배달"] = {
    blipid = 494,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "delivery.service",
    alert_notify = "~y~배달 알림 :~n~~s~",
    notify = "~y~물건 배달을 호출했습니다.",
    answer_notify = "~y~물건 배달이 출발했습니다."
  },
  ["도미노 피자"] = {
    blipid = 494,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "domino.service",
    alert_notify = "~y~배달 알림 :~n~~s~",
    notify = "~y~피자 배달을 호출했습니다.",
    answer_notify = "~y~피자 배달이 출발했습니다."
  }
}

-- define phone announces
-- image: background image for the announce (800x150 px)
-- price: amount to pay to post the announce
-- description (optional)
-- permission (optional): permission required to post the announce
cfg.announces = {
  ["admin"] = {
    --image = "nui://vrp_mod/announce_admin.png",
    image = "https://i.imgur.com/kFvV2ed.png",
    price = 0,
    description = "Admin only.",
    permission = "admin.announce"
  },
  ["president"] = {
    --image = "nui://vrp_mod/announce_police.png",
    image = "http://imgur.com/T0wrmUI.png",
    price = 0,
    description = "President Only",
    permission = "president.announce"
  },
  ["police"] = {
    --image = "nui://vrp_mod/announce_police.png",
    image = "http://i.imgur.com/DY6DEeV.png",
    price = 0,
    description = "Only for police, ex: wanted advert.",
    permission = "police.announce"
  },
  ["EMS"] = {
    --image = "nui://vrp_mod/announce_police.png",
    image = "http://i.imgur.com/DY6DEeV.png",
    price = 0,
    description = "Only for EMS",
    permission = "ems.announce"
  },
  ["commercial"] = {
    --image = "nui://vrp_mod/announce_commercial.png",
    image = "http://i.imgur.com/b2O9WMa.png",
    description = "Commercial stuff (buy, sell, work).",
    price = 5000
  },
  ["party"] = {
    --image = "nui://vrp_mod/announce_party.png",
    image = "http://i.imgur.com/OaEnk64.png",
    description = "Organizing a party ? Let everyone know the rendez-vous.",
    price = 5000
  },
  ["airelysium"] = {
    --image = "nui://vrp_mod/announce_police.png",
    image = "http://imgur.com/QRVQYIH.png",
    price = 0,
    description = "Air Elysium Only",
    permission = "airelysium.announce"
  },
}

return cfg


local cfg = {}
-- list of weapons for sale
-- for the native name, see https://wiki.fivem.net/wiki/Weapons (not all of them will work, look at client/player_state.lua for the real weapon list)
-- create groups like for the garage config
-- [native_weapon_name] = {display_name,body_price,ammo_price,description}
-- ammo_price can be < 1, total price will be rounded

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.gunshop_types = {
["Paleto"] = {
    _config = {blipid=110,blipcolor=1},
    ["WEAPON_BOTTLE"] = {"병",1000,0,""},
    ["WEAPON_BAT"] = {"야구방망이",5000,0,""},
    ["WEAPON_KNUCKLE"] = {"너클 더스터",10000,0,""},
    ["WEAPON_KNIFE"] = {"나이프",5000,0,""},
    ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,2,""},
    ["WEAPON_SNSPISTOL"] = {"SNS피스톨",250000,2,""},
    ["WEAPON_VINTAGEPISTOL"] = {"빈티지 피스톨",250000,2,""},
    ["WEAPON_PISTOL"] = {"피스톨",50000,2,""},
    ["WEAPON_COMBATPISTOL"] = {"컴뱃 피스톨",500000,2,""},
    ["WEAPON_HEAVYPISTOL"] = {"헤비 피스톨",500000,2,""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨",750000,2,""},
    ["WEAPON_DAGGER"] = {"고전적 기사 단검",10000,0,""},
    ["WEAPON_HAMMER"] = {"망치",5000,0,""},
    ["WEAPON_HATCHET"] = {"손도끼",10000,0,""},
    ["WEAPON_MICROSMG"] = {"마이크로 SMG",500000,5,""},
    ["WEAPON_SMG"] = {"SMG",500000,5,""},
    ["WEAPON_ASSAULTSMG"] = {"어썰트 SMG",550000,5,""},
    ["WEAPON_COMBATPDW"] = {"컴뱃 PDW",750000,5,""},
    ["WEAPON_MACHINEPISTOL"] = {"머신 Pistol",750000,5,""},
    ["WEAPON_CROWBAR"] = {"쇠 지렛대",7000,0,""},
    ["WEAPON_GOLFCLUB"] = {"골프채",3000,0,""},
    ["WEAPON_SWITCHBLADE"] = {"스위치 블레이드",10000,0,""},
    ["WEAPON_MACHETE"] = {"마체테",15000,0,""},
    ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,5,""},
    ["WEAPON_SNSPISTOL"] = {"SNS피스톨",250000,5,""},
    ["WEAPON_COMPACTRIFLE"] = {"마이크로 SMG",550000,10,""},
    ["WEAPON_ASSAULTRIFLE"] = {"어썰트 라이플",6500000,50,""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총",6500000,50,""},
    ["WEAPON_FLARE"] = {"신호탄",1000,10,""},
    ["WEAPON_GUSENBERG"] = {"구젠버그 스위퍼",500000,5,""},
    ["WEAPON_MG"] = {"MG",10000000,75,""},
    ["WEAPON_COMBATMG"] = {"컴뱃 MG",15000000,100,""},
    ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,7,""},
    ["WEAPON_SNSPISTOL"] = {"피스톨",50000,7,""},
    ["WEAPON_MARKSMANRIFLE"] = {"마크스맨 라이플",10000000,100,""},
    ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플",20000000,75,""},
    ["WEAPON_BULLPUPRIFLE"] = {"불펍 라이플",5000000,45,""},
    ["WEAPON_ADVANCEDRIFLE"] = {"차세대 라이플",6500000,50,""},
    ["WEAPON_SPECIALCARBINE"] = {"스페셜 카빈소총",6500000,50,""},
    ["WEAPON_FLARE"] = {"신호탄",1000,10,""},
    ["WEAPON_SAWNOFFSHOTGUN"] = {"소드오프 샷건",3000000,65,""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",700000,20,""},
    ["WEAPON_BULLPUPSHOTGUN"] = {"불펍 샷건",1000000,30,""},
    ["WEAPON_HEAVYSHOTGUN"] = {"헤비 샷건",5000000,50,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건",15000000,50,""},
    --["WEAPON_FIREWORK"] = {"폭죽",2000,0,""},
    ["WEAPON_SNOWBALL"] = {"눈",3000000,0,""},
    ["WEAPON_FLASHLIGHT"] = {"라이트",2000,0,""},
    ["WEAPON_MUSKET"] = {"머스킷",5000000,0,""},
    ["WEAPON_FLAREGUN"] = {"신호탄 총",3500,0,""},
    ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,15,""},
    ["WEAPON_SNSPISTOL"] = {"SNS 피스톨",250000,15,""},
    ["WEAPON_PETROLCAN"] = {"석유통",25000,0,""}
  },
  ["eastlossantos1"] = {
    _config = {blipid=110,blipcolor=1},
    ["WEAPON_BOTTLE"] = {"병",1000,0,""},
    ["WEAPON_BAT"] = {"야구방망이",5000,0,""},
    ["WEAPON_KNUCKLE"] = {"너클 더스터",10000,0,""},
    ["WEAPON_KNIFE"] = {"나이프",5000,0,""},
	["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,2,""},
    ["WEAPON_SNSPISTOL"] = {"SNS피스톨",250000,2,""},
    ["WEAPON_VINTAGEPISTOL"] = {"빈티지 피스톨",250000,2,""},
    ["WEAPON_PISTOL"] = {"피스톨",50000,2,""},
    ["WEAPON_COMBATPISTOL"] = {"컴뱃 피스톨",500000,2,""},
    ["WEAPON_HEAVYPISTOL"] = {"헤비 피스톨",500000,2,""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨",750000,2,""},
    ["WEAPON_DAGGER"] = {"고전적 기사 단검",10000,0,""},
    ["WEAPON_HAMMER"] = {"망치",5000,0,""},
    ["WEAPON_HATCHET"] = {"손도끼",10000,0,""},
    ["WEAPON_MICROSMG"] = {"마이크로 SMG",500000,5,""},
    ["WEAPON_SMG"] = {"SMG",500000,5,""},
    ["WEAPON_ASSAULTSMG"] = {"어썰트 SMG",550000,5,""},
    ["WEAPON_COMBATPDW"] = {"컴뱃 PDW",750000,5,""},
    ["WEAPON_MACHINEPISTOL"] = {"머신 Pistol",750000,5,""},
    ["WEAPON_CROWBAR"] = {"쇠 지렛대",7000,0,""},
    ["WEAPON_GOLFCLUB"] = {"골프채",3000,0,""},
    ["WEAPON_SWITCHBLADE"] = {"스위치 블레이드",10000,0,""},
    ["WEAPON_MACHETE"] = {"마체테",15000,0,""},
    ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,5,""},
    ["WEAPON_SNSPISTOL"] = {"SNS피스톨",250000,5,""},
    ["WEAPON_COMPACTRIFLE"] = {"마이크로 SMG",550000,10,""},
    ["WEAPON_ASSAULTRIFLE"] = {"어썰트 라이플",6500000,50,""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총",6500000,50,""},
    ["WEAPON_FLARE"] = {"신호탄",1000,10,""},
    ["WEAPON_GUSENBERG"] = {"구젠버그 스위퍼",500000,5,""},
    ["WEAPON_MG"] = {"MG",10000000,75,""},
    ["WEAPON_COMBATMG"] = {"컴뱃 MG",15000000,100,""},
    ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,7,""},
    ["WEAPON_SNSPISTOL"] = {"피스톨",50000,7,""},
    ["WEAPON_MARKSMANRIFLE"] = {"마크스맨 라이플",10000000,100,""},
    ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플",20000000,75,""},
    ["WEAPON_BULLPUPRIFLE"] = {"불펍 라이플",5000000,45,""},
    ["WEAPON_ADVANCEDRIFLE"] = {"차세대 라이플",6500000,50,""},
    ["WEAPON_SPECIALCARBINE"] = {"스페셜 카빈소총",6500000,50,""},
    ["WEAPON_FLARE"] = {"신호탄",1000,10,""},
    ["WEAPON_SAWNOFFSHOTGUN"] = {"소드오프 샷건",3000000,65,""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",700000,20,""},
    ["WEAPON_BULLPUPSHOTGUN"] = {"불펍 샷건",1000000,30,""},
    ["WEAPON_HEAVYSHOTGUN"] = {"헤비 샷건",5000000,50,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건",15000000,50,""},
    --["WEAPON_FIREWORK"] = {"폭죽",2000,0,""},
    ["WEAPON_SNOWBALL"] = {"눈",3000000,0,""},
    ["WEAPON_FLASHLIGHT"] = {"라이트",2000,0,""},
    ["WEAPON_MUSKET"] = {"머스킷",5000000,0,""},
    ["WEAPON_FLAREGUN"] = {"신호탄 총",3500,0,""},
    ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,15,""},
    ["WEAPON_SNSPISTOL"] = {"SNS 피스톨",250000,15,""},
    ["WEAPON_PETROLCAN"] = {"석유통",25000,0,""},
  },
  ["policeloadout"] = {
    _config = {blipid=110,blipcolor=74, permissions = {"police.loadshop"}},
    ["WEAPON_APPISTOL"] = {"AP 피스톨",0,0,""},
    ["WEAPON_PETROLCAN"] = {"석유통",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",0,0,""},
	["WEAPON_SAWNOFFSHOTGUN"] = {"소드오프 샷건",0,0,""},
	["WEAPON_FLAREGUN"] = {"신호탄 총",0,0,""},
	["WEAPON_FLASHLIGHT"] = {"플래시",0,0,""},
    ["WEAPON_FLARE"] = {"신호탄",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"야경봉",0,0,""},
	["WEAPON_STUNGUN"] = {"스턴 건",0,0,""},
    ["WEAPON_COMBATPISTOL"] = {"컴뱃 피스톨",0,0,""},
    ["WEAPON_SNSPISTOL"] = {"피스톨",0,0,""},
	["WEAPON_CARBINERIFLE"] = {"카빈 소총",0,0,""},
	["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플",0,0,""},
  },
  ["Cadet"] = {
    _config = {blipid=110,blipcolor=74, permissions = {"Cadet.loadshop"}},
    ["WEAPON_PETROLCAN"] = {"Petrol",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",0,0,""},
  ["WEAPON_FLAREGUN"] = {"Flare Gun",0,0,""},
  ["WEAPON_FLASHLIGHT"] = {"Flashlight",0,0,""},
    ["WEAPON_FLARE"] = {"Flare",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Nighstick",0,0,""},
  ["WEAPON_STUNGUN"] = {"Tazer",0,0,""}
  },
  ["SWAT"] = {
    _config = {blipid=110,blipcolor=74, permissions = {"SWAT.loadshop"}},
    ["WEAPON_APPISTOL"] = {"AP 피스톨",0,0,""},
    ["WEAPON_SMOKEGRENADE"] = {"최루가스",0,0,""},
    ["WEAPON_PETROLCAN"] = {"석유통",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",0,0,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건",0,0,""},
    ["WEAPON_FLAREGUN"] = {"신호탄 총",0,0,""},
    ["WEAPON_FLASHLIGHT"] = {"플래시",0,0,""},
    ["WEAPON_FLARE"] = {"신호탄",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"야경봉",0,0,""},
    ["WEAPON_STUNGUN"] = {"스턴 건",0,0,""},
    ["WEAPON_COMBATPISTOL"] = {"컴뱃 피스톨",0,0,""},
	["WEAPON_SPECIALCARBINE"] = {"특별 카빈소총",0,0,""},
	["WEAPON_COMBATMG"] = {"컴뱃 MG",0,0,""},
 	["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플",0,0,""},
  },
 ["Mafia"] = {
_config = {blipid=110,blipcolor=74, permissions = {"mafia.loadshop"}},
    ["WEAPON_PETROLCAN"] = {"석유통",100000000,0,""},
    ["WEAPON_BAT"] = {"야구방망이",100000000,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",100000000,0,""},
    ["WEAPON_FLASHLIGHT"] = {"손전등",100000000,0,""},
    ["WEAPON_FLARE"] = {"신호탄",100000000,0,""},
    --["WEAPON_SNIPERRIFLE"] = {"Sniper Rifle",0,0,""},
    --["WEAPON_ADVANCEDRIFLE"] = {"Carabine",0,0,""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨",100000000,0,""},
    --["WEAPON_MARKSMANPISTOL"] = {"Marksman Pistol",0,0,""},
    ["WEAPON_SNSPISTOL"] = {"피스톨",100000000,0,""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총",100000000,0,""},
 --   ["WEAPON_GRENADE"] = {"수류탄",0,0,""}
    --["WEAPON_MOLOTOV"] = {"Molotov",0,0,""}
    --["WEAPON_ASSAULTRIFLE"] = {"AK47",0,0,""}
  },
  ["Jungmoon"] = {
  _config = {blipid=110,blipcolor=74, permissions = {"jmp.loadshop"}},
    ["WEAPON_PETROLCAN"] = {"석유통",100000000,0,""},
    ["WEAPON_BAT"] = {"야구방망이",100000000,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",100000000,0,""},
    ["WEAPON_FLASHLIGHT"] = {"손전등",100000000,0,""},
    ["WEAPON_FLARE"] = {"신호탄",100000000,0,""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨",100000000,0,""},
    ["WEAPON_SNSPISTOL"] = {"피스톨",100000000,0,""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총",100000000,0,""},
    ["WEAPON_GUSENBERG"] = {"구젠버그 스위퍼",100000000,5,""},
  },
  ["Monkey"] = {
  _config = {blipid=110,blipcolor=74, permissions = {"monkey.loadshop"}},
    ["WEAPON_PETROLCAN"] = {"석유통",0,0,""},
    ["WEAPON_BAT"] = {"야구방망이",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",0,0,""},
    ["WEAPON_FLASHLIGHT"] = {"손전등",0,0,""},
    ["WEAPON_FLARE"] = {"신호탄",0,0,""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨",0,0,""},
    ["WEAPON_SNSPISTOL"] = {"피스톨",0,0,""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총",0,0,""},
},
    ["president"] = {
_config = {blipid=110,blipcolor=74, permissions = {"president.loadshop"}},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",0,0,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건",0,0,""},
    ["WEAPON_ADVANCEDRIFLE"] = {"차세대 라이플",0,0,""},
    ["WEAPON_PETROLCAN"] = {"석유통",0,0,""},
    --["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",0,0,""},
    ["WEAPON_FLASHLIGHT"] = {"손전등",0,0,""},
    ["WEAPON_FLARE"] = {"신호탄",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"야경봉",0,0,""},
    ["WEAPON_STUNGUN"] = {"스턴 건",0,0,""},
    ["WEAPON_COMBATPISTOL"] = {"컴뱃 피스톨",0,0,""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총",0,0,""},
    ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플",0,0,""},
    ["WEAPON_GRENADE"] = {"수류탄",0,0,""}
},

    ["army"] = {
_config = {blipid=110,blipcolor=74, permissions = {"elysiumarmy.loadshop"}},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",0,0,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건",0,0,""},
    ["WEAPON_ADVANCEDRIFLE"] = {"차세대 라이플",0,0,""},
    ["WEAPON_PETROLCAN"] = {"석유통",0,0,""},
    --["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",0,0,""},
    ["WEAPON_FLASHLIGHT"] = {"손전등",0,0,""},
    ["WEAPON_FLARE"] = {"신호탄",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"야경봉",0,0,""},
    ["WEAPON_STUNGUN"] = {"스턴 건",0,0,""},
    ["WEAPON_COMBATPISTOL"] = {"컴뱃 피스톨",0,0,""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총",0,0,""},
    ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플",0,0,""},
    ["WEAPON_GRENADE"] = {"수류탄",0,0,""}
},

  ["Bounty_Hunter"] = {
    _config = {blipid=150,blipcolor=1, permissions = {"Bounty.loadshop"}},
    ["WEAPON_PETROLCAN"] = {"Petrol",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",0,0,""},
	["WEAPON_FLAREGUN"] = {"Flare Gun",0,0,""},
	["WEAPON_FLASHLIGHT"] = {"Flashlight",0,0,""},
    ["WEAPON_FLARE"] = {"Flare",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Nighstick",0,0,""},
	["WEAPON_STUNGUN"] = {"Tazer",0,0,""},
    ["WEAPON_COMBATPISTOL"] = {"Combat Pistol",0,0,""}
  },
  ["emsloadout"] = {
    _config = {blipid=446,blipcolor=74, permissions = {"ems.loadshop"}},
  ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건",0,0,""},
  ["WEAPON_PETROLCAN"] = {"석유통",0,0,""},
  ["WEAPON_FLAREGUN"] = {"신호탄 총",0,0,""},
	["WEAPON_FLASHLIGHT"] = {"플래시",0,0,""},
  ["WEAPON_FLARE"] = {"신호탄",0,0,""},
  ["WEAPON_NIGHTSTICK"] = {"야경봉",0,0,""},
	["WEAPON_APPISTOL"] = {"AP 피스톨",0,0,""},
	["WEAPON_STUNGUN"] = {"스턴 건",0,0,""}
   },
  ["bombsticky"] = {
    _config = {blipid=110,blipcolor=1},
   --["WEAPON_STICKYBOMB"] = {"Sticky bomb",50000,50000,""} 
 }
}
-- list of gunshops positions

cfg.gunshops = {
  {"emsloadout", 232.89363098145,-1368.3338623047,39.534381866455}, -- spawn hospital
  {"emsloadout", 1837.8341064453,3671.3837890625,34.276763916016}, -- sandy shores
  {"emsloadout", -246.91954040527,6330.349609375,32.42618560791}, -- paleto
  --{"eastlossantos1", 844.299, -1033.26, 28.1949},
  {"SWAT", 461.33551025391,-981.11071777344,30.689584732056},
  {"Cadet", 461.33551025391,-981.11071777344,30.689584732056},
  {"policeloadout", 456.48107910156,-982.85803222656,30.689607620239},--- main pd
  {"policeloadout", 123.70247650146,-768.35559082031,242.15203857422},--- 국가정보원
  --{"Bounty_Hunter", 563.62060546875,-3126.9626464844,18.768604278564},
  --{"Mafia", 1397.0635986328,3604.9565429688,38.941886901855}, -- EXAMPLE , UPDATE IF YOU WANT
  {"Mafia", 1403.6105957031,1145.814453125,114.3335647583}, -- EXAMPLE , UPDATE IF YOU WANT
  {"Mafia", -1411.3881835938,-1011.7694091797,24.059061050415}, -- EXAMPLE , UPDATE IF YOU WANT
  {"Mafia", 3.3855454921722,529.25799560547,174.62803649902}, -- 삼합회 저택
  {"Mafia", -1616.0505371094,-2996.74609375,-78.149841308594}, -- 더팰리스 클럽 내부
  {"Jungmoon", -139.10836791992,869.85192871094,232.6951751709}, -- 중문파 저택
  --{"Monkey", 2440.8869628906,4977.2055664063,46.810550689697}, -- 신태일
  {"policeloadout", 1851.7342529297,3683.7416992188,34.267044067383}, -- sandy shores
  {"policeloadout", -442.724609375,6012.6293945313,31.716390609741}, -- paleto
  --{"bombsticky", 708.847778320313,-959.231750488281,30.3953418731689},
  --{"Paleto", -331.50210571289,6082.5063476563,31.454769134521}, -- Paleto
  {"president", -462.6481628418,1099.0528564453,327.68231201172}, -- President
  {"army", -2357.1953125,3254.8461914063,32.810722351074} -- 군대
}

return cfg

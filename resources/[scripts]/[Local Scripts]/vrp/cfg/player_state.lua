
local cfg = {}

-- define the first spawn position/radius of the player (very first spawn on the server, or after death)
cfg.spawn_enabled = true -- set to false to disable the feature
cfg.spawn_position = {-266.07498168945,-961.10437011719,31.223129272461} -- 기본 스폰
--cfg.spawn_position = {-1032.2100830078,-2734.4274902344,13.756636619568} --공항
cfg.spawn_death = {340.44674682617,-1388.2272949219,32.509239196777} -- x,y,z for death location
--cfg.spawn_death = {355.98583984375,-596.39697265625,28.777002334595} -- 병원 리스폰
cfg.spawn_radius = 1

-- customization set when spawning for the first time
-- see https://wiki.fivem.net/wiki/Peds
-- mp_m_freemode_01 (male)
-- mp_f_freemode_01 (female)
cfg.default_customization = {
  model = "mp_m_freemode_01" 
}

-- init default ped parts
for i=0,255 do
  cfg.default_customization[i] = {0,0}
end

cfg.clear_phone_directory_on_death = false
cfg.lose_aptitudes_on_death = false

return cfg
 -- {1151.2432861328,-1526.7790527344,34.843448638916}
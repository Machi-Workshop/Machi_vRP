

              
              
              


                	--DrawText3D(x,y,z-0.2, "~b~"..settings[lang].price.." : $"..StationsPrice[item.s].."/litru")


local cfg = {}


-- city hall position
--cfg.city_hall =	{-262.25286865234,-969.47399902344,31.223146438599}  -- 시청 기본
cfg.city_hall =	{-266.61505126953,-968.71441650391,31.224632263184}  -- 시청 오른편
--cfg.city_hall =	{-1030.8408203125,-2732.3103027344,13.756634712219}
--city_hall =	{-1030.8408203125,-2732.3103027344,13.756634712219}

-- cityhall blip {blipid,blipcolor}
cfg.blip = {498,4}

-- cost of a new identity
cfg.new_identity_cost = 0

-- phone format (max: 20 chars, use D for a random digit)
cfg.phone_format = "0D0DDDDDDDD"
-- cfg.phone_format = "06DDDDDDDD" -- another example for cellphone in France


-- config the random name generation (first join identity)
-- (I know, it's a lot of names for a little feature)
-- (cf: http://names.mongabay.com/most_common_surnames.htm)
cfg.random_first_names = {
  "Hari",
  "Sohee"
}

cfg.random_last_names = {
  "Kim",
  "Lee",
  "Park"
}



return cfg

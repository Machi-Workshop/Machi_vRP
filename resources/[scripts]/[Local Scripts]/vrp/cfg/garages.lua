
local cfg = {}
-- define garage types with their associated vehicles
-- (vehicle list: https://wiki.fivem.net/wiki/Vehicles)

-- each garage type is an associated list of veh_name/veh_definition 
-- they need a _config property to define the blip and the vehicle type for the garage (each vtype allow one vehicle to be spawned at a time, the default vtype is "default")
-- this is used to let the player spawn a boat AND a car at the same time for example, and only despawn it in the correct garage
-- _config: vtype, blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.rent_factor = 0.1 -- 10% of the original price if a rent
cfg.sell_factor = 0.4-- sell for 75% of the original price

cfg.garage_types = {
  ["일반 차고"] = {
    _config = {vtype="car",blipid=50,blipcolor=4},
    --["모델"] = {"이름",12000,""}
  }
  }
}
--   {"domino",-1524.8208007813,-430.8518371582,35.442138671875},
-- {garage_type,x,y,z}
--{"Cadet",451.2121887207,-1018.2822875977,28.495378494263}, -- cadet garage
--{"Bounty",512.07818603516,-3052.1579589844,6.0687308311462},  
cfg.garages = {
}

return cfg

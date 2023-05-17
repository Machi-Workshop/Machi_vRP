--===============================================--===============================================
--= stationary radars based on 	https://github.com/DreanorGTA5Mods/StationaryRadar	         =
--===============================================--===============================================

local radares = {
{x = -2554.6257324219, y = 3395.1008300781, z = 13.263509750366}, -- 포트 잔쿠도 터널
{x = -2560.501953125, y = 3395.0119628906, z = 13.260280609131},
{x = -2567.1750488281, y = 3397.3063964844, z = 13.274488449097},
{x = 2400.4750976563, y = 2919.7021484375, z = 39.918910980225}, -- 교도소 근처 IC 2400.4750976563,2919.7021484375, 39.918910980225
{x = 2403.9938964844, y = 2916.2004394531, z = 40.284770965576}, -- 교도소 근처 IC 2400.4750976563,2919.7021484375, 39.918910980225
{x = 2415.5358886719, y =2899.83984375, z = 39.901397705078}, -- 교도소 근처 IC 2400.4750976563,2919.7021484375, 39.918910980225
{x = 2418.7866210938, y = 2896.4841308594, z = 39.898097991943}, -- 교도소 근처 IC 2400.4750976563,2919.7021484375, 39.918910980225
}

Citizen.CreateThread(function()
  while true do
    Wait(0)
	for k,v in pairs(radares) do
	local player = GetPlayerPed(-1)
	local coords = GetEntityCoords(player, true)
	if Vdist2(radares[k].x, radares[k].y, radares[k].z, coords["x"], coords["y"], coords["z"]) < 10 then
	Citizen.Trace("estas pasando por un radar")
		checkSpeed()
	end
  end
 end
end)

  function checkSpeed()
  local pP = GetPlayerPed(-1)
  local speed = GetEntitySpeed(pP)
  local vehicle = GetVehiclePedIsIn(pP, false)
  local driver = GetPedInVehicleSeat(vehicle, -1)
  local maxspeed = 201
	local kmhspeed = math.ceil(speed*3.6)
		if kmhspeed > maxspeed and driver == pP then
			Citizen.Wait(250)
			TriggerServerEvent('cobrarMulta')
			exports.pNotify:SetQueueMax("left", 1)
            exports.pNotify:SendNotification({
            text = "200km/h 과속 단속 카메라 적발 / 벌금 부과",
            type = "error",
            timeout = 3000,
            layout = "centerLeft",
            queue = "left"
          })
	end
end

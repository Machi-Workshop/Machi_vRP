--===============================================--===============================================
--= stationary radars based on 	https://github.com/DreanorGTA5Mods/StationaryRadar	         =
--===============================================--===============================================

local radares = {
{x = 379.68807983398, y = -1048.3527832031, z = 29.250692367554},
{x = -253.10794067383, y = -630.20385742188, z = 33.002685546875},
{x = -201.3777923584, y = -522.90338134766, z = 34.153560638428},
{x = -227.88055419922, y = -64.816833496094, z = 49.125984191895},
{x = -55.754215240479, y = -107.16513824463, z = 57.338497161865},
{x = -225.42152404785, y = -47.808887481689, z = 49.063480377197},
{x = -790.82281494141, y = -65.880279541016, z = 37.180515289307},
{x = -1033.5516357422, y = -193.52819824219, z = 37.258892059326},
{x = 581.05529785156, y = -366.34283447266, z = 43.020248413086},
{x = -142.87184143066, y = -1739.3713378906, z = 29.540693283081},
{x = 45.637058258057, y = -1678.9293212891, z = 28.717638015747},
{x = 54.355247497559, y = -1664.37890625, z = 28.726228713989},
{x = -662.02947998047, y = -665.06677246094, z = 31.188533782959},-- 메인차고 왼쪽으로 나가면 굴다리 지나서 있는 사거리
{x = -605.04998779297, y = -652.35833740234, z = 31.464593887329},-- 메인차고 왼쪽으로 나가면 굴다리 지나서 있는 사거리
{x = 395.00506591797, y = -600.08807373047, z = 28.818470001221},-- 병원 앞
{x = 386.08334350586, y =-594.26190185547, z =28.802043914795},-- 병원 앞
{x = -159.18670654297, y = -894.28277587891, z = 29.349035263062},-- 시청 사거리
{x = -215.88916015625, y = -887.82879638672, z = 29.597486495972},-- 시청 사거리
}

Citizen.CreateThread(function()
  while true do
    Wait(0)
	for k,v in pairs(radares) do
	local player = GetPlayerPed(-1)
	local coords = GetEntityCoords(player, true)
	if Vdist2(radares[k].x, radares[k].y, radares[k].z, coords["x"], coords["y"], coords["z"]) < 20 then
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
  local maxspeed = 121
	local kmhspeed = math.ceil(speed*3.6)
		if kmhspeed > maxspeed and driver == pP then
			Citizen.Wait(250)
			TriggerServerEvent('cobrarMulta')
			exports.pNotify:SetQueueMax("left", 1)
            exports.pNotify:SendNotification({
            text = "120km/h 과속 단속 카메라 적발 / 벌금 부과",
            type = "error",
            timeout = 3000,
            layout = "centerLeft",
            queue = "left"
          })
	end
end

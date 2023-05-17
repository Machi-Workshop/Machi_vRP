local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	{title="랜덤 박스", colour=69, id=500, x = -530.02941894532, y = -229.9102935791, z = 36.702156066894},
	{title="과속 카메라", colour=40, id=135, x = 379.68807983398, y = -1048.3527832031, z = 29.250692367554},
	{title="과속 카메라", colour=40, id=135, x = -253.10794067383, y = -630.20385742188, z = 33.002685546875},
	{title="과속 카메라", colour=40, id=135, x = -201.3777923584, y = -522.90338134766, z = 34.153560638428},
	{title="과속 카메라", colour=40, id=135, x = -227.88055419922, y = -64.816833496094, z = 49.125984191895},
	{title="과속 카메라", colour=40, id=135, x = -55.754215240479, y = -107.16513824463, z = 57.338497161865},
	{title="과속 카메라", colour=40, id=135, x = -225.42152404785, y = -47.808887481689, z = 49.063480377197},
	{title="과속 카메라", colour=40, id=135, x = -790.82281494141, y = -65.880279541016, z = 37.180515289307},
	{title="과속 카메라", colour=40, id=135, x = -1033.5516357422, y = -193.52819824219, z = 37.258892059326},
	{title="과속 카메라", colour=40, id=135, x = 581.05529785156, y = -366.34283447266, z = 43.020248413086},
	{title="과속 카메라", colour=40, id=135, x = -142.87184143066, y = -1739.3713378906, z = 29.540693283081},
	{title="과속 카메라", colour=40, id=135, x = 45.637058258057, y = -1678.9293212891, z = 28.717638015747},
	{title="과속 카메라", colour=40, id=135, x = 54.355247497559, y = -1664.37890625, z = 28.726228713989},
	{title="과속 카메라", colour=40, id=135, x = -632.78424072266, y = -657.67004394531, z = 31.711702346802},
	{title="과속 카메라", colour=40, id=135, x = 390.57409667969, y = -597.5185546875,z = 28.811317443848},
	{title="과속 카메라", colour=40, id=135, x = -184.28941345215, y =-891.50695800781,z = 29.342586517334},
	{title="과속 카메라 (고속도로)", colour=40, id=135, x = -2560.501953125, y = 3395.0119628906, z = 13.260280609131},
	{title="과속 카메라 (고속도로)", colour=40, id=135, x = 2410.0947265625, y = 2908.7846679688, z = 48.957111358643}
  }

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

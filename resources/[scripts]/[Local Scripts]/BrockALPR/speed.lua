--[[------------------------------------------------------------------------

	Radar/ALPR 
	Created by Brock =]
	Uses Numpad5 to turn on
    Uses Numpad8 to freeze	

------------------------------------------------------------------------]]--

local radar =
{
	shown = false,
	freeze = false,
	info = "~y~차량이 감지되지 않았습니다.",
	--info = "~y~Initializing ALPR...~w~321...~y~Loaded! ",
	--info2 = "~y~Initializing ALPR...~w~321...~y~Loaded! ",
	info2 = "~y~차량이 감지되지 않았습니다.",
	minSpeed = 5.0,
	maxSpeed = 75.0,
}
--local distanceToCheckFront = 50

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

Citizen.CreateThread( function()
	
	while true do
		Wait(0)
		if IsControlJustPressed(1, 128) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
			
			if radar.shown then 
				radar.shown = false 
				--radar.info = string.format("~y~Initializing ALPR...~w~321...~y~Loaded! ")
				radar.info = string.format("~y~차량이 감지되지 않았습니다.")
				--radar.info2 = string.format("~y~Initializing ALPR...~w~321...~y~Loaded! ")
				radar.info2 = string.format("~y~차량이 감지되지 않았습니다.")
			else 
				radar.shown = true 
			end		
                Wait(75)
			
		end
		if IsControlJustPressed(1, 127) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
		
			if radar.freeze then radar.freeze = false else radar.freeze = true end
	
		end
		if radar.shown  then
			if radar.freeze == false then
					local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
					local a, b, c, d, e = GetShapeTestResult(frontcar)
					
					if IsEntityAVehicle(e) then
						
						local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
						--local fvspeed = GetEntitySpeed(e)*2.236936
						local fvspeed = GetEntitySpeed(e)*3.6
						local fplate = GetVehicleNumberPlateText(e)
						radar.info = string.format("~y~번호판: ~w~%s  ~y~모델: ~w~%s  ~y~속도: ~w~%s Km/h", fplate, fmodel, math.ceil(fvspeed))
					end
					
					local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
					local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
					local f, g, h, i, j = GetShapeTestResult(rearcar)
					
					if IsEntityAVehicle(j) then
					
						local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
						--local bvspeed = GetEntitySpeed(j)*2.236936
						local bvspeed = GetEntitySpeed(j)*3.6
						local bplate = GetVehicleNumberPlateText(j)
						radar.info2 = string.format("~y~번호판: ~w~%s  ~y~모델: ~w~%s  ~y~속도: ~w~%s Km/h", bplate, bmodel, math.ceil(bvspeed))
					
					
					end
					
			end
			
			--DrawRect(0.508, 0.940, 0.256, 0.116, 0, 0, 0, 150) --박스
      --DrawAdvancedText(0.591, 0.903, 0.005, 0.0028, 0.4, "정면 카메라", 0, 191, 255, 255, 6, 0)
      --DrawAdvancedText(0.591, 0.953, 0.005, 0.0028, 0.4, "후면 카메라", 0, 191, 255, 255, 6, 0)
      --DrawAdvancedText(0.6, 0.928, 0.005, 0.0028, 0.4, radar.info, 255, 255, 255, 255, 6, 0)
      --DrawAdvancedText(0.6, 0.979, 0.005, 0.0028, 0.4, radar.info2, 255, 255, 255, 255, 6, 0)
      
			DrawRect(0.844, 0.780, 0.256, 0.116, 0, 0, 0, 150) --박스
			DrawAdvancedText(0.927, 0.743, 0.005, 0.0028, 0.4, "정면 카메라", 0, 191, 255, 255, 6, 0)
			DrawAdvancedText(0.927, 0.793, 0.005, 0.0028, 0.4, "후면 카메라", 0, 191, 255, 255, 6, 0)
			DrawAdvancedText(0.936, 0.768, 0.005, 0.0028, 0.4, radar.info, 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.936, 0.819, 0.005, 0.0028, 0.4, radar.info2, 255, 255, 255, 255, 6, 0)

			
		end
		
		if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
			radar.shown = false
			radar.info = string.format("~y~Initializing ALPR...~w~321...~y~Loaded! ")
			radar.info2 = string.format("~y~Initializing ALPR...~w~321...~y~Loaded! ")
		end
					
	end
	
	
end)


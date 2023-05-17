local displayTime = true
local useMilitaryTime = true
local displayDayOfWeek = true
local displayDate = true

local timeAndDateString = nil
local hour
local minute
local dayOfWeek
local month
local dayOfMonth
local year

-- Display Time and Date at top right of screen -- format: | 12:13 | Wednesday | January 17, 2017 |
Citizen.CreateThread(function()
	while true do
		Wait(1)
		timeAndDateString = ""
		
		if displayTime == true then
			CalculateTimeToDisplay()
			timeAndDateString = timeAndDateString .. " " .. hour .. ":" .. minute .. " |"
		end
		if displayDayOfWeek == true then
			CalculateDayOfWeekToDisplay()
			timeAndDateString = timeAndDateString .. " " .. dayOfWeek .. " |"
		end
		if displayDate == true then
			CalculateDateToDisplay()
			--timeAndDateString = timeAndDateString .. " " .. year .. "년 " .. month .. " " .. dayOfMonth .. "일 | 엘리시움"
			--timeAndDateString = timeAndDateString .. " 엘리시움 3년 " .. month .. " " .. dayOfMonth .. "일"
			timeAndDateString = timeAndDateString .. " " .. month .. " " .. dayOfMonth .. "일"
		end
		
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.30, 0.30)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
--		SetTextRightJustify(true)
--	SetTextWrap(0,0.2)
		SetTextEntry("STRING")
		
		AddTextComponentString(timeAndDateString)
		DrawText(0.01, 0.695)
	end
end)

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()

	if useMilitaryTime == false then
		if hour == 0 or hour == 24 then
			hour = 12
		elseif hour >= 13 then
			hour = hour - 12
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

function CalculateDayOfWeekToDisplay()
	dayOfWeek = GetClockDayOfWeek()
	
	if dayOfWeek == 0 then
		dayOfWeek = "일요일"
	elseif dayOfWeek == 1 then
		dayOfWeek = "월요일"
	elseif dayOfWeek == 2 then
		dayOfWeek = "화요일"
	elseif dayOfWeek == 3 then
		dayOfWeek = "수요일"
	elseif dayOfWeek == 4 then
		dayOfWeek = "목요일"
	elseif dayOfWeek == 5 then
		dayOfWeek = "금요일"
	elseif dayOfWeek == 6 then
		dayOfWeek = "토요일"
	end
end

function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	year = GetClockYear()
	
	if month == 0 then
		month = "1월"
	elseif month == 1 then
		month = "2월"
	elseif month == 2 then
		month = "3월"
	elseif month == 3 then
		month = "4월"
	elseif month == 4 then
		month = "5월"
	elseif month == 5 then
		month = "6월"
	elseif month == 6 then
		month = "7월"
	elseif month == 7 then
		month = "8월"
	elseif month == 8 then
		month = "9월"
	elseif month == 9 then
		month = "10월"
	elseif month == 10 then
		month = "11월"
	elseif month == 11 then
		month = "12월"
	end
end

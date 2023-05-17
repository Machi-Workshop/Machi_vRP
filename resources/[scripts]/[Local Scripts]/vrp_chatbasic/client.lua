RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "^*I C | " .. name .."^0^r:  ".. message )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "^*I C | " .. name .."^0^r:  ".. message )
	end
end)

RegisterNetEvent('sendProximityMessageEn')
AddEventHandler('sendProximityMessageEn', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "^*^1[영어]^0 " .. name .."^r: ".. message )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "^*^1[영어]^0 " .. name .."^r: ".. message )
	end
end)

RegisterNetEvent('sendProximityMessageJp')
AddEventHandler('sendProximityMessageJp', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "^*^1[일본어]^0 " .. name .."^r: ".. message )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 255, 255}, "^*^1[일본어]^0 " .. name .."^r: ".. message )
	end
end)

RegisterNetEvent('sendProximityMessageCn')
AddEventHandler('sendProximityMessageCn', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "^*^1[중국어]^0 " .. name .."^r: ".. message )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "^*^1[중국어]^0 " .. name .."^r: ".. message )
	end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6^* * * " .. name .." 이(가) ".."^6  " .. message )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6^* * * " .. name .." 이(가) ".."^6  " .. message )
	end
end)

RegisterNetEvent('sendProximityMessageW')
AddEventHandler('sendProximityMessageW', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "─────────────────────────────────────")
		TriggerEvent('chatMessage', "", {255, 255, 255}, " ^* 📜 " .. name .." 이(가) ".."  " .. message )
		TriggerEvent('chatMessage', "", {255, 255, 255}, "─────────────────────────────────────")
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 255, 255}, "─────────────────────────────────────")
		TriggerEvent('chatMessage', "", {255, 255, 255}, " ^* 📜 " .. name .." 이(가) ".."  " .. message )
		TriggerEvent('chatMessage', "", {255, 255, 255}, "─────────────────────────────────────")
	end
end)

RegisterNetEvent('sendProximityMessageSt')
AddEventHandler('sendProximityMessageSt', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {150, 150, 150}, "^*🙍 " .. name .."^r의 상태 | ".."" .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {150, 150, 150}, "^*🙍 " .. name .."^r의 상태 | ".."" .. message)
	end
end)

RegisterNetEvent('sendProximityMessageTh')
AddEventHandler('sendProximityMessageTh', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {180, 180, 180}, "^*💡 " .. name .."^r의 생각 | ".."" .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {180, 180, 180}, "^*💡 " .. name .."^r의 생각 | ".."" .. message)
	end
end)

RegisterNetEvent('sendProximityMessageSh')
AddEventHandler('sendProximityMessageSh', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 0, 0}, "^3^* " .. name ..": ".."" .. message .. " ! ! !")
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 49.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, "^3^* " .. name ..": ".."" .. message .. " ! ! !")
	end
end)


RegisterNetEvent('sendProximityMessagePm1')
AddEventHandler('sendProximityMessagePm1', function(id, name, message)
  local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	local veh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(id)), false)
	local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
	local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
  local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
	local a, b, c, d, e = GetShapeTestResult(frontcar)
  local myplate = GetVehicleNumberPlateText(veh)
  local fplate = GetVehicleNumberPlateText(e)
  if IsPedInAnyPoliceVehicle(GetPlayerPed(GetPlayerFromServerId(id)), false) then
    if fplate ~= nil then
      if sonid == monid then
      TriggerEvent('chatMessage', "", {0, 230, 255}, "^*🚨 L S P D | ".. name .. "의 메가폰: 전방 " .. fplate .. " 차량 정차하세요 ! ! !")
      elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 99.999 then
      local myplate = GetVehicleNumberPlateText(veh)
      TriggerEvent('chatMessage', "", {0, 230, 255}, "^*🚨 L S P D | ".. name .. "의 메가폰: 전방 " .. fplate .. " 차량 정차하세요 ! ! !")
      end
    else
      if sonid == monid then
      TriggerEvent('chatMessage', "", {0, 230, 255}, "^*[알림] 전방에 차량이 없습니다.")
      elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 99.999 then
      end
    end
    else
    if sonid == monid then
      TriggerEvent('chatMessage', "", {0, 230, 255}, "^*[알림] 경찰차 안이 아닙니다.")
      elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 99.999 then
      end
  end
end)

RegisterNetEvent('sendProximityMessagePolice')
AddEventHandler('sendProximityMessagePolice', function(id, name, message)
  local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
  if IsPedInAnyPoliceVehicle(GetPlayerPed(GetPlayerFromServerId(id)), false) then
    if sonid == monid then
      TriggerEvent('chatMessage', "", {0, 230, 255}, "^*🚨 L S P D | ".. name .. "의 메가폰: " .. message .." ! ! !")
      elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 99.999 then
      TriggerEvent('chatMessage', "", {0, 230, 255}, "^*🚨 L S P D | ".. name .. "의 메가폰: " .. message .. " ! ! !")
      end
  else
    if sonid == monid then
    TriggerEvent('chatMessage', "", {0, 230, 255}, "^*[알림] 경찰차 안이 아닙니다.")
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 99.999 then
  end
  end
end)

RegisterNetEvent('sendProximityMessageB')
AddEventHandler('sendProximityMessageB', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {150, 150, 150}, " 근처 OOC | " .. name ..":  ".."^0  " .. message .. "" )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {150, 150, 150}, " 근처 OOC | " .. name ..":  ".."^0  " .. message .. "" )
	end
end)

RegisterNetEvent('sendProximityMessageError')
AddEventHandler('sendProximityMessageError', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 255, 0}, "사용할 권한이 없습니다!" )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		--TriggerEvent('chatMessage', "", {150, 150, 150}, " O O C | " .. name ..":  ".."^0  " .. message .. "" )
	end
end)
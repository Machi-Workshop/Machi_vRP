vRP = Proxy.getInterface("vRP")

Citizen.CreateThread(function ()
	while true do
	local user_id = vRP.getUserId(source)
		Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
		TriggerServerEvent('paycheck:salary')
	end
end)

Citizen.CreateThread(function ()
	while true do
	local user_id = vRP.getUserId(source)
		Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
		TriggerServerEvent('paycheck:bonus')
	end
end)

Citizen.CreateThread(function ()
	while true do
	local user_id = vRP.getUserId(source)
		Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
		TriggerServerEvent('paycheck:realestate')
	end
end)

Citizen.CreateThread(function ()
	while true do
	local user_id = vRP.getUserId(source)
		Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
		TriggerServerEvent('paycheck:loan')
	end
end)

Citizen.CreateThread(function ()
	while true do
	local user_id = vRP.getUserId(source)
		Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
		TriggerServerEvent('paycheck:army')
	end
end)

Citizen.CreateThread(function ()
	while true do
	local user_id = vRP.getUserId(source)
		Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
		TriggerServerEvent('paycheck:companysalary')
	end
end)

RegisterNetEvent("elysiumautohot")
AddEventHandler("elysiumautohot", function()
  local user_id = vRP.getUserId(source)
  Citizen.Wait(3000)
  TriggerServerEvent('paycheck:elysiumautohot')
end)

RegisterNetEvent("elysiumautohot2")
AddEventHandler("elysiumautohot2", function()
  local user_id = vRP.getUserId(source)
  Citizen.Wait(3000)
  TriggerServerEvent('paycheck:elysiumautohot2')
end)

RegisterNetEvent("elysiumautohot3")
AddEventHandler("elysiumautohot3", function()
  local user_id = vRP.getUserId(source)
  Citizen.Wait(3000)
  TriggerServerEvent('paycheck:elysiumautohot3')
end)

RegisterNetEvent("elysiumautohot4")
AddEventHandler("elysiumautohot4", function()
  local user_id = vRP.getUserId(source)
  Citizen.Wait(3000)
  TriggerServerEvent('paycheck:elysiumautohot4')
end)

RegisterNetEvent("elysiumautohot5")
AddEventHandler("elysiumautohot5", function()
  local user_id = vRP.getUserId(source)
  Citizen.Wait(3000)
  TriggerServerEvent('paycheck:elysiumautohot5')
end)

RegisterNetEvent("elysiumautohot6")
AddEventHandler("elysiumautohot6", function()
  local user_id = vRP.getUserId(source)
  Citizen.Wait(3000)
  TriggerServerEvent('paycheck:elysiumautohot6')
end)
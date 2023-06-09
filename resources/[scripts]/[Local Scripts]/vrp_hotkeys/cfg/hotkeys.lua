-- TUNNEL AND PROXY
cfg = {}
vRPhk = {}
Tunnel.bindInterface("vrp_hotkeys",vRPhk)
vRPserver = Tunnel.getInterface("vRP","vrp_hotkeys")
HKserver = Tunnel.getInterface("vrp_hotkeys","vrp_hotkeys")
vRP = Proxy.getInterface("vRP")

-- GLOBAL VARIABLES
called = 0

-- YOU ARE ON A CLIENT SCRIPT ( Just reminding you ;) )
-- Keys IDs can be found at https://wiki.fivem.net/wiki/Controls

-- Hotkeys Configuration: cfg.hotkeys = {[Key] = {group = 1, pressed = function() end, released = function() end},}
cfg.hotkeys = {
  [47] = {
	-- F2 Handcuff/uncuff
	group = 1,
	pressed = function()
		if not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			HKserver.toggleHandcuff()
		end 
	end,
	released = function()
	end,
  },
  [46] = {
    -- E call/skip emergency
    group = 0, 
	pressed = function() 
	  if vRP.isInComa({}) then
	    if called == 0 then
        HKserver.checkinJail({},function(injail)
	      HKserver.canSkipComa({},function(skipper)
		    if skipper then
		      HKserver.docsOnline({},function(docs)
          if docs == 0 then
				  vRP.killComa({})
          else
          if injail then
          vRP.killComa({})
          else
          called = 60
				  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
				  HKserver.helpComa({x,y,z})
          end
			    end
			  end)
        end
		  end)
      end)
		else
		  vRP.notify({"~r~이미 긴급 의료 서비스를 호출하였습니다."})
		  vRP.notify({"~r~지속적으로 중복 호출할 시 처벌 받을 수 있습니다."})
		end
	  end
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  },
  --[[  [168] = {
    --home on numberpad toggle User List
    group = 0, 
	pressed = function() 
	  HKserver.openUserList({})
	end,
	released = function()
	  -- Do nothing on release because it's toggle.
	end,
  }, 
  ]]-- 기존 유저리스트
}

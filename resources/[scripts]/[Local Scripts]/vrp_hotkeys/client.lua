-- MAIN THREAD
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k,v in pairs(cfg.hotkeys) do
		  if IsControlJustPressed(v.group, k) or IsDisabledControlJustPressed(v.group, k) then
		    v.pressed()
		  end

		  if IsControlJustReleased(v.group, k) or IsDisabledControlJustReleased(v.group, k) then
		    v.released()
		  end
		end
	end
end)


-- THIS IS FOR NO DOC COMA
Citizen.CreateThread(function() -- coma thread
  while true do
    Citizen.Wait(1000)
    if vRP.isInComa({}) then
	  if called == 0  then
	    HKserver.canSkipComa({},function(skipper)
	      if skipper then
		    HKserver.docsOnline({},function(docs)
		      if docs == 0 then
			    vRP.notify({"~r~당신을 살려줄 구급대원이 없습니다.\n~b~~g~E~b~ 를 눌러 리스폰하세요."})
			  else
			    vRP.notify({"~g~구급대원 접속 중\n~b~~g~E~b~ 버튼을 눌러 의료서비스를 호출하세요."})
			  end
		    end)
          end
	    end)
	  else
	    called = called - 1
	  end
	else
	  called = 0
	end
  end
end)



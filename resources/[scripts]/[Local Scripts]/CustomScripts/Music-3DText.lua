

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    RegisterFontFile('Arita-dotum-Bold')
    FontId = RegisterFontId('Arita-dotum-Bold')
    
    if onScreen then
        SetTextScale(0.0*scale, 0.6*scale)
        SetTextFont(FontId)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(0, 255, 0, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function() -- 1854.6323242188,2592.5581054688,45.671997070313
    while true do
        for i = 1, #objectlist do
            local x = 1854.6323242188
            local y = 2592.5581054688
            local z = 45.671997070313
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~b~[교도소] 죄수복 환복하는 곳")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -1733.2800292969,-576.30682373047,37.495258331299
    while true do
        for i = 1, #objectlist do
            local x = -1733.2800292969
            local y = -576.30682373047
            local z = 37.495258331299
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~한정차고")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -436.6259765625,-994.01892089844,25.699934005737
    while true do
        for i = 1, #objectlist do
            local x = -436.6259765625
            local y = -994.01892089844
            local z = 25.699934005737
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~g~일반차고")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 4058.3217773438,-4676.3100585938,4.1845149993896
    while true do
        for i = 1, #objectlist do
            local x = 4058.3217773438
            local y = -4676.3100585938
            local z = 4.1845149993896
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[배틀로얄] 무기 구매장소")
        end
        end
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function() -- 4065.8547363281,-4673.6318359375,4.1867690086365
    while true do
        for i = 1, #objectlist do
            local x = 4065.8547363281
            local y = -4673.6318359375
            local z = 4.1867690086365
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[배틀로얄] 무기 구매장소")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 4060.7141113281,-4670.6020507813,4.1845254898071
    while true do
        for i = 1, #objectlist do
            local x = 4060.7141113281
            local y = -4670.6020507813
            local z = 4.1845254898071
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[배틀로얄] 무기 구매장소")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 480.96786499023,-995.21655273438,30.689767837524
    while true do
        for i = 1, #objectlist do
            local x = 480.96786499023
            local y = -995.21655273438
            local z = 30.689767837524
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~경찰청 무기", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() --  482.53439331055,-995.291015625,30.689767837524
    while true do
        for i = 1, #objectlist do
            local x = 482.53439331055
            local y = -995.291015625
            local z = 30.689767837524
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~경찰특공대 무기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() --4066.8588867188,-4668.2109375,4.2066898345947
    while true do
        for i = 1, #objectlist do
            local x = 4066.8588867188
            local y = -4668.2109375
            local z = 4.2066898345947
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[배틀로얄] 무기 구매장소")
        end
        end
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function() --4051.9545898438,-4673.9262695313,4.1844310760498
    while true do
        for i = 1, #objectlist do
            local x = 4051.9545898438
            local y = -4673.9262695313
            local z = 4.1844310760498
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[배틀로얄] 무기 구매장소")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -414.71356201172
            local y = 1133.902587890
            local z = 325.90454101563
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
                DrawText3D(x, y, z + 0.35,"~b~ OOOOOOOOOOOO")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -429.26940917969
            local y = 1137.8717041016
            local z = 325.9045715332
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
                DrawText3D(x, y, z + 0.35,"~r~ XXXXXXXXXXXXX")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -1461.7791748047,-42.465057373047,54.672706604004
    while true do
        for i = 1, #objectlist do
            local x = -334.0661315918
            local y = -904.3335571289
            local z = 31.08399772644
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[SKY MAP] 레드팀 입장하기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -1461.7791748047,-42.465057373047,54.672706604004
    while true do
        for i = 1, #objectlist do
            local x = -463.06466674805
            local y = 1388.9602050781
            local z = 936.63757324219
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[SKY MAP] 레드팀 퇴장하기")
        end
        end
        Citizen.Wait(0)
    end
end)

-- Citizen.CreateThread(function() -- -326.0690612793,-906.38787841797,31.083993911743
--     while true do
--         for i = 1, #objectlist do
--             local x = -326.0690612793
--             local y = -906.38787841797
--             local z = 31.083993911743
--             local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
--             if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
--                 DrawText3D(x, y, z + 0.35,"~r~[웨어하우스] 레드팀 입장하기")
--         end
--         end
--         Citizen.Wait(0)
--     end
-- end)

-- Citizen.CreateThread(function() -- -321.89297485352,-907.39105224609,31.083993911743
--     while true do
--         for i = 1, #objectlist do
--             local x = -321.89297485352
--             local y = -907.39105224609
--             local z = 31.083993911743
--             local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
--             if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
--                 DrawText3D(x, y, z + 0.35,"~b~[웨어하우스] 블루팀 입장하기")
--         end
--         end
--         Citizen.Wait(0)
--     end
-- end)

Citizen.CreateThread(function() -- -1461.7791748047,-42.465057373047,54.672706604004
    while true do
        for i = 1, #objectlist do
            local x = -330.56686401367
            local y = -905.15209960938
            local z = 31.08399772644
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~b~[SKY MAP] 블루팀 입장하기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -1461.7791748047,-42.465057373047,54.672706604004
    while true do
        for i = 1, #objectlist do
            local x = -335.89990234375
            local y = 1260.9838867188
            local z = 936.64813232422
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~b~[SKY MAP] 블루팀 퇴장하기")
        end
        end
        Citizen.Wait(0)
    end
end)

--

Citizen.CreateThread(function() -- -339.51583862305,-902.92053222656,31.083995819092
    while true do
        for i = 1, #objectlist do
            local x = -339.51583862305
            local y = -902.92053222656
            local z = 31.083995819092
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~y~카트 레이싱장 입장")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -21.045392990112
            local y = -3164.0405273438
            local z = 16.173141479492
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~y~카트 레이싱장 퇴장")
        end
        end
        Citizen.Wait(0)
    end
end)

-------------------------

Citizen.CreateThread(function() -- 1412.7945556641,1139.8653564453,114.33573150635
    while true do
        for i = 1, #objectlist do
            local x = 1412.7945556641
            local y = 1139.8653564453
            local z = 114.33573150635
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[게릴라 RP] 흑사회 공격진영 바로가기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 1418.2711181641,1138.8726806641,114.33571624756
    while true do
        for i = 1, #objectlist do
            local x = 1418.2711181641
            local y = 1138.8726806641
            local z = 114.33571624756
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~g~[게릴라 RP] 흑사회 방어진영 바로가기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -110.57640075684,1004.1406860352,235.77485656738
    while true do
        for i = 1, #objectlist do
            local x = -110.57640075684
            local y = 1004.1406860352
            local z = 235.77485656738
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[게릴라 RP] 만월 공격진영 바로가기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -104.41219329834,1006.8369140625,235.76028442383
    while true do
        for i = 1, #objectlist do
            local x = -104.41219329834
            local y = 1006.8369140625
            local z = 235.76028442383
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~g~[게릴라 RP] 만월 방어진영 바로가기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -1500.6752929688,867.79156494141,181.8032989502
    while true do
        for i = 1, #objectlist do
            local x = -1500.6752929688
            local y = 867.79156494141
            local z = 181.8032989502
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[게릴라 RP] 마피아 공격진영 바로가기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -1503.0701904297,866.62963867188,181.76690673828
    while true do
        for i = 1, #objectlist do
            local x = -1503.0701904297
            local y = 866.62963867188
            local z = 181.76690673828
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~g~[게릴라 RP] 마피아 방어진영 바로가기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 406.63970947266,23.453441619873,91.331230163574
    while true do
        for i = 1, #objectlist do
            local x = 406.63970947266
            local y = 23.453441619873
            local z = 91.331230163574
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~r~[게릴라 RP] 독사회 공격진영 바로가기")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 408.52178955078,26.649480819702,91.331214904785
    while true do
        for i = 1, #objectlist do
            local x = 408.52178955078
            local y = 26.649480819702
            local z = 91.331214904785
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~g~[게릴라 RP] 독사회 방어진영 바로가기")
        end
        end
        Citizen.Wait(0)
    end
end)


-- 디스코드 주소 
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -318.87530517578
            local y = -956.50555419922
            local z = 31.097803115845
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~y~스피드 다리다리 배팅")
        end
        end
        Citizen.Wait(0)
    end
end)

-- 디스코드 주소 
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -2245.9733886719
            local y = 264.97769165039
            local z = 174.61534118652
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
                DrawText3D(x, y, z + 0.35,"~y~Music RP 디스코드\n~w~https://discord.gg/dami\n")
        end
        end
        Citizen.Wait(0)
    end
end)


--신분증 발급 -2242.2651367188,260.45248413086,174.60758972168
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -2242.2651367188
            local y = 260.45248413086
            local z = 174.60758972168
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x, y, z + 0.35,"신분증을 발급해주세요")

        end
        end
        Citizen.Wait(0)
    end
end)

--직업 선택 -2235.3488769531,261.6298828125,174.60845947266
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -2235.3488769531
            local y = 261.6298828125
            local z = 174.60845947266
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x, y, z + 0.35,"직업을 선택해 주세요")

        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- -337.90823364258,-919.20434570313,32.079498291016
    while true do
        for i = 1, #objectlist do
            local x = -337.90823364258
            local y = -919.20434570313
            local z = 32.079498291016
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x, y, z + 0.35,"직업 선택소")

        end
        end
        Citizen.Wait(0)
    end
end) 
--r

Citizen.CreateThread(function() -- 252.09866333008,-735.58099365234,31.706308364868 남부 메차2
    while true do
        for i = 1, #objectlist do
            local x = 252.09866333008
            local y = -735.58099365234
            local z = 31.706308364868
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~g~편의점", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 256.74179077148,-775.11267089844,31.750364303589
    while true do
        for i = 1, #objectlist do
            local x = 256.74179077148
            local y = -775.11267089844
            local z = 31.750364303589
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~g~편의점", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 254.1028137207,-781.99926757813,31.750377655029
    while true do
        for i = 1, #objectlist do
            local x = 254.1028137207
            local y = -781.99926757813
            local z = 31.750377655029
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~g~편의점", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 248.93154907227,-785.82849121094,31.750377655029
    while true do
        for i = 1, #objectlist do
            local x = 248.93154907227
            local y = -785.82849121094
            local z = 31.750377655029
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~g~편의점", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

-------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function() -- 243.80278015137,-743.22521972656,31.304513931274
    while true do
        for i = 1, #objectlist do
            local x = 243.80278015137
            local y = -743.22521972656
            local z = 31.304513931274
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~r~한정 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 246.89688110352,-744.41265869141,31.304517745972
    while true do
        for i = 1, #objectlist do
            local x = 246.89688110352
            local y = -744.41265869141
            local z = 31.304517745972
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~r~한정 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 250.55104064941,-745.88726806641,31.304517745972
    while true do
        for i = 1, #objectlist do
            local x = 250.55104064941
            local y = -745.88726806641
            local z = 31.304517745972
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~r~한정 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 254.12512207031,-747.19104003906,31.30451965332
    while true do
        for i = 1, #objectlist do
            local x = 254.12512207031
            local y = -747.19104003906
            local z = 31.30451965332
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~r~한정 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

------------------------------------ 메차

Citizen.CreateThread(function() -- 217.74789428711,-918.28356933594,30.701225280762 광장 ATM 1
    while true do
        for i = 1, #objectlist do
            local x = 217.74789428711
            local y = -918.28356933594
            local z = 30.701225280762
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~ATM", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 214.01583862305,-923.2958984375,30.708297729492 광장 ATM 2
    while true do
        for i = 1, #objectlist do
            local x = 214.01583862305
            local y = -923.2958984375
            local z = 30.708297729492
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~ATM", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 210.95860290527,-927.54345703125,30.692218780518 광장 ATM 3
    while true do
        for i = 1, #objectlist do
            local x = 210.95860290527
            local y = -927.54345703125
            local z = 30.692218780518
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~ATM", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

-- 뉴비 차고 -2238.4978027344,261.81829833984,174.60963439941
--[[Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -2238.4978027344
            local y = 261.81829833984
            local z = 174.60963439941
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~뉴비 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 50, 220, 100, 255, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)]]--

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -367.92733764648
            local y = -112.62401580811
            local z = 38.680870056152
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~렉카차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 50, 220, 100, 255, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -370.49206542969
            local y = -128.65098571777
            local z = 38.697227478027
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~렉카차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 50, 220, 100, 255, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)
--[[전쟁 RP 위치
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 201.23486328125
            local y = -906.07739257812
            local z = 31.116901397705
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~전쟁RP A보급 포탈", 2.0, 1)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() 
    while true do
        for i = 1, #objectlist do
            local x = 198.91456604004
            local y = -904.123046875
            local z = 31.116868972778
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~전쟁RP 웨어하우스 포탈", 2.0, 1)
        end
        end
        Citizen.Wait(0)
    end
end) ]]

--[[일반 차고
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 228.94906616211
            local y = -783.87042236328
            local z = 30.707168579102
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~일반차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 50, 220, 100, 255, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)]]
--[[
--골드 전용차고
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 245.15093994141
            local y = -771.90191650391
            local z = 30.715394973755
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.5, "~y~GOLD 전용 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 190, 80, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--플레티넘 전용차고
Citizen.CreateThread(function()
    while true do  
        for i = 1, #objectlist do
            local x = 242.1005859375
            local y = -779.69171142578
            local z = 30.620914459229
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.5, "~w~PLATINUM 전용 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 225, 255, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 239.29335021973
            local y = -787.3515625
            local z = 30.561180114746
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.5, "~b~DIAMOND 전용 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 73, 229, 235, 92, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--마스터 전용차고
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 236.53930664063
            local y = -794.95880126953
            local z = 30.507684707642
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.5, "~r~MASTER 전용 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 255, 101, 10, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--레전드 전용차고
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 233.81219482422
            local y = -802.54577636719
            local z = 30.467445373535
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.5, "~r~LEGEND 전용 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 255, 25, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)
 ]]
--[[
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 840.42523193359
            local y = -1030.0217285156
            local z = 28.194858551025
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.5, "~b~DIAMOND 전용 총기", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 100, 200, 255, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--마스터 전용차고
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 840.40808105469
            local y = -1027.7734375
            local z = 28.194858551025
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.5, "~r~MASTER 전용 총기", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 100, 200, 255, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end) ]]


--[[랭커 전용차고
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 243.69828796387
            local y = -777.50573730469
            local z = 30.645168304443
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.5, "~r~RANKER 전용 차고", 2.0, 1)
			--DrawMarker(36, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 100, 200, 255, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)]]

--다이아 스킨
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -709.57067871094
            local y = -384.35354614258
            local z = 34.838497161865
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~DIAMOND 전용 스킨", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 225, 255, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--플레티넘전용 스킨
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -727.37652587891
            local y = -383.51016235352
            local z = 34.828315734863
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~w~PLATINUM 전용 스킨", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 225, 255, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--골드전용 스킨
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -726.13684082031
            local y = -379.94595336914
            local z = 34.828315734863
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~y~GOLD 전용 스킨", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 190, 80, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--실버전용 스킨
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -724.62249755859
            local y = -377.43139648438
            local z = 34.828315734863
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~r~SILVER 전용 스킨", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--후원 마일리지 상점 
--[[Citizen.CreateThread(function() -- -356.31729125977,-955.6162109375,31.100105285645
    while true do
        for i = 1, #objectlist do
            local x = -356.31729125977
            local y = -955.6162109375
            local z = 31.100105285645
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~w~후원 마일리지 상점", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)]]

--메이즈 1호차
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -325.84902954102
            local y = -978.85772705078
            local z = 31.353525161743
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~w~추석 패키지 No.1\n ~r~람보르기니 시안 블랙위도우 에디션", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--메이즈 1호차
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -332.07208251953
            local y = -976.80950927734
            local z = 31.353527069092
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~w~추석 패키지 No.2\n ~r~아폴로 라이팅에디션", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--
--메이즈 1호차
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -337.919921875
            local y = -974.81945800781
            local z = 31.353525161743
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~w~1만원의 행복\n ~r~웨니 피넛", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)


--메이즈 1호차
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -343.04254150391
            local y = -972.83679199219
            local z = 31.353527069092
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~w~뮤직 티켓 차량\n ~r~롤스로이스 보트테일", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)


--메이즈 1호차
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -791.35980224609
            local y = -217.41062927246
            local z = 37.414421081543
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~w~다이아 등급 차량\n ~r~메르세데스 벤츠 VISION GT", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)




Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -356.23040771484
            local y = -970.68597412109
            local z = 32.028076171875
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~뮤직 박스 오픈", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do -- -351.13912963867,-957.15106201172,31.100103378296
            local x = -351.13912963867
            local y = -957.15106201172
            local z = 31.100103378296
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~뮤직 박스 구매\n ~g~1000만원", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -360.93734741211
            local y = -968.89953613281
            local z = 32.028076171875
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~행운 상자 오픈", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -346.77224731445
            local y = -958.99938964844
            local z = 31.100103378296
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~랜덤상자 구매\n ~g~300만원", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do ---352.06451416016,-972.31518554688,32.028076171875
            local x = -352.06451416016
            local y = -972.31518554688
            local z = 32.028076171875
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~랜덤상자 오픈", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 2484.3354492188
            local y = -366.20736694336
            local z = 82.694114685059
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~r~소방서\n~w~[~g~출근~w~] [~g~퇴근~w~]", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 485.69464111328,-997.00921630859,30.689767837524 487.12997436523,-995.62817382813,30.689767837524
    while true do
        for i = 1, #objectlist do
            local x = 487.12997436523
            local y = -995.62817382813
            local z = 30.689767837524
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~방탄복", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 462.94952392578,-996.60015869141,30.68955039978
    while true do
        for i = 1, #objectlist do
            local x = 462.94952392578
            local y = -996.60015869141
            local z = 30.68955039978
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~경찰청 옷장", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 463.5895690918,-999.13568115234,30.689544677734
    while true do
        for i = 1, #objectlist do
            local x = 463.5895690918
            local y = -999.13568115234
            local z = 30.689544677734
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~일반 옷장", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -433.13522338867
            local y = -319.6159362793
            local z = 34.910797119141
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~소방무기", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function() -- 442.89514160156,-1026.4124755859,28.708745956421 
    while true do
        for i = 1, #objectlist do
            local x = 435.28814697266
            local y = -1024.3345947266
            local z = 28.794374465942
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~경찰차고", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 445.77325439453,-986.259765625,25.699934005737
    while true do
        for i = 1, #objectlist do
            local x = 445.77325439453
            local y = -986.259765625
            local z = 25.699934005737
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~경찰차고", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

-----

Citizen.CreateThread(function() -- 445.72912597656,-991.53961181641,25.699934005737
    while true do
        for i = 1, #objectlist do
            local x = 445.72912597656
            local y = -991.53961181641
            local z = 25.699934005737
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~일반차고", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 435.7356262207,-1027.0549316406,28.839517593384
    while true do
        for i = 1, #objectlist do
            local x = 442.20269775391
            local y = -1023.5749511719
            local z = 28.650104522705
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~g~일반차고", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 218.5414276123,-758.76086425781,31.522399902344 메차 atm
    while true do
        for i = 1, #objectlist do
            local x = 218.5414276123
            local y = -758.76086425781
            local z = 31.522399902344
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
                DrawText3D(x,y,z+0.6, "~y~ATM", 2.0, 1)
                ----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 220.94554138184,-759.67657470703,31.522390365601 메차 atm
    while true do
        for i = 1, #objectlist do
            local x = 220.94554138184
            local y = -759.67657470703
            local z = 31.522390365601
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
                DrawText3D(x,y,z+0.6, "~y~ATM", 2.0, 1)
                ----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 244.80871582031,-761.40808105469,31.304525375366 남부 메인차고
    while true do
        for i = 1, #objectlist do
            local x = 244.80871582031
            local y = -761.40808105469
            local z = 31.304525375366
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
                DrawText3D(x,y,z+0.6, "~b~일반차고", 2.0, 1)
                ----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 251.82626342773,-764.12591552734,31.304525375366 남부 메인차고
    while true do
        for i = 1, #objectlist do
            local x = 251.82626342773
            local y = -764.12591552734
            local z = 31.304525375366
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
                DrawText3D(x,y,z+0.6, "~b~일반차고", 2.0, 1)
                ----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 238.10946655273,-758.90405273438,31.304513931274 남부 메인차고
    while true do
        for i = 1, #objectlist do
            local x = 238.10946655273
            local y = -758.90405273438
            local z = 31.304513931274
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
                DrawText3D(x,y,z+0.6, "~b~일반차고", 2.0, 1)
                ----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
            end
        end
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function() -- 241.51483154297,-760.21405029297,31.304513931274 남부 메인차고
    while true do
        for i = 1, #objectlist do
            local x = 241.51483154297
            local y = -760.21405029297
            local z = 31.304513931274
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
                DrawText3D(x,y,z+0.6, "~b~일반차고", 2.0, 1)
                ----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 248.57684326172,-762.93579101563,31.304523468018 남부메인차고 2
    while true do
        for i = 1, #objectlist do
            local x = 248.57684326172
            local y = -762.93579101563
            local z = 31.304523468018
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 30) then
            DrawText3D(x,y,z+0.6, "~b~일반차고", 2.0, 1)
            ----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 445.81442260742,-997.10888671875,25.699920654297   --경찰서 지하
    while true do
        for i = 1, #objectlist do
            local x = 445.81442260742
            local y = -997.10888671875
            local z = 25.699920654297
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~r~한정차고", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- 449.30038452148,-1023.0092773438,28.519569396973 --경찰서 밖
    while true do
        for i = 1, #objectlist do
            local x = 449.30038452148
            local y = -1023.0092773438
            local z = 28.519569396973
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~r~한정차고", 2.0, 1)
			----DrawMarker(41, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 225, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--해상 전쟁 1팀
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 31.194791793823
            local y = 957.36730957031
            local z = 196.57640075684
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~r~해상전장 1팀", 2.0, 1)
			--DrawMarker(35, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 255, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--해상 전쟁 1팀
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = 26.287616729736
            local y = 956.27008056641
            local z = 197.05084228516
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~r~해상전장 1팀", 2.0, 1)
			--DrawMarker(35, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 255, 0, 0, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)


--해상 전쟁 2팀
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -312.23428344727
            local y = 850.39593505859
            local z = 196.44769287109
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~해상전장 2팀", 2.0, 1)
			--DrawMarker(35, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 0, 255, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

--해상 전쟁 2팀
Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -324.14025878906
            local y = 834.14575195313
            local z = 196.65550231934
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 5) then
            DrawText3D(x,y,z+0.6, "~b~해상전장 2팀", 2.0, 1)
			--DrawMarker(35, x, y, z-0.1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 0, 255, 100, true, 0, 0, true)
        end
        end
        Citizen.Wait(0)
    end
end)

objectlist = {
    [1] = 'prop_bench_01a',
    [2] = 'prop_bench_01b',
    [3] = 'prop_bench_01c',
    [4] = 'prop_bench_02',
    [5] = 'prop_bench_03',
    [6] = 'prop_bench_04',
    [7] = 'prop_bench_05',
    [8] = 'prop_bench_06',
    [9] = 'prop_bench_05',
    [10] = 'prop_bench_08',
    [11] = 'prop_bench_09',
    [12] = 'prop_bench_10',
    [13] = 'prop_bench_11'
}
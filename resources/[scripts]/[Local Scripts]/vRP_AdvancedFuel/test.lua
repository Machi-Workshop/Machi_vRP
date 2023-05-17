

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.6*scale)
        SetTextFont(0)
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

function DrawText3D2(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.6*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 0, 0, 255)
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


Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -1030.8408203125
            local y = -2732.3103027344
            local z = 13.756634712219
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
            DrawText3D(x, y, z + 0.35, "엘리시움에 어서오세요!")
            DrawText3D(x, y, z + 0.2, "주민등록증 발급")
        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -322.99188232422
            local y = -699.27380371094
            local z = 32.982234954834
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
            DrawText3D(x, y, z + 0.2, "차고 질서 유지 부탁드립니다")
            DrawText3D(x, y, z + 0.35,"일반 차고")

        end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #objectlist do
            local x = -327.28286743164
            local y = -699.03472900391
            local z = 32.950366973877
            local objectCoords = GetEntityCoords( GetPlayerPed(-1) )
            if(GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
            DrawText3D2(x, y, z + 0.35, "한정 차고")
            DrawText3D2(x, y, z + 0.2, "")
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
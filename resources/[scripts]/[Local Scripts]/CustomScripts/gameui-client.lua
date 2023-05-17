-- 3d vector (airport) <x,y,z>
local start = vector3(1780.3740234375,2567.3474121094,45.797794342041)
local gun = vector3(1625.3029785156,2491.0776367188,45.623893737793?)

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
	RegisterFontFile('Arita-dotum-Bold')
	FontID = RegisterFontId('Arita-dotum-Bold')
    if onScreen then
		SetTextScale(0.0*scale, 0.6*scale)
        SetTextFont(FontId)
        SetTextProportional(1)
        --SetTextColour(0, 255, 0, 255)
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

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if Vdist2(GetEntityCoords(PlayerPedId(), false), start) < 30 then
				SetTextFont(FontId)
				Draw3DText(start.x, start.y, start.z, 1, "~y~[H]~s~ 키를 눌러 ~r~총격전 RP~s~를 시작합니다.")
            end
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
				if Vdist2(GetEntityCoords(PlayerPedId(), false), gun) < 30 then
				SetTextFont(FontId)
                Draw3DText(gun.x, gun.y, gun.z, 1, "~y~[H]~s~ 키를 눌러 ~r~총기~s~를 지급받습니다.")
            end
        end
    end
)

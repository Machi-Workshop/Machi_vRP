function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end

function RequestTextureDictionary (dict)
	RequestStreamedTextureDict(dict)

	while not HasStreamedTextureDictLoaded(dict) do Citizen.Wait(0) end

	return dict
end;

function LoadModel (model)
	if not IsModelInCdimage(model) then return end

	RequestModel(model)

	while not HasModelLoaded(model) do Citizen.Wait(0) end

	return model
end

function CreateObj (model, coords, ang, networked)
	LoadModel(model)

	local entity = CreateObject(model, coords.x, coords.y, coords.z, networked == true, true, false)

	SetEntityHeading(entity, ang or 0.0)
	SetModelAsNoLongerNeeded(model)

	return entity
end

--------------------------------------------------------------------------------

local scale = 1.0--크기 조정
local screenssWidth = math.floor(1920 / scale)--영상 크기 조절 
local screenssHeight = math.floor(790 / scale)
local screenss = 0

local shouldDraw = false
local model = GetHashKey('xm_prop_x17dlc_monitor_wall_01a')--프롭 이름
local handle = CreateNamedRenderTargetForModel('prop_x17dlc_monitor_wall_01a', model)--dui 모델 이름

local txd = Citizen.InvokeNative(GetHashKey("CREATE_RUNTIME_TXD"), 'video2', Citizen.ResultAsLong())
local duiObj = Citizen.InvokeNative(GetHashKey('CREATE_DUI'), "about:blank", screenssWidth, screenssHeight, Citizen.ResultAsLong())
local dui = Citizen.InvokeNative(GetHashKey('GET_DUI_HANDLE'), duiObj, Citizen.ResultAsString())
local tx = Citizen.InvokeNative(GetHashKey("CREATE_RUNTIME_TEXTURE_FROM_DUI_HANDLE") & 0xFFFFFFFF, txd, 'test2', dui, Citizen.ResultAsLong())

-- Draw
Citizen.CreateThread(function ()



	while true do
		SetTextRenderId(handle)
		Set_2dLayer(4)
		Citizen.InvokeNative(0xC6372ECD45D73BCD, 1) -- SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU

		-- Draw black|off texture
		DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 255)

		-- Draw the dui and mouse
		if DoesEntityExist(screenss) and shouldDraw then
			DrawSprite("video2", "test2", 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
			
		end

		SetTextRenderId(GetDefaultScriptRendertargetRenderId())
		Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
		Wait(0)
	end
end)

-- 화면을 생성하는 명령을 내리십시오.
local function Createscreenss (screenssCoords, screenssAngle)
        if DoesEntityExist(screenss) then
            SetEntityAsMissionEntity(screenss,  false,  true)
            DeleteObject(screenss)
            screenss = nil
        end

    local screenss = CreateObj(model, screenssCoords, screenssAngle, true)
    local screenssNet = ObjToNet(screenss)

    if NetworkDoesNetworkIdExist(screenssNet) then
        if NetworkGetEntityIsNetworked(screenss) then
            SetNetworkIdExistsOnAllMachines(screenssNet, 1)
        end
    end

    -- Tell the server about the entity
    TriggerServerEvent('youtube:createscreenss', screenssNet, {
        x = screenssCoords.x,
        y = screenssCoords.y,
        z = screenssCoords.z
    }, screenssAngle)
end

-- 명령어로 화면 생성
RegisterCommand('瀚契魯youtube', function () -- 오브젝트 생성 및 시작

	local playerPed = PlayerPedId()
	local screenssAngle = GetEntityHeading(playerPed) + 30
	local screenssCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0,1.0, -1.0)

	Createscreenss(screenssCoords, screenssAngle)

end)
-- 이전 위치에서 화면생성 
RegisterNetEvent('youtube:init')
AddEventHandler('youtube:init', Createscreenss)

-- 서버로 부터 받은 화면 엔티티
RegisterNetEvent('youtube:createscreenss')
AddEventHandler('youtube:createscreenss', function (netId)
	-- The netId may arrive before the entity has migrated
	  if DoesEntityExist(screenss) and NetworkHasControlOfEntity(screenss) then
        SetEntityAsMissionEntity(screenss,  false,  true)
        DeleteObject(screenss)
    end
	while not NetworkDoesNetworkIdExist(netId) do Wait(0) end

	screenss = NetToObj(netId)
	print('cinema ready', netId)
end)

-- dui 화면 컨트롤 제거함.

-- Handle proximityHandle proximity
Citizen.CreateThread(function ()
	local playerPed
	local playerCoords
	local screenssCoords

	while true do
		playerPed = PlayerPedId()
		playerCoords = GetEntityCoords(playerPed)

		if DoesEntityExist(screenss) then
			screenssCoords = GetEntityCoords(screenss)

			if GetDistanceBetweenCoords(
				playerCoords.x, playerCoords.y, playerCoords.z,
				screenssCoords.x, screenssCoords.y, screenssCoords.z
			) <= 25.0 then
				if not shouldDraw then
				Wait(1000)			
				RegisterCommand('reset', function () --주소 리셋 영상 안나올 때 
				SetDuiUrl(duiObj, 'http://fireworkmen.mooo.com/eltv.html')
					Wait(1500)	
				SetDuiUrl(duiObj, 'about:blank')
					Wait(1500)	
				SetDuiUrl(duiObj, 'http://fireworkmen.mooo.com/eltv.html')
	
				end)
				SetDuiUrl(duiObj, 'about:blank')
		SetDuiUrl(duiObj, 'http://fireworkmen.mooo.com/eltv.html')
		Wait(1500)
					SetDuiUrl(duiObj, 'about:blank')
			Wait(1500)	
				SetDuiUrl(duiObj, 'http://fireworkmen.mooo.com/eltv.html')
					Wait(500)	
					print('Within youtube range.')
					shouldDraw = true
					Wait(500)
				end
			else
				if shouldDraw then
					SetDuiUrl(duiObj, 'about:blank') --빈 url을 불러와서 영상을 멈추게 한다 
					print('Out of youtube range.')
					shouldDraw = false
					Wait(500)
				end
			end
		end

		Wait(0)
	end
end)

-- Cleanup on resource stopped
AddEventHandler('onResourceStop', function (resource)
	if resource == GetCurrentResourceName() then
		SetDuiUrl(duiObj, 'about:blank')
		DestroyDui(duiObj)
		Citizen.InvokeNative(0xE9F6FFE837354DD4, 'prop_x17dlc_monitor_wall_01a') -- RELEASE_NAMED_RENDERTARGET
		if DoesEntityExist(screenss) and NetworkHasControlOfEntity(screenss) then
			SetEntityAsMissionEntity(screenss,  false,  true)
			DeleteObject(screenss)
		end
	end
end)

RegisterNetEvent('ObjectDeleteGunOn') -- Registers the event on the net so that it can be called on a server_script
RegisterNetEvent('ObjectDeleteGunOff') -- Registers the event on the net so that it can be called on a server_script
RegisterNetEvent('noPermissions') -- Registers the event on the net so that it can be called on a server_script
local toggle = false

AddEventHandler('ObjectDeleteGunOn', function() -- adds an event handler so it can be registered
	if toggle == false then -- checks if toggle is false
		drawNotification("~g~Object Delete Gun Enabled!") -- activates function drawNotification() with message in parentheses
		toggle = true -- sets toggle to true
	else -- if not
		drawNotification('~y~Object Delete Gun is already enabled!') -- activates function drawNotification() with message in parentheses
	end
end)

AddEventHandler('ObjectDeleteGunOff', function() -- adds an event handler so it can be registered
	if toggle == true then -- checks if toggle is true
		drawNotification('~b~Object Delete Gun Disabled!') -- activates function drawNotification() with message in parentheses
		toggle = false -- sets toggle to false
	else -- if not
		drawNotification('~y~Object Delete Gun is already disabled!') -- activates function drawNotification() with message in parentheses
	end
end)

AddEventHandler('noPermissions', function() -- adds an event handler so it can be registered
	drawNotification("~r~You have insufficient permissions to activate the Object Delete Gun.") -- activates function drawNotification() with message in parentheses
end)

Citizen.CreateThread(function() -- Creates thread
	while true do -- infinite loop
		Citizen.Wait(0) -- wait so it doesnt crash
		if toggle then -- checks toggle if its true (infinitely
			if IsPlayerFreeAiming(PlayerId()) then -- checks if player is aiming around
				local entity = getEntity(PlayerId()) -- gets the entity
				if IsPedShooting(GetPlayerPed(-1)) then -- checks if ped is shooting
					SetEntityAsMissionEntity(entity, true, true) -- sets the entity as mission entity so it can be despawned
					DeleteEntity(entity) -- deletes the entity

				end
			end
		end
	end
end)

function getEntity(player) --Function To Get Entity Player Is Aiming At
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

function drawNotification(text) --Just Don't Edit!
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
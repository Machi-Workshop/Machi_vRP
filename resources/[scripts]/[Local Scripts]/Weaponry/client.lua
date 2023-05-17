--[[       

####	Title:          	Weaponry - Realistic Gunplay

####	Description:     	FiveM Script that adds Recoil to weapons, ability to toggle the reticle 

####						and removes ammo from the hud

####

####	URL:				https://forum.fivem.net/t/weaponry-realistic-gunplay-recoil-no-ammo-hud-no-reticle/				

####	Author:		 		Lyrad

####	Release date:       15th of July, 2018.

####	Update date:		28th of June, 2019.

####	Contributors:		AdrineX and Spudgun

####	Version:        	v1.2  

]]--



local global_wait = 300 			-- Don't change this

local disable_reticle =  false		-- Change this to false if you want a reticle



local scopedWeapons = 

{

    100416529,  	-- WEAPON_SNIPERRIFLE

    205991906,  	-- WEAPON_HEAVYSNIPER

    3342088282, 	-- WEAPON_MARKSMANRIFLE

	177293209,  	-- WEAPON_HEAVYSNIPER MKII

	1785463520  	-- WEAPON_MARKSMANRIFLE_MK2

}



function HashInTable( hash )

    for k, v in pairs( scopedWeapons ) do 

        if ( hash == v ) then 

            return true 

        end 

    end 



    return false 

end 



function ManageReticle()

    local ped = GetPlayerPed( -1 )

    local _, hash = GetCurrentPedWeapon( ped, true )

        if not HashInTable( hash ) then 

            HideHudComponentThisFrame( 14 )

		end 

end 





Citizen.CreateThread(function()

	local wait = global_wait

	while true do

		Citizen.Wait(wait)

		local ped = GetPlayerPed(-1)

		if IsPedArmed(ped, 6) then

			wait = 0

			local weapon = GetSelectedPedWeapon(ped)

			

			-- Disable reticle

			if disable_reticle then		

				ManageReticle()

			end

			

			-- Disable melee while aiming (may be not working)			

	       	DisableControlAction(1, 140, true)

	        DisableControlAction(1, 141, true)

	        DisableControlAction(1, 142, true)

			

			-- Disable ammo HUD			

			DisplayAmmoThisFrame(false)

			

			-- Shakycam				

			if IsPedShooting(ped) then

				-- Pistols

				if weapon == GetHashKey("WEAPON_STUNGUN") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)



				elseif weapon == GetHashKey("WEAPON_FLAREGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)

				

				elseif weapon == GetHashKey("WEAPON_SNSPISTOL") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)

				

				elseif weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)

				

				elseif weapon == GetHashKey("WEAPON_PISTOL") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)

				

				elseif weapon == GetHashKey("WEAPON_PISTOL_MK2") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)

				

				elseif weapon == GetHashKey("WEAPON_APPISTOL") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)

				

				elseif weapon == GetHashKey("WEAPON_COMBATPISTOL") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)

				

				elseif weapon == GetHashKey("WEAPON_PISTOL50") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)

				

				elseif weapon == GetHashKey("WEAPON_HEAVYPISTOL") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)

				

				elseif weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)

				

				elseif weapon == GetHashKey("WEAPON_MARKSMANPISTOL") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)

				

				elseif weapon == GetHashKey("WEAPON_REVOLVER") then						

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)

				

				elseif weapon == GetHashKey("WEAPON_REVOLVER_MK2") then						

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)

				

				elseif weapon == GetHashKey("WEAPON_DOUBLEACTION") then						

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)

				

				-- Small Machine Guns (SMG's)				

				elseif weapon == GetHashKey("WEAPON_MICROSMG") then						

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)

				

				elseif weapon == GetHashKey("WEAPON_COMBATPDW") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)

				

				elseif weapon == GetHashKey("WEAPON_SMG") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)

				

				elseif weapon == GetHashKey("WEAPON_SMG_MK2") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)

				

				elseif weapon == GetHashKey("WEAPON_ASSAULTSMG") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)

				

				elseif weapon == GetHashKey("WEAPON_MACHINEPISTOL") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)

				

				elseif weapon == GetHashKey("WEAPON_MINISMG") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)

				

				elseif weapon == GetHashKey("WEAPON_MG") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)

				

				elseif weapon == GetHashKey("WEAPON_COMBATMG") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)

				

				elseif weapon == GetHashKey("WEAPON_COMBATMG_MK2") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)

				

				-- Rifles				

				elseif weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)

				

				elseif weapon == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.075)

				

				elseif weapon == GetHashKey("WEAPON_CARBINERIFLE") then				

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)

				

				elseif weapon == GetHashKey("WEAPON_CARBINERIFLE_MK2") then						

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.065)

				

				elseif weapon == GetHashKey("WEAPON_ADVANCEDRIFLE") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)

				

				elseif weapon == GetHashKey("WEAPON_GUSENBERG") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)

				

				elseif weapon == GetHashKey("WEAPON_SPECIALCARBINE") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)

				

				elseif weapon == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.075)

				

				elseif weapon == GetHashKey("WEAPON_BULLPUPRIFLE") then						

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)

				

				elseif weapon == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.065)

				

				elseif weapon == GetHashKey("WEAPON_COMPACTRIFLE") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)

				

				-- Shotguns				

				elseif weapon == GetHashKey("WEAPON_PUMPSHOTGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)

				

				elseif weapon == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)

				

				elseif weapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)

				

				elseif weapon == GetHashKey("WEAPON_ASSAULTSHOTGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.12)

				

				elseif weapon == GetHashKey("WEAPON_BULLPUPSHOTGUN") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)

				

				elseif weapon == GetHashKey("WEAPON_DBSHOTGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)

				

				elseif weapon == GetHashKey("WEAPON_AUTOSHOTGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)

				

				elseif weapon == GetHashKey("WEAPON_MUSKET") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.04)

				

				elseif weapon == GetHashKey("WEAPON_HEAVYSHOTGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.13)

				

				-- Snipers				

				elseif weapon == GetHashKey("WEAPON_SNIPERRIFLE") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)

				

				elseif weapon == GetHashKey("WEAPON_HEAVYSNIPER") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)

				

				elseif weapon == GetHashKey("WEAPON_HEAVYSNIPER_MK2") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.35)

				

				elseif weapon == GetHashKey("WEAPON_MARKSMANRIFLE") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)

				

				elseif weapon == GetHashKey("WEAPON_MARKSMANRIFLE_MK2") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)

				

				-- Launchers				

				elseif weapon == GetHashKey("WEAPON_GRENADELAUNCHER") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)

				

				elseif weapon == GetHashKey("WEAPON_RPG") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.9)

				

				elseif weapon == GetHashKey("WEAPON_HOMINGLAUNCHER") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.9)

				

				elseif weapon == GetHashKey("WEAPON_MINIGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.20)

				

				elseif weapon == GetHashKey("WEAPON_RAILGUN") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)				

				

				elseif weapon == GetHashKey("WEAPON_COMPACTLAUNCHER") then

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)

				

				elseif weapon == GetHashKey("WEAPON_FIREWORK") then					

					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.5)

				

				-- Infinite FireExtinguisher				

				elseif weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then					

					SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))

				end

			end

		else

			wait = global_wait

		end

	end

end)



-- recoil script by bluethefurry / Blumlaut https://forum.fivem.net/t/betterrecoil-better-3rd-person-recoil-for-fivem/82894

-- I just added some missing weapons because of the doomsday update adding some MK2.

-- I can't manage to make negative hashes works, if someone make it works, please let me know =)



local recoils = {

	[453432689] = 0.3, -- PISTOL

	[3219281620] = 0.3, -- PISTOL MK2

	[1593441988] = 0.2, -- COMBAT PISTOL

	[584646201] = 0.1, -- AP PISTOL

	[2578377531] = 0.6, -- PISTOL .50

	[324215364] = 0.2, -- MICRO SMG

	[736523883] = 0.1, -- SMG

	[2024373456] = 0.1, -- SMG MK2

	[4024951519] = 0.1, -- ASSAULT SMG

	[3220176749] = 0.2, -- ASSAULT RIFLE

	[961495388] = 0.2, -- ASSAULT RIFLE MK2

	[2210333304] = 0.1, -- CARBINE RIFLE

	[4208062921] = 0.1, -- CARBINE RIFLE MK2

	[2937143193] = 0.1, -- ADVANCED RIFLE

	[2634544996] = 0.1, -- MG

	[2144741730] = 0.1, -- COMBAT MG

	[3686625920] = 0.1, -- COMBAT MG MK2

	[487013001] = 0.4, -- PUMP SHOTGUN

	[1432025498] = 0.4, -- PUMP SHOTGUN MK2

	[2017895192] = 0.7, -- SAWNOFF SHOTGUN

	[3800352039] = 0.4, -- ASSAULT SHOTGUN

	[2640438543] = 0.2, -- BULLPUP SHOTGUN

	[911657153] = 0.1, -- STUN GUN

	[100416529] = 0.5, -- SNIPER RIFLE

	[205991906] = 0.7, -- HEAVY SNIPER

	[177293209] = 0.7, -- HEAVY SNIPER MK2

	[856002082] = 1.2, -- REMOTE SNIPER

	[2726580491] = 1.0, -- GRENADE LAUNCHER

	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE

	[2982836145] = 0.0, -- RPG

	[1752584910] = 0.0, -- STINGER

	[1119849093] = 0.01, -- MINIGUN

	[3218215474] = 0.2, -- SNS PISTOL

	[2009644972] = 0.25, -- SNS PISTOL MK2

	[1627465347] = 0.1, -- GUSENBERG

	[3231910285] = 0.2, -- SPECIAL CARBINE

	[-1768145561] = 0.25, -- SPECIAL CARBINE MK2

	[3523564046] = 0.5, -- HEAVY PISTOL

	[2132975508] = 0.2, -- BULLPUP RIFLE

	[-2066285827] = 0.25, -- BULLPUP RIFLE MK2

	[137902532] = 0.4, -- VINTAGE PISTOL

	[-1746263880] = 0.4, -- DOUBLE ACTION REVOLVER

	[2828843422] = 0.7, -- MUSKET

	[984333226] = 0.2, -- HEAVY SHOTGUN

	[3342088282] = 0.3, -- MARKSMAN RIFLE

	[1785463520] = 0.35, -- MARKSMAN RIFLE MK2

	[1672152130] = 0, -- HOMING LAUNCHER

	[1198879012] = 0.9, -- FLARE GUN

	[171789620] = 0.2, -- COMBAT PDW

	[3696079510] = 0.9, -- MARKSMAN PISTOL

  	[1834241177] = 2.4, -- RAILGUN

	[3675956304] = 0.3, -- MACHINE PISTOL

	[3249783761] = 0.6, -- REVOLVER

	[-879347409] = 0.65, -- REVOLVER MK2

	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN

	[1649403952] = 0.3, -- COMPACT RIFLE

	[317205821] = 0.2, -- AUTO SHOTGUN

	[125959754] = 0.5, -- COMPACT LAUNCHER

	[3173288789] = 0.1, -- MINI SMG		

}







Citizen.CreateThread(function()

	local wait = global_wait

	while true do

		Citizen.Wait(wait)

		if IsPedArmed(PlayerPedId(), 6) then

			wait = 0

			local ped = PlayerPedId()

			if IsPedShooting(ped) and not IsPedDoingDriveby(ped) then

				local _,wep = GetCurrentPedWeapon(ped)

				_,cAmmo = GetAmmoInClip(ped, wep)

				if recoils[wep] and recoils[wep] ~= 0 then

					tv = 0

					repeat 

						Wait(0)

						p = GetGameplayCamRelativePitch()

						if GetFollowPedCamViewMode() ~= 4 then

							SetGameplayCamRelativePitch(p+0.1, 0.2)

						end		

					tv = tv+0.1

					until tv >= recoils[wep]

				end

				

			end

		else

			wait = global_wait

		end

	end

end)
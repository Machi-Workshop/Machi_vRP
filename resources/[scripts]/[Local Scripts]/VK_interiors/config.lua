INTERIORS = {
    -- HOPITAL
    [1] = {id = 1, x = 360.08847045898, y = -585.16223144531, z = 28.820465087891,  name = "응급실 나가기", destination = {2}},
    [2] = {id = 2, x = 251.32405090332, y = -1367.2664794922, z = 39.534370422363,  name = "응급실 들어가기", destination = {1}},
    


    -- FIB
    [4] = {id = 4, x = 138.18788146973, y = -764.86633300781, z = 45.75199508667,  name = "국가정보원 나가기", destination = {5}},
    --[4] = {id = 4, x = 136.56649780273, y = -765.42962646484, z = 242.15199279785,  name = "Exit FBI", destination = {5}},
    [5] = {id = 5, x = 136.56649780273, y = -765.42962646484, z = 242.15199279785,  name = "국가정보원 들어가기", destination = {4}},

    -- FIB GARAGE
    [6] = {id = 6, x = 142.06883239746, y = -768.97241210938, z = 45.752010345459, h = 72.884956359863, name = "FIB Building", destination = {7}},
    [7] = {id = 7, x = 176.67442321777, y = -728.77349853516, z = 39.403667449951, h = 248.2452545166, name = "Garage", destination = {6}},

    -- BAHMAS MAMAS
    --[8] = {id = 8, x = -1388.9272460938, y = -586.08123779297, z = 30.219741821289, h = 35.407787322998, name = "나가기", destination = {9}},
    --[9] = {id = 9, x = -1394.5030517578, y = -596.09210205078, z = 30.319562911987, h = 205.4248046875, name = "클럽 엘리시움 들어가기", destination = {8}},

    -- HOPITAL Dead
    [12] = {id = 12, x = 240.50773620605, y = -1379.4248046875, z = 33.741641998291,  name = "Exit Morgue", destination = {13}},
    [13] = {id = 13,x = 285.69213867188, y = -1351.2567138672, z = 24.534639358521,  name = "Enter Morgue", destination = {12}},

--	Police Gun
    [14] = {id = 14, x = 452.10162353516, y = -982.51348876953, z = 30.689580917358,  name = "Exit Armory", destination = {15}},
    [15] = {id = 15, x = 454.17575073242, y = -982.42846679688, z = 30.689605712891,  name = "Enter Armory", destination = {14}},

-- Lawyer
    [16] = {id = 16, x = -1898.3725585938, y = -572.23272705078, z = 11.844171524048,  name = "Exit Lawyers office", destination = {17}},
    [17] = {id = 17,x = -1902.0192871094, y = -572.36346435547, z = 19.097213745117,  name = "Enter Lawyers office", destination = {16}},	
	
	-- New
    [18] = {id = 18, x =  3562.8259277344, y = 3690.3332519531, z = 28.121658325195,  name = "Enter Business", destination = {19}},
    [19] = {id = 19,x = 3526.3579101563, y = 3673.7409667969, z = 28.121139526367,  name = "Exit Business", destination = {18}},
	-- New
    [20] = {id = 20, x =  -1396.8383789063, y = -1008.8212280273, z = 24.70457649231,  name = "삼합회 저택 들어가기", destination = {21}},
    [21] = {id = 21,x = -1370.9072265625, y = -1001.8865966797, z = 8.2923002243042,  name = "삼합회 저택 나가기", destination = {20}},
	-- New
   -- [22] = {id = 22, x =  -262.89254760742, y = -713.45825195313, z = 71.032730102539,  name = "Enter Home", destination = {23}},
   -- [23] = {id = 23,x = -271.89880371094, y = -693.51745605469, z = 34.276473999023,  name = "Exit Home", destination = {22}},	
  -- Mafia House
    [24] = {id = 24, x =  1394.4956054688, y = 1152.6457519531, z = 114.41397857666,  name = "시미즈카이 저택 나가기", destination = {25}},
    [25] = {id = 25, x = 1396.7984619141, y = 1141.5932617188, z = 114.33354187012,  name = "시미즈카이 저택 들어가기", destination = {24}},
  -- 삼합회 수영장
    [26] = {id = 26, x = -1399.4239501953, y = -986.27062988281, z = 19.380447387695,  name = "수영장 가기", destination = {27}},
    [27] = {id = 27, x = -1396.2088623047, y = -1000.7382202148, z = 24.70457649231,  name = "삼합회 저택 들어가기", destination = {26}},
  -- EMS 옥상
    [28] = {id = 28, x = 361.55169677734, y = -580.25946044922, z = 28.828340530396,  name = "EMS 옥상 나가기", destination = {29}},
    [29] = {id = 29, x = 339.86917114258, y = -583.98480224609, z = 74.165649414063,  name = "EMS 옥상 들어가기", destination = {28}}, 
  -- 메이즈뱅크 옥상
    [30] = {id = 30, x = -75.46671295166, y = -825.80383300781, z = 321.29190063477,  name = "메이즈 뱅크 타워 옥상 가기", destination = {31}},
    [31] = {id = 31, x = -70.957939147949, y = -799.73712158203, z = 44.227291107178,  name = "메이즈 뱅크 타워 옥상 나가기", destination = {30}},
  -- 아카디어스 옥상
    [32] = {id = 32, x = -135.99784851074, y = -596.46508789063, z = 206.9156036377,  name = "아카디어스 옥상 가기", destination = {33}},
    [33] = {id = 33, x = -114.32406616211, y = -602.45129394531, z = 36.280715942383,  name = "아카디어스 옥상 나가기", destination = {32}},
    
--    [34] = {id = 34, x = 930.88812255859, y = 44.106189727783, z = 81.094787597656,  name = "카지노 나가기", destination = {35}},
-- [35] = {id = 35, x = 906.66900634766, y = -942.90209960938, z = 44.421562194824,  name = "카지노 들어가기", destination = {34}},
    
    [36] = {id = 36, x = 4.8348937034607, y = 220.30805969238, z = 107.72504425049,  name = "City MoNes Club 나가기", destination = {37}},
    [37] = {id = 37, x = -1569.5506591797, y = -3017.3059082031, z = -74.406150817871,  name = "City MoNes Club 들어가기", destination = {36}},
    
    [38] = {id = 38, x = -2360.7512207031, y = 3249.2556152344, z = 32.810722351074,  name = "관제탑", destination = {39}},
    [39] = {id = 39, x = -2353.2082519531, y = 3251.2373046875, z = 101.45072174072,  name = "관제탑", destination = {38}},
}

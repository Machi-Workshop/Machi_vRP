--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE



local Director = {"license:7c67b8e3e89dffa9ac52d2759f65f491b74feb79",}
local Admin = {"steam:1100001095cfff6",}
local Police = {
"license:a926de28030e93e6fe1bc3f29c693fb1b9034e77",
"license:8cfe1745b2606017e6f46c130cf63b11065e92d8",
"steam:110000103200dd2",
"steam:1100001184d0fb6",
"license:09a38a6f22f656ad8c771200c4ce491399dcf393",
"steam:110000132769ab1",
"steam:11000010895e65c",
"steam:110000111f53d3a",
"steam:11000011379ae70",
"steam:1100001141ee6bd",
"steam:110000119adba3d",
"steam:11000010d400ce3",}
local Police2 = {"license:001d2e06c816d8047862ec311d3dce1cbe5b652f",}
local Police3 = {"license:bc1cd058b3510f2f721fd9bf6193c3a14a42b852",}
local Fire = {"steam:","ip:",}
local EMS = {"steam:11000010f45381b",}
local EMS2 = {"steam:110000115bf57f8",}
local EMS3 = {"license:a926de28030e93e6fe1bc3f29c693fb1b9034e77","steam:1100001098130bb",}
local EMS4 = {"steam:11000010aa02a1e","steam:110000118588941","steam:11000010bc6e8ab","license:d5f8622eb21bc0b31c96ddb8b26cc6d265269b21","license:5f13bfba1f4e58fc217fb45bd05e3fb68acf99a2",}
local UBER = {"steam:11000010a598ed0","steam:110000119adba3d","license:ec62ddc0eb358a0a85cb875f9890255ffa6d82d6",}
local Moderator = {"steam:","ip:",}
local STNIS1 = {"steam:","ip:",}
local Officer = {"license:6ab84d39d447fadaa4a93c022b51abc46d1790be","steam:1100001168cd869","steam:11000011ab73af9",}
local ScriptCreator = {"steam:110000108ce69e8","ip:",}


AddEventHandler('chatMessage', function(Source, Name, Msg)
    args = stringsplit(Msg, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    else     
        local player = GetPlayerIdentifiers(Source)[1]
        if has_value(Director, player) then
            TriggerClientEvent('chatMessage', -1, "서버 관리자 ◆ 에어 엘리시움 | " .. Name, { 255, 0, 0 }, Msg)           
        elseif has_value(Admin, player) then
            TriggerClientEvent('chatMessage', -1, "서버 관리자 ◆ 잘생김 | " .. Name, { 255, 0, 0 }, Msg)
		elseif has_value(Police2, player) then
            TriggerClientEvent('chatMessage', -1, "경찰서장 | " .. Name, { 90, 150, 255 }, Msg)
		elseif has_value(Police3, player) then
            TriggerClientEvent('chatMessage', -1, "연방경찰국장 | " .. Name, { 70, 110, 255 }, Msg)
        elseif has_value(Police, player) then
            TriggerClientEvent('chatMessage', -1, "경찰 | " .. Name, { 90, 150, 255 }, Msg)
        elseif has_value(Fire, player) then
            TriggerClientEvent('chatMessage', -1, "Fire | " .. Name, { 0, 0, 255 }, Msg)
        elseif has_value(EMS, player) then
            TriggerClientEvent('chatMessage', -1, "의료국장 | " .. Name, { 178, 102, 255 }, Msg)
		elseif has_value(EMS2, player) then
            TriggerClientEvent('chatMessage', -1, "병원장 | " .. Name, { 178, 102, 255 }, Msg)
		elseif has_value(EMS3, player) then
            TriggerClientEvent('chatMessage', -1, "구급대원 | " .. Name, { 178, 102, 255 }, Msg)
		elseif has_value(EMS4, player) then
            TriggerClientEvent('chatMessage', -1, "구급대원 인턴직 | " .. Name, { 178, 102, 255 }, Msg)
        elseif has_value(UBER, player) then
            TriggerClientEvent('chatMessage', -1, "택시 | " .. Name, { 255, 102, 0 }, Msg)
	    elseif has_value(Moderator, player) then
            TriggerClientEvent('chatMessage', -1, "Moderator | " .. Name, { 0, 255, 247 }, Msg)
        elseif has_value(STNIS1, player) then
            TriggerClientEvent('chatMessage', -1, "연방경찰국 NIS | " .. Name, { 222, 100, 100 }, Msg)
		elseif has_value(Officer, player) then
            TriggerClientEvent('chatMessage', -1, "정부 · 공무수행 | " .. Name, { 51, 204, 102 }, Msg)
		elseif has_value(ScriptCreator, player) then
            TriggerClientEvent('chatMessage', -1, "Chat Roles Creator | " .. Name, { 0, 255, 43 }, Msg)
        else
            TriggerClientEvent('chatMessage', -1, "시민 | " .. Name, { 255, 255, 255 }, Msg)
        end
            
    end
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

---ALLOWS YOU TO CHECK VERSIONS IN GAME

AddEventHandler('chatMessage', function(source, name, msg)
  if msg:sub(1, 1) == "/" then
    sm = stringsplit(msg, " ");
	   if sm[1] == "/fversion" then
		     CancelEvent()
	TriggerClientEvent('chatMessage', source, "^0[^1RolesFX Script Version Check^0]", {30, 144, 255}, " ^2Version 1.1.0 | RolesFX By Jay Gatsby!^0 ) " .. string.sub(msg,11))
     end
  end

end)

---PRINTS THIS CODE BELOW TO THE CONSOLE 

--print('Jay's Roles FX has loaded in to the server! Type in chat to test it out!')

--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE
--- IP'S ARE BROKEN DO NOT USE

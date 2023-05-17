local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")

-- this module define some admin menu functions

local player_lists = {}

local function ch_list(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.list") then
    if player_lists[player] then -- hide
      player_lists[player] = nil
      vRPclient.removeDiv(player,{"user_list"})
    else -- show
      local content = ""
      local count = 0
      for k,v in pairs(vRP.rusers) do
        count = count+1
        local source = vRP.getUserSource(k)
        vRP.getUserIdentity(k, function(identity)
          if source ~= nil then
            content = content.."<br />"..k.." => <span class=\"pseudo\">"..vRP.getPlayerName(source).."</span> <span class=\"endpoint\">"..vRP.getPlayerEndpoint(source).."</span>"
            if identity then
              content = content.." <span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span> <span class=\"reg\">"..identity.registration.."</span> <span class=\"phone\">"..identity.phone.."</span>"
            end
          end

          -- check end
          count = count-1
          if count == 0 then
            player_lists[player] = true
            local css = [[
.div_user_list{ 
  margin: auto; 
  padding: 8px; 
  width: 650px; 
  margin-top: 80px; 
  background: black; 
  color: white; 
  font-weight: bold; 
  font-size: 1.1em;
} 

.div_user_list .pseudo{ 
  color: rgb(0,255,125);
}

.div_user_list .endpoint{ 
  color: rgb(255,0,0);
}

.div_user_list .name{ 
  color: #309eff;
}

.div_user_list .reg{ 
  color: rgb(0,125,255);
}
              
.div_user_list .phone{ 
  color: rgb(211, 0, 255);
}
            ]]
            vRPclient.setDiv(player,{"user_list", css, content})
          end
        end)
      end
    end
  end
end

local function ch_whitelist(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.whitelist") then
    vRP.prompt(player,"User id to whitelist: ","",function(player,id)
      id = parseInt(id)
      vRP.setWhitelisted(id,true)
      vRPclient.notify(player,{"whitelisted user "..id})
    end)
  end
end

local function ch_unwhitelist(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.unwhitelist") then
    vRP.prompt(player,"User id to un-whitelist: ","",function(player,id)
      id = parseInt(id)
      vRP.setWhitelisted(id,false)
      vRPclient.notify(player,{"un-whitelisted user "..id})
    end)
  end
end

local function ch_addgroup(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.add") then
    vRP.prompt(player,"User id: ","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.addUserGroup(id,group)
        vRPclient.notify(player,{group.." added to user "..id})
      end)
    end)
  end
end

local function ch_removegroup(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.remove") then
    vRP.prompt(player,"User id: ","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"Group to remove: ","",function(player,group)
        vRP.removeUserGroup(id,group)
        vRPclient.notify(player,{group.." removed from user "..id})
      end)
    end)
  end
end

local function ch_addcop(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addcop") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"학생, 순경, 경장, 경사, 경위, 경감, 경정, 치안정감","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "학생" then
            vRP.addUserGroup(id,"경찰 학생")
          end
          if groupprefix == "순경" then
            vRP.addUserGroup(id,"경찰 순경")
          end 
          if groupprefix == "경장" then
            vRP.addUserGroup(id,"경찰 경장")
          end
          if groupprefix == "경사" then
            vRP.addUserGroup(id,"경찰 경사")
          end
          if groupprefix == "경위" then
            vRP.addUserGroup(id,"경찰 경위")
          end
          if groupprefix == "경감" then
            vRP.addUserGroup(id,"경찰 경감")
          end
          if groupprefix == "경정" then
            vRP.addUserGroup(id,"경찰 경정")
          end
          if groupprefix == "치안정감" then
            vRP.addUserGroup(id,"치안정감")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_removecop(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removecop") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"경찰 학생")
        vRP.removeUserGroup(id,"경찰 순경")
        vRP.removeUserGroup(id,"경찰 경장")
        vRP.removeUserGroup(id,"경찰 경사")
        vRP.removeUserGroup(id,"경찰 경위")
        vRP.removeUserGroup(id,"경찰 경감")
        vRP.removeUserGroup(id,"경찰 경정")
        vRP.removeUserGroup(id,"치안정감")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end


-- 청장/특공대장 그룹 권한 (특공대장 삭제)
local function ch_removeswat1(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removeswat1") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "경찰특공대장"
        vRP.removeUserGroup(id,group)
        vRPclient.notify(player,{group.." removed from user "..id})
    --  end)
    end)
  end
end

-- 청장/특공대원 그룹 권한 (특공대장 추가)
local function ch_addswat1(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addswat1") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "경찰특공대장"
        vRP.addUserGroup(id,group)
        vRPclient.notify(player,{group.." added to user "..id})
    --  end)
    end)
  end
end

-- 청장/특공대장 그룹 권한 (특공대원 삭제)
local function ch_removeswat2(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removeswat2") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "경찰특공대원"
        vRP.removeUserGroup(id,group)
        vRPclient.notify(player,{group.." removed from user "..id})
    --  end)
    end)
  end
end

-- 청장/특공대원 그룹 권한 (특공대원 추가)
local function ch_addswat2(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addswat2") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "경찰특공대원"
        vRP.addUserGroup(id,group)
        vRPclient.notify(player,{group.." added to user "..id})
    --  end)
    end)
  end
end


local function ch_addems(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addems") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"시보, 생, 대원, 사, 교, 진, 경, 정, 총, 감, 정감","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "시보" then
            vRP.addUserGroup(id,"의무시보")
          end
          if groupprefix == "생" then
            vRP.addUserGroup(id,"의무생")
          end 
          if groupprefix == "대원" then
            vRP.addUserGroup(id,"의무대원")
          end
          if groupprefix == "사" then
            vRP.addUserGroup(id,"의무사")
          end
          if groupprefix == "교" then
            vRP.addUserGroup(id,"의무교")
          end
          if groupprefix == "진" then
            vRP.addUserGroup(id,"의무진")
          end
          if groupprefix == "경" then
            vRP.addUserGroup(id,"의무경")
          end
          if groupprefix == "정" then
            vRP.addUserGroup(id,"의무정")
          end
          if groupprefix == "총" then
            vRP.addUserGroup(id,"의무총")
          end
          if groupprefix == "감" then
            vRP.addUserGroup(id,"의무감")
          end
          if groupprefix == "정감" then
            vRP.addUserGroup(id,"의무정감")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_removeems(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removeems") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"의무시보")
        vRP.removeUserGroup(id,"의무생")
        vRP.removeUserGroup(id,"의무대원")
        vRP.removeUserGroup(id,"의무사")
        vRP.removeUserGroup(id,"의무교")
        vRP.removeUserGroup(id,"의무진")
        vRP.removeUserGroup(id,"의무경")
        vRP.removeUserGroup(id,"의무정")
        vRP.removeUserGroup(id,"의무총")
        vRP.removeUserGroup(id,"의무감")
        vRP.removeUserGroup(id,"의무정감")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end


-- 총리 그룹 권한 (비서실장 추가)
local function ch_addpre(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addpre") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "총리부 비서실장"
        vRP.addUserGroup(id,group)
        vRPclient.notify(player,{group.." added to user "..id})
    --  end)
    end)
  end
end

-- 총리 그룹 권한 (비서실장 삭제)
local function ch_removepre(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removepre") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "총리부 비서실장"
        vRP.removeUserGroup(id,group)
        vRPclient.notify(player,{group.." removed from user "..id})
    --  end)
    end)
  end
end

local function ch_addpre2(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addpre2") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "총리부 경호원"
        vRP.addUserGroup(id,group)
        vRPclient.notify(player,{group.." added to user "..id})
    --  end)
    end)
  end
end

-- 총리/비서실장 그룹 권한 (경호원 삭제)
local function ch_removepre2(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removepre2") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "총리부 경호원"
        vRP.removeUserGroup(id,group)
        vRPclient.notify(player,{group.." removed from user "..id})
    --  end)
    end)
  end
end


local function ch_addyakuza(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addyakuza") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"부령, 쇼군, 후다이 다이묘, 사무라이, 한슈, 하닌","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "부령" then
            vRP.addUserGroup(id,"시미즈카이 부령")
          end
          if groupprefix == "쇼군" then
            vRP.addUserGroup(id,"시미즈카이 쇼군")
          end 
          if groupprefix == "후다이 다이묘" then
            vRP.addUserGroup(id,"시미즈카이 후다이 다이묘")
          end 
          if groupprefix == "사무라이" then
            vRP.addUserGroup(id,"시미즈카이 사무라이")
          end
          if groupprefix == "한슈" then
            vRP.addUserGroup(id,"시미즈카이 한슈")
          end 
          if groupprefix == "하닌" then
            vRP.addUserGroup(id,"시미즈카이 하닌")
          end 
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_removeyakuza(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removeyakuza") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"시미즈카이 부령")
        vRP.removeUserGroup(id,"시미즈카이 쇼군")
        vRP.removeUserGroup(id,"시미즈카이 후다이 다이묘")
        vRP.removeUserGroup(id,"시미즈카이 사무라이")
        vRP.removeUserGroup(id,"시미즈카이 한슈")
        vRP.removeUserGroup(id,"시미즈카이 하닌")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end


local function ch_addjmp(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addjmp") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"부회장, 이사, 부장, 과장, 대리, 사원, 인턴","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "부회장" then
            vRP.addUserGroup(id,"중문파 부회장")
          end
          if groupprefix == "이사" then
            vRP.addUserGroup(id,"중문파 이사")
          end 
          if groupprefix == "부장" then
            vRP.addUserGroup(id,"중문파 부장")
          end 
          if groupprefix == "과장" then
            vRP.addUserGroup(id,"중문파 과장")
          end
          if groupprefix == "대리" then
            vRP.addUserGroup(id,"중문파 대리")
          end 
          if groupprefix == "사원" then
            vRP.addUserGroup(id,"중문파 사원")
          end
          if groupprefix == "인턴" then
            vRP.addUserGroup(id,"중문파 인턴")
          end 
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_removejmp(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removejmp") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"중문파 부회장")
        vRP.removeUserGroup(id,"중문파 이사")
        vRP.removeUserGroup(id,"중문파 부장")
        vRP.removeUserGroup(id,"중문파 과장")
        vRP.removeUserGroup(id,"중문파 대리")
        vRP.removeUserGroup(id,"중문파 사원")
        vRP.removeUserGroup(id,"중문파 인턴")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end


local function ch_addshh(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addshh") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"성별 (남, 여)","",function(player,gender)
        if gender ~= nil then
        if gender == "남" then
        vRP.prompt(player,"산주, 선봉, 홍곤, 초혜, 백지선, 사구자, 남등롱","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "산주" then
            vRP.addUserGroup(id,"삼합회 산주 (男)")
          end
          if groupprefix == "선봉" then
            vRP.addUserGroup(id,"삼합회 선봉 (男)")
          end 
          if groupprefix == "홍곤" then
            vRP.addUserGroup(id,"삼합회 홍곤 (男)")
          end 
          if groupprefix == "초혜" then
            vRP.addUserGroup(id,"삼합회 초혜 (男)")
          end
          if groupprefix == "백지선" then
            vRP.addUserGroup(id,"삼합회 백지선 (男)")
          end
          if groupprefix == "사구자" then
            vRP.addUserGroup(id,"삼합회 사구자 (男)")
          end 
          if groupprefix == "남등롱" then
            vRP.addUserGroup(id,"삼합회 남등롱 (男)")
          end 
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
      end)
    elseif gender == "여" then
      vRP.prompt(player,"산주, 선봉, 홍곤, 초혜, 백지선, 사구자, 남등롱","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "산주" then
            vRP.addUserGroup(id,"삼합회 산주 (女)")
          end
          if groupprefix == "선봉" then
            vRP.addUserGroup(id,"삼합회 선봉 (女)")
          end 
          if groupprefix == "홍곤" then
            vRP.addUserGroup(id,"삼합회 홍곤 (女)")
          end 
          if groupprefix == "초혜" then
            vRP.addUserGroup(id,"삼합회 초혜 (女)")
          end
          if groupprefix == "백지선" then
            vRP.addUserGroup(id,"삼합회 백지선 (女)")
          end
          if groupprefix == "사구자" then
            vRP.addUserGroup(id,"삼합회 사구자 (女)")
          end 
          if groupprefix == "남등롱" then
            vRP.addUserGroup(id,"삼합회 남등롱 (女)")
          end 
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
      end)
    end
    else
    vRPclient.notify(player,{"~r~성별을 적어주세요."})
    end
      end)
      end
    end)
  end
end

-- 삼합회 그룹 권한 (조직원 삭제)
local function ch_removeshh(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removeshh") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "삼합회 조직원"
        vRP.removeUserGroup(id,group)
        vRPclient.notify(player,{group.." removed from user "..id})
    --  end)
    end)
  end
end


local function ch_addmafia(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addmafia") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"트리플, 더블, 오리지널, 베이비, 틴, 아웃사이더","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "트리플" then
            vRP.addUserGroup(id,"세인트 트리플 O.G")
          end
          if groupprefix == "더블" then
            vRP.addUserGroup(id,"세인트 더블 O.G")
          end 
          if groupprefix == "오리지널" then
            vRP.addUserGroup(id,"세인트 O.G")
          end 
          if groupprefix == "베이비" then
            vRP.addUserGroup(id,"세인트 B.G")
          end
          if groupprefix == "틴" then
            vRP.addUserGroup(id,"세인트 T.G")
          end
          if groupprefix == "아웃사이더" then
            vRP.addUserGroup(id,"세인트 아웃사이더")
          end 
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

-- 마피아 대부 그룹 권한 (조직원 삭제)
local function ch_removemafia(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removemafia") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"세인트 트리플 O.G")
        vRP.removeUserGroup(id,"세인트 더블 O.G")
        vRP.removeUserGroup(id,"세인트 O.G")
        vRP.removeUserGroup(id,"세인트 B.G")
        vRP.removeUserGroup(id,"세인트 T.G")
        vRP.removeUserGroup(id,"세인트 아웃사이더")
        vRPclient.notify(player,{"~b~제거 완료"})
    --  end)
    end)
  end
end


-- 도미노피자 그룹 권한 (직원 추가)
local function ch_adddomino(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.adddomino") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "도미노피자 직원"
        vRP.addUserGroup(id,group)
        vRPclient.notify(player,{group.." added to user "..id})
    --  end)
    end)
  end
end

-- 도미노피자 그룹 권한 (직원 삭제)
local function ch_removedomino(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.removedomino") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        group = "도미노피자 직원"
        vRP.removeUserGroup(id,group)
        vRPclient.notify(player,{group.." removed from user "..id})
    --  end)
    end)
  end
end


local function ch_addakh(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.akh.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"인턴, 사원, 대리, 팀장, 부장, 실장, 부지점장, 지점장","",function(player,groupprefix)
          if groupprefix ~= nil then
            
          if groupprefix == "인턴" then
            vRP.addUserGroup(id,"아스카은행 인턴")
          end
          if groupprefix == "사원" then
            vRP.addUserGroup(id,"아스카은행 사원")
          end 
          if groupprefix == "대리" then
            vRP.addUserGroup(id,"아스카은행 대리")
          end 
          if groupprefix == "팀장" then
            vRP.addUserGroup(id,"아스카은행 팀장")
          end 
          if groupprefix == "부장" then
            vRP.addUserGroup(id,"아스카은행 부장")
          end 
          if groupprefix == "실장" then
            vRP.addUserGroup(id,"아스카은행 실장")
          end 
          if groupprefix == "부지점장" then
            vRP.addUserGroup(id,"아스카은행 부지점장")
          end 
          if groupprefix == "지점장" then
            vRP.addUserGroup(id,"아스카은행 지점장")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delakh(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.akh.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"아스카은행 인턴")
        vRP.removeUserGroup(id,"아스카은행 사원")
        vRP.removeUserGroup(id,"아스카은행 대리")
        vRP.removeUserGroup(id,"아스카은행 팀장")
        vRP.removeUserGroup(id,"아스카은행 부장")
        vRP.removeUserGroup(id,"아스카은행 실장")
        vRP.removeUserGroup(id,"아스카은행 부지점장")
        vRP.removeUserGroup(id,"아스카은행 지점장")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end


local function ch_addmzh(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.mzh.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"버스기사, 정비사, 보안부, 인턴, 사원, 대리, 과장, 차장, 부장, 이사, 상무, 전무","",function(player,groupprefix)
          if groupprefix ~= nil then
            if groupprefix == "버스기사" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 버스기사")
          end
          if groupprefix == "정비사" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 정비사")
          end
          if groupprefix == "보안부" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 보안부")
          end
          if groupprefix == "인턴" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 인턴")
          end
          if groupprefix == "사원" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 사원")
          end 
          if groupprefix == "대리" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 대리")
          end 
          if groupprefix == "과장" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 과장")
          end 
          if groupprefix == "차장" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 차장")
          end 
          if groupprefix == "부장" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 부장")
          end 
          if groupprefix == "이사" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 이사")
          end 
          if groupprefix == "상무" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 상무")
          end 
          if groupprefix == "전무" then
            vRP.addUserGroup(id,"(주)메이즈홀딩스 전무")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delmzh(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.mzh.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 보안부")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 버스기사")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 정비사")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 인턴")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 사원")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 대리")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 과장")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 차장")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 부장")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 이사")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 상무")
        vRP.removeUserGroup(id,"(주)메이즈홀딩스 전무")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end

local function ch_addaprs(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addaprs") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"고등검사장, 지방검사장, 차장검사, 사무국장, 부장검사, 검사","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "고등검사장" then
            vRP.addUserGroup(id,"고등검사장")
          end
          if groupprefix == "지방검사장" then
            vRP.addUserGroup(id,"지방검사장")
          end 
          if groupprefix == "차장검사" then
            vRP.addUserGroup(id,"대검찰청 차장검사")
          end 
          if groupprefix == "사무국장" then
            vRP.addUserGroup(id,"대검찰청 사무국장")
          end 
          if groupprefix == "부장검사" then
            vRP.addUserGroup(id,"대검찰청 부장검사")
          end
          if groupprefix == "검사" then
            vRP.addUserGroup(id,"대검찰청 검사")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delaprs(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.delaprs") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"고등검사장")
        vRP.removeUserGroup(id,"지방검사장")
        vRP.removeUserGroup(id,"대검찰청 차장검사")
        vRP.removeUserGroup(id,"대검찰청 사무국장")
        vRP.removeUserGroup(id,"대검찰청 부장검사")
        vRP.removeUserGroup(id,"대검찰청 검사")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end

local function ch_addbprs(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addbprs") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"차장검사, 부장검사, 검사","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "차장검사" then
            vRP.addUserGroup(id,"고등검찰청 차장검사")
          end 
          if groupprefix == "부장검사" then
            vRP.addUserGroup(id,"고등검찰청 부장검사")
          end
          if groupprefix == "검사" then
            vRP.addUserGroup(id,"고등검찰청 검사")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delbprs(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.delbprs") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"고등검찰청 차장검사")
        vRP.removeUserGroup(id,"고등검찰청 부장검사")
        vRP.removeUserGroup(id,"고등검찰청 검사")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end

local function ch_addcprs(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addcprs") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"차장검사, 부장검사, 검사","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "차장검사" then
            vRP.addUserGroup(id,"지방검찰청 차장검사")
          end 
          if groupprefix == "부장검사" then
            vRP.addUserGroup(id,"지방검찰청 부장검사")
          end
          if groupprefix == "검사" then
            vRP.addUserGroup(id,"지방검찰청 검사")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delcprs(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.delcprs") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"지방검찰청 차장검사")
        vRP.removeUserGroup(id,"지방검찰청 부장검사")
        vRP.removeUserGroup(id,"지방검찰청 검사")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end

local function ch_addacourt(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addacourt") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"고등법원장, 지방법원장, 대법관","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "고등법원장" then
            vRP.addUserGroup(id,"고등법원장")
          end 
          if groupprefix == "지방법원장" then
            vRP.addUserGroup(id,"지방법원장")
          end
          if groupprefix == "대법관" then
            vRP.addUserGroup(id,"대법관")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delacourt(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.delacourt") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"고등법원장")
        vRP.removeUserGroup(id,"지방법원장")
        vRP.removeUserGroup(id,"대법관")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end

local function ch_addbcourt(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addbcourt") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"부장판사, 판사","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "부장판사" then
            vRP.addUserGroup(id,"고등법원 부장판사")
          end 
          if groupprefix == "판사" then
            vRP.addUserGroup(id,"고등법원 판사")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delbcourt(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.delbcourt") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"고등법원 부장판사")
        vRP.removeUserGroup(id,"고등법원 판사")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end

local function ch_addccourt(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.addccourt") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"부장판사, 판사","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "부장판사" then
            vRP.addUserGroup(id,"지방법원 부장판사")
          end 
          if groupprefix == "판사" then
            vRP.addUserGroup(id,"지방법원 판사")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delccourt(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.group.delccourt") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"지방법원 부장판사")
        vRP.removeUserGroup(id,"지방법원 판사")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end

local function ch_addarmy(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.army.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"임명할 계급을 적어주세요. (예: 소장, 대위, 상사, 이병)","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "소장" then
            vRP.addUserGroup(id,"수도방위사령부 소장")
          end
          if groupprefix == "준장" then
            vRP.addUserGroup(id,"수도방위사령부 준장")
          end 
          if groupprefix == "대령" then
            vRP.addUserGroup(id,"수도방위사령부 대령")
          end 
          if groupprefix == "중령" then
            vRP.addUserGroup(id,"수도방위사령부 중령")
          end 
          if groupprefix == "소령" then
            vRP.addUserGroup(id,"수도방위사령부 소령")
          end 
          if groupprefix == "대위" then
            vRP.addUserGroup(id,"수도방위사령부 대위")
          end 
          if groupprefix == "중위" then
            vRP.addUserGroup(id,"수도방위사령부 중위")
          end 
          if groupprefix == "소위" then
            vRP.addUserGroup(id,"수도방위사령부 소위")
          end 
          if groupprefix == "준위" then
            vRP.addUserGroup(id,"수도방위사령부 준위")
          end
          if groupprefix == "원사" then
            vRP.addUserGroup(id,"수도방위사령부 원사")
          end
          if groupprefix == "상사" then
            vRP.addUserGroup(id,"수도방위사령부 상사")
          end
          if groupprefix == "중사" then
            vRP.addUserGroup(id,"수도방위사령부 중사")
          end
          if groupprefix == "하사" then
            vRP.addUserGroup(id,"수도방위사령부 하사")
          end
          if groupprefix == "병장" then
            vRP.addUserGroup(id,"수도방위사령부 병장")
          end
          if groupprefix == "상병" then
            vRP.addUserGroup(id,"수도방위사령부 상병")
          end
          if groupprefix == "일병" then
            vRP.addUserGroup(id,"수도방위사령부 일병")
          end
          if groupprefix == "이병" then
            vRP.addUserGroup(id,"수도방위사령부 이병")
          end
          if groupprefix == "훈련병" then
            vRP.addUserGroup(id,"수도방위사령부 훈련병")
          end
          else
          vRPclient.notify(player,{"~r~정확한 계급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delarmy(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.army.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"수도방위사령부 소장")
        vRP.removeUserGroup(id,"수도방위사령부 준장")
        vRP.removeUserGroup(id,"수도방위사령부 대령")
        vRP.removeUserGroup(id,"수도방위사령부 중령")
        vRP.removeUserGroup(id,"수도방위사령부 소령")
        vRP.removeUserGroup(id,"수도방위사령부 대위")
        vRP.removeUserGroup(id,"수도방위사령부 중위")
        vRP.removeUserGroup(id,"수도방위사령부 소위")
        vRP.removeUserGroup(id,"수도방위사령부 준위")
        vRP.removeUserGroup(id,"수도방위사령부 상사")
        vRP.removeUserGroup(id,"수도방위사령부 중사")
        vRP.removeUserGroup(id,"수도방위사령부 하사")
        vRP.removeUserGroup(id,"수도방위사령부 원사")
        vRP.removeUserGroup(id,"수도방위사령부 병장")
        vRP.removeUserGroup(id,"수도방위사령부 상병")
        vRP.removeUserGroup(id,"수도방위사령부 일병")
        vRP.removeUserGroup(id,"수도방위사령부 이병")
        vRP.removeUserGroup(id,"수도방위사령부 훈련병")
        vRPclient.notify(player,{"~b~해임 완료"})
    --  end)
    end)
  end
end

local function ch_addemm(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.emm.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"인턴, 대리, 과장, 차장, 부장, 이사, 실장, 매니저, 부대표","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "인턴" then
            vRP.addUserGroup(id,"엘리시움매매단지 인턴")
          end
          if groupprefix == "대리" then
            vRP.addUserGroup(id,"엘리시움매매단지 대리")
          end
          if groupprefix == "과장" then
            vRP.addUserGroup(id,"엘리시움매매단지 과장")
          end 
          if groupprefix == "차장" then
            vRP.addUserGroup(id,"엘리시움매매단지 차장")
          end 
          if groupprefix == "부장" then
            vRP.addUserGroup(id,"엘리시움매매단지 부장")
          end 
          if groupprefix == "실장" then
            vRP.addUserGroup(id,"엘리시움매매단지 실장")
          end
          if groupprefix == "매니저" then
            vRP.addUserGroup(id,"엘리시움매매단지 매니저")
          end
          if groupprefix == "부대표" then
            vRP.addUserGroup(id,"엘리시움매매단지 부대표")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delemm(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.emm.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"엘리시움매매단지 인턴")
        vRP.removeUserGroup(id,"엘리시움매매단지 대리")
        vRP.removeUserGroup(id,"엘리시움매매단지 과장")
        vRP.removeUserGroup(id,"엘리시움매매단지 차장")
        vRP.removeUserGroup(id,"엘리시움매매단지 부장")
        vRP.removeUserGroup(id,"엘리시움매매단지 실장")
        vRP.removeUserGroup(id,"엘리시움매매단지 매니저")
        vRP.removeUserGroup(id,"엘리시움매매단지 부대표")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end

local function ch_addhousebeer(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.housebeer.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"직원, 매니저, 점장, 실장, 사장, 부대표","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "직원" then
            vRP.addUserGroup(id,"오늘우리집Beer 직원")
          end
          if groupprefix == "매니저" then
            vRP.addUserGroup(id,"오늘우리집Beer 매니저")
          end 
          if groupprefix == "점장" then
            vRP.addUserGroup(id,"오늘우리집Beer 점장")
          end 
          if groupprefix == "실장" then
            vRP.addUserGroup(id,"오늘우리집Beer 실장")
          end 
          if groupprefix == "사장" then
            vRP.addUserGroup(id,"오늘우리집Beer 사장")
          end
          if groupprefix == "부대표" then
            vRP.addUserGroup(id,"오늘우리집Beer 부대표")
          end 
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delhousebeer(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.housebeer.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"오늘우리집Beer 직원")
        vRP.removeUserGroup(id,"오늘우리집Beer 매니저")
        vRP.removeUserGroup(id,"오늘우리집Beer 점장")
        vRP.removeUserGroup(id,"오늘우리집Beer 실장")
        vRP.removeUserGroup(id,"오늘우리집Beer 사장")
        vRP.removeUserGroup(id,"오늘우리집Beer 부대표")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end




local function ch_addesp(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.esp.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"인턴, 매니저, 이사","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "인턴" then
            vRP.addUserGroup(id,"엘리시움스포츠파트너쉽 인턴")
          end
          if groupprefix == "매니저" then
            vRP.addUserGroup(id,"엘리시움스포츠파트너쉽 매니저")
          end
          if groupprefix == "이사" then
            vRP.addUserGroup(id,"엘리시움스포츠파트너쉽 이사")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delesp(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.esp.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"엘리시움스포츠파트너쉽 이사")
        vRP.removeUserGroup(id,"엘리시움스포츠파트너쉽 매니저")
        vRP.removeUserGroup(id,"엘리시움스포츠파트너쉽 인턴")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end



local function ch_addtaxi(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.taxi.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"인턴, 사원, 대리, 부장, 이사","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "인턴" then
            vRP.addUserGroup(id,"택시조합 인턴")
          end
          if groupprefix == "사원" then
            vRP.addUserGroup(id,"택시조합 사원")
          end
          if groupprefix == "대리" then
            vRP.addUserGroup(id,"택시조합 대리")
          end
          if groupprefix == "부장" then
            vRP.addUserGroup(id,"택시조합 부장")
          end 
          if groupprefix == "이사" then
            vRP.addUserGroup(id,"택시조합 이사")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_deltaxi(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.taxi.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"택시조합 인턴")
        vRP.removeUserGroup(id,"택시조합 사원")
        vRP.removeUserGroup(id,"택시조합 대리")
        vRP.removeUserGroup(id,"택시조합 부장")
        vRP.removeUserGroup(id,"택시조합 이사")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end

local function ch_addia(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.ia.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"부대표, 사무장, 비서, 변호팀장, 변호사, 신입변호사","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "비서" then
            vRP.addUserGroup(id,"IA로펌 비서")
          end
          if groupprefix == "변호사" then
            vRP.addUserGroup(id,"IA로펌 변호사")
          end 
          if groupprefix == "사무장" then
            vRP.addUserGroup(id,"IA로펌 사무장")
          end
          if groupprefix == "부대표" then
            vRP.addUserGroup(id,"IA로펌 부대표")
          end
          if groupprefix == "변호팀장" then
            vRP.addUserGroup(id,"IA로펌 변호팀장")
          end 
          if groupprefix == "신입변호사" then
            vRP.addUserGroup(id,"IA로펌 신입변호사")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delia(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.ia.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"IA로펌 비서")
        vRP.removeUserGroup(id,"IA로펌 변호사")
        vRP.removeUserGroup(id,"IA로펌 신입변호사")
        vRP.removeUserGroup(id,"IA로펌 변호팀장")
        vRP.removeUserGroup(id,"IA로펌 부대표")
        vRP.removeUserGroup(id,"IA로펌 사무장")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end

local function ch_addpalace(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.palace.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"서버, 가드, 가드매니저, 매니저, DJ","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "서버" then
            vRP.addUserGroup(id,"페가수스클럽 서버")
          end
          if groupprefix == "가드" then
            vRP.addUserGroup(id,"페가수스클럽 가드")
          end 
          if groupprefix == "가드매니저" then
            vRP.addUserGroup(id,"페가수스클럽 가드매니저")
          end
          if groupprefix == "매니저" then
            vRP.addUserGroup(id,"페가수스클럽 매니저")
          end
          if groupprefix == "DJ" then
            vRP.addUserGroup(id,"페가수스클럽 DJ")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delpalace(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.palace.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"페가수스클럽 서버")
        vRP.removeUserGroup(id,"페가수스클럽 가드")
        vRP.removeUserGroup(id,"페가수스클럽 가드매니저")
        vRP.removeUserGroup(id,"페가수스클럽 매니저")
        vRP.removeUserGroup(id,"페가수스클럽 DJ")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end

local function ch_addkhg(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.khg.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"사원, 주임, 대리, 과장, 차장, 부장, 본부장, 대표, 상무, 사장","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "사원" then
            vRP.addUserGroup(id,"금호그룹 사원")
          end
          if groupprefix == "주임" then
            vRP.addUserGroup(id,"금호그룹 주임")
          end
          if groupprefix == "대리" then
            vRP.addUserGroup(id,"금호그룹 대리")
          end 
          if groupprefix == "과장" then
            vRP.addUserGroup(id,"금호그룹 과장")
          end
          if groupprefix == "차장" then
            vRP.addUserGroup(id,"금호그룹 차장")
          end
          if groupprefix == "부장" then
            vRP.addUserGroup(id,"금호그룹 부장")
          end
          if groupprefix == "본부장" then
            vRP.addUserGroup(id,"금호그룹 본부장")
          end
          if groupprefix == "대표" then
            vRP.addUserGroup(id,"금호그룹 대표")
          end
          if groupprefix == "상무" then
            vRP.addUserGroup(id,"금호그룹 상무")
          end
          if groupprefix == "사장" then
            vRP.addUserGroup(id,"금호그룹 사장")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delkhg(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.khg.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"금호그룹 사원")
        vRP.removeUserGroup(id,"금호그룹 주임")
        vRP.removeUserGroup(id,"금호그룹 대리")
        vRP.removeUserGroup(id,"금호그룹 과장")
        vRP.removeUserGroup(id,"금호그룹 차장")
        vRP.removeUserGroup(id,"금호그룹 부장")
        vRP.removeUserGroup(id,"금호그룹 본부장")
        vRP.removeUserGroup(id,"금호그룹 대표")
        vRP.removeUserGroup(id,"금호그룹 상무")
        vRP.removeUserGroup(id,"금호그룹 사장")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end

local function ch_addkhe(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.khg.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"사원, 주임, 대리, 과장, 차장, 부장, 전무","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "사원" then
            vRP.addUserGroup(id,"금호고속 사원")
          end
          if groupprefix == "주임" then
            vRP.addUserGroup(id,"금호고속 주임")
          end
          if groupprefix == "대리" then
            vRP.addUserGroup(id,"금호고속 대리")
          end 
          if groupprefix == "과장" then
            vRP.addUserGroup(id,"금호고속 과장")
          end
          if groupprefix == "차장" then
            vRP.addUserGroup(id,"금호고속 차장")
          end
          if groupprefix == "부장" then
            vRP.addUserGroup(id,"금호고속 부장")
          end
          if groupprefix == "전무" then
            vRP.addUserGroup(id,"금호고속 본부장")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delkhe(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.khg.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"금호고속 사원")
        vRP.removeUserGroup(id,"금호고속 주임")
        vRP.removeUserGroup(id,"금호고속 대리")
        vRP.removeUserGroup(id,"금호고속 과장")
        vRP.removeUserGroup(id,"금호고속 차장")
        vRP.removeUserGroup(id,"금호고속 부장")
        vRP.removeUserGroup(id,"금호고속 전무")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end


local function ch_addcasino(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.casino.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"인턴, 사원, 대리, 과장, 팀장, 실장, 본부장, 상무, 전무","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "인턴" then
            vRP.addUserGroup(id,"CASINO 인턴")
          end        
          if groupprefix == "사원" then
            vRP.addUserGroup(id,"CASINO 사원")
          end
          if groupprefix == "대리" then
            vRP.addUserGroup(id,"CASINO 대리")
          end
          if groupprefix == "과장" then
            vRP.addUserGroup(id,"CASINO 과장")
          end 
          if groupprefix == "팀장" then
            vRP.addUserGroup(id,"CASINO 팀장")
          end
          if groupprefix == "실장" then
            vRP.addUserGroup(id,"CASINO 실장")
          end
          if groupprefix == "본부장" then
            vRP.addUserGroup(id,"CASINO 본부장")
          end
          if groupprefix == "상무" then
            vRP.addUserGroup(id,"CASINO 상무")
          end
          if groupprefix == "전무" then
            vRP.addUserGroup(id,"CASINO 전무")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delcasino(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.casino.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"CASINO 인턴")
        vRP.removeUserGroup(id,"CASINO 사원")
        vRP.removeUserGroup(id,"CASINO 대리")
        vRP.removeUserGroup(id,"CASINO 과장")
        vRP.removeUserGroup(id,"CASINO 팀장")
        vRP.removeUserGroup(id,"CASINO 실장")
        vRP.removeUserGroup(id,"CASINO 본부장")
        vRP.removeUserGroup(id,"CASINO 상무")
        vRP.removeUserGroup(id,"CASINO 전무")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end

local function ch_addcbs(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.cbs.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(player,"앵커 인턴, 앵커, 기자 인턴, 기자, 행정부 인턴, 행정부, 행정부 과장, 차장, 부장","",function(player,groupprefix)
          if groupprefix ~= nil then
          if groupprefix == "앵커 인턴" then
            vRP.addUserGroup(id,"엘리시움문화방송 앵커 인턴")
          end        
          if groupprefix == "앵커" then
            vRP.addUserGroup(id,"엘리시움문화방송 앵커")
          end
          if groupprefix == "기자 인턴" then
            vRP.addUserGroup(id,"엘리시움문화방송 기자 인턴")
          end
          if groupprefix == "기자" then
            vRP.addUserGroup(id,"엘리시움문화방송 기자")
          end 
          if groupprefix == "행정부 인턴" then
            vRP.addUserGroup(id,"엘리시움문화방송 행정부 인턴")
          end
          if groupprefix == "행정부" then
            vRP.addUserGroup(id,"엘리시움문화방송 행정부")
          end
          if groupprefix == "행정부 과장" then
            vRP.addUserGroup(id,"엘리시움문화방송 행정부 과장")
          end
          if groupprefix == "차장" then
            vRP.addUserGroup(id,"엘리시움문화방송 차장")
          end
          if groupprefix == "부장" then
            vRP.addUserGroup(id,"엘리시움문화방송 부장")
          end
          else
          vRPclient.notify(player,{"~r~정확한 직급을 적어주세요."})
        end
        end)
      end
    end)
  end
end

local function ch_delcbs(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"elysium.company.cbs.executive") then
    vRP.prompt(player,"고유 번호 : ","",function(player,id)
      id = parseInt(id)
   --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id,"엘리시움문화방송 앵커 인턴")
        vRP.removeUserGroup(id,"엘리시움문화방송 앵커")
        vRP.removeUserGroup(id,"엘리시움문화방송 기자 인턴")
        vRP.removeUserGroup(id,"엘리시움문화방송 기자")
        vRP.removeUserGroup(id,"엘리시움문화방송 행정부 인턴")
        vRP.removeUserGroup(id,"엘리시움문화방송 행정부")
        vRP.removeUserGroup(id,"엘리시움문화방송 행정부 과장")
        vRP.removeUserGroup(id,"엘리시움문화방송 차장")
        vRP.removeUserGroup(id,"엘리시움문화방송 부장")
        vRPclient.notify(player,{"~b~해고 완료"})
    --  end)
    end)
  end
end


local function ch_kick(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.kick") then
    vRP.prompt(player,"강퇴 대상 고유번호: ","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"사유: ","",function(player,reason)
        local source = vRP.getUserSource(id)
        if source ~= nil then
          vRP.kick(source,reason)
          vRPclient.notify(player,{"강제퇴장 완료 "..id})
        end
      end)
    end)
  end
end

local function ch_ickick(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.kick") then
    vRP.prompt(player,"초성 사용 강퇴 대상 고유번호: ","",function(player,id)
      id = parseInt(id)
        local source = vRP.getUserSource(id)
        if source ~= nil then
          vRP.kick(source,"IC 내 초성 사용")
          vRPclient.notify(player,{"강제퇴장 완료"..id})
        end
    end)
  end
end


local function ch_ban(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.ban") then
    vRP.prompt(player,"차단 대상 고유번호: ","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"사유: ","",function(player,reason)
        local source = vRP.getUserSource(id)
        if source ~= nil then
          vRP.ban(source,reason)
          vRPclient.notify(player,{"차단 완료 "..id})
        end
      end)
    end)
  end
end

local function ch_unban(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.unban") then
    vRP.prompt(player,"차단 해제 대상 고유번호: ","",function(player,id)
      id = parseInt(id)
      vRP.setBanned(id,false)
      vRPclient.notify(player,{"차단 해제 완료 "..id})
    end)
  end
end

local function ch_emote(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.custom_emote") then
    vRP.prompt(player,"Animation sequence ('dict anim optional_loops' per line): ","",function(player,content)
      local seq = {}
      for line in string.gmatch(content,"[^\n]+") do
        local args = {}
        for arg in string.gmatch(line,"[^%s]+") do
          table.insert(args,arg)
        end

        table.insert(seq,{args[1] or "", args[2] or "", args[3] or 1})
      end

      vRPclient.playAnim(player,{true,seq,false})
    end)
  end
end

local function ch_sound(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.custom_sound") then
    vRP.prompt(player,"Sound 'dict name': ","",function(player,content)
      local args = {}
      for arg in string.gmatch(content,"[^%s]+") do
        table.insert(args,arg)
      end
      vRPclient.playSound(player,{args[1] or "", args[2] or ""})
    end)
  end
end

local function ch_coords(player,choice)
  vRPclient.getPosition(player,{},function(x,y,z)
    vRP.prompt(player,"Copy the coordinates using Ctrl-A Ctrl-C",x..","..y..","..z,function(player,choice) end)
  end)
end

local function ch_tptome(player,choice)
  vRPclient.getPosition(player,{},function(x,y,z)
    vRP.prompt(player,"User id:","",function(player,user_id) 
      local tplayer = vRP.getUserSource(tonumber(user_id))
      if tplayer ~= nil then
        vRPclient.teleport(tplayer,{x,y,z})
      end
    end)
  end)
end

local function ch_tpto(player,choice)
  vRP.prompt(player,"User id:","",function(player,user_id) 
    local tplayer = vRP.getUserSource(tonumber(user_id))
    if tplayer ~= nil then
      vRPclient.getPosition(tplayer,{},function(x,y,z)
        vRPclient.teleport(player,{x,y,z})
      end)
    end
  end)
end

local function ch_tptocoords(player,choice)
  vRP.prompt(player,"Coords x,y,z:","",function(player,fcoords) 
    local coords = {}
    for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
      table.insert(coords,tonumber(coord))
    end

    local x,y,z = 0,0,0
    if coords[1] ~= nil then x = coords[1] end
    if coords[2] ~= nil then y = coords[2] end
    if coords[3] ~= nil then z = coords[3] end

    vRPclient.teleport(player,{x,y,z})
  end)
end

local function ch_givemoney(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"금액:","",function(player,amount) 
      amount = parseInt(amount)
      vRP.giveMoney(user_id, amount)
      local name = GetPlayerName(player)
      vRP.elysiumlog("moneylog.txt",user_id .. " | " .. name .. "이(가) "..amount.."$를 생성함.")
    end)
  end
end

local function ch_givecredit(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"대상 고유번호: ","",function(player,id)
      id = parseInt(id)
    vRP.prompt(player,"값: ","",function(player,amount) 
      amount = parseInt(amount)
      vRP.giveCredit(id, amount)
      local name = GetPlayerName(player)
      vRP.elysiumlog("moneylog.txt",user_id .. " | " .. name .. "이(가) "..amount.."크레딧을 생성함.")
    end)
    end)
  end
end

local function ch_setloan(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"대상 고유번호: ","",function(player,id)
      id = parseInt(id)
    vRP.prompt(player,"값: ","",function(player,amount) 
      amount = parseInt(amount)
      vRP.setLoan(id, tonumber(amount))
    end)
    end)
  end
end

local function ch_setcr(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"대상 고유번호: ","",function(player,id)
      id = parseInt(id)
    vRP.prompt(player,"값: ","",function(player,amount) 
      --amount = parseInt(amount)
      vRP.setCR(id, tonumber(amount))
    end)
    end)
  end
end

local function ch_hottime(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"대상 고유번호: ","",function(player,id)
    id = parseInt(id)
    amount = parseInt(300000)
    --vRP.giveBankMoney(id, amount)
    vRPclient.notify(id,{"핵 쓰지 마세요 ^^"})
    end)
end
end

local function ch_givebank(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"대상 고유번호: ","",function(player,id)
      id = parseInt(id)
    vRP.prompt(player,"값: ","",function(player,amount) 
      amount = parseInt(amount)
    vRP.giveBankMoney(id, amount)
    end)
  end)
end
end

local function ch_giveitem(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"Id name:","",function(player,idname) 
      idname = idname or ""
      vRP.prompt(player,"Amount:","",function(player,amount) 
        amount = parseInt(amount)
        vRP.giveInventoryItem(user_id, idname, amount,true)
      end)
    end)
  end
end

local function ch_calladmin(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"어떤 문제가 있나요? :","",function(player,desc) 
      desc = desc or ""
      if desc ~= nil and desc ~= "" then
          local answered = false
          local players = {}
          for k,v in pairs(vRP.rusers) do
          local player = vRP.getUserSource(tonumber(k))
          -- check user
          if vRP.hasPermission(k,"admin.tickets") and player ~= nil then
          table.insert(players,player)
          end
          end
      -- send notify and alert to all listening players
      for k,v in pairs(players) do
        vRP.request(v,"도우미 호출 (고유번호 "..user_id..") 수락하시겠습니까?: "..htmlEntities.encode(desc), 120, function(v,ok)
          if ok then -- take the call
            if not answered then
              -- answer the call
              vRPclient.notify(player,{"뉴비도우미가 호출을 받았습니다."})
              vRPclient.getPosition(player, {}, function(x,y,z)
              vRPclient.teleport(v,{x,y,z})
              end)
              answered = true
            else
              vRPclient.notify(v,{"이미 완료된 호출입니다."})
            end
          end
        end)
      end
    else
      vRPclient.notify(player,{"~r~호출 사유를 작성해주세요!"})
      end
    end)
  end
end

local player_customs = {}

local function ch_display_custom(player, choice)
  vRPclient.getCustomization(player,{},function(custom)
    if player_customs[player] then -- hide
      player_customs[player] = nil
      vRPclient.removeDiv(player,{"customization"})
    else -- show
      local content = ""
      for k,v in pairs(custom) do
        content = content..k.." => "..json.encode(v).."<br />" 
      end

      player_customs[player] = true
      vRPclient.setDiv(player,{"customization",".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ", content})
    end
  end)
end

local function ch_noclip(player, choice)
  vRPclient.toggleNoclip(player, {})
end

-- Hotkey Open Admin Menu 1/2
function vRP.openAdminMenu(source)
  vRP.buildMenu("admin", {player = source}, function(menudata)
    menudata.name = "Admin"
    menudata.css = {top="75px",header_color="rgba(0,125,255,0.75)"}
    vRP.openMenu(source,menudata)
  end)
end

-- Hotkey Open Admin Menu 2/2
function tvRP.openAdminMenu()
  vRP.openAdminMenu(source)
end

vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}

    -- build admin menu
    choices["*관리"] = {function(player,choice)
      vRP.buildMenu("admin", {player = player}, function(menu)
        menu.name = "관리"
        menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
        menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu

        if vRP.hasPermission(user_id,"player.list") then
          menu["User list"] = {ch_list,"Show/hide user list."}
        end
        if vRP.hasPermission(user_id,"player.whitelist") then
          menu["Whitelist user"] = {ch_whitelist}
        end
        if vRP.hasPermission(user_id,"player.group.add") then
          menu["*그룹 (칭호) 추가"] = {ch_addgroup}
        end
        if vRP.hasPermission(user_id,"player.group.remove") then
          menu["*그룹 (칭호) 제거"] = {ch_removegroup}
        end
        if vRP.hasPermission(user_id,"player.group.addcop") then
          menu["경찰 임명"] = {ch_addcop}
        end
        if vRP.hasPermission(user_id,"player.group.removecop") then
          menu["경찰 해임"] = {ch_removecop}
        end
        if vRP.hasPermission(user_id,"player.group.addswat1") then
          menu["경찰특공대장 임명"] = {ch_addswat1}
        end
        if vRP.hasPermission(user_id,"player.group.removeswat1") then
          menu["경찰특공대장 해임"] = {ch_removeswat1}
        end
        if vRP.hasPermission(user_id,"player.group.addswat2") then
          menu["경찰특공대원 임명"] = {ch_addswat2}
        end
        if vRP.hasPermission(user_id,"player.group.removeswat2") then
          menu["경찰특공대원 해임"] = {ch_removeswat2}
        end
        if vRP.hasPermission(user_id,"player.group.addems") then
          menu["의료국 임명"] = {ch_addems}
        end
        if vRP.hasPermission(user_id,"player.group.removeems") then
          menu["의료국 해임"] = {ch_removeems}
        end        
        if vRP.hasPermission(user_id,"player.group.addpre") then
          menu["총리부 임명 (비서실장)"] = {ch_addpre}
        end
        if vRP.hasPermission(user_id,"player.group.removepre") then
          menu["총리부 해임 (비서실장)"] = {ch_removepre}
        end
        if vRP.hasPermission(user_id,"player.group.addpre2") then
          menu["총리부 임명 (경호원)"] = {ch_addpre2}
        end
        if vRP.hasPermission(user_id,"player.group.removepre2") then
          menu["총리부 해임 (경호원)"] = {ch_removepre2}
        end
        if vRP.hasPermission(user_id,"player.group.addmafia") then
          menu["마피아 조직원 추가"] = {ch_addmafia}
        end
        if vRP.hasPermission(user_id,"player.group.removemafia") then
          menu["마피아 조직원 해고"] = {ch_removemafia}
        end
        if vRP.hasPermission(user_id,"player.group.addjmp") then
          menu["중문파 추가"] = {ch_addjmp}
        end
        if vRP.hasPermission(user_id,"player.group.removejmp") then
          menu["중문파 해고"] = {ch_removejmp}
        end
        if vRP.hasPermission(user_id,"player.group.addshh") then
          menu["삼합회 조직원 추가"] = {ch_addshh}
        end
        if vRP.hasPermission(user_id,"player.group.removeshh") then
          menu["삼합회 조직원 해고"] = {ch_removeshh}
        end
        if vRP.hasPermission(user_id,"player.group.addyakuza") then
          menu["시미즈카이 추가"] = {ch_addyakuza}
        end
        if vRP.hasPermission(user_id,"player.group.removeyakuza") then
          menu["시미즈카이 해고"] = {ch_removeyakuza}
        end
        if vRP.hasPermission(user_id,"player.group.adddomino") then
          menu["도미노피자 직원 추가"] = {ch_adddomino}
        end
        if vRP.hasPermission(user_id,"player.group.removedomino") then
          menu["도미노피자 직원 해고"] = {ch_removedomino}
        end
        if vRP.hasPermission(user_id,"elysium.army.executive") then
          menu["수도방위사령부 임명"] = {ch_addarmy}
        end
        if vRP.hasPermission(user_id,"elysium.army.executive") then
          menu["수도방위사령부 해임"] = {ch_delarmy}
        end
        if vRP.hasPermission(user_id,"elysium.company.mzh.executive") then
          menu["(주)메이즈홀딩스 고용"] = {ch_addmzh}
        end
        if vRP.hasPermission(user_id,"elysium.company.mzh.executive") then
          menu["(주)메이즈홀딩스 해고"] = {ch_delmzh}
        end
        if vRP.hasPermission(user_id,"elysium.company.akh.executive") then
          menu["아스카은행 고용"] = {ch_addakh}
        end
        if vRP.hasPermission(user_id,"elysium.company.akh.executive") then
          menu["아스카은행 해고"] = {ch_delakh}
        end
        if vRP.hasPermission(user_id,"elysium.company.emm.executive") then
          menu["엘리시움매매단지 고용"] = {ch_addemm}
        end
        if vRP.hasPermission(user_id,"elysium.company.emm.executive") then
          menu["엘리시움매매단지 해고"] = {ch_delemm}
        end
        
        -- 담당자 : 쿠쿠, 말린고기
        
        if vRP.hasPermission(user_id,"elysium.company.esp.executive") then
          menu["엘리시움스포츠파트너쉽 고용"] = {ch_addesp}
        end
        if vRP.hasPermission(user_id,"elysium.company.esp.executive") then
          menu["엘리시움스포츠파트너쉽 해고"] = {ch_delesp}
        end
        
        
        if vRP.hasPermission(user_id,"elysium.company.housebeer.executive") then
          menu["오늘우리집Beer 고용"] = {ch_addhousebeer}
        end
        if vRP.hasPermission(user_id,"elysium.company.housebeer.executive") then
          menu["오늘우리집Beer 해고"] = {ch_delhousebeer}
        end
        if vRP.hasPermission(user_id,"elysium.company.taxi.executive") then
          menu["택시조합 고용"] = {ch_addtaxi}
        end
        if vRP.hasPermission(user_id,"elysium.company.taxi.executive") then
          menu["택시조합 해고"] = {ch_deltaxi}
        end
        if vRP.hasPermission(user_id,"elysium.company.ia.executive") then
          menu["IA로펌 고용"] = {ch_addia}
        end
        if vRP.hasPermission(user_id,"elysium.company.ia.executive") then
          menu["IA로펌 해고"] = {ch_delia}
        end
        if vRP.hasPermission(user_id,"elysium.company.palace.executive") then
          menu["페가수스클럽 고용"] = {ch_addpalace}
        end
        if vRP.hasPermission(user_id,"elysium.company.palace.executive") then
          menu["페가수스클럽 해고"] = {ch_delpalace}
        end
        
        
        if vRP.hasPermission(user_id,"elysium.company.khg.executive") then
          menu["금호그룹 고용"] = {ch_addkhg}
        end
        if vRP.hasPermission(user_id,"elysium.company.khg.executive") then
          menu["금호그룹 해고"] = {ch_delkhg}
        end
        if vRP.hasPermission(user_id,"elysium.company.khg.executive") then
          menu["금호고속 고용"] = {ch_addkhe}
        end
        if vRP.hasPermission(user_id,"elysium.company.khg.executive") then
          menu["금호고속 해고"] = {ch_delkhe}
        end
        
        
        
        if vRP.hasPermission(user_id,"elysium.company.casino.executive") then
          menu["카지노 고용"] = {ch_addcasino}
        end
        if vRP.hasPermission(user_id,"elysium.company.casino.executive") then
          menu["카지노 해고"] = {ch_delcasino}
        end
        if vRP.hasPermission(user_id,"elysium.company.cbs.executive") then
          menu["엘리시움문화방송 고용"] = {ch_addcbs}
        end
        if vRP.hasPermission(user_id,"elysium.company.cbs.executive") then
          menu["엘리시움문화방송 해고"] = {ch_delcbs}
        end
        if vRP.hasPermission(user_id,"player.group.addaprs") then
          menu["검사 임명"] = {ch_addaprs}
        end
        if vRP.hasPermission(user_id,"player.group.delaprs") then
          menu["검사 해임"] = {ch_delaprs}
        end
        if vRP.hasPermission(user_id,"player.group.addbprs") then
          menu["검사 임명"] = {ch_addbprs}
        end
        if vRP.hasPermission(user_id,"player.group.delbprs") then
          menu["검사 해임"] = {ch_delbprs}
        end
        if vRP.hasPermission(user_id,"player.group.addcprs") then
          menu["검사 임명"] = {ch_addcprs}
        end
        if vRP.hasPermission(user_id,"player.group.delcprs") then
          menu["검사 해임"] = {ch_delcprs}
        end
        if vRP.hasPermission(user_id,"player.group.addacourt") then
          menu["판사 임명"] = {ch_addacourt}
        end
        if vRP.hasPermission(user_id,"player.group.delacourt") then
          menu["판사 해임"] = {ch_delacourt}
        end
        if vRP.hasPermission(user_id,"player.group.addbcourt") then
          menu["판사 임명"] = {ch_addbcourt}
        end
        if vRP.hasPermission(user_id,"player.group.debcourt") then
          menu["판사 해임"] = {ch_delbcourt}
        end
        if vRP.hasPermission(user_id,"player.group.addccourt") then
          menu["판사 임명"] = {ch_addccourt}
        end
        if vRP.hasPermission(user_id,"player.group.delccourt") then
          menu["판사 해임"] = {ch_delccourt}
        end
        if vRP.hasPermission(user_id,"player.unwhitelist") then
          menu["화이트리스트"] = {ch_unwhitelist}
        end
        if vRP.hasPermission(user_id,"player.kick") then
          menu["서버에서 추방"] = {ch_kick}
        end
        if vRP.hasPermission(user_id,"player.ickick") then
          menu["서버에서 추방"] = {ch_ickick}
        end
        if vRP.hasPermission(user_id,"player.ban") then
          menu["차단"] = {ch_ban}
        end
        if vRP.hasPermission(user_id,"player.unban") then
          menu["차단 해제"] = {ch_unban}
        end
        if vRP.hasPermission(user_id,"player.noclip") then
          menu["노클립"] = {ch_noclip}
        end
        if vRP.hasPermission(user_id,"player.custom_emote") then
          menu["Custom emote"] = {ch_emote}
        end
        if vRP.hasPermission(user_id,"player.custom_sound") then
          menu["Custom sound"] = {ch_sound}
        end
        if vRP.hasPermission(user_id,"player.coords") then
          menu["좌표 확인"] = {ch_coords}
        end
        if vRP.hasPermission(user_id,"player.tptome") then          menu["플레이어를 소환"] = {ch_tptome}
        end
        if vRP.hasPermission(user_id,"player.tpto") then
          menu["플레이어에게 TP"] = {ch_tpto}
        end
        if vRP.hasPermission(user_id,"player.tpto") then
          menu["좌표로 TP"] = {ch_tptocoords}
        end
        if vRP.hasPermission(user_id,"player.givemoney") then
          menu["*돈 생성"] = {ch_givemoney}
        end
        if vRP.hasPermission(user_id,"player.givecredit") then
          menu["*크레딧 생성"] = {ch_givecredit}
        end
        if vRP.hasPermission(user_id,"elysium.adminloan") then
          menu["**대출 설정"] = {ch_setloan}
        end
        if vRP.hasPermission(user_id,"elysium.adminloan") then
          menu["**신용등급 설정"] = {ch_setcr}
        end
        if vRP.hasPermission(user_id,"player.hottime") then
          menu["*핫타임 지급"] = {ch_hottime}
        end
        if vRP.hasPermission(user_id,"player.givebank") then
          menu["*은행 돈 생성"] = {ch_givebank}
        end
        if vRP.hasPermission(user_id,"player.giveitem") then
          menu["*아이템 생성"] = {ch_giveitem}
        end
        if vRP.hasPermission(user_id,"player.display_custom") then
          menu["Display customization"] = {ch_display_custom}
        end
        if vRP.hasPermission(user_id,"player.calladmin") then
          menu["**도우미 호출"] = {ch_calladmin}
        end

        vRP.openMenu(player,menu)
      end)
    end}

    add(choices)
	end
end)


-- admin god mode
-- function task_god()
  -- SetTimeout(10000, task_god)

  -- for k,v in pairs(vRP.getUsersByPermission("admin.god")) do
    -- vRP.setHunger(v, 0)
    -- vRP.setThirst(v, 0)

    -- local player = vRP.getUserSource(v)
    -- if player ~= nil then
      -- vRPclient.setHealth(player, {200})
    -- end
  -- end
-- end

-- task_god()

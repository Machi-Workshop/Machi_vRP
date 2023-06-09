local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")
vRPhk = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_hotkeys")
HKclient = Tunnel.getInterface("vrp_hotkeys","vrp_hotkeys")
Tunnel.bindInterface("vrp_hotkeys",vRPhk)
-- USE FOR NECESSARY SERVER FUNCTIONS

function vRPhk.toggleHandcuff()
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    if vRP.hasPermission({user_id,"police.pc"}) then
		vRPclient.getNearestPlayer(player,{2},function(nplayer)
			if nplayer ~= nil then
				vRPclient.toggleHandcuff(nplayer)
				vRPclient.Handcuffer(player)
			else
				vRPclient.notify(player,{"~r~근처에 플레이어가 없습니다!"})
			end
		end)
    end
end

function vRPhk.test(msg)
  print("msg "..msg.." received from "..source)
  return 42
end

function vRPhk.docsOnline()
  local docs = vRP.getUsersByPermission({"emscheck.revive"})
  return #docs
end

function vRPhk.checkJail()
    local user_id = vRP.getUserId({source})
    vRP.getUData({user_id,"vRP:jail:time",function(value)
	  if value ~= nil then
	    custom = json.decode(value)
	    if custom ~= nil then
		  if tonumber(custom) > 0 then
        return true
      else
        return true
		  end
	    end
	  end
	end})
end

--edit by fenton
function vRPhk.canSkipComa()
  local user_id = vRP.getUserId({source})
  return vRP.hasPermission({user_id,"player.skip_coma"})
end

function vRPhk.helpComa(x,y,z)
  vRP.sendServiceAlert({source,"119 긴급",x,y,z,"살려주세요!"}) -- people will change this message anyway haha
end

local player_lists = {}
function vRPhk.openUserList()
  local player = source
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    if player_lists[player] then -- hide
      player_lists[player] = nil
      vRPclient.removeDiv(player,{"user_list"})
    else -- show
      local content = "<span class=\"id\">ID</span><span class=\"pseudo\">NICKNAME</span><span class=\"name\">ROLEPLAY NAME</span><span class=\"job\">PROFESSION</span>"
      --local content = "<span class=\"id\">ID</span><span class=\"pseudo\">NICKNAME</span><span class=\"name\">ROLEPLAY NAME</span>"
      local count = 0
	  local users = vRP.getUsers({})
      for k,v in pairs(users) do
        count = count+1
        local user_source = vRP.getUserSource({k})
        vRP.getUserIdentity({k, function(identity)
		  if user_source ~= nil then
            content = content.."<br /><span class=\"id\">"..k.."</span><span class=\"pseudo\">"..vRP.getPlayerName({user_source}).."</span>"
            if identity then
              content = content.."<span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span><span class=\"job\">"..vRP.getUserGroupByType({k,"job"}).."</span>"
              --content = content.."<span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span>"
            end
          end
		  
          -- check end
          count = count-1
          if count == 0 then
            player_lists[player] = true
            local css = [[
              .div_user_list{ 
                margin: auto; 
				text-align: left;
                padding: 8px; 
                width: 650px; 
                margin-top: 100px; 
                background: rgba(50,50,50,0.0); 
                color: white; 
                font-weight: bold; 
                font-size: 1.1em;
              } 
              .div_user_list span{ 
				display: inline-block;
				text-align: center;
              } 
              .div_user_list .id{ 
                color: rgb(255, 255, 255);
                width: 45px; 
              }
              .div_user_list .pseudo{ 
                color: rgb(66, 244, 107);
                width: 145px; 
              }
              .div_user_list .name{ 
                color: rgb(92, 170, 249);
                width: 295px; 
              }
			  .div_user_list .job{ 
                color: rgb(247, 193, 93);
                width: 145px; 
			  }
            ]]
            vRPclient.setDiv(player,{"user_list", css, content})
          end
		end})
      end
    end
  end
end

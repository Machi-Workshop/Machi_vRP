local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
 
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_truckerJob")


RegisterServerEvent('truckerJob:success') -- calls the event from client file
AddEventHandler('truckerJob:success', function(amount) -- handles the event
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    vRP.giveMoney({user_id,amount})
    vRPclient.notify(player,{"수고비를 받았습니다. ~g~"..amount.."$"})
end)

RegisterServerEvent('truckerJob:test') -- calls the event from client file
AddEventHandler('truckerJob:test', function(amount) -- handles the event
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if truckerjob(user_id) then
    TriggerClientEvent('okcok', source)
    else
    vRPclient.notify(player,{"~r~트럭 기사 직업군만 이용 가능합니다!"})
    end
end)

function truckerjob(uid)
  local testtest = 1
    if vRP.hasPermission({uid,"trucker.mission"}) then
      return true
    else
            return false
    end
end
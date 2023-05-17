resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


-- server scripts
server_scripts{ 
  'config.lua',
  "me-server.lua",
  "ooc-server.lua",
 --"deathmessages-server.lua",
  "deletevehicle-server.lua",
  --"weathersync-server.lua",
  -- "fix-server.lua",
  "dispatch-server.lua",
  --"password-server.lua", --비번시스템 비번:auramachi
  "sv_piggyback.lua"
}

-- client scripts
client_scripts{
  "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
  'Music-3DText.lua', -- 3D TEXT
  "gameui-client.lua",
  'config.lua',
  "crouch-client.lua",
  "pointfinger-client.lua",
  "handsup-client.lua",
  "stopwanted-client.lua",
  "deletevehicle-client.lua",
  --"weathersync-client.lua",
  -- "fix-client.lua",
  "missiontext-client.lua",
  "noweapondrops-client.lua",
  --"password-client.lua", --비번시스템 비번:auramachi
  "cl_piggyback.lua",
  "ragdoll-client.lua",
  "vehiclepush-client.lua"
 }
 
  exports {
    'getSurrenderStatus',
}
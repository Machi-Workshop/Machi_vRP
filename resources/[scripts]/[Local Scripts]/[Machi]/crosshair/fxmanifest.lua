-- Resource Metadata
fx_version "bodacious"
games { "gta5" }

author "Cookay" -- No credit needed
description "A very simple crosshair editor/display"
version "1.0.0"

--
client_script "cl_crosshair.lua"
server_scripts {
    "@vrp/lib/utils.lua",
    "sv_crosshair.lua"
}

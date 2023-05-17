resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_08_MEXICAN" { url = "http://fireworkmen.mooo.com:8000/stream.ogg", volume = 1.0, name = "ASUKA.FM" }

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}

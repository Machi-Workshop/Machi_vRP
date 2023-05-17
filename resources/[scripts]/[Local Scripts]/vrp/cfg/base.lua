
local cfg = {}

-- mysql credentials
cfg.db = {
  host = "127.0.0.1", -- database ip (default is local)
  database = "machi",   -- name of database
  user = "root",    --  database username
  password = ""   -- password of your database
}

cfg.save_interval = 120 -- seconds
cfg.whitelist = false -- enable/disable whitelist
cfg.ignore_ip_identifier = true -- This will allow multiple same IP connections (for families etc)

-- delay the tunnel at loading (for weak connections)
cfg.load_duration = 0.1 -- seconds, player duration in loading mode at the first spawn
cfg.load_delay = 0.1 -- milliseconds, delay the tunnel communication when in loading mode
cfg.global_delay = 0.1 -- milliseconds, delay the tunnel communication when not in loading mode


				-- SET YOUR LANGUAGE HERE - MAKE SURE IT'S INSIDE THE ""
cfg.lang = "ko" -- en / fr / it / ger / pt / ru / lith / dan / ar / pl / es / swe / fin / cn / ro / ko 
				-- English/Français/Italiano/Deutsche/Português/Pусский/Lietuvių/Dansk/العربية/Polskie/Español/Svenska/Suomalainen/中文/Română/한국어
cfg.debug = false


return cfg

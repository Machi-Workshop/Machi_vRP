Config = {}

Config.Bans = true -- true to enable automatic banning, false to disable automatic banning (THIS REQUIRES EasyAdmin)
Config.Expose = true -- true to put the players identifiers (ip, steam, etc) in chat when detected, false to disable
Config.NameChecking = false -- This is new, it checks if the source's supplied name(grabbed with natives) matches the author of the message their trying to send, its off by default due to some servers having name modification scripts,
Config.DiscordLogging = true -- true to enable discord logs, false to disable
Config.DiscordWebHookLink = "https://discord.com/api/webhooks/1068322419904872518/s2ryDxFhmZ8DUKXz9Z6etMzbt1crFNwFCAGyLriGEQa-XXLbaD-ifqvK-lCM1PKsigNB" -- Webhook link from the channel you want logs in... Format : "https://discordapp.com/api/webhook/blahblahblah/"
Config.BanMessage = "< Machi Anticheat > 비정상적인 활동이 감지되었습니다. Machi#0208" -- This is what will be your custom part of the ban message. Put whatever.

-- Don't touch k thx
Config.WebhookTryLimit = 2
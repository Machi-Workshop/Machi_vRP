-- Welcome Notice Module
-- 

if CONFIG.welcomeNotice == true then
  -- Welcome Notice
  AddEventHandler("vRP:NUIready", function()
    -- vRP NUI is ready
    SendNUIMessage({
      type = "WELCOME_MESSAGE"
    });
  end)
end

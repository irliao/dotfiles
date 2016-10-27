-- Hotkeys for Macs running osx10.12

-- TODO: remove super modal once Karabiner-Elements officially supports Super/Hyper keys
-- TODO: move some functions below to external require
-- TODO: lower case all keycode strings used (ex. change F17 to f17)

require("termkey") -- override Command_R/L in Terminal
-- require("alttabkey") -- TODO: fix broken module

super = hs.hotkey.modal.new({}, "F17")

-- Alert date, time, battery info, and caffeine status using Notification Center
alertSystemStatus = function()
    hs.alert.closeAll()
    local bat_num = hs.battery.percentage() -- local var for immediate battery status
    local time_str = os.date("%A %b %d, %Y - %H:%M") -- os.date("%a, %m/%d/%y - %H:%m")
    local bat_str = "Battery: " .. (bat_num and (bat_num .. "%") or "Nil")
    local caff_str = "Caffeine: " .. (caffeineStatus and caffeineStatus or "Nil")
    hs.alert(time_str)
    hs.alert(bat_str)
    hs.alert(caff_str)
end

-- Returns string name of browser to use based on machine name
chooseBrowserByMachineName = function()
  local machineName = hs.host.localizedName()
  if machineName == "irl-mba" or machineName == "irl-mbp" then -- personal
    browser = "Safari Technology Preview"
  elseif machineName == "SDGL130e9919d" then -- work
    browser = "Google Chrome"
  else -- default
    browser = "Safari"
  end
  return browser
end

-- Returns string name of mail application to use based on machine name
chooseMailByMachineName = function()
  local machineName = hs.host.localizedName()
  if machineName == "SDGL130e9919d" then -- work
    mail = "Microsoft Outlook"
  else -- default
    mail = "Mail" -- default Apple Mac Mail.app
  end
  return mail
end

-- TODO: enhance this
-- -- Alerts utility hotkeys
reportUtilsHotkeys = function()
    hs.alert.closeAll()
    hs.alert('Super + F#:')
    hs.alert('F1 to Mouse Highlight')
    hs.alert('F2 to Copy Finder Path')
    hs.alert('F3 to Highlight Mouse')
    hs.alert('F12 to Eject MicroSD')
end

-- Reloads Hammerspoon config
reloadConfig = function()
  hs.reload()
  super.triggered = true -- default value
  hs.alert.show("Config loaded")
end

-- Releases the F18 modifier
exitSuperModal = function()
  -- uncomment line below to require Super be released after each binding call
  -- ex: Super + A, release A, while holding Super, pressing B now will not execute Super + B
  --     this forces Super to be released after releasing A first, then press Super + B will register correctly
  -- super.triggered = true
  -- super:exit()
end

-- Vim Arrows
hs.hotkey.bind({"ctrl"}, "h", function()
    hs.eventtap.keyStroke({}, "left")
end)
hs.hotkey.bind({"ctrl"}, "j", function()
    hs.eventtap.keyStroke({}, "down")
end)
hs.hotkey.bind({"ctrl"}, "k", function()
    hs.eventtap.keyStroke({}, "up")
end)
hs.hotkey.bind({"ctrl"}, "l", function()
    hs.eventtap.keyStroke({}, "right")
end)

-- Safari shortcuts
hs.hotkey.bind({"shift"}, ';', function()
    local app = hs.application.frontmostApplication()
    local element = hs.uielement.focusedElement():role()
    if (app:name() == "Safari" or app:name() == "Safari Technology Preview") and not string.find(element, "Text") then
        hs.eventtap.keyStroke({"cmd"}, "l")
    else
        hs.eventtap.keyStrokes(':')
    end
end)
hs.hotkey.bind({}, '/', function()
    local app = hs.application.frontmostApplication()
    local element = hs.uielement.focusedElement():role()
    if (app:name() == "Safari" or app:name() == "Safari Technology Preview") and not string.find(element, "Text") then
        hs.eventtap.keyStroke({"cmd"}, "f")
    else
        hs.eventtap.keyStrokes('/')
    end
end)

-- Window management hotkeys
-- TODO: bind hyper + HJKL to focus screen
-- TODO: bind hyper + DELETE to toggle Notification Center
-- -- Focus window (args: all visible windows, only windows not fully covered, between 45 and -45 degrees)
super:bind({}, 'H', nil, function() hs.window.focusedWindow():focusWindowWest(nil, true, false) end, exitSuperModal)
super:bind({}, 'L', nil, function() hs.window.focusedWindow():focusWindowEast(nil, true, false) end, exitSuperModal)
super:bind({}, 'A', nil, function() focusPreviousWindow() super.triggered = true end, exitSuperModal)
super:bind({}, 'S', nil, function() resizeLeftRightFull() super.triggered = true end, exitSuperModal)
super:bind({'shift'}, 'S', nil, function() hs.window.setFrameCorrectness=true resizeLeftRightFull() hs.window.setFrameCorrectness=false super.triggered = true end, exitSuperModal)
super:bind({}, 'Z', nil, function() centerScreen() super.triggered = true end, exitSuperModal)
-- super:bind({}, 'W', nil, function() hideScreen() super.triggered = true end, exitSuperModal)
super:bind({}, 'ESCAPE', nil, function() moveToNextScreen() super.triggered = true end, exitSuperModal)
super:bind({}, 'RETURN', nil, function() toggleFullScreen() super.triggered = true end, exitSuperModal)
super:bind({}, '1', nil, function() alertSystemStatus() super.triggered = true end, exitSuperModal)
super:bind({}, '2', nil, function() reportUtilsHotsupereys() super.triggered = true end, exitSuperModal)
super:bind({}, ';', nil, function() hs.toggleConsole() end, exitSuperModal)

-- Application opener hotsupereys
super:bind({}, "C", nil, function() openApplication(chooseBrowserByMachineName()) end, exitSuperModal)
super:bind({}, "E", nil, function() openApplication("Sublime Text") end, exitSuperModal)
super:bind({}, "F", nil, function() openApplication("Finder") end, exitSuperModal)
super:bind({}, 'G', nil, function() hs.hints.windowHints(hs.window.focusedWindow():application():allWindows()) end, exitSuperModal) -- display hints only for focused application
super:bind({'shift'}, 'G', nil, function() hs.hints.windowHints() super.triggered = true end, exitSuperModal) -- display hints for all active applications
super:bind({}, "I", nil, function() openApplication("IntelliJ IDEA") super.triggered = true end, exitSuperModal)
super:bind({}, "K", nil, function() openApplication("Slack") super.triggered = true end, exitSuperModal)
super:bind({}, "M", nil, function() openApplication("Messages") super.triggered = true end, exitSuperModal)
super:bind({}, "N", nil, function() openApplication("Notes") super.triggered = true end, exitSuperModal)
super:bind({}, "O", nil, function() openApplication(chooseMailByMachineName()) super.triggered = true end, exitSuperModal)
super:bind({}, "R", nil, function() reloadConfig() super.triggered = true end, exitSuperModal)
super:bind({}, "T", nil, function() openApplication("Spotify") super.triggered = true end, exitSuperModal)
super:bind({}, "T", nil, function() openApplication("Spotify") super.triggered = true end, exitSuperModal)
super:bind({}, "X", nil, function() openApplication("Terminal") super.triggered = true end, exitSuperModal)
super:bind({'shift'}, "X", nil, function() openApplication("iTerm") super.triggered = true end, exitSuperModal)
super:bind({}, ",", nil, function() openApplication("System Preferences") super.triggered = true end, exitSuperModal)
super:bind({}, "=", nil, function() openApplication("App Store") super.triggered = true end, exitSuperModal)
super:bind({}, 'Tab', nil, function() switcher_focused_apps:next() super.triggered = true end, exitSuperModal)
super:bind({'shift'}, 'Tab', nil, function() switcher_active_space_apps:previous() super.triggered = true end, exitSuperModal)
super:bind({}, "DELETE", nil, function() openApplication("AppCleaner") super.triggered = true end, exitSuperModal)

-- Super keyDown when F18 (Capslock) is pressed
pressedF18 = function()
  super.triggered = false
  super:enter()
end

-- Super keyUp when F18 (Capslock) is released,
releasedF18 = function()
  super:exit()

  -- send Esc if no other keys are pressed
  if not super.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind Capslock to Super
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18) -- WARN: do not use nil as 3rd param, omit it instead to disable hotkey alert

-- Control mode (similar to Tmux prefix key)
-- modalKey = k.modal.new({}, "f19")
-- modalKey:bind('', 'escape', function() modalKey:exit() end, exitSuperModal)
-- appShortCuts = {
--     C = 'Safari Technology Preview',
--     X = 'Terminal'
-- }
-- for key, app in pairs(appShortCuts) do
--     modalKey:bind('', key, function() openApplication(app) end, function() modalKey:exit() end, exitSuperModal)
-- end

-- WARN: debug only, prints all typed values
-- -- tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
-- --   print(hs.inspect(event:getRawEventData()))
-- -- end, exitSuperModal)
-- -- tap:start()

-- -- k = k.modal.new('cmd-shift', 'd')
-- -- function super:entered() hs.alert'Entered mode' end
-- -- function super:exited() hs.alert'Exited mode' end
-- -- super:bind('', 'escape', function() super:exit() end, exitSuperModal)
-- -- super:bind('', 'J', 'Pressed J',function() print'let the record show that J was pressed' end, exitSuperModal)

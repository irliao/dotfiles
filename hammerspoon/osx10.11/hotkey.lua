-- Hotkeys for Mac running osx10.11 or older

-- TODO: remove super modal once Karabiner-Elements officially supports Super/Hyper keys
-- TODO: move some functions below to external require
-- TODO: lower case all keycode strings used (ex. change F17 to f17)

super = {'ctrl', 'alt', 'cmd'}
hyper = {'ctrl', 'alt', 'cmd', 'shift'}

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

-- Window management hotkeys
-- TODO: bind hyper + HJKL to focus screen
-- TODO: bind hyper + DELETE to toggle Notification Center
-- -- Focus window (args: all visible windows, only windows not fully covered, between 45 and -45 degrees)
hs.hotkey.bind(super, 'H', function() hs.window.focusedWindow():focusWindowWest(nil, true, false) end)
hs.hotkey.bind(super, 'L', function() hs.window.focusedWindow():focusWindowEast(nil, true, false) end)
hs.hotkey.bind(super, 'A', focusPreviousWindow)
hs.hotkey.bind(super, 'S', resizeLeftRightFull)
hs.hotkey.bind(hyper, 'S', resizeTopBottomFull) -- simulate Caps + Shift j+ S for vertical divide
hs.hotkey.bind(super, 'W', hideScreen)
hs.hotkey.bind(super, 'ESCAPE', moveToNextScreen)
hs.hotkey.bind(super, 'RETURN', toggleFullScreen)
hs.hotkey.bind(super, '1', alertSystemStatus)
hs.hotkey.bind(super, '2', reportUtilsHotsupereys)
hs.hotkey.bind(super, ';', function() hs.toggleConsole() end)

-- Application opener hotsupereys
hs.hotkey.bind(super, "C", function() openApplication(chooseBrowserByMachineName()) end)
hs.hotkey.bind(super, "E", function() openApplication("Sublime Text") end)
hs.hotkey.bind(super, "F", function() openApplication("Finder") end)
hs.hotkey.bind(super, 'G', function() hs.hints.windowHints(hs.window.focusedWindow():application():allWindows()) end) -- display hints only for focused application
hs.hotkey.bind(hyper, 'G', hs.hints.windowHints) -- display hints for all active applications
hs.hotkey.bind(super, "I", function() openApplication("IntelliJ IDEA") end)
hs.hotkey.bind(super, "K", function() openApplication("Slack") end)
hs.hotkey.bind(super, "M", function() openApplication("Messages") end)
hs.hotkey.bind(super, "N", function() openApplication("Notes") end)
hs.hotkey.bind(super, "O", function() openApplication(chooseMailByMachineName()) end)
hs.hotkey.bind(super, "R", reloadConfig)
hs.hotkey.bind(super, "T", function() openApplication("Spotify") end)
hs.hotkey.bind(super, "T", function() openApplication("Spotify") end)
hs.hotkey.bind(super, "X", function() openApplication("Terminal") end)
hs.hotkey.bind(hyper, "X", function() openApplication("iTerm") end)
hs.hotkey.bind(super, ",", function() openApplication("System Preferences") end)
hs.hotkey.bind(super, "=", function() openApplication("App Store") end)
hs.hotkey.bind(super, 'Tab', function()switcher_focused_apps:next()end)
hs.hotkey.bind(hyper, 'Tab', function()switcher_active_space_apps:previous() end)
hs.hotkey.bind(super, "DELETE", function() openApplication("AppCleaner") end)

-- Resize windows with arrow hotkeys
-- super:bind(super, 'LEFT', function() resizeFocusedWindow("horizontal", -25) end, exitSuperModal)
-- super:bind(super, 'RIGHT', function() resizeFocusedWindow("horizontal", 25) end, exitSuperModal)
-- super:bind(super, 'UP', function() resizeFocusedWindow("vertical", -25) end, exitSuperModal)
-- super:bind(super, 'DOWN', function() resizeFocusedWindow("vertical", 25) end, exitSuperModal)

-- Resize window to corner, requires Karabiner overriding 2 arrow keys to be diagonal arrows
-- super:bind(super, 'HOME', leftTopScreen) -- left top
-- super:bind(super, 'PAGEUP', rightTopScreen) -- right top
-- super:bind(super, 'END', leftBottomScreen) -- left bottom
-- super:bind(super, 'PAGEDOWN', rightBottomScreen) -- right bottom

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

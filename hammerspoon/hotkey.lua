-- WARN: requires modifier.lua

super = {'ctrl', 'alt', 'cmd'}
hyper = {'ctrl', 'alt', 'cmd', 'shift'}

-- Alert date, time, battery info, and caffeine status using Notification Center
function alertSystemStatus()
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
function chooseBrowserByMachineName()
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

-- TODO: enhance this
-- -- Alerts utility hotkeys
function reportUtilsHotkeys()
    hs.alert.closeAll()
    hs.alert('Super + F#:')
    hs.alert('F1 to Mouse Highlight')
    hs.alert('F2 to Copy Finder Path')
    hs.alert('F3 to Highlight Mouse')
    hs.alert('F12 to Eject MicroSD')
end

-- Reloads Hammerspoon config
function reloadConfig()
  hs.reload()
  hs.alert.show("Config loaded")
  superModal.triggered = true
end

-- Window management hotkeys
-- TODO: bind hyper + HJKL to focus screen
-- TODO: bind hyper + DELETE to toggle Notification Center
-- -- Focus window (args: all visible windows, only windows not fully covered, between 45 and -45 degrees)
hs.hotkey.bind(super, 'H', nil, function() hs.window.focusedWindow():focusWindowWest(nil, true, false) end)
hs.hotkey.bind(super, 'L', nil, function() hs.window.focusedWindow():focusWindowEast(nil, true, false) end)
hs.hotkey.bind(super, 'A', nil, focusPreviousWindow)
hs.hotkey.bind(super, 'S', nil, resizeLeftRightFull)
hs.hotkey.bind(hyper, 'S', nil, resizeTopBottomFull) -- simulate Caps + Shift j+ S for vertical divide
hs.hotkey.bind(super, 'W', nil, hideScreen)
hs.hotkey.bind(super, 'ESCAPE', nil, moveToNextScreen)
hs.hotkey.bind(super, 'RETURN', nil, toggleFullScreen)
hs.hotkey.bind(super, '`', nil, alertSystemStatus)
hs.hotkey.bind(super, '/', nil, reportUtilsHotkeys)
hs.hotkey.bind(super, ';', nil, function() hs.toggleConsole() end)

-- Application opener hotkeys
hs.hotkey.bind(super, "C", nil, function() openApplication(chooseBrowserByMachineName()) end)
hs.hotkey.bind(super, "E", nil, function() openApplication("Sublime Text") end)
hs.hotkey.bind(super, "F", nil, function() openApplication("Finder") end)
hs.hotkey.bind(super, 'G', nil, hs.hints.windowHints)
hs.hotkey.bind(hyper, 'G', nil, function() hs.hints.windowHints(hs.window.focusedWindow():application():allWindows()) end) -- hint for windows of focused app
hs.hotkey.bind(super, "I", nil, function() openApplication("IntelliJ IDEA") end)
hs.hotkey.bind(super, "K", nil, function() openApplication("Slack") end)
hs.hotkey.bind(super, "M", nil, function() openApplication("Messages") end)
hs.hotkey.bind(super, "N", nil, function() openApplication("Notes") end)
hs.hotkey.bind(super, "R", nil, reloadConfig)
hs.hotkey.bind(super, "T", nil, function() openApplication("Spotify") end)
hs.hotkey.bind(super, "T", nil, function() openApplication("Spotify") end)
hs.hotkey.bind(super, "X", nil, function() openApplication("Terminal") end)
hs.hotkey.bind(hyper, "X", function() openApplication("iTerm") end)
hs.hotkey.bind(super, ",", nil, function() openApplication("System Preferences") end)
hs.hotkey.bind(super, "=", nil, function() openApplication("App Store") end)
hs.hotkey.bind(super,'Tab', nil, function()switcher_focused_apps:next()end)
hs.hotkey.bind(hyper,'Tab', function()switcher_active_space_apps:previous()end)
hs.hotkey.bind(super, "DELETE", nil, function() openApplication("AppCleaner") end)

-- Resize windows with arrow hotkeys
-- hs.hotkey.bind(super, 'LEFT', function() resizeFocusedWindow("horizontal", -25) end)
-- hs.hotkey.bind(super, 'RIGHT', function() resizeFocusedWindow("horizontal", 25) end)
-- hs.hotkey.bind(super, 'UP', function() resizeFocusedWindow("vertical", -25) end)
-- hs.hotkey.bind(super, 'DOWN', function() resizeFocusedWindow("vertical", 25) end)

-- Resize window to corner, requires Karabiner overriding 2 arrow keys to be diagonal arrows
-- hs.hotkey.bind(super, 'HOME', leftTopScreen) -- left top
-- hs.hotkey.bind(super, 'PAGEUP', rightTopScreen) -- right top
-- hs.hotkey.bind(super, 'END', leftBottomScreen) -- left bottom
-- hs.hotkey.bind(super, 'PAGEDOWN', rightBottomScreen) -- right bottom

-- Control mode (similar to Tmux prefix key)
-- modalKey = hs.hotkey.modal.new({}, "f19")
-- modalKey:bind('', 'escape', function() modalKey:exit() end)
-- appShortCuts = {
--     C = 'Safari Technology Preview',
--     X = 'Terminal'
-- }
-- for key, app in pairs(appShortCuts) do
--     modalKey:bind('', key, function() openApplication(app) end, function() modalKey:exit() end)
-- end

-- WARN: debug only, prints all typed values
-- -- tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
-- --   print(hs.inspect(event:getRawEventData()))
-- -- end)
-- -- tap:start()

-- -- k = hs.hotkey.modal.new('cmd-shift', 'd')
-- -- function k:entered() hs.alert'Entered mode' end
-- -- function k:exited() hs.alert'Exited mode' end
-- -- k:bind('', 'escape', function() k:exit() end)
-- -- k:bind('', 'J', 'Pressed J',function() print'let the record show that J was pressed' end)


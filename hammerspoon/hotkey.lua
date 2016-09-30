-- WARN: requires modifier.lua

super = {'ctrl', 'alt', 'cmd'}
hyper = {'ctrl', 'alt', 'cmd', 'shift'}

-- Alert date, time, battery info, and caffeine status using Notification Center
function alertStatus()
    hs.alert.closeAll()
    local bat_num = hs.battery.percentage() -- local var for immediate battery status
    local time_str = os.date("%A %b %d, %Y - %H:%M") -- os.date("%a, %m/%d/%y - %H:%m")
    local bat_str = "Battery: " .. (bat_num and (bat_num .. "%") or "Nil")
    local caff_str = "Caffeine: " .. (caffeineStatus and caffeineStatus or "Nil")
    hs.alert(time_str)
    hs.alert(bat_str)
    hs.alert(caff_str)
end
hs.hotkey.bind(super, '`', alertStatus)

-- Both Modifer + Key to activate hotkey
-- TODO: refactor hotkey bindings to an external file
hs.hotkey.bind(super, 'A', focusPreviousWindow)
hs.hotkey.bind(super, 'S', resizeLeftRightFull)
hs.hotkey.bind(hyper, 'S', resizeTopBottomFull) -- simulate Caps + Shift j+ S for vertical divide
hs.hotkey.bind(super, 'W', hideScreen)
hs.hotkey.bind(super, 'ESCAPE', moveToNextScreen)
hs.hotkey.bind(super, 'RETURN', toggleFullScreen)
hs.hotkey.bind(super, 'SPACE', function()
  hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end) -- hint for windows of focused app
hs.hotkey.bind(hyper, 'SPACE', hs.hints.windowHints)

-- -- TODO: consider binding hyper + HJKL to focus screen
-- -- Focus window (args: all visible windows, only windows not fully covered, between 45 and -45 degrees)
hs.hotkey.bind(super, 'H', function() hs.window.focusedWindow():focusWindowWest(nil, true, false) end)
hs.hotkey.bind(super, 'J', function() hs.window.focusedWindow():focusWindowSouth(nil, true, false) end)
hs.hotkey.bind(super, 'K', function() hs.window.focusedWindow():focusWindowNorth(nil, true, false) end)
hs.hotkey.bind(super, 'L', function() hs.window.focusedWindow():focusWindowEast(nil, true, false) end)

-- -- TODO: disable some hotkeys based on username
-- -- Application opener hotkeys
hs.hotkey.bind(super, "C", function() openApplication("Safari Technology Preview") end)
-- hs.hotkey.bind(hyper, "C", function() openApplication("Slack") end)
hs.hotkey.bind(super, "G", function() openApplication("Google Chrome") end)
hs.hotkey.bind(super, "D", function() openApplication("Dash") end)
hs.hotkey.bind(super, "E", function() openApplication("Sublime Text") end)
hs.hotkey.bind(super, "F", function() openApplication("Finder") end)
hs.hotkey.bind(super, "I", function() openApplication("IntelliJ IDEA") end)
hs.hotkey.bind(super, "M", function() openApplication("Messages") end)
hs.hotkey.bind(super, "N", function() openApplication("Notes") end)
hs.hotkey.bind(super, 'Q', 'Lock System', function() hs.caffeinate.lockScreen() end)
-- hs.hotkey.bind(hyper, 'Q', 'Put system to sleep',function() hs.caffeinate.systemSleep() end)
-- hs.hotkey.bind(super, "O", function() openApplication("Microsoft Outlook") end)
hs.hotkey.bind(super, "T", function() openApplication("iTunes") end)
hs.hotkey.bind(super, "X", function() openApplication("Terminal") end)
-- hs.hotkey.bind(hyper, "X", function() openApplication("iTerm") end)
hs.hotkey.bind(super, ",", function() openApplication("System Preferences") end)
hs.hotkey.bind(super, "=", function() openApplication("App Store") end)
hs.hotkey.bind(super, "DELETE", function() openApplication("AppCleaner") end) -- TODO: bind to toggle Notification Center instead
hs.hotkey.bind(super,'Tab', function()switcher_focused_apps:next()end)
hs.hotkey.bind(hyper,'Tab', function()switcher_active_space_apps:previous()end)

-- -- Alerts utility hotkeys
function reportUtils()
    hs.alert.closeAll()
    hs.alert('Super + F#:')
    hs.alert('F1 to Mouse Highlight')
    hs.alert('F2 to Copy Finder Path')
    hs.alert('F3 to Highlight Mouse')
    hs.alert('F12 to Eject MicroSD')
end
hs.hotkey.bind(super, '/', reportUtils)
hs.hotkey.bind(super, ';', function() hs.toggleConsole() end)


-- -- Arrow hotkeys
-- hs.hotkey.bind(super, 'LEFT', function() resizeFocusedWindow("horizontal", -25) end)
-- hs.hotkey.bind(super, 'RIGHT', function() resizeFocusedWindow("horizontal", 25) end)
-- hs.hotkey.bind(super, 'UP', function() resizeFocusedWindow("vertical", -25) end)
-- hs.hotkey.bind(super, 'DOWN', function() resizeFocusedWindow("vertical", 25) end)

-- -- Resize window to corner, requires Karabiner overriding 2 arrow keys to be diagonal arrows
-- hs.hotkey.bind(super, 'HOME', leftTopScreen) -- left top
-- hs.hotkey.bind(super, 'PAGEUP', rightTopScreen) -- right top
-- hs.hotkey.bind(super, 'END', leftBottomScreen) -- left bottom
-- hs.hotkey.bind(super, 'PAGEDOWN', rightBottomScreen) -- right bottom

-- Utility call hotkeys
-- hs.hotkey.bind(super, 'F1', mouseHighlight)
-- hs.hotkey.bind(super, 'F2', copyCurrentFinderPath)
-- hs.hotkey.bind(super, 'F3', copyCurrentSafariTechURL)
-- hs.hotkey.bind(hyper, "F12", ejectMicroSD)

-- TODO: implement temporary hotkey for single key Tmux prefix
-- hs.hotkey.bind(super, "SPACE", function()
--   local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
--   if not win or win:application().then
--     return
--   end

-- -- bind to hotkeys; WARNING: at least one modifier key is required!
-- -- Window switcher for apps in all spaces
-- -- hs.hotkey.bind('alt','Tab', 'All Windows', function()switcher_all_apps:next()end)
-- -- hs.hotkey.bind('alt-shift','Tab', 'All Windows', function()switcher_all_apps:previous()end)
-- -- Window switcher for apps in current space only

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


-- Hotkeys for Macs running osx10.12

-- TODO: remove super modal once Karabiner-Elements officially supports Super/Hyper keys
-- TODO: move some functions below to external require
-- TODO: lower case all keycode strings used (ex. change F17 to f17)

-- require("alt-tab-key") -- TODO: fix broken module

super = hs.hotkey.modal.new({}, "F17")

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

-- Bind Capslock to Super, make sure Capslock is mapped to F18 in Karabiner-Elements
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18) -- WARN: do not use nil as 3rd param, omit it instead to disable hotkey alert

-- Releases the F18 modifier, should be called last in hotkey binded function
exitSuperModal = function()
  -- uncomment line below to require Super be released after binded hotkey call
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

-- Window management hotkeys
-- -- Focus window (args: all visible windows, only windows not fully covered, between 45 and -45 degrees)
super:bind({}, 'H', nil, function() hs.window.focusedWindow():focusWindowWest(nil, true, false) end, exitSuperModal)
super:bind({}, 'L', nil, function() hs.window.focusedWindow():focusWindowEast(nil, true, false) end, exitSuperModal)
super:bind({}, 'A', nil, function() focusPreviousWindow() super.triggered = true end, exitSuperModal)
super:bind({}, 'S', nil, function() resizeLeftRightFull() super.triggered = true end, exitSuperModal)
super:bind({}, 'D', nil, function() centerScreen() super.triggered = true end, exitSuperModal)
super:bind({}, 'Z', nil, function() alertSystemStatus() super.triggered = true end, exitSuperModal)
super:bind({}, 'Tab', nil, function() switcher_focused_apps:next() super.triggered = true end, exitSuperModal)
super:bind({}, 'ESCAPE', nil, function() moveToNextScreen() super.triggered = true end, exitSuperModal)
super:bind({}, 'RETURN', nil, function() toggleFullScreen() super.triggered = true end, exitSuperModal)
super:bind({}, ';', nil, function() hs.toggleConsole() super.triggered = true end, exitSuperModal)

-- Application opener hotsupereys
super:bind({}, "C", nil, function() openApplication(chooseBrowserByMachineName()) super.triggered = true end, exitSuperModal)
super:bind({}, "E", nil, function() openApplication("Sublime Text") super.triggered = true end, exitSuperModal)
super:bind({}, "F", nil, function() openApplication("Finder") super.triggered = true end, exitSuperModal)
super:bind({}, 'G', nil, function() hs.hints.windowHints(hs.window.focusedWindow():application():allWindows()) super.triggered = true end, exitSuperModal) -- display hints only for windows from focused application
super:bind({}, 'V', nil, function() hs.hints.windowHints() super.triggered = true end, exitSuperModal) -- display hints for all windows from active applications
super:bind({}, "I", nil, function() openApplication("IntelliJ IDEA") super.triggered = true end, exitSuperModal)
super:bind({}, "R", nil, function() reloadConfig() super.triggered = true end, exitSuperModal)
super:bind({}, "T", nil, function() openApplication("Spotify") super.triggered = true end, exitSuperModal)
super:bind({}, "X", nil, function() openApplication("Terminal") super.triggered = true end, exitSuperModal)
super:bind({}, ",", nil, function() openApplication("System Preferences") super.triggered = true end, exitSuperModal)

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

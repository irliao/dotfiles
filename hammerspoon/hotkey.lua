-- Hotkeys for Macs running osx10.12 and using HHKB keyboard layout (Capslock replaced with Control)

-- mash = {"ctrl", "shift"}
-- mash = {"alt", "shift"}
mash = {"ctrl", "cmd"}

-- Vim Arrows
hs.hotkey.bind({"ctrl"}, "h", function() hs.eventtap.keyStroke({}, "left") end)
hs.hotkey.bind({"ctrl"}, "j", function() hs.eventtap.keyStroke({}, "down") end)
hs.hotkey.bind({"ctrl"}, "k", function() hs.eventtap.keyStroke({}, "up") end)
hs.hotkey.bind({"ctrl"}, "l", function() hs.eventtap.keyStroke({}, "right") end)

-- Window management hotkeys
hs.hotkey.bind(mash, 'H', function() hs.window.focusedWindow():focusWindowWest(nil, true, false) end)
hs.hotkey.bind(mash, 'L', function() hs.window.focusedWindow():focusWindowEast(nil, true, false) end)
hs.hotkey.bind(mash, 'A', function() focusPreviousWindow() end)
hs.hotkey.bind(mash, 'S', function() resizeLeftRightFull() end)
hs.hotkey.bind(mash, 'D', function() centerScreen() end)
hs.hotkey.bind(mash, 'Z', function() alertSystemStatus() end)
hs.hotkey.bind(mash, 'Tab', function() switcher_focused_apps:next() end)
hs.hotkey.bind(mash, 'ESCAPE', function() moveToNextScreen() end)
hs.hotkey.bind(mash, 'RETURN', function() toggleFullScreen() end)
hs.hotkey.bind(mash, ';', function() hs.toggleConsole() end)

-- Application opener hotsupereys
-- hs.hotkey.bind(mash, "C", function() openApplication(chooseBrowserByMachineName()) end)
-- hs.hotkey.bind(mash, "C", function() openApplication("Safari Technology Preview") end)
hs.hotkey.bind(mash, "C", function() openApplication("Safari") end)
hs.hotkey.bind(mash, "E", function() openApplication("Sublime Text") end)
hs.hotkey.bind(mash, "F", function() openApplication("Finder") end)
hs.hotkey.bind(mash, "I", function() openApplication("IntelliJ IDEA") end)
hs.hotkey.bind(mash, "M", function() openApplication("Messages") end)
hs.hotkey.bind(mash, "N", function() openApplication("Notes") end)
hs.hotkey.bind(mash, "R", function() reloadConfig() end)
hs.hotkey.bind(mash, "T", function() openApplication("Spotify") end)
hs.hotkey.bind(mash, "X", function() openApplication("Terminal") end)
hs.hotkey.bind(mash, ",", function() openApplication("System Preferences") end)

-- Jump to Applications with Vimperator
hs.hotkey.bind(mash, 'G', function() hs.hints.windowHints(hs.window.focusedWindow():application():allWindows()) end) -- display hints only for windows from focused application
hs.hotkey.bind(mash, 'SPACE', function() hs.hints.windowHints() end) -- display hints for all windows from active applications

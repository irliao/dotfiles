-- Hotkeys bindings

require("utility")
require("window")
require("clipboard")
require("application-menu")

local super = {"ctrl"}
local mash = {"ctrl", "cmd"}
local mashShift = {"ctrl", "cmd", "shift"}

-- removes delay for repeating keyStroke (default eventtap.keyStroke has sleep between the newKeyEvents)
local function keyStrokeNoDelay(key)
  return function()
    hs.eventtap.event.newKeyEvent({}, string.lower(key), true):post()
    hs.eventtap.event.newKeyEvent({}, string.lower(key), false):post()
  end
end
hs.hotkey.bind(super, "H", keyStrokeNoDelay("left"), nil, keyStrokeNoDelay("left"))
hs.hotkey.bind(super, "J", keyStrokeNoDelay("down"), nil, keyStrokeNoDelay("down"))
hs.hotkey.bind(super, "K", keyStrokeNoDelay("up"), nil, keyStrokeNoDelay("up"))
hs.hotkey.bind(super, "L", keyStrokeNoDelay("right"), nil, keyStrokeNoDelay("right"))

-- Safari
hs.hotkey.bind(mash, '1', cycle_safari_agents)

-- Vimperator
hs.hotkey.bind(mash, "SPACE", function() hs.hints.windowHints() end) -- display hints for all windows from active applications
-- hs.hotkey.bind(super, "SPACE", function() hs.hints.windowHints(hs.window.focusedWindow():application():allWindows()) end) -- display hints only for windows from focused application TODO: remap key

-- Window management
hs.hotkey.bind(mash, "H", function() hs.window.focusedWindow():focusWindowWest(nil, true, false) end)
hs.hotkey.bind(mash, "L", function() hs.window.focusedWindow():focusWindowEast(nil, true, false) end)
hs.hotkey.bind(mash, "S", function() resizeLeftRightFull() end)
hs.hotkey.bind(mash, "D", function() resizeTopBottomFull() end)
hs.hotkey.bind(mash, "P", function() showClipboardMenuBarAtMouse() end)
hs.hotkey.bind(mash, "R", function() reloadConfig() end)
hs.hotkey.bind(mash, "Tab", function() switcher_focused_apps:next() end) -- TODO: map app switch to another hotkey
-- hs.hotkey.bind(mash, "TAB", function() focusPreviousWindow() end) -- TODO: remap and make focus cycle when reaching the first previous window
hs.hotkey.bind(mash, "ESCAPE", function() moveToNextScreen() end)
hs.hotkey.bind(mash, "RETURN", function() toggleFullScreen() end)
hs.hotkey.bind(mash, "DELETE", "Lock system", function() hs.caffeinate.lockScreen() end)
hs.hotkey.bind(mash, "`", function() alertSystemStatus() end)
hs.hotkey.bind(mash, ";", function() hs.toggleConsole() end)

-- Application opener
hs.hotkey.bind(mash, "C", function() openApplication(chooseBrowserByMachineName()) end)
hs.hotkey.bind(mash, "Z", function() openApplication("Google Chrome") end)
hs.hotkey.bind(mash, "E", function() openApplication("Sublime Text") end)
hs.hotkey.bind(mash, "F", function() openApplication("Finder") end)
hs.hotkey.bind(mash, "I", function() openApplication("IntelliJ IDEA") end)
hs.hotkey.bind(mash, "K", function() openApplication("Slack") end)
hs.hotkey.bind(mash, "M", function() openApplication("Messages") end)
hs.hotkey.bind(mash, "N", function() openApplication("Notes") end)
hs.hotkey.bind(mash, "T", function() openApplication("Spotify") end)
hs.hotkey.bind(mash, "X", function() openApplication("iTerm") end)
hs.hotkey.bind(mash, ",", function() openApplication("System Preferences") end)

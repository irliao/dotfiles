-- Hotkeys bindings

-- TODO: use JSON to define all mappings
-- TODO: implement own showHotkeys() to show all mappings from JSON file

-- Global settings
hs.hotkey.alertDuration = 0 -- hotkey alerts are disabled
hs.hints.style = 'vimperator' -- window hint starts with the first character of the parent application's title
hs.hints.fontName = 'Hack-Regular'
hs.hints.fontSize = 10

local module = {}

require("utility")
local windowUtil = require("windowUtil")

module.windowSwitcher = require("windowSwitcher")

-- Modifiers (Ctrl + Cmd/Alt)
local ctrlCmd = {"ctrl", "cmd"} -- modifier for most frequent hotkey
local ctrlAlt = {"ctrl", "alt"} -- modifier for less frequent hotkey
local ctrlCmdShift = {"ctrl", "cmd", "shift"} -- inverse modifier for most frequent hotkey
local ctrlAltShift = {"ctrl", "alt", "shift"} -- inverse modifier for less frequent hotkey

-- Window management
hs.hotkey.bind(ctrlCmd, "S", "Resize Full", function() resizeFocusedWindowTo("full") end)
hs.hotkey.bind(ctrlCmd, "A", "Resize Left", function() resizeFocusedWindowTo("left") end)
hs.hotkey.bind(ctrlCmd, "D", "Resize Right", function() resizeFocusedWindowTo("right") end)
hs.hotkey.bind(ctrlCmd, "W", "Resize Top", function() resizeFocusedWindowTo("top") end)
hs.hotkey.bind(ctrlCmd, "X", "Resize Bottom", function() resizeFocusedWindowTo("bottom") end)
hs.hotkey.bind(ctrlCmd, "Z", "Resize Center", function() resizeFocusedWindowTo("center") end)
hs.hotkey.bind(ctrlCmd, "H", "Focus Left Window", function() focusWindowAtDirection("left") end)
hs.hotkey.bind(ctrlCmd, "L", "Focus Right Window", function() focusWindowAtDirection("right") end)
-- hs.hotkey.bind(ctrlCmd, "Z", "Hide All Windows", function() hideAllWindows() end)
hs.hotkey.bind(ctrlCmd, "TAB", "Focus Previous Window", module.windowSwitcher.focusPreviousWindow, nil, module.windowSwitcher.focusPreviousWindow)
hs.hotkey.bind(ctrlCmdShift, "TAB", "Focus Next Window", module.windowSwitcher.focusNextWindow, nil, module.windowSwitcher.focusNextWindow)
hs.hotkey.bind(ctrlCmd, "ESCAPE", "Move Previous Screen", function() moveWindowToScreen("prev") end)
hs.hotkey.bind(ctrlCmdShift, "ESCAPE", "Move Next Screen", function() moveWindowToScreen("next") end)
hs.hotkey.bind(ctrlCmd, "`", "Move Previous Screen", function() moveWindowToScreen("prev") end)
hs.hotkey.bind(ctrlCmdShift, "`", "Move Next Screen", function() moveWindowToScreen("next") end)
hs.hotkey.bind(ctrlCmd, "RETURN", "Enter Full Screen", function() toggleFullScreen() end)
hs.hotkey.bind(ctrlCmd, "SPACE", "Vimperator", function() hs.hints.windowHints() end)
hs.hotkey.bind(ctrlCmd, "I", "System Status", function() alertSystemStatus() end)

-- Application opener
hs.hotkey.bind(ctrlCmd, "1", "Misson Control", function() openApplication("Mission Control") end)
hs.hotkey.bind(ctrlCmd, "2", "Launchpad", function() openApplication("Launchpad") end)
hs.hotkey.bind(ctrlCmd, "B", "Docker", function() openApplication("Docker Desktop") end)
hs.hotkey.bind(ctrlCmd, "C", "Safari", function() openApplication("Safari") end)
hs.hotkey.bind(ctrlAlt, "C", "Chrome", function() openApplication("Google Chrome") end)
hs.hotkey.bind(ctrlAlt, "E", "Xcode", function() openApplication("Xcode") end)
hs.hotkey.bind(ctrlCmd, "E", "Visual Studio Code", function() openApplication("Visual Studio Code") end)
hs.hotkey.bind(ctrlCmd, "F", "Finder", function() openApplication("Finder") end)
hs.hotkey.bind(ctrlCmd, "G", "ChatGPT", function() openApplication("ChatGPT") end)
hs.hotkey.bind(ctrlCmd, "M", "Line", function() openApplication("Line") end)
hs.hotkey.bind(ctrlAlt, "M", "Messages", function() openApplication("Messages") end)
hs.hotkey.bind(ctrlCmd, "N", "Notes", function() openApplication("Notes") end)
hs.hotkey.bind(ctrlCmd, "P", "Bruno", function() openApplication("Bruno") end)
hs.hotkey.bind(ctrlCmd, "T", "Spotify", function() openApplication("Spotify") end)
hs.hotkey.bind(ctrlCmd, "R", "iTerm", function() openApplication("iTerm") end)
hs.hotkey.bind(ctrlCmd, ";", "Hammerspoon", function() openApplication("Hammerspoon") end)
hs.hotkey.bind(ctrlCmd, ",", "System Preferences", function() openApplication("System Preferences") end)
hs.hotkey.bind(ctrlCmd, "'", "Activity Monitor", function() openApplication("Activity Monitor") end)
hs.hotkey.bind(ctrlCmd, "\\", "Passwords", function() openApplication("Passwords") end)

return module

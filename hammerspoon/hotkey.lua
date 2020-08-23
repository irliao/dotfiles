-- Hotkeys bindings

-- TODO: use JSON to define all mappings
-- TODO: implement own showHotkeys() to show all mappings from JSON file

-- Global settings
hs.hotkey.alertDuration = 0 -- hotkey alerts are disabled
-- hs.hints.style = 'vimperator' -- window hint starts with the first character of the parent application's title
hs.hints.hintChars = { 'A', 'S', 'D', 'F', 'J', 'K', 'L', 'Q', 'W', 'E', 'R', 'Z', 'X', 'C' } -- NOTE: ignored when style is vimperator
hs.hints.fontName = 'Hack-Regular'
hs.hints.fontSize = 10
hs.hints.showTitleThresh = 0 -- if number of windows is less than or equal to this, show window titles in hint

local module = {}

require("utility")
local windowUtil = require("windowUtil")

module.windowSwitcher = require("windowSwitcher")
module.clipboard = require("clipboard")

-- Modifiers (Ctrl + Cmd/Alt)
local ctrlCmd = {"ctrl", "cmd"} -- modifier for most frequent hotkey
local ctrlAlt = {"ctrl", "alt"} -- modifier for less frequent hotkey
local ctrlCmdShift = {"ctrl", "cmd", "shift"} -- inverse modifier for most frequent hotkey
local ctrlAltShift = {"ctrl", "alt", "shift"} -- inverse modifier for less frequent hotkey

-- Window management
hs.hotkey.bind(ctrlCmd, "A", "Resize Left", function() resizeToLeftHalf() end)
hs.hotkey.bind(ctrlCmd, "S", "Resize Full", function() resizeToFullScreen() end)
hs.hotkey.bind(ctrlCmd, "D", "Resize Right", function() resizeToRightHalf() end)
hs.hotkey.bind(ctrlCmd, "H", "Focus Left Window", function() focusWindowAtDirection("left") end)
hs.hotkey.bind(ctrlCmd, "L", "Focus Right Window", function() focusWindowAtDirection("right") end)
hs.hotkey.bind(ctrlCmd, "Z", "Hide All Windows", function() hideAllWindows() end)
hs.hotkey.bind(ctrlCmd, "TAB", "Focus Previous Window", function() module.windowSwitcher:focusPreviousWindow() end)
hs.hotkey.bind(ctrlCmdShift, "TAB", "Focus Next Window", function() module.windowSwitcher:focusNextWindow() end)
hs.hotkey.bind(ctrlCmd, "`", "Move Previous Screen", function() moveWindowToScreen("prev") end)
hs.hotkey.bind(ctrlCmdShift, "`", "Move Next Screen", function() moveWindowToScreen("next") end)
hs.hotkey.bind(ctrlCmd, "RETURN", "Enter Full Screen", function() toggleFullScreen() end)
hs.hotkey.bind(ctrlCmd, "G", "Vimperator", function() hs.hints.windowHints(hs.window:focusedWindow():otherWindowsSameScreen()) end)
hs.hotkey.bind(ctrlCmd, "1", "System Status", function() alertSystemStatus() end)

-- Application opener
hs.hotkey.bind(ctrlCmd, "C", "Safari", function() openApplication("Safari") end)
hs.hotkey.bind(ctrlAlt, "C", "Chrome", function() openApplication("Google Chrome") end)
hs.hotkey.bind(ctrlCmd, "E", "IntelliJ", function() openApplication("IntelliJ IDEA CE") end)
hs.hotkey.bind(ctrlAlt, "E", "Sublime", function() openApplication("Sublime Text") end)
hs.hotkey.bind(ctrlCmd, "F", "Finder", function() openApplication("Finder") end)
hs.hotkey.bind(ctrlCmd, "M", "Messages", function() openApplication("Messages") end)
hs.hotkey.bind(ctrlAlt, "M", "Line", function() openApplication("Line") end)
hs.hotkey.bind(ctrlCmd, "N", "Notes", function() openApplication("Notes") end)
hs.hotkey.bind(ctrlCmd, "P", "Postman", function() openApplication("Postman") end)
hs.hotkey.bind(ctrlCmd, "T", "Spotify", function() openApplication("Spotify") end)
hs.hotkey.bind(ctrlAlt, "T", "iTunes", function() openApplication("iTunes") end)
hs.hotkey.bind(ctrlCmd, "R", "iTerm", function() openApplication("iTerm") end)
hs.hotkey.bind(ctrlAlt, "R", "Terminal", function() openApplication("Terminal") end)
hs.hotkey.bind(ctrlCmd, ";", "Hammerspoon", function() openApplication("Hammerspoon") end)
hs.hotkey.bind(ctrlCmd, ",", "System Preferences", function() openApplication("System Preferences") end)

return module

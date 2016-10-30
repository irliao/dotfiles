-- Hammerspoon Config

-- Hammerspoon CLI
-- require("hs.ipc") -- provides server portion of cli

hs.ipc.cliInstall() -- installs cli named 'hs' in /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/ipc/bin/
hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.dockIcon(false)
hs.menuIcon(false)
hs.dockIcon(false)
hs.consoleOnTop(true)
hs.crash.crashLogToNSLog = true -- show crash logs as OSX notification
hs.window.animationDuration = 0
hs.window.setShadows(false)
hs.hotkey.alertDuration = 0 -- hotkey alerts are disabled
hs.hints.style = 'vimperator' -- window hint starts with the first character of the parent application's title
hs.hints.fontName = 'Hack'
hs.window.filter.setLogLevel = 'error'
hs.window.filter.ignoreAlways['Safari Technology Preview Networking'] = true
hs.window.filter.ignoreAlways['Safari Technology Preview Database Storage'] = true
hs.window.filter.ignoreAlways['Siri'] = true -- prevent wfilter warnings from windowHighlight
hs.window.filter.ignoreAlways['Spotlight'] = false -- prevent wfilter warnings from windowHighlight
-- hs.window.filter.ignoreAlways['Autoupdate'] = true

-- TODO: currently order matters, should remove such dependency order
require("utility")
require("window") -- depends on util
require("highlight") -- depends on window
require("switcher")
require("clipboard")
require("window-filter")
-- if hs.host.operatingSystemVersion().minor == 12 then require("sierra-key") else require("el-capitan-key") end
-- require("terminal-key") -- override Command_R/L in Terminal
require("hhkb-key")

-- TODO: broken
-- Input source change with alert
-- function alertInputSource()
--   hs.alert.closeAll()
--   local input_src = hs.keycodes.currentLayout()
--   hs.alert(input_src)
-- end
-- hs.keycodes.inputSourceChanged(alertInputSource)

-- Toggle binded to caffeine icon on menu bar
caffeineMenubar = hs.menubar.new() -- menubar icon
caffeineStatus = nil
isConfigLoaded = true
function caffeineToggle()
    hs.alert.closeAll()
    hs.caffeinate.toggle("system")
    if hs.caffeinate.get("system") then
        hs.caffeinate.set("displayIdle", true, true) -- set(sleepType, canSleep, whenOnBattery AND whenOnAC)
        hs.caffeinate.set("systemIdle", true, true)
        caffeineMenubar:setIcon("caffeine_on.pdf")
        caffeineStatus = "Caffeine: ON"
    else
        hs.caffeinate.set("displayIdle", false, true)
        hs.caffeinate.set("systemIdle", false, true)
        caffeineMenubar:setIcon("caffeine_off.pdf")
        caffeineStatus = "Caffeine: OFF"
    end
    if not isConfigLoaded then -- surpress any alert until config is loaded
        hs.alert(caffeineStatus)
    end
end
caffeineMenubar:setClickCallback(caffeineToggle)
caffeineToggle() -- default Caffeine to be ON
isConfigLoaded = false -- controls when Caffeine can alert

-- TODO: move applicationWatcher() out of window.lua
-- Application watcher
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- Reload config
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/init.lua", reloadConfig):start()
hs.alert.show('Config Loaded')

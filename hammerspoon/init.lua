-- Hammerspoon Config

-- Ensure IPC is installed for CLI access
-- require("hs.ipc")

-- Hammerspoon configs
hs.ipc.cliInstall()
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
hs.window.filter.ignoreAlways['Spotlight']=true -- prevent wfilter warnings from windowHighlight
hs.window.filter.ignoreAlways['Siri']=true -- prevent wfilter warnings from windowHighlight
-- hs.window.filter.ignoreAlways['Hammerspoon']=true -- TODO: figure out how to remove errors from Hammerspoon console logs
-- hs.window.filter.ignoreAlways['Hammerspoon Console']=true
-- hs.window.filter.ignoreAlways[hs.console.hswindow():application():title()]=true

-- NOTE: import order matters!
-- Preload defaults APIs/configs from Hammerspoon
-- require("hs.application") -- fixes error from hs.window.orderedWindows() in layoutVertical()
require("utility") -- no dependencies
require("window") -- depends on util
require("highlight") -- depends on window
require("switcher") -- no dependencies

osVer = hs.host.operatingSystemVersion()
if osVer and osVer.major == 10 and osVer.minor == 12 then
  require("superkey") -- no dependencies, defines Super/Hyper key
end

require("hotkey") -- depends on all others, especially super/hyper definition

-- TODO: broken
-- Input source change with alert
-- function alertInputSource()
--   hs.alert.closeAll()
--   local input_src = hs.keycodes.currentLayout()
--   hs.alert(input_src)
-- end
-- hs.keycodes.inputSourceChanged(alertInputSource)

-- Global vars, persists across Hammerspoon session
caffeineMenubar = hs.menubar.new() -- menubar icon

-- Global-local vars, reset each time init.lua is loaded
isConfigLoaded = true
caffeineStatus = nil
-- browser = selectBrowserByMachineName() -- TODO: figure out how to make function static for readibility, ex: ClassName.functionName

-- Toggle binded to caffeine icon on menu bar
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

-- Application watcher
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- Reload config
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/init.lua", reloadConfig):start()
hs.alert.show('Config Loaded')

-- Unused configs

-- -- Window filter, WARN: subscribe MUST be in init.lua
-- wf=hs.window.filter.new() -- empty filter
-- wf:subscribe(hs.window.filter.windowFullscreened, function() hs.window.highlight.stop() end)
-- wf:subscribe(hs.window.filter.windowFocused, function ()
--     if isFocusedWindowFullOrMax() then
--         hs.window.highlight.stop()
--     else
--         hs.window.highlight.start()
--     end
-- end)

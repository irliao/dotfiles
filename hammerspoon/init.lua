-- Hammerspoon Config

-- NOTE: import order matters!
-- Preload defaults APIs/configs from Hammerspoon
require("hs.application") -- fixes error from hs.window.orderedWindows() in layoutVertical()
require("utility") -- no dependencies
require("window") -- depends on util
require("highlight") -- depends on window
require("switcher") -- no dependencies

-- Ensure IPC is installed for CLI access
if not hs.ipc.cliStatus() then hs.ipc.cliInstall() end

-- Hammerspoon configs
hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.dockIcon(false)
hs.menuIcon(false)
hs.dockIcon(false)
hs.consoleOnTop(true)
hs.crash.crashLogToNSLog = true
hs.window.animationDuration = 0
hs.window.setShadows(false)

-- Global vars, persists across Hammerspoon session
super = {"cmd", "alt", "ctrl"}
hyper = {"cmd", "alt", "ctrl", "shift"}
caffeineMenubar = hs.menubar.new() -- menubar icon

-- Global-local vars, reset each time init.lua is loaded
isConfigLoaded = true
caffeineStatus = nil
-- browser = selectBrowserByMachineName()

-- Alert date, time, battery info, and caffeine status using Notification Center
function alertStatus()
    hs.alert.closeAll()
    local bat_num = hs.battery.percentage() -- local var for immediate battery status
    local time_str = os.date("%A %b %d, %Y - %I:%M%p") -- os.date("%a, %m/%d/%y - %H:%m")
    local bat_str = "Battery: " .. (bat_num and (bat_num .. "%") or "Nil")
    local caff_str = "Caffeine: " .. (caffeineStatus and caffeineStatus or "Nil")
    hs.alert(time_str)
    hs.alert(bat_str)
    hs.alert(caff_str)
end

-- Window management hotkeys
-- hs.hotkey.bind(super, '1', function() hs.window.focusedWindow():focusWindowWest() end)
-- hs.hotkey.bind(super, '2', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(super, 'A', focusPreviousWindow)
hs.hotkey.bind(super, 'S', resizeLeftRightFull)
hs.hotkey.bind(hyper, 'S', resizeTopBottomFull) -- simulate Caps + Shift + S for vertical divide
hs.hotkey.bind(super, 'R', function() hs.reload() end)
hs.hotkey.bind(super, 'W', hideScreen)
-- hs.hotkey.bind(super, 'TAB', toggleFullScreen)
hs.hotkey.bind(super, 'ESCAPE', moveToNextScreen)
hs.hotkey.bind(super, 'SPACE', hs.hints.windowHints)
hs.hotkey.bind(hyper, 'RETURN', centerScreen)
hs.hotkey.bind(super, 'RETURN', toggleFullScreen)
hs.hotkey.bind(super,'Tab', 'Next window',function()switcher_active_app:next()end)
hs.hotkey.bind(hyper,'Tab','Prev window',function()switcher_active_app:previous()end)

-- Arrow hotkeys
hs.hotkey.bind(super, 'LEFT', function() resizeFocusedWindow("horizontal", -25) end)
hs.hotkey.bind(super, 'RIGHT', function() resizeFocusedWindow("horizontal", 25) end)
hs.hotkey.bind(super, 'UP', function() resizeFocusedWindow("vertical", -25) end)
hs.hotkey.bind(super, 'DOWN', function() resizeFocusedWindow("vertical", 25) end)

-- Focus hotkeys (args: all visible windows, only windows not fully covered, between 45 and -45 degrees)
hs.hotkey.bind(super, 'H', function() hs.window.focusedWindow():focusWindowWest(nil, true, false) end)
hs.hotkey.bind(super, 'L', function() hs.window.focusedWindow():focusWindowEast(nil, true, false) end)
hs.hotkey.bind(super, 'K', function() hs.window.focusedWindow():focusWindowNorth(nil, true, false) end)
hs.hotkey.bind(super, 'J', function() hs.window.focusedWindow():focusWindowSouth(nil, true, false) end)

-- Resize window to corner, requires Karabiner overriding 2 arrow keys to be diagonal arrows
hs.hotkey.bind(super, 'HOME', leftTopScreen) -- left top
hs.hotkey.bind(super, 'PAGEUP', rightTopScreen) -- right top
hs.hotkey.bind(super, 'END', leftBottomScreen) -- left bottom
hs.hotkey.bind(super, 'PAGEDOWN', rightBottomScreen) -- right bottom

-- TODO: figure out how to setup different hotkeys for different usernames
-- Application opener hotkeys
hs.hotkey.bind(super, "C", function() openApplication("Safari Technology Preview") end)
hs.hotkey.bind(hyper, "C", function() openApplication("Google Chrome") end)
hs.hotkey.bind(super, "D", function() openApplication("Dash") end)
hs.hotkey.bind(super, "E", function() openApplication("Sublime Text") end)
hs.hotkey.bind(super, "F", function() openApplication("Finder") end)
hs.hotkey.bind(super, "I", function() openApplication("IntelliJ IDEA") end)
hs.hotkey.bind(hyper, "I", function() openApplication("WebStorm") end)
hs.hotkey.bind(super, "N", function() openApplication("Notes") end)
hs.hotkey.bind(super, "O", function() openApplication("Microsoft Outlook") end)
hs.hotkey.bind(super, "T", function() openApplication("iTunes") end)
hs.hotkey.bind(super, "X", function() openApplication("Terminal") end)
hs.hotkey.bind(hyper, "X", function() openApplication("iTerm") end)
hs.hotkey.bind(super, ",", function() openApplication("System Preferences") end)
hs.hotkey.bind(super, "=", function() openApplication("App Store") end)
hs.hotkey.bind(super, "DELETE", function() openApplication("AppCleaner") end)

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt','Tab','Next window',function()switcher_all:next()end)
hs.hotkey.bind('alt-shift','Tab','Prev window',function()switcher_all:previous()end)

-- TODO: implement bundles of system settings into each F# key
-- Utility call hotkeys
hs.hotkey.bind(super, 'F2', function() hs.toggleConsole() end)
hs.hotkey.bind(super, 'F3', function() openApplication("Hammerspoon") end)
hs.hotkey.bind(super, 'F4', function() openApplication("Karabiner") end)
hs.hotkey.bind(super, '/', reportUtils)
hs.hotkey.bind(super, '`', alertStatus)
hs.hotkey.bind(super, '3', mouseHighlight)
hs.hotkey.bind(super, '4', ejectMicroSD)
hs.hotkey.bind(super, '5', copyCurrentFinderPath)
hs.hotkey.bind(super, '6', copyCurrentSafariTechURL)
hs.hotkey.bind(super, '7', toggleTerminalFullScreen)

-- Karabiner URL hooks
hs.urlevent.bind("safari", function(eventName, params)
    if params["someParam"] then
        -- hs.alert.show(params["someParam"]) -- for debugging
        openSafariTechExtensionBuilder()
    end
end)

-- Sets Caffeine icon on menubar
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
isConfigLoaded = false -- control when Caffeine can alert

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

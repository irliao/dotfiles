-- Hammerspoon Config

-- Preload defaults APIs/configs from Hammerspoon
require("hs.application") -- fixes error from hs.window.orderedWindows() in layoutVertical()
require("util") -- should not have dependencies
require("draw") -- depends on util
require("resize") -- depends on util and draw

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
wf = hs.window.filter.new():setOverrideFilter{fullscreen = false} -- copy of default window filter

-- Global-local vars, reset each time init.lua is loaded
isConfigLoaded = true
caffeineStatus = nil

-- Alert date, time, battery info, and caffeine status using Notification Center
function alertStatus()
    hs.alert.closeAll()
    local bat_num = hs.battery.percentage() -- local var for immediate battery status
    local time_str = os.date("%A %b %d, %Y - %I:%M%p") -- os.date("%a, %m/%d/%y - %H:%m")
    local bat_str = "Battery % Left: " .. (bat_num and string.format("%d%%", bat_num) or "Nil")
    local caff_str = "Caffeine: " .. (caffeineStatus and caffeineStatus or "Nil")
    hs.alert.show(time_str, 4)
    hs.alert(bat_str)
    hs.alert(caff_str)
end

-- Window management hotkeys
hs.hotkey.bind(super, 'A', leftScreen)
hs.hotkey.bind(super, 'S', rightScreen)
hs.hotkey.bind(super, 'D', centerScreen)
hs.hotkey.bind(super, 'W', maxScreen)
hs.hotkey.bind(super, 'Q', hideScreen)
hs.hotkey.bind(super, 'TAB', focusPreviousWindow)
hs.hotkey.bind(super, 'ESCAPE', moveToNextScreen)
hs.hotkey.bind(super, 'RETURN', toggleFullScreen)
hs.hotkey.bind(super, 'SPACE', hs.hints.windowHints)

-- Window management with Arrow hotkeys
hs.hotkey.bind(super, 'UP', topScreen) -- top
hs.hotkey.bind(super, 'DOWN', bottomScreen) -- bottom
hs.hotkey.bind(super, 'LEFT', leftScreen) -- bottom
hs.hotkey.bind(super, 'RIGHT', rightScreen) -- bottom
hs.hotkey.bind(super, 'HOME', leftTopScreen) -- left top
hs.hotkey.bind(super, 'PAGEUP', rightTopScreen) -- right top
hs.hotkey.bind(super, 'END', leftBottomScreen) -- left bottom
hs.hotkey.bind(super, 'PAGEDOWN', rightBottomScreen) -- right bottom

-- Application opener hotkeys
hs.hotkey.bind(super, "C", function() openApplication("Safari") end)
hs.hotkey.bind(super, 'E', function() openApplication("Sublime Text") end)
hs.hotkey.bind(super, "F", function() openApplication("Finder") end)
hs.hotkey.bind(super, "H", function() openApplication("Helium") end)
hs.hotkey.bind(super, "N", function() openApplication("Evernote") end)
hs.hotkey.bind(super, "T", function() openApplication("Terminal") end)
hs.hotkey.bind(super, "V", function() openApplication("MacVim") end)
hs.hotkey.bind(super, ",", function() openApplication("System Preferences") end)

-- Work Application opener hotkeys
-- hs.hotkey.bind(super, "I", function() openApplication("WebStorm") end)
-- hs.hotkey.bind(super, "K", function() openApplication("Slack") end)
-- hs.hotkey.bind(super, "O", function() openApplication("Microsoft Outlook") end)

-- Utility call hotkeys
hs.hotkey.bind(super, 'F1', function() hs.reload() end)
hs.hotkey.bind(super, 'F2', function() hs.toggleConsole() end) 
hs.hotkey.bind(super, 'F3', function() openApplication("Hammerspoon") end)
hs.hotkey.bind(super, 'F4', function() openApplication("Karabiner") end)
hs.hotkey.bind(super, '/', reportUtils)
hs.hotkey.bind(super, '`', alertStatus)
hs.hotkey.bind(super, '1', copyCurrentFinderPath)
hs.hotkey.bind(super, '2', mouseHighlight)
hs.hotkey.bind(super, '3', ejectMicroSD)
hs.hotkey.bind(super, '4', copyCurrentSafariURL)
hs.hotkey.bind(super, '5', toggleTerminalFullScreen)

-- Karabiner URL hooks
hs.urlevent.bind("safari", function(eventName, params)
    if params["someParam"] then
        -- hs.alert.show(params["someParam"]) -- for debugging
        openSafariExtensionBuilder()  
    end
end)

-- Sets Caffeine icon on menubar
function caffeineToggle()
    hs.alert.closeAll()
    hs.caffeinate.toggle("system")
    if hs.caffeinate.get("system") then 
        hs.caffeinate.set("displayIdle", true, true) -- set(sleepType, canSleep, whenOnBattery AND whenOnAC)
        hs.caffeinate.set("systemIdle", true, true)
        caffeineMenubar:setIcon("caffeine-on.pdf")
        caffeineStatus = "Caffeine: ON"
    else
        hs.caffeinate.set("displayIdle", false, true)
        hs.caffeinate.set("systemIdle", false, true)
        caffeineMenubar:setIcon("caffeine-off.pdf")
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

-- Window watcher for border drawing
hs.window.filter.ignoreAlways['Spotlight'] = true -- prevent wfilter warnings from windowHighlight
wf:subscribe(hs.window.filter.windowFocused, function () windowHighlight() end)
wf:subscribe(hs.window.filter.windowUnfocused, function () eraseHighlight() end)
wf:subscribe(hs.window.filter.windowMoved, function () windowHighlight() end)

-- Reload config
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/init.lua", reloadConfig):start()
hs.alert.show('Config Loaded')

-- EOF

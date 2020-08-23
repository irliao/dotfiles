-- Hammerspoon config

-- NOTE: if requiring a file inside a folder in ~/.hammerspoon, replace "/" with "."
--       (ex. ~/.hammerspoon/someFolder/someFile.lua => require('someFolder.someFile')
--       you can also require all files in a folder by requiring the folder name (ex. require('someFolder')

-- Logger setup
hs.logger.setGlobalLogLevel('warning')
hs.logger.defaultLogLevel = 'warning'
logger = hs.logger.new('Init')
hs.console.clearConsole()

-- CLI integration
require("hs.ipc") -- provides server portion of cli
if not hs.ipc.cliStatus() then
  logger.w('No IPC installed, trying to install now')
  if not hs.ipc.cliInstall() then -- installs cli named 'hs' in /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/ipc/bin/
    logger.e('Attempt to install IPC failed, trying uninstall first before install now')
    hs.ipc.cliUninstall()
    if not hs.ipc.cliInstall() then
      logger.e('IPC still install failed, require user triage')
    end
  end
end

-- miscellaneous configs
hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.preferencesDarkMode(true)
hs.accessibilityState(true) -- show System Preferences if Accessibility is not enabled for Hammerspoon
hs.dockIcon(false)
hs.menuIcon(false)
hs.consoleOnTop(true)

-- window configs
hs.window.animationDuration = 0
hs.window.filter.setLogLevel = 'error'
hs.window.filter.ignoreAlways['Spotlight'] = false -- NOTE: set to false for window-filter to auto center Spotlight
hs.window.filter.ignoreAlways['Hammerspoon'] = false -- prevent wfiltre warning
hs.window.filter.ignoreAlways['Hammerspoon Networking'] = true -- prevent wfiltre warning
hs.window.filter.ignoreAlways['Autoupdate'] = true -- prevent wfiltre warning
hs.window.filter.ignoreAlways['Siri'] = true -- prevent wfilter warning

-- assign imported modules to global variable to avoid getting destroyed by garbage collection
console = require("console")
utility = require("utility")
hotkey = require("hotkey")
caffeine = require("caffeine")
windowFilter = require("windowFilter")
applicationWatcher = require("applicationWatcher").start()
fileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/init.lua", reloadConfig):start() -- reloads Hammerspoon whenever ~/.hammerspoon/init.lua is edited and saved

-- plugin to auto pause music when headphone disconnects
hs.loadSpoon('HeadphoneAutoPause')
spoon.HeadphoneAutoPause.autoResume = false
spoon.HeadphoneAutoPause.defaultControlFns('iTunes')
spoon.HeadphoneAutoPause:start()

-- plugin to get notification when WiFi changes
hs.loadSpoon('WifiNotifier')
spoon.WifiNotifier:init()
spoon.WifiNotifier:start()

-- callback when Hammerspoon is exiting or reloading, mainly for serialising state,
-- destroying system resources that will not be released by normal Lua garbage collection processes, etc
hs.shutdownCallback = function()
  applicationWatcher.stop()
  spoon.WifiNotifier:stop()
  spoon.HeadphoneAutoPause:stop()
  localProfile = nil
  logger.i("Hammerspoon Shutting Down")
  -- no OS/GUI commands will be executed in here since Hammerspoon is already shutting down
end
logger.i("Hammerspoon Config Loaded")

if hs.fs.displayName(os.getenv("HOME") .. "/.hammerspoon/local_profile.lua") == "local_profile.lua" then
  localProfile = require("local_profile")
  -- TODO: replace with logger (broken, no messages logged to hs console)
  -- hs.alert("Loaded local profile: ~/.hammerspoon/local_profile.lua")
end

-- plugin to display Hammerspoon logo to indicate Hammerspoon successfully loaded
hs.loadSpoon('FadeLogo')
spoon.FadeLogo.zoom = false
spoon.FadeLogo.image_size = hs.geometry.size(80, 80)
spoon.FadeLogo.run_time = 1.5
spoon.FadeLogo:start()


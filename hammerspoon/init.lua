-- Hammerspoon config

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
hs.window.filter.ignoreAlways['Siri'] = true -- prevent wfilter warnings from windowHighlight
hs.window.filter.ignoreAlways['Spotlight'] = false -- prevent wfilter warnings from windowHighlight
hs.window.filter.ignoreAlways['Autoupdate'] = true

-- Global logger to send debug logs to Hammerspoon console
logger = hs.logger.new('Debug', 'info') -- usage: logger.i('message')

-- TODO: verify duplicate require will not affect performance
require("caffeine")
require("utility")
require("hotkey")
require("application-watcher")
require("window")
require("switcher")
require("clipboard")
require("window-filter")
require("reload-config")

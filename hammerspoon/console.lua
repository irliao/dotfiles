-- Hammerspoon Console settings

-- function alias in Hammerspoon console
i = hs.inspect
r  = hs.reload
c = hs.console.clearConsole
a = hs.alert
p = print
u = hs.checkForUpdates
help = hs.help
docs = hs.hsdocs
settings = hs.openPreferences

printWindowsInScreen = function()
  hs.fnutils.each(hs.window.allWindows(), function(win)
    print(inspect({
      title   = win:title(),
      app     = win:application():name(),
      role    = win:role(),
      subrole = win:subrole()
    }))
  end)
end

hs.console.darkMode(true)
if hs.console.darkMode() then
  hs.console.outputBackgroundColor{ white = 0 }
  hs.console.consoleCommandColor{ white = 1 }
end

hs.console.consoleFont("Hack-Regular")

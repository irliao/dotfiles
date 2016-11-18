-- Utilities (mostly binded to some hotkey)

-- TODO: broken
-- Input source change with alert
-- function alertInputSource()
--   hs.alert.closeAll()
--   local input_src = hs.keycodes.currentLayout()
--   hs.alert(input_src)
-- end
-- hs.keycodes.inputSourceChanged(alertInputSource)

-- Returns string name of browser to use based on machine name
chooseBrowserByMachineName = function()
  local machineName = hs.host.localizedName()
  if machineName == "irl-mba" or machineName == "irl-mbp" then -- personal
    browser = "Safari Technology Preview"
  elseif machineName == "SDGL130e9919d" then -- work
    browser = "Google Chrome"
  else -- default
    browser = "Safari"
  end
  return browser
end

-- Returns string name of mail application to use based on machine name
chooseMailByMachineName = function()
  local machineName = hs.host.localizedName()
  if machineName == "SDGL130e9919d" then -- work
    mail = "Microsoft Outlook"
  else -- default
    mail = "Mail" -- default Apple Mac Mail.app
  end
  return mail
end

-- Reloads Hammerspoon config
reloadConfig = function()
  hs.reload()
  hs.alert.show("Config loaded")
end

-- Alert date, time, battery info, and caffeine status using Notification Center
alertSystemStatus = function()
    hs.alert.closeAll()
    local bat_num = hs.battery.percentage() -- local var for immediate battery status
    local time_str = os.date("%A %b %d, %Y - %H:%M") -- os.date("%a, %m/%d/%y - %H:%m")
    local bat_str = "Battery: " .. (bat_num and (bat_num .. "%") or "Nil")
    hs.alert(time_str)
    hs.alert(bat_str)
end

-- Mouse highlight
function mouseHighlight()
  local mouseColor={["red"]=250,["green"]=250,["blue"]=0,["alpha"]=1}
  if mouseCircle then
      mouseCircle:delete()
      if mouseCircleTimer then
          mouseCircleTimer:stop()
      end
  end
  mousepoint = hs.mouse.getAbsolutePosition()
  mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-20, mousepoint.y-20, 40, 40))
  mouseCircle:setStrokeColor(mouseColor)
  mouseCircle:setFill(false)
  mouseCircle:setStrokeWidth(5)
  mouseCircle:bringToFront(true)
  mouseCircle:show(0.5)

  mouseCircleTimer = hs.timer.doAfter(1, function()
      mouseCircle:hide(0.5)
      hs.timer.doAfter(0.6, function() mouseCircle:delete() end)
  end)
end

-- TODO: detect if focused window is maximized (fill-screen)
-- @return - boolean
function isFocusedWindowFullOrMax()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return true -- window filter will remove highlight if no focused window
  end
  return win:isFullScreen()
end

-- Eject EVO64 MicroSD
function ejectMicroSD()
    local volumes = hs.fs.volume.allVolumes(true) -- key = paths of disk volumes
    local volumePath = "/Volumes/EVO64"
    if not volumes or not volumes[volumePath] then
        hs.alert("No MicroSD Found")
        return
    end
    hs.fs.volume.eject(volumePath)
    hs.alert("Ejected EVO64")
end

-- Sent message to OSX Notification Center
function sendNotif(title_str, message_str)
    local notif_msg = {
        title = ((title_str ~= nil and title_str:len() > 0) and title_str or 'Hammerspoon'),
        informativeText = ((message_str ~= nil and message_str:len() > 0) and message_str or 'Empty or Nil Message')
    }
    hs.notify.new(notif_msg):send()
end

-- TODO: move Term functions below to another file, refactor window.lua to import it
-- Open Terminal and Enter Full Screen
function openTerminalFullScreen()
    script = [[
    activate application "Terminal"
    tell application "System Events"
        tell process "Terminal"
            click menu item "Enter Full Screen" of menu 1 of menu bar item "View" of menu bar 1
        end tell
    end tell
    ]]
    hs.applescript(script)
end

-- Toggle Terminal Full Screen
function toggleTerminalFullScreen()
    script = [[
    activate application "Terminal"
    tell application "System Events"
        tell process "Terminal"
            if menu item "Enter Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists then
                click menu item "Enter Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists
            else if menu item "Exit Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists then
                click menu item "Exit Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists
            end if
        end tell
    end tell
    ]]
    hs.applescript(script)
end

-- Open iTerm2 and Enter Full Screen
function openiTermFullScreen()
    script = [[
    activate application "iTerm2"
    tell application "System Events"
        tell process "iTerm2"
            click menu item "Toggle Full Screen" of menu 1 of menu bar item "View" of menu bar 1
        end tell
    end tell
    ]]
    hs.applescript(script)
end

-- Toggle iTerm2 Full Screen
function toggleiTermFullScreen()
    script = [[
    activate application "iTerm2"
    tell application "System Events"
        tell process "iTerm2"
            if menu item "Toggle Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists then
                click menu item "Toggle Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists
            else if menu item "Toggle Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists then
                click menu item "Toggle Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists
            end if
        end tell
    end tell
    ]]
    hs.applescript(script)
end

-- Types the current PATH of Finder
function copyCurrentFinderPath()
    script = [[
    tell application "Finder"
        set finderWin to window 1
        set finderPath to (POSIX path of (target of finderWin as alias))
    end tell
    return finderPath
    ]]
    ok, result = hs.applescript(script)
    if (ok) then
        -- hs.eventtap.keyStrokes(result) -- type the result
        hs.pasteboard.setContents(result)
        sendNotif('Clipboard', 'Copied current directory Path of Finder')
    end
end

-- Checks if a device is currently connected
function isDeviceConnected(productID, productName, vendorID)
  local attachedUsbs = hs.usb.attachedDevices()
  for i,usb in ipairs(attachedUsbs) do
    if usb and usb['productID'] == productID and usb['productName'] == productName and usb['vendorID'] == vendorID then
      return true
    end
  end

  -- no such device found connected
  return false
end

-- Reload Hammerspoon config if any files passed in is lua file and has saved changes
function reloadConfigWithAnyChange(files)
    local doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

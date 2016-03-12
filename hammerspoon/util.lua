-- Utilities

-- Alerts utility hotkeys
function reportUtils()
    hs.alert.closeAll()
    hs.alert('Super + 1 to Copy Finder Path')
    hs.alert('Super + 2 to Highlight Mouse')
    hs.alert('Super + 3 to Eject MicroSD')
    hs.alert('Super + 4 to Copy Safari URL')
    hs.alert('Super + 5 to Toggle Termianl Full Screen')
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

-- Report date, time, battery info, and caffeine status using Notification Center
function reportStatus()
    hs.alert.closeAll()
    local bat_num = hs.battery.percentage() -- local var for immediate battery status
    local date_str = os.date("%a, %m/%d/%y - %H:%m")
    local bat_str = "Battery % Left: " .. (bat_num and string.format("%d%%", bat_num) or "Charging")
    local caff_str = "Caffeine: " .. (caffeineStatus and caffeineStatus or "Nil")
    local notif_str = bat_str .. caff_str
    sendNotif(date_str, notif_str)
end

-- Open Terminal and Enter Full Screen
function openTerminalFullScreen()
    script = [[
    activate application "Terminal"
    tell application "System Events"
        tell process "Terminal"
            click menu item "Enter Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists
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

-- Open Safari Extension Builder
function openSafariExtensionBuilder()
    script = [[
    activate application "Safari"
    tell application "System Events"
        tell process "Safari"
            click menu item "Show Extension Builder" of menu 1 of menu bar item "Develop" of menu bar 1
        end tell
    end tell
    ]]
    hs.applescript(script)
end 

-- Types the current URL of Safari
function copyCurrentSafariURL()
    script = [[
    tell application "Safari"
        set currentURL to URL of document 1
    end tell
    return currentURL
    ]]
    ok, result = hs.applescript(script)
    if (ok) then
        -- hs.eventtap.keyStrokes(result) -- type the result
        hs.pasteboard.setContents(result)
        sendNotif('Clipboard', 'Copied current URL of Safari')
    end
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

-- Reload Hammerspoon config
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- EOF
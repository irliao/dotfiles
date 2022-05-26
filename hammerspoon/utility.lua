-- Utilities (mostly binded to some hotkey)

-- Reloads Hammerspoon config
reloadConfig = function()
  hs.reload()
  hs.alert.show("Config loaded")
end

-- rounds a number to the given number of decimal places
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- TODO: refactor and move to it's own module
-- Alert date, time, battery info, and caffeine status using Notification Center
alertSystemStatus = function()
    hs.alert.closeAll()

    local batteryPercentage = hs.battery.percentage() -- local var for immediate battery status
    local batteryTimeRemaining = hs.battery.timeRemaining()
    local batteryRemainDisplay = string.format("%d hours %d minutes Remaining", math.floor(batteryTimeRemaining / 60), batteryTimeRemaining % 60)
    if batteryTimeRemaining == -1 then -- calculating
      batteryRemainDisplay = "Calculating Remaining"
    elseif batteryTimeRemaining == -2 then -- plugged in
      if hs.battery.isCharged() then
        batteryRemainDisplay = "Charged"
      elseif hs.battery.isCharging() then
        local bat_charge = hs.battery.timeToFullCharge()
        if bat_charge == -1 then -- calculating
          batteryRemainDisplay = "Calculating Time till Full"
        else
          batteryRemainDisplay = string.format("Time till Full: %0.2f", (bat_charge / 60))
        end
      end
    end

    local curWifiName = hs.wifi.currentNetwork()
    if not curWifiName then
      curWifiName = "Off"
    end
    local wifiInfiDisplay = "Wi-Fi: " .. curWifiName

    local timeDisplay = os.date("%A %b %d, %Y - %H:%M") -- os.date("%a, %m/%d/%y - %H:%m")

    local batteryInfoDisplay = "Battery: " .. (batteryPercentage and (math.floor(batteryPercentage) .. "%") or "Nil") .. ", " .. batteryRemainDisplay

    -- TODO: refactor to get sourceName from input-source.lua once getter function is complete
    local inputSources = {}
    inputSources["com.apple.keylayout.ABC"] = "ABC"
    inputSources["com.apple.keylayout.US"] = "US"
    inputSources["com.apple.inputmethod.TCIM.Pinyin"] = "中文"
    local sourceId = hs.keycodes.currentSourceID()
    local sourceName = inputSources[sourceId]
    local inputInfoDisplay = "Input: " .. sourceName

    hs.alert(timeDisplay)
    hs.alert(batteryInfoDisplay)
    hs.alert(wifiInfiDisplay)
    hs.alert(inputInfoDisplay)
end

-- Sent message to OSX Notification Center
function sendNotif(title_str, message_str)
    local notif_msg = {
        title = ((title_str ~= nil and title_str:len() > 0) and title_str or 'Hammerspoon'),
        informativeText = ((message_str ~= nil and message_str:len() > 0) and message_str or 'Empty or Nil Message')
    }
    hs.notify.new(notif_msg):send()
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

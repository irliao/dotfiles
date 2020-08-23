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

    local bat_num = hs.battery.percentage() -- local var for immediate battery status
    local bat_time = hs.battery.timeRemaining()
    local bat_remain = string.format("%0.2f Remaining", (bat_time / 60))
    -- TODO: make bat_remain have max precision of 2 decimal places
    if bat_time == -1 then -- calculating
      bat_remain = "Calculating Remaining"
    elseif bat_time == -2 then -- plugged in
      if hs.battery.isCharged() then
        bat_remain = "Charged"
      elseif hs.battery.isCharging() then
        local bat_charge = hs.battery.timeToFullCharge()
        if bat_charge == -1 then -- calculating
          bat_remain = "Calculating Time till Full"
        else
          bat_remain = string.format("Time till Full: %0.2f", (bat_charge / 60))
        end
      end
    end

    local curWifiName = hs.wifi.currentNetwork()
    if not curWifiName then
      curWifiName = "Off"
    end
    local wifiStr = "Wi-Fi: " .. curWifiName

    local time_str = os.date("%A %b %d, %Y - %H:%M") -- os.date("%a, %m/%d/%y - %H:%m")

    local bat_str = "Battery: " .. (bat_num and (bat_num .. "%") or "Nil") .. ", " .. bat_remain

    -- TODO: refactor to get sourceName from input-source.lua once getter function is complete
    local inputSources = {}
    inputSources["com.apple.keylayout.ABC"] = "ABC"
    inputSources["com.apple.keylayout.US"] = "US"
    inputSources["com.apple.inputmethod.TCIM.Pinyin"] = "中文"
    local sourceId = hs.keycodes.currentSourceID()
    local sourceName = inputSources[sourceId]
    local input_str = "Input: " .. sourceName

    hs.alert(time_str)
    hs.alert(bat_str)
    hs.alert(wifiStr)
    hs.alert(input_str)
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

-- Terminal modifier customization

local module = {}
module.showPopUp = false

-- local wf = hs.window.filter.default:setAppFilter('My IDE',{allowTitles=1}) -- ignore no-title windows (e.g. transient autocomplete suggestions) in My IDE
local wf=hs.window.filter
module.wf = wf.new{'Terminal'} -- all visible terminal windows

-- integrate this to handle WASD right Command key
usingWASD = function()
  local attachedUsbs = hs.usb.attachedDevices()
  for i,usb in ipairs(attachedUsbs) do
    if usb and usb['productID'] == 321 and usb['productName'] == 'USB Keyboard' and usb['vendorID'] == 1241 then
      return true
    end
  end

  -- no WASD keyboard found connected
  return false
end

module.eventwatcher1 = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(e)

    local flags = e:getFlags()

    if flags.cmd
       and not (flags.alt or flags.shift or flags.ctrl or flags.fn)
    then
        module.cmdWasPressed = true
        module.cmdShouldBeIgnored = false
        return false;
    end

    if flags.cmd
       and (flags.alt or flags.shift or flags.ctrl or flags.fn)
       and module.cmdWasPressed
    then
        module.cmdShouldBeIgnored = true
        return false;
    end

    if not flags.cmd
    then
        if module.cmdWasPressed
       and not module.cmdShouldBeIgnored
        then
            local keyCode = e:getKeyCode()

            if keyCode == 0x37 then
              hs.eventtap.keyStroke({"ctrl"}, "s")

        elseif keyCode == 0x36 then
          hs.eventtap.keyStroke({}, ",")

        end
    end

    module.cmdWasPressed = false
    module.cmdShouldBeIgnored = false
    end

    return false;
end)


module.eventwatcher2 = hs.eventtap.new({"all", hs.eventtap.event.types.flagsChanged}, function(e)
    local flags = e:getFlags()

    if flags.cmd and module.cmdWasPressed then
    module.cmdShouldBeIgnored = true
    end

    return false;
end)

startWatch = function()
  module.eventwatcher1:start()
  module.eventwatcher2:start()
  -- hs.alert.show('termkey event watch started')
end

stopWatch = function()
  module.eventwatcher1:stop()
  module.eventwatcher2:stop()
  -- hs.alert.show('termkey event watch stopped')
end

module.wf:subscribe(wf.windowFocused, startWatch)
module.wf:subscribe(wf.windowUnfocused, stopWatch)

return module

-- Terminal.app keyboard customization

-- NOTE: 1 wf can only subscribe to 1 function per eventType

wf = hs.window.filter
wf.default:setAppFilter('My IDE',{allowTitles=1}) -- ignore no-title windows (e.g. transient autocomplete suggestions) in My IDE
wf_terminal = wf.new{'Terminal'} -- all visible terminal windows

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

-- Override Command_L press to Ctrl-S for Tmux prefix and Command_R to ',' for Vim prefix in Terminal.app
-- Overrid Option_R to press Ctrl-S for Tmux prefix in Terminal
cmdKeyEvent = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(o)
  local keyCode = o:getKeyCode()
  local modifiers = o:getFlags()

  -- first checks if Command is the only modifier pressed, then checks if Command_L or Command_R is pressed without any other key
  -- keycodes: 58 = Option_L, 61 = Option_R, 54 = COMMAND_R, 55 = Command_L
  if not modifiers['alt'] and not modifiers['shift'] and modifiers['cmd'] and not modifiers['ctrl'] then
    if keyCode == 55 then -- left Command key
      hs.eventtap.keyStroke({"ctrl"}, "s")
      return
    elseif keyCode == 54 then -- right Command key
      hs.eventtap.keyStroke({}, ",")
      return
    end
  end

  -- check if Option_R (WASD keyboard does not have Command_R, so mapping Option_R instead)
  -- keycodes: 58 = Option_L, 61 = Option_R, 54 = COMMAND_R, 55 = Command_L
  if modifiers['alt'] and not modifiers['shift'] and not modifiers['cmd'] and not modifiers['ctrl'] then
    if keyCode == 61 and usingWASD() == true then -- WASD keyboard is connected
      hs.eventtap.keyStroke({}, ",")
      return
    end
  end

  -- stop propagation, perform original key stroke
  return true
end)

wf_terminal:subscribe(wf.windowFocused, function() cmdKeyEvent:start() end)
wf_terminal:subscribe(wf.windowUnfocused, function() cmdKeyEvent:start() end)


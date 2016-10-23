-- Terminal.app keyboard customization

-- TODO: combine altKeyEvent() with cmdKeyEvent() into single function

local wf = hs.window.filter
wf.default:setAppFilter('My IDE',{allowTitles=1}) -- ignore no-title windows (e.g. transient autocomplete suggestions) in My IDE

wf_terminal = wf.new{'Terminal'} -- all visible terminal windows

-- TODO: possibly obsolete
-- Override Alt-key to press Ctrl-S for Tmux prefix in Terminal
altKeyEvent = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(o)
  local keyCode = o:getKeyCode()
  local modifiers = o:getFlags()

  -- check if correct key code
  if keyCode ~= 58 then return end
  if not (modifiers['alt'] and not modifiers['shift'] and not modifiers['cmd'] and not modifiers['ctrl']) then return end

  hs.eventtap.keyStroke({"ctrl"}, "s")

  -- stop propagation
  return true
end)
-- wf_terminal:subscribe(wf.windowFocused, function() altKeyEvent:start() end)
-- wf_terminal:subscribe(wf.windowUnfocused, function() altKeyEvent:stop() end)

-- Override Command_L press to Ctrl-S for Tmux prefix and Command_R to ',' for Vim prefix in Terminal.app
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
    else
      -- do nothing here
    end
  end

  -- stop propagation
  return true
end)
wf_terminal:subscribe(wf.windowFocused, function() cmdKeyEvent:start() end)
wf_terminal:subscribe(wf.windowUnfocused, function() cmdKeyEvent:stop() end)

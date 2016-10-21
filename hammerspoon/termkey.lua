-- Terminal.app keyboard customization

local wf = hs.window.filter
wf.default:setAppFilter('My IDE',{allowTitles=1}) -- ignore no-title windows (e.g. transient autocomplete suggestions) in My IDE

wf_terminal = wf.new{'Terminal'} -- all visible terminal windows

-- TODO: override right-Alt to press ',' in Vim
-- Override Alt-key to press Ctrl-S for Tmux prefix in Terminal
altKeyOverride = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(o)
  local keyCode = o:getKeyCode()
  local modifiers = o:getFlags()

  -- check if correct key code
  if keyCode ~= 58 then return end
  if not (modifiers['alt'] and not modifiers['shift'] and not modifiers['cmd'] and not modifiers['ctrl']) then return end

  -- TODO: implement this to have higher accuracy
  -- check if no other modifiers where pressed
  -- spacesModifiers = {"fn", "cmd", "ctrl", "shift"}
  -- local otherModifiers = hs.fnutils.every(modifiers, function(_, modifier)
  --   return hs.fnutils.contains(spacesModifiers, modifier)
  -- end)
  -- if otherModifiers then return end

  hs.eventtap.keyStroke({"ctrl"}, "s")

  -- stop propagation
  return true
end)

wf_terminal:subscribe(wf.windowFocused, function() altKeyOverride:start() end)
wf_terminal:subscribe(wf.windowUnfocused, function() altKeyOverride:stop() end)

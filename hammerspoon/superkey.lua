-- TODO: remove this file once Karabiner-Elements officially supports Super/Hyper keys
-- References:
-- https://github.com/lodestone/hyper-hacks/blob/master/hammerspoon/init.lua
-- https://gist.github.com/prenagha/1c28f71cb4d52b3133a4bff1b3849c3e
-- https://gist.github.com/ttscoff/cce98a711b5476166792d5e6f1ac5907
-- https://github.com/lodestone/hyper-hacks/blob/master/hammerspoon/init.lua

-- Variable to represent Super key
-- F17 is just a key value that is never used
superModal = hs.hotkey.modal.new({}, "F17", nil)

-- TODO: refactor and add every single key allowed on keyboard
-- Keys allowed to be binded with Super
keys = { '1', '2', 'a', 's', '/', 'w', 'h', 'j', 'k', 'l',
         'c', 'g', 'e', 'f', 'g', 'i', 'm', 'n', 'o', 'q',
         't', 'x', ',', '=', '`', 'tab', 'space', 'delete', 'escape', 'return'
}

-- Map each Capslock + key to emit Cmd+Alt+Ctrl + key
-- WARN: using this approach in order to preserve original hotkey.lua file
for i,key in ipairs(keys) do
  superModal:bind({}, key, nil, function() hs.eventtap.keyStroke({'cmd','alt','ctrl'}, key)
    -- superModal.triggered = true
  end)
end

-- Super keyDown when F18 (Capslock) is pressed
pressedF18 = function()
  superModal.triggered = false
  superModal:enter()
end

-- Super keyUp when F18 (Capslock) is released,
-- send ESCAPE if no other keys are pressed.
releasedF18 = function()
  superModal:exit()

  -- send ESC if no other keys are pressed
  if not superModal.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind Capslock to Super
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18) -- WARN: do not use nil as 3rd param, omit it instead to disable hotkey alert

-- WARN: this does not binding each key to emit cmd+alt+ctrl+key
--       using this approach will require refactoring entire hotkey.lua
-- k:bind({}, 'A', nil, function()
--   focusPreviousWindow()
--   k.triggered = true
-- end)
-- k:bind({}, 'S', nil, function()
--   resizeLeftRightFull()
--   k.triggered = true
-- end)

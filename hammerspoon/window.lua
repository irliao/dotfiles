-- Window management

-- TODO: implement function to use Mac split screen

require("utility")

-- Check if window is maximized (not fullscreen)
function isWindowMaximized(win)
  if not win or win:isFullScreen() then
    return false
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  return f.x == max.x and f.y == max.y and f.w == max.w and f.h == max.h
end

-- Focus window into Left or Right
function focusLeftRight()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win or win:isFullScreen() or isWindowMaximized(win) then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if f.x > (max.w / 2) then -- right -> left
    hs.window.focusedWindow():focusWindowWest()
  else -- left -> right
    hs.window.focusedWindow():focusWindowEast()
  end
end

-- Resize window into Left, Right, or Full
function resizeLeftRightFull()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win or win:isFullScreen() then
    return
  end

  local originalFrame = win:frame()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  -- full -> left half
  if f.x == max.x and f.y == max.y and f.w == max.w and f.h == max.h then
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    -- hs.window.highlight.start()
  else
    -- left -> right
    if f.x == max.x and f.y == max.y then
      f.x = max.x + (max.w / 2)
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
    -- right -> full
    elseif f.x == (max.x + (max.w / 2)) and f.y == max.y then
      f.x = max.x
      f.y = max.y
      f.w = max.w
      f.h = max.h
      -- hs.window.highlight.stop()
    -- other -> left
    else
      f.x = max.x
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
    end
  end

  win:setFrame(f)

  -- resize with setFrameCorrectness if window did not resize correctly due to max.y being below menubar instead of the screen
  if originalFrame.x == f.x and originalFrame.y == f.y and originalFrame.w == f.w and originalFrame.h == f.h then
    hs.alert('Debug: resizing window with setFrameCorrectness')
    hs.window.setFrameCorrectness = true
    win:setFrame(f)
    hs.window.setFrameCorrectness = false -- disable to prevent window wiggling
  end

  centerMouse()
end

-- Resize window into Top, Bottom, or Full
function resizeTopBottomFull()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win or win:isFullScreen() then
    return
  end
  local originalFrame = win:frame()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  -- full -> top half
  if f.x == max.x and f.y == max.y and f.w == max.w and f.h == max.h then
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
  else
    -- top -> bottom
    if f.x == max.x and f.y == max.y then
      f.x = max.x
      f.y = max.y + (max.h / 2)
      f.w = max.w
      f.h = max.h / 2
    -- bottom -> full
    elseif f.y == (max.y + (max.h / 2)) and f.x == max.x then
      f.x = max.x
      f.y = max.y
      f.w = max.w
      f.h = max.h
    -- other -> top
    else
      f.x = max.x
      f.y = max.y
      f.w = max.w
      f.h = max.h / 2
    end
  end

  win:setFrame(f)

  -- resize with setFrameCorrectness if window did not resize correctly due to max.y being below menubar instead of the screen
  if originalFrame.x == f.x and originalFrame.y == f.y and originalFrame.w == f.w and originalFrame.h == f.h then
    hs.alert('Debug: resizing window with setFrameCorrectness')
    hs.window.setFrameCorrectness = true
    win:setFrame(f)
    hs.window.setFrameCorrectness = false -- disable to prevent window wiggling
  end

  centerMouse()
end

-- TODO: refactor functions below to an external file
-- Resize currently focused window in X/Y fashion
-- @param direction - horizontal or vertical
-- @param amount - how much to grow/shrink (positive grows, negative shrinks)
function resizeFocusedWindow(direction, amount)
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = f.w + ((direction == "horizontal") and amount or 0)
  f.h = f.h + ((direction == "vertical") and amount or 0)

  win:setFrame(f)
  centerMouse()
end

-- Center mouse to current frame... should be called AFTER window resized
function centerMouse()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local mousePoint = {
    x = f.x + (f.w / 2),
    y = f.y + (f.h / 2)
  }

  hs.mouse.setRelativePosition(mousePoint, screen)
end

-- Toggle Full Screen
function toggleFullScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local app = win:application()
  if app:name() == 'Terminal' then
    toggleTerminalFullScreen()
  elseif app:name() == 'iTerm2' or app:name() == 'iTerm' then
    toggleiTermFullScreen()
  else
    win:toggleFullScreen()
  end
end

-- Move focused window to next screen if available
function moveToNextScreen()
    local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
    if not win then
      return
    end

    -- TODO: broken, does not toggleFullScreen properly
    -- exit out of fullscreen to move to different screen
    -- local shouldFullScreen = false
    -- if win:isFullScreen() then
    --   shouldFullScreen = true
    --   win:setFullScreen(false)
    --   win:toggleFullScreen()
    -- end

    local prevScreen = win:screen():previous()
    local nextScreen = win:screen():next()
    if nextScreen ~= nil then
        win:moveToScreen(nextScreen)
        centerMouse()
    elseif prevScreen ~= nil then
        win:moveToScreen(prevScreen)
        centerMouse()
    end

    -- TODO: broken, does not toggleFullScreen properly
    -- reenter fullscreen on the new screen
    -- if shouldFullScreen then
    --   win:setFullScreen(true)
    --   win:toggleFullScreen()
    -- end

    -- refocus to show current window even when moved to fullscreened screen
    win:focus()
end

-- open an application that is named -app_name-
function openApplication(app_name)
  local success = hs.application.launchOrFocus(app_name)
  if not success then hs.alert(app_name .. " not found") end
end

-- Focus previously focused window, looping two windows until others get focused
function focusPreviousWindow()
    local visibleWins = hs.window.orderedWindows()
    if visibleWins and visibleWins[2] then
        visibleWins[2]:focus()
    end
end

function centerScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 4)
  f.y = max.y + (max.h / 4)
  f.w = max.w / 2
  f.h = max.h / 2

  win:setFrame(f)
  centerMouse()
end

function hideScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local app = win:application()
  if app and app:hide() then
    centerMouse()
  end
end

function maxScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h

  win:setFrame(f)
  centerMouse()
end

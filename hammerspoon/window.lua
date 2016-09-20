-- Window manipulation

-- TODO: implement function to go FullScreen + join another FullScreen space (if exists) to create split FullScreen

-- Check if window is maximized
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
  centerMouse()
end

-- Resize window into Top, Bottom, or Full
function resizeTopBottomFull()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win or win:isFullScreen() then
    return
  end
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

-- App watcher for Activate and Launch events
function applicationWatcher(appName, eventType, appObject)
    -- Activated Apps
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            appObject:selectMenuItem({"Window", "Bring All to Front"})
            -- centerScreen()
        end
    end

    -- Launched Apps
    if (eventType == hs.application.watcher.launched) then
        if (appName == "Finder") then
            -- centerScreen()
        elseif (appName == "Terminal") then
            openTerminalFullScreen()
        elseif (appName == "iTerm2") then
            openiTermFullScreen()
        else
            maxScreen()
        end
    end
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
  elseif app:name() == 'iTerm2' then
    toggleiTermFullScreen()
  else
    win:toggleFullScreen()
  end
  centerMouse()
end

-- Move focused window to next screen if available
function moveToNextScreen()
    local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
    if not win or win:isFullScreen() then
      return
    end
    local prevScreen = win:screen():previous()
    local nextScreen = win:screen():next()
    if prevScreen ~= nil then
        win:moveToScreen(prevScreen)
        centerMouse()
    elseif nextScreen ~= nil then
        win:moveToScreen(nextScreen)
        centerMouse()
    else
        sendNotif('Screen', 'No Screen to Move to')
    end
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

function leftScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h

  win:setFrame(f)
  -- windowHighlight()
  centerMouse()
end

function rightScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h

  win:setFrame(f)
  centerMouse()
end

function topScreen()
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
  f.h = max.h / 2

  win:setFrame(f)
  centerMouse()
end

function bottomScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2

  win:setFrame(f)
  centerMouse()
end

function rightBottomScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2

  win:setFrame(f)
  centerMouse()
end

function rightTopScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2

  win:setFrame(f)
  centerMouse()
end

function leftBottomScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2

  win:setFrame(f)
  centerMouse()
end

function leftTopScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2

  win:setFrame(f)
  centerMouse()
end

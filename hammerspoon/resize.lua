-- Resize Window Screens

-- App watcher for Activate and Launch events
function applicationWatcher(appName, eventType, appObject)
    local terminalScript = [[
    tell application "System Events"
        tell process "Terminal"
            click menu item "Enter Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists
        end tell
    end tell
    ]]

    local safariScript = [[
    tell application "System Events"
        tell process "Safari"
            click menu item "Enter Full Screen" of menu 1 of menu bar item "View" of menu bar 1 exists
        end tell
    end tell
    ]]

    -- Activated Apps
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            appObject:selectMenuItem({"Window", "Bring All to Front"})
            centerScreen()
        end
    end

    -- Launched Apps
    if (eventType == hs.application.watcher.launched) then
        maxScreen()
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
  else
    win:toggleFullScreen()
  end
  eraseHighlight()
end

-- Move focused window to next screen if available
function moveToNextScreen() 
    local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow()) 
    local prevScreen = win:screen():previous()
    local nextScreen = win:screen():next()
    if prevScreen ~= nil then
        win:moveToScreen(prevScreen)
        windowHighlight()
    elseif nextScreen ~= nil then
        win:moveToScreen(nextScreen)
        windowHighlight()
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
        windowHighlight()
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
  eraseHighlight()
end

function hideScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow()) 
  if not win then 
    return 
  end
  local app = win:application()
  if app and app:hide() then
    eraseHighlight()
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
  eraseHighlight()
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
  windowHighlight()
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
  windowHighlight()
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
  windowHighlight()
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
  windowHighlight()
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
  windowHighlight()
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
  windowHighlight()
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
  windowHighlight()
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
  windowHighlight()
end

-- EOF
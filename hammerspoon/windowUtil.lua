-- Window management

require("utility")

local module = {}

function hideAllWindows()
  hs.fnutils.each(hs.window.allWindows(), function(window)
   if window then
     window:minimize()
   end
  end)
end

function focusWindowAtDirection(direction)
  if #hs.window.visibleWindows() > 1 then
    if direction == "left" then
      hs.window.focusedWindow():focusWindowWest(nil, true, false)
    elseif direction == "right" then
      hs.window.focusedWindow():focusWindowEast(nil, true, false)
    else
      hs.alert("ERROR: please specify direction (left/right) of window to focus")
    end
  end
end

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

function resizeFocusedWindowToSize(x, y, w, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = x
  f.y = y
  f.w = w
  f.h = h
  win:setFrame(f)
end

function resizeFocusedWindowTo(direction)
    local max = hs.window.focusedWindow():screen():frame()
    if direction == "center" then
      resizeFocusedWindowToSize(max.x, max.y, max.w, max.h)
    elseif direction == "middle" then
      resizeFocusedWindowToSize(max.x + (max.w / 3), max.y, max.w / 3, max.h)
    elseif direction == "left" then
      resizeFocusedWindowToSize(max.x, max.y, max.w / 2, max.h)
    elseif direction == "right" then
      resizeFocusedWindowToSize(max.x + (max.w / 2), max.y, max.w / 2, max.h)
    elseif direction == "top" then
      resizeFocusedWindowToSize(max.x, max.y, max.w, max.h / 2)
    elseif direction == "bottom" then
      resizeFocusedWindowToSize(max.x, max.y + (max.h / 2), max.w, max.h / 2)
    elseif direction == "top-left" then
      resizeFocusedWindowToSize(max.x, max.y, max.w / 2, max.h / 2)
    elseif direction == "top-right" then
      resizeFocusedWindowToSize(max.x + (max.w / 2), max.y, max.w / 2, max.h / 2)
    elseif direction == "bottom-left" then
      resizeFocusedWindowToSize(max.x, max.y + (max.h / 2), max.w / 2, max.h / 2)
    elseif direction == "bottom-right" then
      resizeFocusedWindowToSize(max.x + (max.w / 2), max.y + (max.h / 2), max.w, max.h / 2)
    else
      hs.alert("ERROR: please specify direction (center|left|right|top|bottom|diagonal) of window to resize to")
    end
end

-- Toggle Full Screen
function toggleFullScreen()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    -- TODO: add WARN debug logging
    return
  end

  win:toggleFullScreen()
end

-- Move focused window to next screen if available
function moveWindowToScreen(screen)
    local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
    if not win then
      return
    end

    local screenTable = {
      ["prev"] = win:screen():previous(),
      ["next"] = win:screen():next(),
    }
    local screenDestination = screenTable[screen]

    if not screenDestination then
      hs.alert("ERROR: please specify Screen (prev/next) to switch Window to")
      return
    end

    win:moveToScreen(screenDestination)
    win:focus() -- refocus to show current window even when moved to fullscreened screen
end

-- Open application with name
function openApplication(app_name)
  local success = hs.application.launchOrFocus(app_name)
  if not success then
    hs.alert("ERROR: " .. app_name .. " not found")
  end
end

return module

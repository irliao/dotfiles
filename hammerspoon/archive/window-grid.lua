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

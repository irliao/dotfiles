-- Window filter

-- NOTE: window filter is shared by entire app, so subscribing to the same event twice
--       will only use the most recent change, even if its a filter for different Apps

local module = {}
local wf = hs.window.filter -- window filter copy shared by entire app

fixSpotlightPosition = function()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  -- not changing f.w and f.h since Spotlight's w/h can't be modified
  f.x = max.x + (max.w / 4)
  f.y = max.y + (max.h / 6)

  win:setFrame(f)
end

wf_spotlight = wf.new'Spotlight'
wf_spotlight:subscribe(wf.windowVisible, fixSpotlightPosition)


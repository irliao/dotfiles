-- Window filter

-- NOTE: window filter is shared by entire app, so subscribing to the same event twice
--       will only use the most recent change, even if its a filter for different Apps

-- local module = {}
-- local wf = hs.window.filter -- window filter copy shared by entire app

fixSpotlightPosition = function()
  local spotlightWindow = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not spotlightWindow then
    return
  end
  local spotlightFrame = spotlightWindow:frame()
  local screen = spotlightWindow:screen() -- screen the spotlight window is on
  local screenFrame = screen:frame()

  -- not changing f.w and f.h since Spotlight's w/h can't be modified
  spotlightFrame.x = (screenFrame.w / 2) - (spotlightFrame.w / 2)
  spotlightFrame.y = screenFrame.y + (screenFrame.h / 6)

  spotlightWindow:setFrame(spotlightFrame)
end

local wf_spotlight = hs.window.filter.new'Spotlight'
wf_spotlight:subscribe(hs.window.filter.windowVisible, fixSpotlightPosition)

return wf_spotlight

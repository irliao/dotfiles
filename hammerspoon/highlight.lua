-- Window focus highlight

-- TODO: integrate this
-- nofs_wf=hs.window.filter.new():setOverrideFilter{fullscreen=false}

-- TODO: handle multiple screens
function toggleWindowHighlight()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win or win:isFullScreen() or isWindowMaximized(win) then
    hs.window.highlight.stop()
  else
    hs.window.highlight.start()
  end
end

wf_highlight = hs.window.filter.new()
hs.window.highlight.ui.overlay=true
hs.window.highlight.ui.overlayColor = {0,0,0,0.25} -- gray
hs.window.highlight.ui.frameWidth = 5
hs.window.highlight.ui.frameColor = {1,0.9,0,0.5} -- yellow
hs.window.highlight.ui.flashDuration= 0

-- TODO: handle existing corner cases, ex: overlay for unfocused windows is short on height
-- wf_highlight:subscribe(hs.window.filter.windowFocused, toggleWindowHighlight)
-- wf_highlight:subscribe(hs.window.filter.windowUnfocused, function() hs.window.highlight.stop() end) -- TODO: test this



-- Window focus highlight

function toggleWindowHighlight()
  local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow())
  if not win or win:isFullScreen() or isWindowMaximized(win) then
    hs.window.highlight.stop()
  else
    hs.window.highlight.start()
  end
end

wf_highlight = hs.window.filter.new()
hs.window.filter.ignoreAlways['Spotlight']=true -- prevent wfilter warnings from windowHighlight
hs.window.filter.ignoreAlways['Hammerspoon']=true
hs.window.highlight.ui.overlay=true
hs.window.highlight.ui.flashDuration=0
hs.window.highlight.ui.overlayColor = {0,0,0,0.5} -- black, transparent
hs.window.highlight.ui.frameWidth = 5
hs.window.highlight.ui.frameColor = {1,0.9,0,0.8} -- yellow
wf_highlight:subscribe(hs.window.filter.windowFocused, toggleWindowHighlight)


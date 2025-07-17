-- Window Switcher
-- modified from original: https://github.com/Hammerspoon/hammerspoon/issues/856

local module = {}
module.focusedAppWins = {}
module.windowCycler = nil

local showThumbnails = false
local showSelectedThumbnail = false

local focusedAppWindowFilter = hs.window.filter.new(function(win)
  local focusedWindow = hs.window.focusedWindow()
  return focusedWindow ~= nil and win:isStandard() and win:application() == focusedWindow:application() -- check win:isStandard() to exclude minimized windows
end):setCurrentSpace(true):setDefaultFilter{}


local switcher = hs.window.switcher.new(focusedAppWindowFilter)
switcher.ui.fontname = 'Lucida Grande'
switcher.ui.textSize = 10
switcher.ui.textColor = {0.9, 0.9, 0.9}
switcher.ui.titleBackgroundColor = {0, 0, 0, 0}
-- switcher.ui.highlightColor = {0, 0.49, 1, 0.5} -- for selected window
switcher.ui.highlightColor = {0.78, 0.86, 0.94, 0.8} -- for selected window (latest mac highlight selection color?)
-- switcher.ui.backgroundColor = {0.3, 0.3, 0.3, 0.5, 0.0}
switcher.ui.backgroundColor = {0.0, 0.0, 0.0, 0.9}

-- enabling this requires screen recording permission for Hammerspoon
switcher.ui.showThumbnails = showThumbnails
if showThumbnails then
  switcher.ui.thumbnailSize = 112
end
switcher.ui.showSelectedThumbnail = showSelectedThumbnail
if showSelectedThumbnail then
  switcher.ui.selectedThumbnailSize = 284
  switcher.ui.showSelectedTitle = true -- show larger title for selected window
end

function module:focusPreviousWindow()
  switcher:previous()
end

function module:focusNextWindow()
  switcher:next()
end

module.switcher = switcher

return module

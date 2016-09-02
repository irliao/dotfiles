-- Window Switcher

-- All apps on app spaces
wf_all = hs.window.filter.new() -- only visible windows, all Spaces
uiPrefsAll = {
  fontName = 'Hack',
  textSize = 12,
  highlightColor = {0,0,0,0},
  backgroundColor = {0,0,0,0},
  onlyActiveApplication = false,
  showTitles = false,
  showThumbnails = true,
  thumbnailSize = 150,
  showSelectedThumbnail = false,
  showSelectedTitle = false
}
switcher_all = hs.window.switcher.new(wf_all, uiPrefsAll)

-- Only active apps in current space
wf_active_app = hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{} -- include minimized/hidden windows, current Space only
uiPrefsActiveApp = {
  fontName = 'Hack',
  textSize = 12,
  highlightColor= {1,0.9,0,0.8},
  backgroundColor = {0.3,0.3,0.3,1},
  onlyActiveApplication = true,
  showTitles = true,
  showThumbNails = false, -- screen as icon
  thumbnailSize = 150,
  showSelectedThumbnail = false, -- screen as popup background
  showSelectedTitle = false

}
switcher_active_app = hs.window.switcher.new(wf_active_app, uiPrefsActiveApp) -- include minimized/hidden windows, current Space only

-- switcher = hs.window.switcher.new{'Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)

-- Window Switcher

-- TODO: look into hs.tabs.tabWindows(app)

-- Only windows from focused app
wf_focused_apps = hs.window.filter.new(function(win)
  local fw = hs.window.focusedWindow()
  return (
    win:isStandard() and
    win:application() == fw:application()
    -- win:screen() == fw:screen() -- only windows on focused screen
  )
end)
uiPrefsFocusedApp = {
  fontName = 'Hack',
  textSize = 13,
  highlightColor= {1,0.9,0,0.8},
  backgroundColor = {0.1,0.1,0.1,1},
  onlyActiveApplication = true,
  showTitles = true,
  showThumbNails = false, -- screen as icon
  thumbnailSize = 150,
  showSelectedThumbnail = false, -- screen as popup background
  selectedThumbnail = 200,
  showSelectedTitle = true
}
switcher_focused_apps = hs.window.switcher.new(wf_focused_apps, uiPrefsFocusedApp) -- include minimized/hidden windows, current Space only

-- All windows, activate with Option + Tab
wf_all_apps = hs.window.filter.new() -- only visible windows, all Spaces
uiPrefsAll = {
  fontName = 'Hack',
  textSize = 13,
  highlightColor= {1,0.9,0,0.8},
  backgroundColor = {0.1,0.1,0.1,1},
  onlyActiveApplication = false,
  showTitles = false,
  showThumbnails = true,
  thumbnailSize = 100,
  showSelectedThumbnail = true,
  selectedThumbnail = 200,
  showSelectedTitle = false
}
switcher_all_apps = hs.window.switcher.new(wf_all_apps, uiPrefsAll)

-- Only windows in active space, activate with Caps + Tab
wf_active_space_apps = hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{} -- include minimized/hidden windows, current Space only
uiPrefsActiveApp = {
  fontName = 'Hack',
  textSize = 13,
  highlightColor= {1,0.9,0,0.8},
  backgroundColor = {0.1,0.1,0.1,1},
  onlyActiveApplication = true,
  showTitles = true,
  showThumbNails = false, -- screen as icon
  thumbnailSize = 150,
  showSelectedThumbnail = false, -- screen as popup background
  selectedThumbnail = 200,
  showSelectedTitle = true
}
switcher_active_space_apps = hs.window.switcher.new(wf_active_space_apps, uiPrefsActiveApp) -- include minimized/hidden windows, current Space only

-- switcher = hs.window.switcher.new{'Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)

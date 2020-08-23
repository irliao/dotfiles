-- Window Switcher
-- modified from original: https://github.com/Hammerspoon/hammerspoon/issues/856

local module = {}
module.focusedAppWins = {}
module.windowCycler = nil

local focusedAppWindowFilter = hs.window.filter.new(function(win)
    local focusedWin = hs.window.focusedWindow()
    return (
      win:isStandard() and
      win:application() == focusedWin:application() and
      win:screen() == focusedWin:screen()
    )
  end)

local function makeTableCycler(t)
  local i = 1
  return function(d)
    local j = d and d < 0 and -2 or 0
    i = (i + j) % #t + 1
    local x = t[i]
    return x
  end
end

-- explicity passing self instead of colon notation so we can make function local
-- NOTE: self is a variable, not a keyword in Lua, so self is automatically passed in via arg1 when using colon notation
local function updateWindowCycler(self)
  if not hs.fnutils.contains(self.focusedAppWins, hs.window.focusedWindow()) then
    self.focusedAppWins = focusedAppWindowFilter:getWindows()
    self.windowCycler = makeTableCycler(self.focusedAppWins)
  end
end

-- module.focusPreviousWindow = function()
function module:focusPreviousWindow()
    updateWindowCycler(self)
    self.windowCycler():focus()
end

-- module.focusNextWindow = function()
function module:focusNextWindow()
    updateWindowCycler(self)
    self.windowCycler(-1):focus()
end

return module

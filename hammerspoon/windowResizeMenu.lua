-- Drop down in menu bar to resize windows to the corner (less commonly used resizes)

local windowUtil = require("windowUtil")

local module = {}

module.menubar = hs.menubar.new() -- menubar icon

if module.menubar then
  module.menubar:setIcon("assets/win_menubar_icon.png")
  module.menubar:setMenu(
  {
    { title = "Middle", image = hs.image.imageFromPath("assets/win_middle.png"), fn = function() resizeFocusedWindowTo("middle") end },
    { title="TopLeft", image = hs.image.imageFromPath("assets/win_top_left.png"), fn = function() resizeFocusedWindowTo("top-left") end },
    { title = "TopRight", image = hs.image.imageFromPath("assets/win_top_right.png"), fn = function() resizeFocusedWindowTo("top-right") end },
    { title = "BottomLeft", image = hs.image.imageFromPath("assets/win_bottom_left.png"), fn = function() resizeFocusedWindowTo("bottom-left") end },
    { title = "BottomRight", image = hs.image.imageFromPath("assets/win_bottom_right.png"), fn = function() resizeFocusedWindowTo("bottom-right") end },
  })
end

return module


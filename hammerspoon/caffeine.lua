-- Caffeine in menu bar

-- Toggle binded to caffeine icon on menu bar
local module = {}
module.menubar = hs.menubar.new() -- menubar icon

function setCaffeineDisplay(state)
    if state then
        module.menubar:setIcon("assets/caffeine_on.pdf")
    else
        module.menubar:setIcon("assets/caffeine_off.pdf")
    end
end

function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if module.menubar then
  module.menubar:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- Enable caffeine by default
caffeineClicked()

return module


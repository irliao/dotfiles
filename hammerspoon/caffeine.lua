-- Caffeine in menu bar

-- Toggle binded to caffeine icon on menu bar
local caffeineMenubar = hs.menubar.new() -- menubar icon

-- Click action listener
function caffeineToggle()
    hs.caffeinate.toggle("system")
    if hs.caffeinate.get("system") then
        hs.caffeinate.set("displayIdle", true, true) -- set(sleepType, canSleep, whenOnBattery AND whenOnAC)
        hs.caffeinate.set("systemIdle", true, true)
        caffeineMenubar:setIcon("assets/caffeine_on.pdf")
    else
        hs.caffeinate.set("displayIdle", false, true)
        hs.caffeinate.set("systemIdle", false, true)
        caffeineMenubar:setIcon("assets/caffeine_off.pdf")
    end
end
caffeineMenubar:setClickCallback(caffeineToggle)

-- Default caffeine to ON
caffeineToggle()

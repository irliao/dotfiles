-- Unused code saved for archiving

------------------------------------------------------------------------
-- *** If using this, save and import this snippet as undo.lua
-- Undo window changes such as move and resize
local undo = {
    stack = {},
    stackMax = 100,
    skip = false
}

-- Call right BEFORE the window change to save needed window states
function undo:addToStack(wins)
    if self.skip then return end
    if not wins then wins = { hs.window.focusedWindow() } end
    local size = #self.stack
    self.stack[size + 1] = self:getCurrentWindowsLayout(wins)
    size = size + 100
    if size > self.stackMax then
        for i = 1, size - self.stackMax do
            self.stack[1] = nil
        end
    end
end

function undo:undo()
    local size = #self.stack
    if size > 0 then
        local status = self.stack[size]
        for w, f in pairs(status) do 
            if w and f and w:isVisible() and w:isStandard() and w:id() then
                if not compareFrame(f, w:frame()) then
                    w:setFrame(f)
                end
            end
        end
        self.stack[size] = nil
    else
        -- sendNotif inher ited from init.lua
        sendNotif('Window', 'No More Changes to Undo')
    end
end

function undo:getCurrentWindowsLayout(wins)
    if not wins then wins = { hs.window.focusedWindow() } end
    local current = {}
    for i = 1, #wins do
        local w = wins[i]
        local f = w:frame()
        if w:isVisible() and w:isStandard() and w:id() and f then
            current[w] = f
        end
    end
    return current
end

function compareFrame(t1, t2)
    if t1 == t2 then return true end
    if t1 and t2 then
        return t1.x == t2.x and t1.y == t2.y and t1.w == t2.w and t1.h == t2.h
    end
    return false
end

return undo
------------------------------------------------------------------------------

-- Focus window in reverse order
focusStack = {}
function push_focus() 
    local win = hs.window.focusedWindow()
    local size = #focusStack
    if focusStack[size + 1] ~= win then
        focusStack[size + 1] = win
    end
end

function pop_focus()
    local size = #focusStack
    if size > 1 then
        local last = focusStack[size - 1]
        focusStack[size] = nil
        focusStack[size - 1] = nil
        last:focus()
    else 
        sendNotif('Window', 'No more Windows to Refocus')
    end
end

-- Return true if screen and window's screen is equivalent
function windowInScreen(screen, win)
  return win:screen() == screen
end

-- TODO: refactor this to work
-- Draw little text/dot pairs in the bottom right corner of the primary display, to indicate firewall/backup status of my machine
function renderStatuslets()
    -- if (hostname ~= "pixukipa") then
    --     return
    -- end
    -- Destroy existing Statuslets
    if firewallStatusText then firewallStatusText:delete() end
    if firewallStatusDot then firewallStatusDot:delete() end
    if cccStatusText then cccStatusText:delete() end
    if cccStatusDot then cccStatusDot:delete() end
    if arqStatusText then arqStatusText:delete() end
    if arqStatusDot then arqStatusDot:delete() end

    -- Defines for statuslets - little coloured dots in the corner of my screen that give me status info, see:
    -- https://www.dropbox.com/s/3v2vyhi1beyujtj/Screenshot%202015-03-11%2016.13.25.png?dl=0
    local initialScreenFrame = hs.screen.allScreens()[1]:fullFrame()

    -- Start off by declaring the size of the text/circle objects and some anchor positions for them on screen
    local statusDotWidth = 10
    local statusTextWidth = 30
    local statusTextHeight = 15
    local statusText_x = initialScreenFrame.x + initialScreenFrame.w - statusDotWidth - statusTextWidth
    local statusText_y = initialScreenFrame.y + initialScreenFrame.h - statusTextHeight
    local statusDot_x = initialScreenFrame.x + initialScreenFrame.w - statusDotWidth
    local statusDot_y = statusText_y

    -- Now create the text/circle objects using the sizes/positions we just declared (plus a little fudging to make it all align properly)
    firewallStatusText = hs.drawing.text(hs.geometry.rect(statusText_x + 5,
                                                          statusText_y - (statusTextHeight*2) + 2,
                                                          statusTextWidth,
                                                          statusTextHeight), "FW:")
    cccStatusText = hs.drawing.text(hs.geometry.rect(statusText_x,
                                                     statusText_y - statusTextHeight + 1,
                                                     statusTextWidth,
                                                     statusTextHeight), "CCC:")
    arqStatusText = hs.drawing.text(hs.geometry.rect(statusText_x + 4,
                                                     statusText_y,
                                                     statusTextWidth,
                                                     statusTextHeight), "Arq:")

    firewallStatusDot = hs.drawing.circle(hs.geometry.rect(statusDot_x,
                                                           statusDot_y - (statusTextHeight*2) + 4,
                                                           statusDotWidth,
                                                           statusDotWidth))
    cccStatusDot = hs.drawing.circle(hs.geometry.rect(statusDot_x,
                                                      statusDot_y - statusTextHeight + 3,
                                                      statusDotWidth,
                                                      statusDotWidth))
    arqStatusDot = hs.drawing.circle(hs.geometry.rect(statusDot_x,
                                                      statusDot_y + 2,
                                                      statusDotWidth,
                                                      statusDotWidth))

    -- Finally, configure the rendering style of the text/circle objects, clamp them to the desktop, and show them
    firewallStatusText:setBehaviorByLabels({"canJoinAllSpaces", "stationary"}):setTextSize(11):sendToBack():show(0.5)
    cccStatusText:setBehaviorByLabels({"canJoinAllSpaces", "stationary"}):setTextSize(11):sendToBack():show(0.5)
    arqStatusText:setBehaviorByLabels({"canJoinAllSpaces", "stationary"}):setTextSize(11):sendToBack():show(0.5)

    firewallStatusDot:setBehaviorByLabels({"canJoinAllSpaces", "stationary"}):setFillColor(hs.drawing.color.osx_yellow):setStroke(false):sendToBack():show(0.5)
    cccStatusDot:setBehaviorByLabels({"canJoinAllSpaces", "stationary"}):setFillColor(hs.drawing.color.osx_yellow):setStroke(false):sendToBack():show(0.5)
    arqStatusDot:setBehaviorByLabels({"canJoinAllSpaces", "stationary"}):setFillColor(hs.drawing.color.osx_yellow):setStroke(false):sendToBack():show(0.5)
end

-- Utilities

-- Focusing Finder will bring all its windows to front of display
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            -- Bring all Finder windows forward when one gets activated
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end
end
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- Monitors WiFi for disconnection
function wifiDisconnectCallback()
    local wifi = hs.wifi.currentNetwork()

    if not wifi then
        prevWifi = wifi
        sendNotif('Network', 'WiFi Disconnected')
    elseif prevWifi ~= wifi then
        prevWifi = wifi
        sendNotif('Network', ('WiFi Connected: ' .. wifi))
    end

end
wifiWatcher = hs.wifi.watcher.new(wifiDisconnectCallback)
wifiWatcher:start()

function focusPreviousScreen()
  local previous = hs.window.focusedWindow():screen():previous()
end

-- Helper function of layoutVertical()
function setVerticalLayout(win_left, win_right, screen_name)
    if screen_name == nil then screen_name = hs.screen.allScreens()[1]:name() end
    local windowLayout = {
        {win_left:application():name(), nil, laptopScreen, hs.layout.left50, nil, nil},
        {win_right:application():name(), nil, laptopScreen, hs.layout.right50, nil, nil}
    }
    hs.layout.apply(windowLayout)
    saved.winLeft = win_left
    saved.wnRight = win_right
    saved.winLeft:focus()
    drawBorder()
end

-- Set two frontmost windows to layout vertically, auto focus left window
function layoutVertical()
    clearBeforeChange()
    saved.win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow()) 
    saved.winframe = saved.win:frame()
    undo:addToStack()

    if not saved.win:isFullScreen() then
        local frontMostWindows = hs.window.orderedWindows()
        if frontMostWindows ~= nil and #frontMostWindows > 1 then
            for i, win in ipairs(frontMostWindows) do
                if i ~= 1 and frontMostWindows[1]:screen() == win:screen() then
                    saved.win = frontMostWindows[1]
                    saved.winframe = saved.win:frame()
                    local winGrid = hs.grid.get(win)
                    local savedWinGrid = hs.grid.get(saved.win)
                    if ((winGrid.x == 0 and winGrid.y == 0 and winGrid.w == 1 and winGrid.h == 2) and -- swap right to left
                       (savedWinGrid.x == 1 and savedWinGrid.y == 0 and savedWinGrid.w == 1 and savedWinGrid.h == 2)) then
                        setVerticalLayout(saved.win, win, nil)
                    elseif ((winGrid.x == 1 and winGrid.y == 0 and winGrid.w == 1 and winGrid.h == 2) and -- swap left to right
                           (savedWinGrid.x == 0 and savedWinGrid.y == 0 and savedWinGrid.w == 1 and savedWinGrid.h == 2)) then
                        setVerticalLayout(win, saved.win, nil)
                    else -- set left/right
                        setVerticalLayout(saved.win, win, nil)
                    end
                    return
                end
            end
        end
    end
end

----------------------------------------------------------------
-- Debug utilities

-- Debug utility to fix issues when menubar takes up screen space
function toggleFrameCorrectness() 
    isFrameCorrectness = (not isFrameCorrectness) 
    hs.window.setFrameCorrectness = isFrameCorrectness
    sendNotif('Debug', "FrameCorrectness: " .. (isFrameCorrectness and "ON" or "OFF"))
end

-- Run this in Hammerspoon Console if hs.window.orderedWindows() errors:
hs.fnutils.each(hs.application.runningApplications(), function(app) 
  if not app.visibleWindows then 
    print(app) 
  end 
end)

-- Utility for window debugging
function getAllValidWindows ()
    local allWindows = hs.window.allWindows()
    local windows = {}
    local index = 1
    for i = 1, #allWindows do
        local w = allWindows[i]
        if w:screen() then
            windows[index] = w
            index = index + 1
        end
    end
    return windows
end

---------------------------------------------------------------
-- *** Obsolete due to newer Hammerspoon core implementation
borderColor={["red"]=250,["green"]=250,["blue"]=0,["alpha"]=1} -- {["red"]=250,["green"]=0,["blue"]=0,["alpha"]=1} -- red
local border = nil -- drawn border around focused window
-- Draw border around focused window
function windowHighlight()
    eraseHighlight()
    local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow()) 
    if win == nil or win:isFullScreen() or win:isMinimized() or (not win:isStandard()) or (not win:isVisible()) then 
        return
    end

    local f = win:frame()
    local fx = f.x - 0
    local fy = f.y - 0
    local fw = f.w + 0
    local fh = f.h + 0

    border = hs.drawing.rectangle(hs.geometry.rect(fx, fy, fw, fh))
    border:setStrokeWidth(5)
    border:setStrokeColor(borderColor)
    border:setRoundedRectRadii(5.0, 5.0)
    border:setStroke(true):setFill(false)
    border:setLevel("floating")
    border:show()
end

-- Erase border from drawBorder()
function eraseHighlight()
    if border then 
        border:delete() 
    end
end
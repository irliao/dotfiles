-- Watcher for various events

require("utility")

-- Application watcher for Activate and Launch events
function applicationWatcher(appName, eventType, appObject)
    -- Activated Apps
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            appObject:selectMenuItem({"Window", "Bring All to Front"})
            -- centerScreen()
        end
    end

    -- Launched Apps
    if (eventType == hs.application.watcher.launched) then
        if (appName == "Finder") then
            -- centerScreen()
        elseif (appName == "Terminal") then
            openTerminalFullScreen()
        elseif (appName == "iTerm2") then
            openiTermFullScreen()
        else
            maxScreen()
        end
    end
end

local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

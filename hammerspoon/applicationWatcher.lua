-- Application Watcher

local module = {}
module.logger = hs.logger.new('applicationWatcher.lua')

-- NOTE: Use local function for any internal funciton not exported (not included as a part of the return)
local function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            appObject:selectMenuItem({"Window", "Bring All to Front"}) -- Bring all Finder windows forward when one gets activated
        end
    end
end
module.watcher = hs.application.watcher.new(applicationWatcher)

module.start = function()
  module.logger.i("Starting Application Watcher")
  module.watcher:start()
  return module
end

module.stop = function()
  module.logger.i("Stopping Application Watcher")
  module.watcher:stop()
  return module
end

return module

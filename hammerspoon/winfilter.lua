-- Window filter

-- NOTE: window filter is shared by entire app, so subscribing to the same event twice
--       will only use the most recent change, even if its a filter for different Apps

local module = {}
local wf = hs.window.filter -- window filter copy shared by entire app

wf_spotlight = wf.new'Spotlight'
wf_spotlight:subscribe(wf.windowVisible,centerScreen)


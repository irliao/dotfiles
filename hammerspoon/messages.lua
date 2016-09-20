local coffeeShopWifi = "Baristartisan_Guest"
local lastSSID = hs.wifi.currentNetwork()
local wifiWatcher = nil

function ssidChanged()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == coffeeShopWifi and lastSSID ~= coffeeShopWifi then
        -- We have arrived at the coffee shop
        hs.messages.iMessage("iphonefriend@hipstermail.com", "Hey! I'm at Baristartisan's, come join me!")
        hs.messages.SMS("+1234567890", "Hey, you don't have an iPhone, but you should still come for a coffee")
    end
end

wifiWatcher = hs.wifi.watcher.new(ssidChanged)
wifiWatcher:start()

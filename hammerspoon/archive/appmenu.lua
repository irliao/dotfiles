function cycle_safari_agents()
    hs.application.launchOrFocus("Safari")
    local safari = hs.appfinder.appFromName("Safari")

    local str_default = {"Develop", "User Agent", "Default (Automatically Chosen)"}
    local str_ie10 = {"Develop", "User Agent", "Internet Explorer 10.0"}
    local str_chrome = {"Develop", "User Agent", "Google Chrome — Windows"}

    local default = safari:findMenuItem(str_default)
    local ie10 = safari:findMenuItem(str_ie10)
    local chrome = safari:findMenuItem(str_chrome)

    if (default and default["ticked"]) then
        safari:selectMenuItem(str_ie10)
        hs.alert.show("IE10")
    end
    if (ie10 and ie10["ticked"]) then
        safari:selectMenuItem(str_chrome)
        hs.alert.show("Chrome")
    end
    if (chrome and chrome["ticked"]) then
        safari:selectMenuItem(str_default)
        hs.alert.show("Safari")
    end
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, '7', cycle_safari_agents)

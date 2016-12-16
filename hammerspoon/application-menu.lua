-- Application menu interactions

function cycle_safari_agents()
    hs.application.launchOrFocus("Safari")
    local safari = hs.appfinder.appFromName("Safari")

    local str_default = {"Develop", "User Agent", "Default (Automatically Chosen)"}
    local str_chrome = {"Develop", "User Agent", "Google Chrome — Mac"}
    local str_firefox = {"Develop", "User Agent", "Firefox — Mac"}

    local default = safari:findMenuItem(str_default)
    local chrome = safari:findMenuItem(str_chrome)
    local firefox = safari:findMenuItem(str_firefox)

    if (default and default["ticked"]) then
        safari:selectMenuItem(str_chrome)
        hs.alert.show("Chrome")
    end
    if (chrome and chrome["ticked"]) then
        safari:selectMenuItem(str_firefox)
        hs.alert.show("Firefox")
    end
    if (firefox and firefox["ticked"]) then
        safari:selectMenuItem(str_default)
        hs.alert.show("Safari")
    end
end

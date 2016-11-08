-- Safari Utilities

-- Safari Vim shortcuts, to be used with Vim extensions such as Vimmy
hs.hotkey.bind({"shift"}, ';', function()
    local app = hs.application.frontmostApplication()
    local element = hs.uielement.focusedElement():role()
    if (app:name() == "Safari" or app:name() == "Safari Technology Preview") and not string.find(element, "Text") then
        hs.eventtap.keyStroke({"cmd"}, "l")
    else
        hs.eventtap.keyStrokes(':')
    end
end)
hs.hotkey.bind({}, '/', function()
    local app = hs.application.frontmostApplication()
    local element = hs.uielement.focusedElement():role()
    if (app:name() == "Safari" or app:name() == "Safari Technology Preview") and not string.find(element, "Text") then
        hs.eventtap.keyStroke({"cmd"}, "f")
    else
        hs.eventtap.keyStrokes('/')
    end
end)

-- Open Safari Extension Builder
function openSafariExtensionBuilder()
    script = [[
    activate application "Safari"
    tell application "System Events"
        tell process "Safari"
            click menu item "Show Extension Builder" of menu 1 of menu bar item "Develop" of menu bar 1
        end tell
    end tell
    ]]
    hs.applescript(script)
end

-- Open Safari Technology Preview's Extension Builder
function openSafariTechExtensionBuilder()
    script = [[
    activate application "Safari Technology Preview"
    tell application "System Events"
        tell process "Safari Technology Preview"
            click menu item "Show Extension Builder" of menu 1 of menu bar item "Develop" of menu bar 1
        end tell
    end tell
    ]]
    hs.applescript(script)
end

-- Types the current URL of Safari
function copyCurrentSafariURL()
    script = [[
    tell application "Safari"
        set currentURL to URL of document 1
    end tell
    return currentURL
    ]]
    ok, result = hs.applescript(script)
    if (ok) then
        -- hs.eventtap.keyStrokes(result) -- type the result
        hs.pasteboard.setContents(result)
        sendNotif('Clipboard', 'Copied current URL of Safari')
    end
end

-- Types the current URL of Safari Technology Preview
function copyCurrentSafariTechURL()
    script = [[
    tell application "Safari Technology Preview"
        set currentURL to URL of document 1
    end tell
    return currentURL
    ]]
    ok, result = hs.applescript(script)
    if (ok) then
        -- hs.eventtap.keyStrokes(result) -- type the result
        hs.pasteboard.setContents(result)
        sendNotif('Clipboard', 'Copied current URL of Safari Tech')
    end
end


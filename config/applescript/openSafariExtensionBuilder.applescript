activate application "Safari"
delay 1
tell application "System Events"
    tell process "Safari"
        click menu item "Show Extension Builder" of menu 1 of menu bar item "Develop" of menu bar 1
    end tell
end tell
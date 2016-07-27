tell application "Finder"
    set theWin to window 1
    set thePath to (POSIX path of (target of theWin as alias))
    display dialog thePath buttons {"Clipboard", "OK"} default button 2
    if the button returned of the result is "Clipboard" then
        set the clipboard to thePath
    end if
end tell
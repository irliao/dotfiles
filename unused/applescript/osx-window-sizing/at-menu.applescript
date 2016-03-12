-- AUTHOR:      Yehuda Katz
-- MODIFIED:    Geoffrey Grosenbach http://peepcode.com
-- DESCRIPTION: Size a window and put it at the top of the screen
--              so it can be screencaptured along with the menu.

set windowWidth to 1000
set windowHeight to 600
set menuBarHeight to 20
delay 0.1

set AppleScript's text item delimiters to ""

tell application "Finder"
	set {screen_top, screen_left, screen_width, screen_height} to bounds of window of desktop
end tell

tell application "System Events"
	set myFrontMost to name of first item of (processes whose frontmost is true)
end tell

tell application "System Events"
	tell process myFrontMost
		set position of window 1 to {0, menuBarHeight}
		set size of window 1 to {windowWidth, (windowHeight - menuBarHeight)}
	end tell
end tell

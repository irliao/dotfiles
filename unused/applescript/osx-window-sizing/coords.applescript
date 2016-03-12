-- AUTHOR: Geoffrey Grosenbach http://peepcode.com
-- DESCRIPTION: Show the coordinates of a window of fixed size, centered.

set windowWidth to 1000
set windowHeight to 600

set AppleScript's text item delimiters to "x"

set res to "" & windowWidth & "x" & windowHeight

if res is "" then
	display dialog "You need to enter a correct response"
	return
end if
set {windowWidth, windowHeight} to text items of res

set AppleScript's text item delimiters to ""

-- Works with most setups
tell application "Finder"
	set {screen_top, screen_left, screen_width, screen_height} to bounds of window of desktop
end tell

tell application "System Events"
	set myFrontMost to name of first item of (processes whose frontmost is true)
end tell

tell application "Finder"
	set {desktopTop, desktopLeft, desktopRight, desktopBottom} to bounds of desktop
end tell

set {w, h} to {0, 0}

tell application "System Events"
	display dialog "X " & ((screen_width - windowWidth - w) / 2) & "
Y " & (((screen_height - windowHeight) / 2.0) - desktopTop) & "
W " & windowWidth & "
H " & windowHeight
end tell

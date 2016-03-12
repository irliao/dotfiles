-- AUTHOR: Yehuda Katz
-- MODIFIED: Geoffrey Grosenbach http://peepcode.com

set windowWidth to 460
set windowHeight to 580
delay 0.1

set AppleScript's text item delimiters to "x"

-- Uncomment to see dialog
-- set res to text returned of (display dialog "Enter the width x height:" default answer ((windowWidth & windowHeight) as text))
-- HACK Manually set target window size
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

-- NOTE This may work better with some multi-monitor setups
-- tell application "Safari"
--   set screen_width to (do JavaScript "screen.availWidth" in document 1)
--   set screen_height to (do JavaScript "screen.availHeight" in document 1)
-- end tell


tell application "System Events"
  set myFrontMost to name of first item of (processes whose frontmost is true)
end tell

tell application "Finder"
  set {desktopTop, desktopLeft, desktopRight, desktopBottom} to bounds of desktop
end tell

try
  tell application "System Events"
    tell process myFrontMost
      set {{w, h}} to size of drawer of window 1
    end tell
  end tell
on error
  set {w, h} to {0, 0}
end try

tell application "System Events"
  tell process myFrontMost
    try
      set {{w, h}} to size of drawer of window 1
    on error
      set {w, h} to {0, 0}
    end try
    set position of window 1 to {((screen_width - windowWidth - w) / 2), ((screen_height - windowHeight) / 2.0) - desktopTop}
    set size of window 1 to {windowWidth, windowHeight}
  end tell
end tell

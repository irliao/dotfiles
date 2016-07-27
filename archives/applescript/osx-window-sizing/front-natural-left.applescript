-- AUTHOR: Geoffrey Grosenbach http://peepcode.com

-- Put frontmost window on left side

set windowWidth to 1100

-- Works with most setups
tell application "Finder"
  set {screen_left, screen_top, screen_width, screen_height} to bounds of window of desktop
end tell

-- NOTE This may work better with some multi-monitor setups
-- tell application "Safari"
--   set screen_width to (do JavaScript "screen.availWidth" in document 1)
--   set screen_height to (do JavaScript "screen.availHeight" in document 1)
-- end tell

tell application "System Events"

  set myFrontMost to name of first item of (processes whose frontmost is true)
	
  tell process myFrontMost
    set size of window 1 to {windowWidth, screen_height}
    set position of window 1 to {0, 20}
  end tell

end tell

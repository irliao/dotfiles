-- Maximize frontmost window.
--
-- AUTHOR: Geoffrey Grosenbach http://peepcode.com

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
    set position of window 1 to {0, 0}
    set size of window 1 to {screen_width - w, screen_height}
  end tell
end tell

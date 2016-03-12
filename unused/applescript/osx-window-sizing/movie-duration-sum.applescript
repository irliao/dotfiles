-- DESCRIPTION: Takes a folder and shows the total duration of all the movie files in it.
--
-- AUTHOR: Geoffrey Grosenbach http://topfunky.com
--         August 29, 2008
on open (args)
  try

    set myFolder to (the first item of args)
    
    tell application "Finder" 
      set movFiles to (files of folder myFolder whose name contains ".mov")
    end

    tell application "QuickTime Player"
      set totalDuration to 0

      repeat with movFile in movFiles

        open movFile
        set movProperties to the properties of the front document
        set movDuration to the duration of movProperties

        set totalDuration to totalDuration + movDuration
        close the front document
     		
      end repeat
     	
    end tell
     
    set totalDurationSeconds to totalDuration / 1000
    set totalDurationMinutes to (totalDurationSeconds / 60) as integer
    set totalDurationSecondRemainder to (totalDurationSeconds mod 60) as integer

    tell application "FastScripts"
      display message "Duration: " & totalDurationMinutes & ":" & totalDurationSecondRemainder dismissing after delay 10
    end
     
    on error errmsg
    -- should anything go wrong let the user know
    display dialog errmsg
  end try
  
end open

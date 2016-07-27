-- Hide all applications except TextMate and Terminal.
--
-- Author: Geoffrey Grosenbach http://peepcode.com
--         April 2, 2009
-- Also:   http://newsgroups.derkeiler.com/Archive/Comp/comp.sys.mac.system/2006-03/msg00407.html

tell application "System Events"
	set activeProcesses to every process
	repeat with processCounter from 1 to count activeProcesses
                set thisProcess to item processCounter of activeProcesses
                set visible of thisProcess to false
	end repeat
end tell

tell application "TextMate"
	activate
end tell

tell application "Terminal"
	activate
end tell

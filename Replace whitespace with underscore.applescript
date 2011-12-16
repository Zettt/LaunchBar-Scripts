-- 
--  Replace whitespace with underscore.applescript replaces all whitespaces of the selected files with underscore characters. 
-- 
--  Useage: 
--  1. Select some files in Finder
--  2. Bring up LaunchBar
--  3. Type in the abbreviation for this action
--  4. Press return
--  
--  Created by Zettt. 
--  More info URL (german only): http://www.zettt.de/2009/07/mac-dateien-automatisch-umbenennen/
-- 


on run
	tell application "Finder"
		repeat with i in (selection as list)
			set TheFile to (a reference to item (i as string))
			set TheName to (name of TheFile) as string
			set the_Text to TheName
			set OldDelims to AppleScript's text item delimiters
			set AppleScript's text item delimiters to " "
			set newText to text items of the_Text
			set AppleScript's text item delimiters to "_"
			set finalText to newText as text
			set the (name of TheFile) to finalText
		end repeat
	end tell
end run
-- 
--  Replace whitespace with underscore.applescript replaces all whitespaces of the selected files with underscore characters. 
-- 
--  Useage: 
--  1. Select some files in Finder
--  2. Run script
--  3. Type in the abbreviation for this action
--  4. Press return
--  
--  Created by Zettt. 
--  More info URL (german only): http://www.zettt.de/2009/07/mac-dateien-automatisch-umbenennen/
-- 

tell application "System Events"
	activate
	
	-- replace what?
	set {text returned:textReturned, button returned:buttonReturned} to (display dialog "Replace ..." default answer " " default button "OK")
	if buttonReturned is "OK" then
		set replace_this to textReturned
	else
		set replace_this to " "
	end if
	
	-- with?
	set {text returned:textReturned, button returned:buttonReturned} to (display dialog "Replace ..." default answer "_" default button "OK")
	if buttonReturned is "OK" then
		set with_that to textReturned
	else
		set with_that to "_"
	end if
end tell

-- rename finder items
tell application "Finder"
	repeat with i in (selection as list)
		set TheFile to (a reference to item (i as string))
		set TheName to (name of TheFile) as string
		set the_Text to TheName
		
		-- this is the actual replacement
		set AppleScript's text item delimiters to replace_this
		set newText to text items of the_Text
		set AppleScript's text item delimiters to with_that
		set finalText to newText as text
		set AppleScript's text item delimiters to ""
		
		set the (name of TheFile) to finalText
		
	end repeat
end tell
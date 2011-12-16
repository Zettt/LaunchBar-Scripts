-- Share on Dropbox
-- 
-- Created by Zettt on 2010-05-04
-- Copyright 2010 Mac OS X Screencasts. All rights reserved.
--
-- Version: 1.2
-- 1.0: Initial release
-- 1.1: Successful-operation notification (default submarine.aiff)
-- 1.2: Support for multiple files
-- 

-- where should the file be copied to? (absolute path, please!)
set destination to "/Users/YOU/Dropbox/Public/tmp/"
-- this is your dropbox' public folder url
-- you get this by going to your dropbox and selecting any file and then Dropbox => Copy Public Link
-- afterwards delete the file 
-- eg.: http://dl.dropbox.com/u/12345000/tmp/an%20awesome_cat.jpg ==> http://dl.dropbox.com/u/6102/tmp/
set dropbox_public_path to "http://dl.dropbox.com/u/12345000/tmp/"

set filelist to {}
set cliplist to {}

tell application "Finder"
	repeat with i in (selection as list)
		set filename to name of i as string
		set the end of filelist to filename
	end repeat
end tell

repeat with current_file in filelist
	-- Search and Replace
	set AppleScript's text item delimiters to " "
	set textItems to text items of current_file
	set AppleScript's text item delimiters to "%20"
	if (class of current_file is string) then
		set current_file to textItems as string
	else
		set current_file to textItems as Unicode text
	end if
	set AppleScript's text item delimiters to ""
	
	-- build a list of public links
	set the end of cliplist to dropbox_public_path & current_file & "
" as string
	
end repeat

-- finally copy the results to the clipboard
set the clipboard to cliplist as string

-- play a nice sound to tell the user everything worked :)
do shell script "afplay /System/Library/Sounds/Submarine.aiff"

(*
(*
Set iTunes Repeat
Sets iTunes' repeat mode using LaunchBar.

Created by Andreas "Zettt" Zeitler on 2014-08-02
Mac OS X Screencasts, zCasting 3000.
*)
*)
-- Changes
-- 1.0: Initial version.
-- 1.1: 
--    - New icon
--    - Code signed
--    - Code refactored


on run
	set repeatMode to ""

tell application "iTunes"
	tell application "System Events"
		-- figure out current repeat mode
		if value of attribute "AXMenuItemMarkChar" of menu item "Off" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes" is not missing value then
			set repeatMode to "off"
		else if value of attribute "AXMenuItemMarkChar" of menu item "All" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes" is not missing value then
			set repeatMode to "All"
		else if value of attribute "AXMenuItemMarkChar" of menu item "One" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes" is not missing value then
			set repeatMode to "one"
		end if
		
		--return repeatMode
		
		-- toggle repeat mode: off to all to one
		if repeatMode is "" then
			return
		else if repeatMode is "off" then
			click menu item "All" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
		else if repeatMode is "all" then
			click menu item "One" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
		else if repeatMode is "one" then
			click menu item "Off" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
		end if
	end tell
end tell
	
	
	
	
	
	set _url to the clipboard
	return checkAvailability(_url)
end run

on handle_string(_url)
	set _url to _url
	return checkAvailability(_url)
end handle_string

on checkAvailability(_testURL)
	
	(*
	-- apparently this is not needed. 
	-- strip off starting https:// and http://
	if _testURL begins with "https://" then
		set AppleScript's text item delimiters to "https://"
		set the item_list to every text item of _testURL
		set AppleScript's text item delimiters to ""
		set _testURL to the item_list as string
	else if _testURL begins with "http://" then
		set AppleScript's text item delimiters to "http://"
		set the item_list to every text item of _testURL
		set AppleScript's text item delimiters to ""
		set _testURL to the item_list as string
	end if
	set AppleScript's text item delimiters to ""
	*)
	
	-- check website availability
	set cmd to do shell script "curl --silent 'http://www.downforeveryoneorjustme.com/" & Â
		_testURL & Â
		"' | awk 'BEGIN{IGNORECASE=1;FS=\"<body>|</body>\";RS=EOF} {print $2}'"
	if cmd contains "is up" then
		return "Site is up. It's just you."
	else if cmd contains "looks down" then
		return "Site is down. It's not just you."
	else
		return "Error. Please provide valid URL."
	end if
	
	
	
	
	
	
end checkAvailability

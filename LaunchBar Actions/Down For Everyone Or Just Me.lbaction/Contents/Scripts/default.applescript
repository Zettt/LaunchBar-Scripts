(*
Down For Everyone Or Just Me
Checks website availability using an external service, i.e. downforeveryoneorjustme.com

Created by Andreas "Zettt" Zeitler on 2014-07-05
Copyright Mac OS X Screencasts 2014. All rights reserved.
*)
-- Changes
-- 1.0: Initial version.
-- 1.1: 
--    - New icon
--    - Code signed
--    - Code refactored


on run
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
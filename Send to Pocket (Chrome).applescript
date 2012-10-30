(*
Send To Pocket
Script to send frontmost tab in Chrome/Chromium to Pocket.

Created by Andreas Zeitler on 2012-10-30
Originally by Federicco Viticci 
http://www.macstories.net/reviews/pocket-releases-mac-app/
Check out his post on how to get an API key.
*)

set PocUser to "YOURUSERNAME"
set PocPass to "YOURPASSWORD"
set PocAPI to "YOURAPIKEY"


tell application "Google Chrome"
	set myURL to URL of active tab of first window
	set myTitle to title of active tab of first window
end tell

try
	do shell script "curl \"https://readitlaterlist.com/v2/add?username=" & PocUser & "&password=" & PocPass & "&apikey=" & PocAPI & "&url=" & myURL & "\""
	return "Sent to Pocket"
on error errorMessage
	return errorMessage
end try
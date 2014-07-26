(*
Switch To Username
This script allows you to switch to a specific user. It's basically a replacement for Fast User Switching.

Originates from this post on macosxhins.com http://www.macosxhints.com/article.php?story=20080401232826118

Created by Andreas "Zettt" Zeitler on 2009-03-30
Mac OS X Screencasts, zCasting 3000 2009
*)
-- Changes:
-- 1.0: Initial version.
-- 1.1: 
--    - Added modern header and change log
--    - Major code refactoring, now uses LaunchBar's run and handle_string
--    - Error handling when username is not available

on run
	
	-- you can use this routine to switch to a default user
	-- please set the username here
	set username to "myusername"
	
	tell application "LaunchBar" to hide
	
	switchToUsername(username)
	
end run

on handle_string(_username)
	
	set username to _username
	switchToUsername(username)
	
end handle_string

on switchToUsername(_username)
	
	try
		set username to do shell script "/usr/bin/id -u " & _username
		do shell script "/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -switchToUserID " & username
	on error errorMsg
		display notification errorMsg as string with title "LaunchBar" subtitle "Switch to Username" sound name "Funk"
	end try
	
end switchToUsername

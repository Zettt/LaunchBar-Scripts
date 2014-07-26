-- taken from this post on macosxhins.com http://www.macosxhints.com/article.php?story=20080401232826118
-- written by Zettt 30.03.2009
-- thanks fo Ice|House for help awk and such
-- this one uses itsself name and lets the user input his password. Best way probably

tell application "System Events"
	activate
	set {text returned:textReturned, button returned:buttonReturned} to (display dialog "Which person would you log into?" default answer "root" default button "OK")
	if buttonReturned is "OK" then
		set username to textReturned
	else
		display dialog "Please provide a username"
	end if
end tell

set username to do shell script "/usr/bin/id -u " & username
do shell script "/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -switchToUserID " & username
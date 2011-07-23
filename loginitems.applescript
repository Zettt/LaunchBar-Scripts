-- gets rid of all unnecessary applications in the login items

set removeAppList to {"TextExpander", "EvernoteHelper"}

tell application "System Events"
	--Find out what login items we have
	get the name of every login item
	--see if the item we want exists.  If so then delete it
	repeat with removeApp in removeAppList
		-- display dialog "removing " & removeApp
		if login item removeApp exists then
			delete login item removeApp
		end if
	end repeat
end tell


-- starts all the applications needed

set theAppList to {"LaunchBar", "TextMate", "OmniFocus", "TextExpander", "Dropbox", "Keyboard Maestro Engine", "HazelHelper", "GrowlHelperApp"} as list
set theDelay to 10

repeat with currentApp in theAppList
	tell application currentApp to launch
	delay theDelay
	tell application "Finder" to set visible of process currentApp to false
end repeat
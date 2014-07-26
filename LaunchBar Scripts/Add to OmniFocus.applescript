on handle_string(theString)
	
	if theString is not "" then
		tell application "OmniFocus" to parse tasks into default document with transport text theString
	else
		display notification "No string to work with." with title "LaunchBar" subtitle "Add to OmniFocus"
	end if
	
end handle_string

on run
	
	if (the clipboard) contains text then
		set clipboardString to the clipboard as text
		tell application "OmniFocus" to parse tasks into default document with transport text clipboardString
	else
		display notification "No string to work with on clipboard." with title "LaunchBar" subtitle "Add to OmniFocus"
	end if
	
end run
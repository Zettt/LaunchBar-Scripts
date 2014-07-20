on handle_string(theString)
	tell application "OmniFocus" to parse tasks into default document with transport text theString
end handle_string

on run
	
	if (the clipboard) contains text then
		set clipboardString to the clipboard as text
	else
		tell application "LaunchBar" to display in large type "No string to work with on clipboard"
	end if
	
	tell application "OmniFocus" to parse tasks into default document with transport text clipboardString
	
end run
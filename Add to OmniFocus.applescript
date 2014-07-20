on handle_string(theString)
	
	if theString contains text then
		tell application "OmniFocus" to parse tasks into default document with transport text theString
	else
		display notification "No string to work with on clipboard"
	end if
	
end handle_string

on run
	
	if (the clipboard) contains text then
		set clipboardString to the clipboard as text
		tell application "OmniFocus" to parse tasks into default document with transport text clipboardString
	else
		display notification "No string to work with on clipboard"
	end if
	
end run
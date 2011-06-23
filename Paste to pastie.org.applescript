on run
	sendTextToPastie(the clipboard)
end run

on handle_string(textToPaste)
	sendTextToPastie(textToPaste)
end handle_string

on open of filesToPaste
	set nl to ASCII character 10
	set bannerblock to "*******************************************************************************"
	set textToPaste to ""
	repeat with oneFile in filesToPaste
		set textToPaste to textToPaste & nl & nl & bannerblock & nl & (POSIX path of oneFile) & nl & bannerblock & nl & nl & (read oneFile)
	end repeat
	sendTextToPastie(textToPaste)
end open

on sendTextToPastie(textToPaste)
	set pastieURL to "http://pastie.org/pastes"
	# Escape the text, particularly single quotes which seem to cause problems
	set textToPaste to quoted form of textToPaste
	# Use line breaks that pastie will understand
	set textToPaste to replaceString(textToPaste, ASCII character 13, ASCII character 10)
	try
		set responseURL to (do shell script "curl http://pastie.caboo.se/pastes/create -H 'Expect:' -F 'paste[parser]=plaintext' -F 'paste[body]=" & "'" & textToPaste & "'" & "' -F 'paste[authorization]=burger' -s -L -o /dev/null -w '%{url_effective}'")
		set the clipboard to responseURL
		growlAnnounce("Text pasted to " & responseURL)
		tell application "LaunchBar"
			set selection to responseURL
		end tell
	on error errmesg number errnumber
		growlAnnounce("There was an error")
		display dialog errmesg
	end try
end sendTextToPastie

on replaceString(theText, oldString, newString)
	set AppleScript's text item delimiters to oldString
	set tempList to every text item of theText
	set AppleScript's text item delimiters to newString
	set theText to the tempList as string
	set AppleScript's text item delimiters to ""
	return theText
end replaceString

on growlAnnounce(txt)
	tell application "GrowlHelperApp"
		notify with name Â
			"LaunchBar" title Â
			"Pastie" description txt Â
			application name "LaunchBar"
	end tell
end growlAnnounce
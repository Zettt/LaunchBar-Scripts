set fileLocation to the clipboard
set homeFolderPath to POSIX path of (path to home folder)

-- check whether file begins with ~ or /
if fileLocation does not start with "~" and fileLocation does not start with "/" then
	set fileLocation to "/" & fileLocation
end if
-- check whether location ends with /
if fileLocation does not end with "/" then
	set fileLocation to fileLocation & "/"
end if

-- expand tilde
if fileLocation starts with "~" then
	set fileLocation to characters 3 thru -1 of fileLocation as string -- dirty hack to remove ~/ from the beginning
	set fileLocation to homeFolderPath & fileLocation
end if

try
	-- we got all we need, let's open the location
	set fileLocation to (POSIX file fileLocation) as alias -- convert POSIX to alias
	
	tell application "Finder"
		activate
		open folder fileLocation
	end tell
	
on error
	-- location doesn't exist let's notify the user
	do shell script "afplay /System/Library/Sounds/Basso.aiff"
	return
end try
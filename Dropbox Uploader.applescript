-- where should files be uploaded to?
set dropboxSharePath to "/Dropbox/SharedFiles/"

-- where is Dropbox Uploader
set dropboxUploaderPath to "$HOME/Library/Application Support/LaunchBar/Actions/Dropbox-Uploader/"
set dropboxUploaderBin to "dropbox_uploader.sh"

-- check if Dropbox-Uploader is setup correctly
try
	do shell script "ls $HOME/.dropbox_uploader"
on error errorMessage number errorNumber
	set _error to errorMessage
	set _errorNum to errorNumber
	display dialog "You haven't set up Dropbox-Uploader. It's easiest to do this step manually. Open a Terminal.
	
`cd ~/Library/Application Support/LaunchBar/Actions/Dropbox-Uploader`

Finish setting up Dropbox-Uploader then come back and use this script."
end try

set filelist to {}
set cliplist to {}

tell application "Finder"
	repeat with i in (selection as list)
		set filename to name of i as string
		set the end of filelist to filename
		display dialog
		
		-- uploads one of the files to Dropbox through the API
		set cmd to dropboxUploaderPath & dropboxUploaderBin & "upload" & quoted form of POSIX path of (i as string) & " " & dropboxSharePath
	end repeat
end tell
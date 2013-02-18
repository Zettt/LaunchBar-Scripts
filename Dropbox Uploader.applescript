-- where should files be uploaded to?
set dropboxSharePath to "/SharedFiles/"

-- where is Dropbox Uploader
set dropboxUploaderPath to "/Library/Application Support/LaunchBar/Actions/Dropbox-Uploader/"
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

-- this uploads the file through the API
-- note: your dropbox app will therefore *download* the file once it's uploaded
tell application "Finder"
	repeat with i in (selection as list)
		set filename to name of i as string
		set the end of filelist to filename
		display dialog filelist as string
		
		-- uploads one of the files to Dropbox through the API
		set cmd to "$HOME" & quoted form of (dropboxUploaderPath & dropboxUploaderBin) & " " & "upload" & " " & quoted form of POSIX path of (i as string) & " " & dropboxSharePath & filename
		display dialog cmd
		do shell script cmd
	end repeat
end tell

-- get public share url of shared files
repeat with currentFile in filelist
	
	set cmd to "$HOME" & quoted form of (dropboxUploaderPath & dropboxUploaderBin) & " " & "share" & " " & quoted form of POSIX path of (currentFile as string) & " " & dropboxSharePath & filename
	return cmd
	
end repeat
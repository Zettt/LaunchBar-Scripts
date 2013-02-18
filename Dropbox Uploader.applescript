(*
Share on Dropbox through Dropbox's API

This script shares selected files in the Finder on Dropbox.
It is similar in functionality to "Share on Dropbox", but instead
of calculating the URL, the API is used to get Dropbox Share URLs.
(https://www.dropbox.com/help/167/en)

Dropbox generates these individually per every access.
This means you can share a file more "privately".

Created by Andreas Zeitler on 2013-02-18
Built on Dropbox-Uploader by Andrea Fabrizi https://github.com/andreafabrizi/Dropbox-Uploader 
*)

-- where should files be uploaded to?
-- make sure this doesn't start with /Public 
-- (that would defeat the point, wouldn't it?)
set dropboxSharePath to "/Shared Files/"

-- where is Dropbox Uploader
set dropboxUploaderPath to "/Library/Application Support/LaunchBar/Actions/Dropbox-Uploader/"
set dropboxUploaderBin to "dropbox_uploader.sh"

-- check if Dropbox-Uploader is setup correctly
try
	do shell script "ls $HOME/.dropbox_uploader"
on error errorMessage number errorNumber
	set _error to errorMessage
	set _errorNum to errorNumber
	display dialog "You haven't set up Dropbox-Uploader. It's easiest to do this step manually. Open a Terminal.\n\n`cd ~/Library/Application Support/LaunchBar/Actions/Dropbox-Uploader`\n\nFinish setting up Dropbox-Uploader then come back and use this script."
end try

set filelist to {}
set cliplist to {}

-- this uploads the file through the API
-- note: your dropbox app will therefore *download* the file once it's uploaded
tell application "Finder"
	repeat with i in (selection as list)
		set filename to name of i as string
		set the end of filelist to filename
		
		-- uploads one of the files to Dropbox through the API
		set cmd to "$HOME" & quoted form of (dropboxUploaderPath & dropboxUploaderBin) & " " & "upload" & " " & quoted form of POSIX path of (i as string) & " " & quoted form of (dropboxSharePath & filename)
		do shell script cmd
		
		-- you will hear Finder's "move to trash" sound!
		-- don't worry the file is in dropbox (and your trash for that matter)
		move i to trash
	end repeat
end tell

-- get public share url of shared files
repeat with currentFile in filelist
	set cmd to "$HOME" & quoted form of (dropboxUploaderPath & dropboxUploaderBin) & " " & "share" & " " & quoted form of (dropboxSharePath & currentFile)
	set the end of cliplist to ((do shell script cmd) as string) & "\n"
end repeat

-- copy the results to the clipboard
set the clipboard to cliplist as string

-- play a nice sound to tell the user everything worked
do shell script "afplay /System/Library/Sounds/Submarine.aiff"

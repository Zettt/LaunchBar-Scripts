-- =================================
-- = script by Zettt: www.zettt.de  =
-- = Version 1.0 from 2009-05-29 =
-- =================================
-- = Known issues: 
-- = 1. This script *may not work* with files that have a whitespace in their name
-- = 2. Please give it some time to run. This is no problem of AppleScript, but MacFUSE.
-- =================================
tell application "Finder"
	-- i don't know if we really need two lists at all but for my understanding of this code i'll use them
	set fileList to {}
	set URLList to {}
	
	-- get every selected file's POSIX path and save them in fileList
	repeat with i in (selection as list)
		set the end of fileList to (POSIX path of (i as alias))
	end repeat
	
	-- here the magic happens
	
	repeat with currentFile in (fileList as list)
		set currentFile to currentFile as text
		
		-- look in currenFile if there is an identical identifier for ExpanDrive volumes
		-- in my case i have a connection which is called "podzilla.de"
		-- here you should enter your own server name like it is set in ExpanDrive
		
		-- these lines are for domain firstftp
		if currentFile contains "firstftp" then
			
			-- strip local volume name from the currentFile
			-- again have a look at how your /Volumes/ExpanDrive volume is mounted and provide here the *complete* path to your http root folder
			set AppleScript's text item delimiters to {"/Volumes/firstftp/httpdocs"}
			set fileURL to text item 2 of currentFile
			set AppleScript's text item delimiters to ""
			
			-- append web url in front of currentFile
			-- replace everything after http:// with your own domain
			set fileURL to "http://www.example.com" & fileURL
			-- display dialog fileURL as text
			set the end of URLList to fileURL
		end if
		
		-- these lines are for domain secondftp
		if currentFile contains "secondftp" then
			-- strip local volume name from the currentFile
			-- again have a look at how your /Volumes/ExpanDrive volume is mounted and provide here the *complete* path to your http root folder
			set AppleScript's text item delimiters to {"/Volumes/secondftp/websites"}
			set fileURL to text item 2 of currentFile
			set AppleScript's text item delimiters to ""
			
			-- append web url in front of currentFile
			-- replace everything after http:// with your own domain
			set fileURL to "http://www.example.com" & fileURL
			-- display dialog fileURL as text
			set the end of URLList to fileURL
		end if
		
	end repeat
	
	-- make URLList into a \r delimited list of strings
	set AppleScript's text item delimiters to {return}
	set flatlist to URLList as text
	set AppleScript's text item delimiters to ""
	
	-- copy everything to the clipboard
	set the clipboard to flatlist as text
end tell
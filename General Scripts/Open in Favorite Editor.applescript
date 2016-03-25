(*
Open in Favorite Editor

On my computer I often have a viewer (a software that opens quickly and displays a file's content) and an editor (an app that I use to actually manipulate a file). I leave the standard association of files to their viewer, e.g. QuickLook or Preview. And with this script I can now easily type a shortcut and open all of them in my favorite editor. So I get best of both worlds. Quick preview and a quick editing possibility.

This script also considers multiple file "types", e.g. images and text. It takes the whole selection and considers their extensions for opening in an editor.

Created by Andreas "Zettt" Zeitler on 2011-09-03
2010 Mac OS X Screencasts, zCasting 3000
*)
-- Changes
-- 1.0: Initial release
-- 1.1: Multiple file type support
-- 1.2: Added suggestions for improvements
-- 1.3: Documentation
-- 1.4: Fix for permission error in Acorn 
-- 1.5: Added video extensions (MPEG Streamclip)

set fileList to {}

-- images
--
-- images are an example for more file types!
-- put additional lists here and repeats below in case
-- you need to differentiate more file types.
set imageTypes to {"png", "jpg", "jpeg", "tiff"}
-- don't manipulate the following line
set imageFileList to {}
-- what's your favorite editor for this type of file?
set favImageEditor to "Affinity Photo"

-- text
set textTypes to {"txt", "md"}
set textFileList to {}
set favTextEditor to "MacVim"

-- video
set videoTypes to {"mp4", "mov", "m4v"}
set videoFileList to {}
set favVideoEditor to "MPEG Streamclip"

-- audio
set audioTypes to {"aif", "aiff", "aifc", "wav", "m4a"}
set audioFileList to {}
set favAudioEditor to "Amadeus Pro"

-- get all selected Finder items and put them on a list of POSIX paths
tell application "Finder"
	repeat with i in (selection as list)
		set fileName to POSIX path of (i as string)
		set the end of fileList to fileName
	end repeat
end tell

-- scan all Finder items for their extension
repeat with currentFile in fileList
	
	-- ignoring case of filetypes for convenience
	-- writing "JPG" above is the same as "jpg", essentially.
	ignoring case
		
		-- if file is an image (put path of file on a list)
		repeat with imageType in imageTypes
			if currentFile contains imageType then
				set the end of imageFileList to currentFile
			end if
		end repeat
		
		-- if file is text (put path of file on another list)
		repeat with textType in textTypes
			if currentFile contains textType then
				set the end of textFileList to currentFile
			end if
		end repeat
		
		repeat with videoType in videoTypes
			if currentFile contains videoType then
				set the end of videoFileList to currentFile
			end if
		end repeat
		
		repeat with audioType in audioTypes
			if currentFile contains audioType then
				set the end of audioFileList to currentFile
			end if
		end repeat
		
	end ignoring
end repeat

-- open in favorite editor
repeat with currentFile in imageFileList
	tell application favImageEditor to open (currentFile as POSIX file)
	tell application favImageEditor to activate
end repeat

repeat with currentFile in textFileList
	tell application favTextEditor to open (currentFile as POSIX file)
	-- you might want to put an additional "tell application "foo" to open currentFile" line
	-- here in case you want to open, e.g. a Markdown file, in an editor
	-- *and* a live preview app (like Marked).
	tell application favTextEditor to activate
end repeat

repeat with currentFile in videoFileList
	tell application favVideoEditor to open (currentFile as POSIX file)
	tell application favVideoEditor to activate
end repeat

repeat with currentFile in audioFileList
	tell application favAudioEditor to open (currentFile as POSIX file)
	tell application favAudioEditor to activate
end repeat

-- play a nice sound to tell the user everything worked
do shell script "afplay /System/Library/Sounds/Submarine.aiff"

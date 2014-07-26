-- Hide/Unhide Library Folder
--
-- Created by robJ on 2011-10-23
-- http://hints.macworld.com/comment.php?mode=view&cid=126571
--
-- Changed by Zettt on 2011-10-23
-- http://www.macosxscreencasts.com
-- 

set lib_folder to path to library folder from user domain
set lib_visible to do shell script "ls -Ol ~ | grep \"Library\"" as text

if lib_visible contains "hidden" then
	do shell script "chflags nohidden ~/Library/"
	return "Library has been unhidden" as text
else
	do shell script "chflags hidden ~/Library/"
	return "Library has been hidden" as text
end if

try
	tell application "Finder" to update front window
end try
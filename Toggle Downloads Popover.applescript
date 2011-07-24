-- © Copyright 2011, Red Sweater Software. All Rights Reserved.
-- Permission to copy granted for personal use only. All copies of this script
-- must retain this copyright information and all lines of comments below, up to
-- and including the line indicating "End of Red Sweater Comments". 
--
-- Any commercial use of this code must be licensed from the Copyright
-- owner, Red Sweater Software.
--
-- A script to show and/or hide the Downloads popover in Safari 5.1
--
-- Version 1.0.2 - Add check for and automatic prompting for enabling UI Scripting support.
-- Version 1.0.1 - Add comment and easy to change variable for changing
--             		the language-specific name of the Downloads button
-- Version 1.0 - Initial release
--
-- End of Red Sweater Comments

-- The only way I know to reliably identify the Downloads button is 
-- by referring to its accessibility description. Unfortunately this value
-- will be different in every language. Change the localizedDescription 
-- value to match your language. E.g. "Descargas" in Spanish
set localizedDescription to "Downloads"

tell application "System Events"
	if UI elements enabled is false then
		display dialog "This script requires that you enable 'UI Scripting' support for AppleScript. You will be prompted to authorize this change by the system. If you do not wish to authorize this, click Cancel."
		
		-- Automaticaly prompts the user
		set UI elements enabled to true
	end if
	
	tell application process "Safari"
		click (first button of tool bar of window 1 whose accessibility description is localizedDescription)
	end tell
end tell
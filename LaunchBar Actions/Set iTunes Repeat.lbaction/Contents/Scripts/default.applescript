(*
(*
Set iTunes Repeat
Sets iTunes' repeat mode using LaunchBar.

Created by Andreas "Zettt" Zeitler on 2014-08-02
Mac OS X Screencasts, zCasting 3000.
*)
*)
-- Changes
-- 1.0: Initial version.
-- 1.1: 
--    - Accepts string "a" or "all" for repeat all, etc. See handle_string
--    - Displays repeat modes on run and allows to set or toggle
-- 1.2:
--    - Code refactored
--    - Documentation

-- by default return a list to toggle and set a specific repeat mode	
on run
	set repeatModes to {}
	
	set currentRepeatMode to checkRepeatMode()
	set nextRepeatMode to checkNextRepeatMode(currentRepeatMode)
	
	set repeatModes to repeatModes & [{title:"Toggle Repeat (is: \"" & currentRepeatMode & "\" will be: \"" & nextRepeatMode & "\")", action:"toggle"}] Â
		& [{title:"None", action:"none"}] Â
		& [{title:"One", action:"one"}] Â
		& [{title:"All", action:"all"}]
	return repeatModes
end run

-- alternatively passing a string, such as "a" or "all", will also work
on handle_string(_repeatMode)
	if _repeatMode is not "" then
		if _repeatMode is "n" or _repeatMode is "none" then
			setRepeatMode("none")
		else if _repeatMode is "o" or _repeatMode is "one" then
			setRepeatMode("one")
		else if _repeatMode is "a" or _repeatMode is "all" then
			setRepeatMode("all")
		end if
	end if
end handle_string

-- these set the repeat mode based on which item is select in LaunchBar
on toggle()
	set currentRepeatMode to checkRepeatMode()
	set nextRepeatMode to checkNextRepeatMode(currentRepeatMode)
	setRepeatMode(nextRepeatMode)
end toggle

on none()
	setRepeatMode("none")
end none

on one()
	setRepeatMode("one")
end one

on all()
	setRepeatMode("all")
end all

-- below are the functions that do the heavy lifting
--
-- checks the current repeat mode and returns a string
on checkRepeatMode()
	set repeatMode to ""
	tell application "iTunes"
		tell application "System Events"
			-- figure out current repeat mode
			if value of attribute "AXMenuItemMarkChar" of menu item "Off" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes" is not missing value then
				set repeatMode to "off"
			else if value of attribute "AXMenuItemMarkChar" of menu item "All" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes" is not missing value then
				set repeatMode to "All"
			else if value of attribute "AXMenuItemMarkChar" of menu item "One" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes" is not missing value then
				set repeatMode to "one"
			end if
			
			-- toggle repeat mode: off to all to one
			if repeatMode is "" then
				return
			else if repeatMode is "off" then
				return "None"
			else if repeatMode is "all" then
				return "All"
			else if repeatMode is "one" then
				return "One"
			end if
		end tell
	end tell
end checkRepeatMode

-- returns the next repeat mode based on the current one
on checkNextRepeatMode(_currentRepeatMode)
	if _currentRepeatMode is "" then
		return
	else if _currentRepeatMode is "none" or _currentRepeatMode is "None" then
		return "All"
	else if _currentRepeatMode is "all" or _currentRepeatMode is "All" then
		return "One"
	else if _currentRepeatMode is "one" or _currentRepeatMode is "One" then
		return "Off"
	end if
end checkNextRepeatMode

-- sets the repeat mode based on the string it receives
on setRepeatMode(_repeatMode)
	display notification "rep: " & _repeatMode
	if _repeatMode is not "" then
		tell application "iTunes"
			tell application "System Events"
				if _repeatMode is "none" or _repeatMode is "None" or _repeatMode is "Off" then
					click menu item "Off" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
				else if _repeatMode is "all" or _repeatMode is "All" then
					click menu item "All" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
				else if _repeatMode is "one" or _repeatMode is "One" then
					click menu item "One" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
				end if
			end tell
		end tell
		tell application "LaunchBar" to hide
	else
		return
	end if
end setRepeatMode

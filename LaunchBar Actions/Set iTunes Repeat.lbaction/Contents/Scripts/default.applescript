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
--    - New icon
--    - Code signed
--    - Code refactored


on run
	set repeatModes to {}
	set repeatModes to repeatModes & [{title:"Toggle Repeat (is: \"" & checkRepeatMode() & "\" will be: \"" & nextRepeatMode() & "\")", action:"toggle"}] Â
		& [{title:"None", action:"none"}] Â
		& [{title:"One", action:"one"}] Â
		& [{title:"All", action:"all"}]
	return repeatModes
end run

on handle_string(_repeatMode)
	display notification _repeatMode
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

on toggle()
	display notification "toggle"
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

on nextRepeatMode()
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
			
			--return repeatMode
			
			-- toggle repeat mode: off to all to one
			if repeatMode is "" then
				return
			else if repeatMode is "off" then
				return "All"
				--click menu item "All" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
			else if repeatMode is "all" then
				return "One"
				--click menu item "One" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
			else if repeatMode is "one" then
				return "Off"
				--click menu item "Off" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
			end if
		end tell
	end tell
end nextRepeatMode

on setRepeatMode(_repeatMode)
	if _repeatMode is not "" then
		tell application "iTunes"
			tell application "System Events"
				if _repeatMode is "none" then
					click menu item "Off" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
				else if _repeatMode is "all" then
					click menu item "All" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
				else if _repeatMode is "one" then
					click menu item "One" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
				end if
			end tell
		end tell
		tell application "LaunchBar" to hide
	else
		return
	end if
end setRepeatMode

on toggleRepeat()
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
			
			--return repeatMode
			
			-- toggle repeat mode: off to all to one
			if repeatMode is "" then
				return
			else if repeatMode is "off" then
				click menu item "All" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
			else if repeatMode is "all" then
				click menu item "One" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
			else if repeatMode is "one" then
				click menu item "Off" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
			end if
		end tell
	end tell
	
	tell application "LaunchBar" to hide
	
	return
end toggleRepeat

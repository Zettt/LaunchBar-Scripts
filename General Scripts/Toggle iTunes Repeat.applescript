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
			click menu item "All" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
		else if repeatMode is "all" then
			click menu item "One" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
		else if repeatMode is "one" then
			click menu item "Off" of menu 1 of menu item "Repeat" of menu 1 of menu bar item "Controls" of menu bar 1 of application process "iTunes"
		end if
	end tell
end tell
-- Version 1.0 - Initial release
--
-- Restore a fixed set of enabled calendards. Proof of concept by
-- Daniel (@danielpunkass) for Wave (@drwave)

tell application "System Events"
	if UI elements enabled is false then
		display dialog "This script requires that you enable 'UI Scripting' support for AppleScript. You will be prompted to authorize this change by the system. If you do not wish to authorize this, click Cancel."
		
		-- Automaticaly prompts the user
		set UI elements enabled to true
	end if
end tell

on GetCalendarTableRows()
	
	tell application "System Events"
		tell application process "Calendar"
			tell window 1
				return (value of attribute "AXChildren" of outline 1 of scroll area 1 of splitter group 1 of splitter group 1 of splitter group 1)
			end tell
		end tell
	end tell
end GetCalendarTableRows

-- I can't seem to filter out the non-group items in GetCalendarTableRows
-- without screwing up the references to the rows... sigh, AppleScript.
on IsGroupTypeTableRow(thisRow)
	tell application "System Events"
		tell application process "Calendar"
			set isGroupType to false
			try
				if (group 1 of thisRow) is not missing value then
					set isGroupType to true
				end if
			end try
			return isGroupType
		end tell
	end tell
end IsGroupTypeTableRow

-- If any calendar is selected (highlighted) in the list, return its name
on SelectedCalendarName()
	set selectedCalendar to ""
	
	tell application "System Events"
		tell application process "Calendar"
			repeat with thisCal in my GetCalendarTableRows()
				if my IsGroupTypeTableRow(thisCal) is false then
					if selected of thisCal is true then
						return value of text field 1 of thisCal
					end if
				end if
			end repeat
		end tell
	end tell
	
	return missing value
end SelectedCalendarName

-- Which calendars are currently checked?
on EnabledCalendars()
	set enabledCalendarNames to {}
	
	tell application "System Events"
		tell application process "Calendar"
			repeat with thisCal in my GetCalendarTableRows()
				if my IsGroupTypeTableRow(thisCal) is false then
					try
						if (value of checkbox 1 of thisCal is equal to 1) then
							set end of enabledCalendarNames to value of text field 1 of thisCal
						end if
					end try
				end if
			end repeat
		end tell
	end tell
	
	return enabledCalendarNames
end EnabledCalendars

on EnableCalendarsWithName(nameList)
	tell application "System Events"
		tell application process "Calendar"
			tell window 1
				repeat with thisCal in my GetCalendarTableRows()
					try
						set thisLineName to value of text field 1 of thisCal
						set isChecked to ((value of checkbox 1 of thisCal) is equal to 1)
						set shouldBeChecked to (thisLineName is in nameList)
						
						if (isChecked is not equal to shouldBeChecked) then
							click checkbox 1 of thisCal
						end if
					end try
				end repeat
			end tell
		end tell
	end tell
end EnableCalendarsWithName

on saveCalendarList(theList)
	set theFile to open for access "/tmp/com.red-sweater.toggleCalendars.savedCalendars.txt" with write permission
	write theList to theFile
	close access theFile
end saveCalendarList

on readCalendarList()
	set theFile to open for access "/tmp/com.red-sweater.toggleCalendars.savedCalendars.txt"
	set theList to read theFile as list
	close access theFile
	return theList
end readCalendarList

-- If the number of checked calendars is 1 or fewer, we restore the calendars from saved list. Otherwise we try to enable just the current selected calendar.
set enabledCalendarNames to EnabledCalendars()

set calCount to count of enabledCalendarNames
if (calCount is less than 2) then
	set newList to readCalendarList()
	if ((count of newList) is greater than 0) then
		EnableCalendarsWithName(newList)
	end if
else
	saveCalendarList(enabledCalendarNames)
	
	set currentCalendar to SelectedCalendarName()
	EnableCalendarsWithName({currentCalendar})
end if


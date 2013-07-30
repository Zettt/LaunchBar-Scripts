-- get clipboard and separate lines
set clipboardText to the clipboard as text
set reminderLines to paragraphs of clipboardText
set defaultRemindersList to "Shoppinglist"

-- figure out if a non-default reminder list should be used
if item 1 of reminderLines starts with "!" then
	-- set other reminder list and delete first line
	set remindersList to characters 2 thru -1 of item 1 of reminderLines as text
	set reminderLines to items 2 thru -1 of reminderLines
else
	set remindersList to defaultRemindersList
end if

tell application "Reminders"
	activate
	
	-- create reminders
	tell list remindersList
		repeat with currentReminderLine in reminderLines
			make new reminder with properties {name:currentReminderLine as text}
		end repeat
	end tell
	
end tell

-- optionally quit Reminders
tell application "System Events"
	activate
	set quitReminders to display dialog "Quit Reminders?" buttons {"No", "Yes"} default button "Yes"
	
	if button returned of quitReminders is equal to "Yes" then
		tell application "Reminders" to quit
	else if button returned of quitReminders is equal to "No" then
		-- if no is clicked, system events would still be active, so
		-- let's activate Reminders again
		tell application "Reminders" to activate
	end if
	
end tell
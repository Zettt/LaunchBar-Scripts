-- register script for growl notifications
tell application "GrowlHelperApp"
	-- Tell Growl we want to send a notification, use the BT icon
	register as application Â
		"Bluetooth" all notifications {"Bluetooth Notification"} Â
		default notifications {"Bluetooth Notification"} Â
		icon of application "Bluetooth Explorer"
end tell

property blueutilPath : "/usr/local/bin/blueutil"

-- get the status of the *current* bluetooth setting
set cmd to do shell script blueutilPath & " status"

if cmd contains "off" then
	-- switch it off if it was on
	tell application "GrowlHelperApp" to notify with name Â
		"Bluetooth Notification" title Â
		"Bluetooth status" description Â
		"Bluetooth is now ON." application name "Bluetooth"
	do shell script blueutilPath & " on"
else if cmd contains "on" then
	-- switch it on if it was off
	tell application "GrowlHelperApp" to notify with name Â
		"Bluetooth Notification" title Â
		"Bluetooth status" description Â
		"Bluetooth is now OFF." application name "Bluetooth"
	do shell script blueutilPath & " off"
end if

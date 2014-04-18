-- This script requires audiodevice, which can be obtained from here:
-- http://whoshacks.blogspot.com/2009/01/change-audio-devices-via-shell-script.html

-- tell application "Growl"
--	set allNotifications to {"Switch Audio"}
--	set enabledNotifications to {"Switch Audio"}
--	register as application Â
--		"Sound" all notifications allNotifications Â
--		default notifications enabledNotifications Â
--		icon of application "Sound"
-- end tell

property audiodeviceCommand : "/usr/local/bin/audiodevice "

set inputDevices to do shell script audiodeviceCommand & "input list"
-- display dialog inputDevices

set AppleScript's text item delimiters to "
"
set inputDevicesList to text items of inputDevices
set AppleScript's text item delimiters to {""}

tell application "System Events"
	activate
	set chosenDevice to choose from list inputDevicesList with prompt "Choose wisely..." OK button name "OK"
end tell

set cmd to do shell script audiodeviceCommand & "input " & quoted form of (chosenDevice as string)

if cmd is "" then
	-- return "Input set to " & chosenDevice
	tell application "Growl" to notify with name Â
		"Switch Audio" title Â
		"Switch Audio" description Â
		"Active input " & chosenDevice application name "Sound"
else
	tell application "Growl" to notify with name Â
		"Switch Audio" title Â
		"Switch Audio" description Â
		"Something went wrong. Open Terminal an check if /usr/local/bin/audiodevice is working" application name "Sound"
end if
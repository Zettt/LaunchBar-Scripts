-- I want to delete that
-- This script requires audiodevice, which can be obtained from here:
-- http://whoshacks.blogspot.com/2009/01/change-audio-devices-via-shell-script.html

-- tell application "GrowlHelperApp"
--	set allNotifications to {"Switch Audio"}
--	set enabledNotifications to {"Switch Audio"}
--	register as application �
--		"Sound" all notifications allNotifications �
--		default notifications enabledNotifications �
--		icon of application "Sound"
-- end tell

property audiodeviceCommand : "/usr/local/bin/audiodevice "

set inputDevices to do shell script audiodeviceCommand & "input list"
-- display dialog inputDevices

set AppleScript's text item delimiters to "\r"
set inputDevicesList to text items of inputDevices
set AppleScript's text item delimiters to {""}

tell application "System Events"
	activate
	set chosenDevice to choose from list inputDevicesList with prompt "Choose wisely..." OK button name "OK"
end tell

set cmd to do shell script audiodeviceCommand & "input " & quoted form of (chosenDevice as string)

if cmd is "" then
	-- return "Input set to " & chosenDevice
	tell application "GrowlHelperApp" to notify with name �
		"Switch Audio" title �
		"Switch Audio" description �
		"Active input " & chosenDevice application name "Sound"
else
	tell application "GrowlHelperApp" to notify with name �
		"Switch Audio" title �
		"Switch Audio" description �
		"Something went wrong. Open Terminal an check if /usr/local/bin/audiodevice is working" application name "Sound"
end if
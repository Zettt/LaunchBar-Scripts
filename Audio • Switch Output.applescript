-- This script requires audiodevice, which can be obtained from here:
-- http://whoshacks.blogspot.com/2009/01/change-audio-devices-via-shell-script.html

property audiodeviceCommand : "/usr/local/bin/audiodevice "

set inputDevices to do shell script audiodeviceCommand & "output list"
-- display dialog inputDevices

set AppleScript's text item delimiters to "\r"
set inputDevicesList to text items of inputDevices
set AppleScript's text item delimiters to {""}

tell application "System Events"
	activate
	set chosenDevice to choose from list inputDevicesList with prompt "Choose wisely..." OK button name "OK"
end tell

set cmd to do shell script audiodeviceCommand & "output " & quoted form of (chosenDevice as string)

return "Output set to " & chosenDevice
property blueutilPath : "/usr/local/bin/blueutil"

-- get the status of the *current* bluetooth setting
try
	set cmd to do shell script blueutilPath & " power"
on error
	display notification "No blueutil binary found" with title "LaunchBar" subtitle "Toggle Bluetooth"
end try


if cmd contains "0" then
	-- switch it off if it was on
	display notification "Bluetooth is now ON." with title "LaunchBar" subtitle "Toggle Bluetooth"
	do shell script blueutilPath & " power 1"
else if cmd contains "1" then
	-- switch it on if it was off
	display notification "Bluetooth is now OFF." with title "LaunchBar" subtitle "Toggle Bluetooth"
	do shell script blueutilPath & " power 0"
end if

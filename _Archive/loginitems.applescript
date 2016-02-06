-- ======================================================
-- =         loginitems by Zettt from Mac OS X Screencasts
-- ======================================================
-- = This script is an attempt to fasten up login times.
-- = The original idea came from Mac OS X Hints:
-- = http://hints.macworld.com/article.php?story=20091108173250445
-- = The idea is to "queue up" login items and launch them conscutively rather
-- = than all at once.
-- ======================================================
-- = Checkout the screencast as well
-- = http://macosxscreencasts.com/en/tutorial/schnellerer-mac-tutorial
-- ======================================================
-- = v3: allowedAppList added: a list of apps that are allowed in Login Items
--    everything else will be removed
-- = v4: Lion changes: commented out line `-- delay 10`. Lion takes care of the
--    the initial delay
-- = v5: Now uses Notification Center notifications

-- A list of apps that are allowed in Login Items
-- !!! Everything else will be removed !!!
set allowedAppList to {"loginitems", "SmartSleep Helper", "BusyCalAlarm", "DEVONthink Sorter"}

tell application "System Events"
	-- Get all apps in Login Items as list...
	set appList to get (name of every login item)
	
	repeat with appName in appList
		-- Check whether the app is allowed or not
		if allowedAppList does not contain appName then
			-- Remove the app, comment following line for debugging purposes
			--display dialog (appName as string) & " is not contained in allowedAppList"
			delete login item appName
		end if
	end repeat
end tell

-- initial delay
-- delay 10

-- starts all the applications needed
set executeAppList to {"Growl", "Alfred", "Keyboard Maestro Engine", "Moom", "TextExpander", "HazelHelper", "Dropbox", "Watts", "GeekTool", "Time Sink"} as list
set theDelay to 5
set delayOnce to false

repeat with executeApp in executeAppList
	
	-- launch the current app 
	tell application executeApp to launch
	
	-- display a notification
	if delayOnce is false then
		delay 5
		set delayOnce to true
	end if
	display notification executeApp with title "App Starting Notification" subtitle "Starting…"
	
	-- wait a bit until the next application will be launching
	delay theDelay
	tell application "Finder" to set visible of process executeApp to false
	
	-- my textmate starts on space 2, but i want to go back to space 1 after its launch
	-- I really don't know how to prevent
	if executeApp as string is "TextMate" then
		tell application "System Events"
			delay theDelay
			-- go back to space 1
			keystroke "1" using control down
		end tell
	end if
	
end repeat
-- =====================================================================
-- =         loginitems by Zettt from Mac OS X Screencasts             =
-- =====================================================================
-- = This script is an attempt to fasten login times                   =
-- = The original idea came from Mac OS X Hints                        =
-- = Thanks, guys, you've been a great inspiration                     =
-- = http://hints.macworld.com/article.php?story=20091108173250445     =
-- =====================================================================
-- = Checkout the screencast as well                                   =
-- = http://macosxscreencasts.com/en/tutorial/schnellerer-mac-tutorial =
-- =====================================================================
-- = I'm not responsible for any harm to your computer.                =
-- =====================================================================

-- A list of apps that are allowed in Login Items
-- !!! Everything else will be removed !!!
set allowedAppList to {"loginitems", "Alfred"}
-- Initial delay
set initialDelay to 20
-- Delay between each application launch
set theDelay to 4
-- List of apps to start (Please keep GrowlHelperApp at the _beginning_ if you want to get Growl notifications!)
set executeAppList to {"GrowlHelperApp", "BusyCalAlarm", "Dropbox", "Alfred", "Keyboard Maestro Engine", "TextExpander", "HazelHelper", "MercuryMoverAgent", "TextMate", "Watts"} as list

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
delay initialDelay

-- Needed to delay 
set delayOnce to false

repeat with executeApp in executeAppList
	
	-- launch the current app 
	tell application executeApp to launch
	
	-- display a growl notification
	tell application "GrowlHelperApp"
		-- wait a couple of seconds to let growl launch
		if delayOnce is false then
			delay 5
			set delayOnce to true
		end if
		
		-- send the notification...
		notify with name ¬
			"App Starting Notification" title ¬
			"Starting..." description ¬
			executeApp application name "System"
	end tell
	
	-- wait a bit until the next application launches
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
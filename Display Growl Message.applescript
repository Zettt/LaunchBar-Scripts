-- written by Zettt (http://www.zettt.de) at 2009-04-28
-- modified version of http://forums.obdev.at/viewtopic.php?f=24&t=615 to work with Growl
-- this script display a growl message after a given delay time
--
-- Usage: Call LaunchBar, Hit Space, Input your message and provied your delay time at the end in "3s", "1m" or "2d" (without quotes) 
-- Example: "This is an example message 2s" (without quotes)

-- take string from LaunchBar
on handle_string(message)
	set future_message to message as text
	
	-- how much delay do we need?
	set delay_word to last word of message
	
	tell application "LaunchBar"
		-- Encode message for URL; strip delay time
		do shell script "/usr/bin/python -c 'import sys, urllib; print urllib.quote(unicode(sys.argv[1], \"utf8\"))' " & quoted form of (text 1 thru ((length of message) - ((length of delay_word) + 1)) of message)
		set delay_time to result
		
		-- Determine seconds, minutes, hours or days
		set time_multiplier to 1
		if last character of delay_word = "m" then set time_multiplier to 60
		if last character of delay_word = "h" then set time_multiplier to 60 * 60
		if last character of delay_word = "d" then set time_multiplier to 60 * 60 * 24
		set delay_value to text 1 thru ((length of delay_word) - 1) of delay_word
		
		-- delay the message
		delay delay_word
		
	end tell
	
	-- display growl message
	my growlRegister()
	my growlNotify("LaunchBar", future_message)
	
end handle_string

-- additional scripting for Growlnotification
using terms from application "Growl"
	on growlRegister()
		tell application "Growl"
			register as application "LaunchBar" all notifications {"Message from the past"} default notifications {"Message from the past"} icon of application "LaunchBar.app"
		end tell
	end growlRegister
	on growlNotify(grrTitle, grrDescription)
		tell application "Growl"
			notify with name "Message from the past" title grrTitle description grrDescription application name "LaunchBar"
		end tell
	end growlNotify
end using terms from
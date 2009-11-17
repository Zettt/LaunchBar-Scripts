-- Display Alert 1.1 for LB 5 RC2
-- this script displays a large typed message after a given delay time
--
-- originally written by ludwigschubert http://forums.obdev.at/viewtopic.php?f=24&t=615
-- modified by Zettt (http://www.zettt.de) at 2009-05-04
-- thanks to ptujec for providing additional information about changed AppleScript terms
--
-- Usage: Call LaunchBar, Hit Space, Input your message and provied your delay time at the end in "3s", "1m" or "2d" (without quotes) 
-- Example: "This is an example message 2s" (without quotes)

-- take string from LaunchBar
on handle_string(message)
	set future_message to message as text
	
	tell application "LaunchBar"
		-- we don't need to talk with LaunchBar from here. But it's nice to have a LaunchBar icon in the following dialogs. :)
		
		-- how much delay do we need?
		set delay_word to last word of message
		
		-- strip away last word of message
		set delay_word_length to length of delay_word
		set message_length to length of future_message
		set future_message to (characters 1 thru (message_length - delay_word_length) of future_message) as string
		
		-- display it in large type
		display in large type future_message after delay delay_word
	end tell
end handle_string
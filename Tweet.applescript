--   This script was put together with the help of the following sources:
--   http://blog.codahale.com/2007/01/15/tweet-twitter-quicksilver/ by Coda Hale
--   http://i.grahamenglish.net/540/iquicktwitter-my-quicksilver-twitter-ichat-growl-hack/ by Graham English
--   http://www.leancrew.com/all-this/2009/02/url-shortening-scripts-fixed-i-think/ by @drdrang (fix for &ampersand issues)
--   put together and adapted by @ptujec to work with LaunchBar
--   minor changes to convert urls to tiny versions by @ctwise (http://tedwise.com)
--   Some additions by @zettt (http://www.zettt.de): 
-- 		1. Copy the tweet to the clipboard if the tweet exceeds 140 character count. (for extra safeness)
--		2. Shorten links to https:// sites 
--		3. Now you dont have to provide a link at the end of your tweet. This script checks if there is a link on your clipboard and pastes that one at the end of your tweet. In order to work you have to provide a "y" at the end of your tweet to check clipboard. "y" stands for "yes check clipboard" or similiar. ;)
-----------------------------------------------------------------------   

-- take string from LaunchBar
on handle_string(tweet)
	
	-- if last word is a y then clipboard should be checked for a url. If not ignore clipboard
	if last word of tweet is "y" then
		set tweet to (characters 1 thru ((length of tweet) - 2) of tweet) as string
		-- check if tweet contains a link already
		if tweet does not contain "http://" and tweet does not contain "https://" then
			set tweet to check_clipboard(tweet)
		end if
	end if
	
	-- shorten urls
	set tweet to replace_http(tweet)
	
	-- count words
	if length of tweet > 140 then
		-- notify when tweet contains more than 140 characters
		my growlRegister()
		growlNotify("Tweet too long", ("(" & length of tweet as text) & ") characters")
		set the clipboard to tweet as text
		return nothing
	end if
	
	--do tweetescape
	set tweet_new to tweetescape(tweet)
	
	-- take logininformation from keychain
	tell application "Keychain Scripting"
		set twitter_key to first Internet key of current keychain whose server is "twitter.com"
		set twitter_login to quoted form of (account of twitter_key & ":" & password of twitter_key)
	end tell
	
	-- update twitter
	set twitter_status to quoted form of ("source=launchbarat&status=" & tweet_new)
	set results to do shell script "curl --user " & twitter_login & " --data-binary " & twitter_status & " http://twitter.com/statuses/update.json"
	
	-- display dialog results
	my growlRegister()
	-- you can change "Tweet" into a diffent text e.g. "Zwitscher"
	my growlNotify("Tweet", tweet)
end handle_string

-- fix for &ampersand issues (by @drdrang)
on tweetescape(tweet)
	set cmd to "\nfrom urllib import quote\nprint quote(\"\"\"" & tweet & "\"\"\", \"/:\")\n"
	return (do shell script "python -c " & (quoted form of cmd))
end tweetescape

-- additional scripting for Growlnotification
using terms from application "GrowlHelperApp"
	on growlRegister()
		tell application "GrowlHelperApp"
			register as application "Tweet" all notifications {"Alert"} default notifications {"Alert"} icon of application "Launchbar.app"
		end tell
	end growlRegister
	on growlNotify(grrTitle, grrDescription)
		tell application "GrowlHelperApp"
			notify with name "Alert" title grrTitle description grrDescription application name "Tweet"
		end tell
	end growlNotify
end using terms from

-- This uses the built in splitting in AppleScript.
-- Most of the code just restores the delimiters.
on split(theText, splitText)
	set tid to AppleScript's text item delimiters
	set AppleScript's text item delimiters to splitText
	set theTextItems to text items of theText
	set AppleScript's text item delimiters to tid
	return theTextItems
end split

-- I tried the opposite of the split implementation but for some
-- reason it doesn't work reliably
on join(theList, joinText)
	set result to ""
	repeat with theToken in theList
		if length of result = 0 then
			set result to theToken
		else
			set result to result & joinText & theToken
		end if
	end repeat
	return result
end join

-- Send the url to is for shortening
on shorten_url(theURL)
	set theURL to tweetescape(theURL)
	set results to do shell script "curl http://is.gd/api.php?longurl=" & theURL
	return results
end shorten_url

-- Find everything that looks like a URL and shorten it
-- The number 25 is the length of a tiny url, no point in
-- shortening a url if it's already below that.
on replace_http(theText)
	set tokens to split(theText, " ")
	set output to {}
	repeat with theToken in tokens
		if (theToken starts with "http://") and length of theToken > 25 then
			set the end of output to shorten_url(theToken)
		else
			set the end of output to theToken
		end if
	end repeat
	return join(output, " ")
end replace_http

-- Check if there is a link on the clipboard already
-- If there is a link join it to the tweet
on check_clipboard(theTweet)
	set clipboard_contents to the clipboard as text
	if clipboard_contents contains "http://" or clipboard_contents contains "https://" then
		set theTweet to theTweet & " " & clipboard_contents
	end if
	return theTweet
end check_clipboard
-- Keep in mind that you have to allow Twitpic.com to post to Twitter in order to get this script working properly!

-- Upload picture and post a new Tweet
-- curl -F media=@/full/path/to/your/image.jpg -F username=YOUR_TWITTER_USERNAME -F password=YOUR_TWITTER_PASSWORD -F message=\"your twitter message\" http://twitpic.com/api/uploadAndPost
-- just upload to Twitpic
-- curl -F media=@/full/path/to/your/image.jpg -F username=YOUR_TWITTER_USERNAME -F password=YOUR_TWITTER_PASSWORD http://twitpic.com/api/upload

on handle_string(tweet)
	
	-- length of Twitpic URL is 25 characters so we substract that from the tweet length
	-- example "http://twitpic.com/39lox - "	
	if length of tweet > 115 then
		my growlRegister()
		growlNotify("Tweet too long", "(" & length of tweet & ") characters")
		set the clipboard to tweet as text
		return nothing
	end if
	
	-- take logininformation from keychain
	tell application "Keychain Scripting"
		set twitter_key to first Internet key of current keychain whose server is "twitter.com"
		set twitter_username to account of twitter_key
		set twitter_password to password of twitter_key
	end tell
	
	set picture_path to choose file
	set picture_path to quoted form of (POSIX path of picture_path)
	
	set cmd to "curl -F media=@" & picture_path & " -F username=" & twitter_username & " -F password=" & twitter_password & " -F message=" & quoted form of tweet & " http://twitpic.com/api/uploadAndPost"
	do shell script cmd
	
	-- display Growl notification
	my growlRegister()
	-- you can change "Tweet" into a diffent text e.g. "Zwitscher"
	growlNotify("Tweet", tweet)
	
end handle_string

on run
	-- take logininformation from keychain
	tell application "Keychain Scripting"
		set twitter_key to first Internet key of current keychain whose server is "twitter.com"
		set twitter_username to account of twitter_key
		set twitter_password to password of twitter_key
	end tell
	
	set picture_path to choose file
	set picture_path to quoted form of (POSIX path of picture_path)
	
	set cmd to "curl -F media=@" & picture_path & " -F username=" & twitter_username & " -F password=" & twitter_password & " http://twitpic.com/api/upload"
	set received_xml to do shell script cmd
	
	-- set picture_url to the <mediaurl> received from Twitpic
	-- this is ugly coding, but it works. ;) 
	set picture_url to paragraph 4 of received_xml
	set picture_url to characters 12 thru 35 of picture_url as text
	--display dialog picture_url
	
	-- better way to parse xml data
	--tell application "System Events"
	--	set picture_url to XML data of received_xml
	--	display dialog picture_url
	--end tell
	
	-- copy picture url to clipboard
	set the clipboard to picture_url as text
	
	-- display Growl notification
	my growlRegister()
	-- you can change "Tweet" into a diffent text e.g. "Zwitscher"
	growlNotify("Picture URL: ", picture_url as text)
end run

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
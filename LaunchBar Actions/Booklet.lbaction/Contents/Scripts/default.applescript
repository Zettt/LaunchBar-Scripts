(*
Open Google Chrome Bookmarklet
This Action runs a bookmarklet, in Chrome, from LaunchBar

Icons are from
https://www.iconfinder.com/icons/728913/book_bookmark_learning_library_reading_school_study_icon#size=128
https://www.iconfinder.com/icons/763426/bookmark_bookmarks_common_favorite_favourite_icon#size=128

Created by Andreas "Zettt" Zeitler on 2016-03-25
Mac OS X Screencasts, zCasting 3000
*)
-- Changes
-- 1.0: Initial version.

-- return list of all perspectives (with a nice fancypants icon)
on run
	set returnValue to {}
	set bookmarkletList to {"Instapaper", "Pinboard", "OmniFocus"}
	
	repeat with i in bookmarkletList
		set thisBookmarklet to i as string
		set returnValue to returnValue & [{title:thisBookmarklet, action:"runBookmarklet", actionArgument:thisBookmarklet, icon:"Bookmark Icon.pdf"}]
	end repeat
	
	return returnValue
end run

-- open perspective directly
-- note: this is case sensitive!
on handle_string(_bookmkarklet)
	-- in the future we could try to run a bookmarklet by the string passed into it
end handle_string

on runBookmarklet(_bookmarklet)
	set bookmarklet to _bookmarklet
	tell application "System Events" to tell process "Google Chrome"
		try
			click (menu item 1 where its name contains bookmarklet) of menu 1 of menu bar item "Bookmarks" of menu bar 1
		on error
			try
				click (menu item 1 where its name contains bookmarklet) of menu 1 of menu item "More" of menu 1 of menu bar item "Bookmarks" of menu bar 1
			on error
				return "No bookmarklet found with that name."
			end try
		end try
	end tell
	--tell application "LaunchBar" to deactivate
	tell application "Google Chrome" to activate
end runBookmarklet
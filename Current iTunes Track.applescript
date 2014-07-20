-- Current iTunes Track
-- 
-- Created by Zettt on 2010-05-06
-- Copyright 2010 Mac OS X Screencasts. All rights reserved.
-- http://www.macosxscreencasts.com
--
-- Version: 1.3
-- 1.0: Initial release
-- 1.1: Check if iTunes is running
-- 1.2: Check if iTunes is playing, paused or stopped
-- 1.3: Now uses OS X's built in Notification Center instead of Growl
--

set iTunesIsRunning to false

-- figure out if itunes is running
tell application "System Events"
	if process "iTunes" exists then set iTunesIsRunning to true
end tell

-- itunes is running. display notification
if iTunesIsRunning is true then
	
	tell application "iTunes"
		
		-- check whether iTunes is playing
		if player state is stopped or player state is paused then
			-- iTunes is not playing 
			display notification Â
				"iTunes isn't playing any track" with title Â
				"Song Notification"
			
		else if player state is playing or player state is paused then
			-- iTunes is paused or playing
			
			-- get song information from iTunes
			set currentSong to name of current track as string
			set currentArtist to artist of current track as string
			set currentAlbum to album of current track as string
			
			-- show notificiation
			display notification currentSong with title "Song Notification" subtitle currentArtist
		end if
	end tell
	
	
else if iTunesIsRunning is false then
	-- iTunes is not running display a fail notification
	display notification Â
		"iTunes is not running" with title "Song Notification"
	
	
end if


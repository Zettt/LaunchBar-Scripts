(*
	lselect 1.1 by Jim DeVona
	http://anoved.net/lselect.html
	1.0: 1 November 2006
	1.1: 18 December 2006 (somewhat improved Column view behavior)
		
	Select files in the current Finder folder using shell glob syntax.
	When invoked, the user will be prompted to supply a glob pattern.
	The "ls" command line utility is used to determine which files match
	the pattern, and then they are selected.
	
	Suggested installation location:
		~/Library/Scripts/Applications/Finder/lselect.scpt
	
	The script can be invoked with the standard Mac OS X Script Menu,
	but I've found FastScripts (http://www.red-sweater.com/fastscripts/)
	to be a preferable alternative, primarily because of the ease with 
	which reliable keyboard bindings can be assigned. I use Command-G.
	
	Issues:
		- If the last match is a directory and the current view type is
		  Column, other matches will not end up selected (they appear
		  to lose selection when the Finder come to rest on and reveals the
		  contents of the last directory). I don't know how to prevent this.
		- Spaces must be escaped to match properly: "iTunes\ Music"
		- Performance is poor with hundreds of matches; see notes below
	
	Wishes:
		- Select sub-matches within current selection
		- Select matches on desktop instead of in "Desktop" window
		- Support patterns like "../" (subfolder patterns work, but not parent)
*)

tell application "Finder"
	
	(*
		Determine the present working directory as alias and POSIX path.
		If the insertion location is not a folder, use its parent. This is the
		case when a file is selected in Column view (otherwise, file selections
		do not seem to be treated as the insertion location).
	*)
	set pwdAlias to insertion location as alias
	if not (exists folder pwdAlias) then
		set pwdAlias to (container of pwdAlias) as alias
	end if
	set pwd to POSIX path of pwdAlias
	
	(*
		Ask the user what to select. Dialog time out is equivalent to cancellation.
		The default "Select Matches" option clears the current Finder selection,
		whereas "Add Matches" leaves it intact. Clearing the selection is not done
		in Column view if the displayed folder is the only thing selected.
	*)
	tell application "System Events"
		activate
		set dr to display dialog "Glob pattern:" default answer "" buttons {"Cancel", "Add Matches", "Select Matches"} default button 3 cancel button 1 with title pwd giving up after 60
		if button returned of dr is equal to "" then
			return
		else if button returned of dr is equal to "Select Matches" then
			try
				-- do not clear selection if the only thing selected is the focal folder
				if selection as alias is not equal to pwdAlias then select {}
			on error
				-- more than one thing already selected
				select {}
			end try
		end if
	end tell
	
	-- Make Finder become the foreground application again
	activate
	
	(*
		Initialize list of selected files. Generally identical to selection returned
		by Finder, except the present working directory should not be included,
		which is initially selected in some Column view circumstances (see above).
		This is a little clumsy; selection state is vaguely defined in Column view.
	*)
	set selectables to selection
	try
		if selection as alias is equal to pwdAlias then set selectables to {}
	end try
	
	(*
		Get the glob pattern given by the user.
		We treat a blank pattern as cancellation (use * to select everything).
		Alternatively, omit this conditional to select the containing folder;
		this ought to be the default behavior once "../" issues are ironed out.
	*)
	set query to text returned of dr
	if query = "" then return
	
	(*
		Ask ls for a listing of files that match the given pattern.
		From the ls man page:
			-d Directories are listed as plain files (not searched recursively).
		If nothing matches the query, ls will return an error; just stop.
	*)
	try
		tell me to set matches to do shell script ("/bin/ls -d " & quoted form of pwd & query)
	on error
		return
	end try
	
	(*
		Parse each line of the response from ls as the path to a match.
		The visibility test is twofold: the "info for" test throws an error on
		Icon^M (the full name doesn't survive all translations and transmissions).
		This try-info-for-visibilty test is the main bottleneck;
		for faster handling of many matches (100s), replace this
		repeat body with "set end of selectables to matchpath as POSIX file"
	*)
	repeat with matchpath in paragraphs of matches
		set posixmatch to matchpath as POSIX file
		try
			set fileinfo to info for posixmatch without size
			if visible of fileinfo then set end of selectables to posixmatch
		end try
	end repeat
	
	(*
		Conclude by selecting the results.
		The "try" protects against cases we don't [yet] handle,
		such as certain "../" path traversals and anything else that may come up.
		If the last item of selectables is a directory and we're using
		Column view, other items may not end up selected.
	*)
	try
		select every item of selectables
	on error errMsg number errNum
		tell application "System Events"
			display alert "Could not make selection (" & errNum & "):" message errMsg as critical
			return
		end tell
	end try
	
	
end tell
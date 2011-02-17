-- Things to Pomodoro App for iPad
-- This script asks Things for the currently selected todos
-- and generates a Pomodoro App for iPad compatible JSON file
-- for you to import in to the app (using Dropbox)
--
-- Created by Thomas on 2011-02-17
-- Inspired by Andreas on 2011-02-17
-- Modified by Andreas on 2011-02-17
-- Original: https://gist.github.com/832075
-- https://gist.github.com/831942


set estimateItems to {}

set JSONresult to ""
set JSONresults to {}
set JSONBeginning to "[\n"
set JSONresult to ""
set JSONresults to {}
set JSONBeginning to "[\n"
set JSONEnd to "]"
set JSONTaskBegin to "\t{\n"
set JSONTaskEstimate to "\t\t\"estimate\":"
set JSONTaskEnd to "\t}\n"
set JSONTaskListEnd to "\t},\n"
set JSONTaskList to "\t\t\"list\":0,\n"
set JSONTaskTitle to "\t\t\"title\":\""

set UserHome to (POSIX path of (path to home folder)) as string
set JSONfilename to UserHome & "Dropbox/Pomodoro/tasks.json" as string
set JSONpattern to UserHome & "Dropbox/Pomodoro/*.json" as string

set clipboardContent to ""
set cmd to ""
set fileCheck to ""

-- this routine displays a dialog where the user can set an estimate amount of pomodoros for each task on the clipboard
tell application "Things"
	repeat with aToDo in selected to dos
		if (project of aToDo) is not missing value then
			set todoDataRow to "" & Â
				(name of project of aToDo) & ": " & Â
				(name of aToDo) & tab
		else if (area of aToDo) is not missing value then
			set todoDataRow to "" & Â
				(name of area of aToDo) & ": " & Â
				(name of aToDo) & tab
		else
			set todoDataRow to "" & Â
				(name of aToDo) & tab
		end if
		
		set estimateDialog to display dialog "Estimate: " & todoDataRow default answer Â
			"2" buttons {"Cancel", "OK"} default button {"OK"}
		
		if (button returned of estimateDialog is "OK") and (text returned of estimateDialog is not "") then
			copy text returned of estimateDialog to the end of estimateItems
		else if (button returned of estimateDialog is "OK") and (text returned of estimateDialog is "") then
			set amount to "2" -- default estimate is 2
		else if (button returned of estimateDialog is "Cancel") then
			return
		end if
		
		set clipboardContent to clipboardContent & "\n" & todoDataRow
	end repeat
end tell

set clipboardContentLines to (count paragraphs of clipboardContent) - 1 -- get count of lines on clipboard

-- now we're stitching everything together
repeat with i from 1 to clipboardContentLines
	if i is not equal to clipboardContentLines then -- last item needs to be handled differently. FU JSON!
		set end of JSONresults to JSONTaskBegin & Â
			JSONTaskEstimate & (item i of estimateItems) & ",\n" & Â
			JSONTaskList & Â
			JSONTaskTitle & (paragraph i of clipboardContent) & "\"\n" & Â
			JSONTaskListEnd
		
	else
		set end of JSONresults to JSONTaskBegin & Â
			JSONTaskEstimate & (item i of estimateItems) & ",\n" & Â
			JSONTaskList & Â
			JSONTaskTitle & (paragraph i of clipboardContent) & "\"\n" & Â
			JSONTaskEnd
		
	end if
end repeat

repeat with i from 1 to clipboardContentLines
	set JSONresult to JSONresult & (item i of JSONresults)
end repeat

set JSONresult to JSONBeginning & JSONresult & JSONEnd

-- check whether file exists
try
	-- the file exists already. Let's delete it.
	set fileCheck to do shell script "/bin/ls " & JSONfilename
	if fileCheck is equal to JSONfilename then
		set fileMove to "rm " & (quoted form of JSONpattern)
		do shell script fileMove
	end if
on error
	-- apparently there's no tasks.json file yet, so let's create it
	do shell script "touch " & (quoted form of JSONfilename)
end try

--return cmd
set cmd to "echo " & (quoted form of JSONresult) & " > " & (quoted form of JSONfilename) -- yeah, i know i suck for not using applescript here.
do shell script cmd
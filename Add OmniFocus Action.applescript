(*
	Copyright 2006-2007 The Omni Group.  All rights reserved.
	Modified for LaunchBar by Brendan Donohoe.
	Modified for Keyboard Maestro, FastScripts and so on by Andreas Zeitler www.macosxscreencasts.com 
*)

global MyDoc
global Section_Projects, Project_Default, Column_Context_Index, Column_Project_Index, Section_Inbox

on universal_function(actionString)
	-- Check to see if we've got text, ask for it if not
	if actionString is equal to "" then
		tell application "System Events"
			activate
			set question to display dialog ("Enter text:") default answer ""
			set actionString to text returned of question
		end tell
	end if
	my PushToFocus(actionString)
end universal_function


on handle_string(actionString)
	if (length of actionString is not 0) then
		my universal_function(actionString)
	end if
	open location "x-launchbar:hide"
end handle_string

my universal_function("")

(* --tests
PushToFocus("iTo duplicate>proj@cont
TEST
TEST") --test call
PushToFocus("in project, no context>proj") --test call
PushToFocus("inbox context only, no project@cont") --test call
PushToFocus("inbox item, no project or context") --test call
*)

(*
--------------------------------------------------------------------------------------------------------------------------
HANDLER: PushToFocus
--------------------------------------------------------------------------------------------------------------------------
*)
on PushToFocus(IncomingString)
	tell application "OmniFocus"
		set MyDoc to default document
		
		(* parse string and create new task *)
		
		set ParseString to first paragraph of IncomingString
		if (count of paragraphs of IncomingString) > 1 then
			set ThisNote to IncomingString
			--set ThisNote to texts from paragraph 2 to paragraph -1 of IncomingString
		else
			set ThisNote to ""
		end if
		
		set ParseResults to ParseIncomingTask of me given StringToParse:ParseString, FallbackProject:"", FallbackContext:""
		set MyProject to (taskProject of ParseResults)
		set MyContext to (TaskContext of ParseResults)
		set MyTaskTopic to (TaskTopic of ParseResults)
		
		tell MyDoc
			if MyContext is equal to null and MyProject is equal to null then
				set myTask to make new inbox task with properties {name:MyTaskTopic, note:ThisNote}
			else if MyContext is equal to null and MyProject is not equal to null then
				tell MyProject
					set myTask to make new task with properties {name:MyTaskTopic, note:ThisNote}
				end tell
			else if MyProject is equal to null and MyContext is not equal to null then
				set myTask to make new inbox task with properties {name:MyTaskTopic, context:MyContext, note:ThisNote}
			else
				tell MyProject
					set myTask to make new task with properties {name:MyTaskTopic, context:MyContext, note:ThisNote}
				end tell
			end if
			if (name of myTask is MyTaskTopic) then --Pretty weak success test, but it's what I could do.
				my growlNotify(MyTaskTopic)
			end if
		end tell
	end tell
end PushToFocus

on growlNotify(actionString)
	tell application "System Events"
		set isRunning to Â
			(count of (every process whose name is "GrowlHelperApp")) > 0
	end tell
	
	if isRunning then
		tell application "GrowlHelperApp"
			set the allNotificationsList to {"Action Added"}
			set the enabledNotificationsList to {"Action Added"}
			
			register as application Â
				"OmniFocus LaunchBar Script" all notifications allNotificationsList Â
				default notifications enabledNotificationsList Â
				icon of application "OmniFocus"
			
			notify with name Â
				"Action Added" title Â
				"Action Added" description Â
				actionString application name "OmniFocus LaunchBar Script"
		end tell
	end if
end growlNotify

(*
--------------------------------------------------------------------------------------------------------------------------
HANDLER: ParseIncomingTask
Analyzes expected string for possible format variations (assuming whitespace inconsistencies). Returns four values (fourth being everything after first paragraph of string, being the possible notes of the task).
TASK SUBJECT > PROJECT CODE @ CONTEXT
TASK SUBJECT > "NEW" @ CONTEXT - new project
TASK SUBJECT > "1" @ CONTEXT - singleton
TASK SUBJECT @ CONTEXT - no project, but will either assign to default proj based on calendar or user preferences on single/unfiled tasks
TASK SUBJECT > PROJ CODE | "NEW" | "1" - no context, just project, will be inactive
TASK SUBJECT - no project, no context, will be inactive but can still receive a project based on calendar or user defaults
Returns a task topic
Returns a project parent id or missing value
Returns a context value or missing value
--------------------------------------------------------------------------------------------------------------------------
*)

on ParseIncomingTask given StringToParse:SomeString, FallbackProject:SomeProject, FallbackContext:SomeContext
	
	set ProjectInfix to ">"
	set ContextInfix to "@"
	set NewProjectFlag to "new"
	set SingletonsProjectFlag to "1"
	
	if SomeString = "" or SomeString = missing value then return
	
	try
		set SomeString to SomeString as text
	on error
		return
	end try
	
	set FirstLine to first paragraph of SomeString
	log FirstLine
	log text items of FirstLine
	log words of FirstLine
	set TheseWords to words of FirstLine
	set ProjectInfixOffset to offset of ProjectInfix in FirstLine
	set ContextInfixOffset to offset of ContextInfix in FirstLine
	set ShoudlResetTodoTopic to true -- only set to false below if parsing of proj/context infixes fails
	
	set OldDelims to text item delimiters
	set text item delimiters to " "
	if ProjectInfixOffset > 1 and ContextInfixOffset > ProjectInfixOffset then
		set TopicString to text from character 1 to character (ProjectInfixOffset - 1) of FirstLine
		set ProjectString to text from character (ProjectInfixOffset + 1) to character (ContextInfixOffset - 1) of FirstLine
		set ContextString to text from character (ContextInfixOffset + 1) to character -1 of FirstLine
		set TopicString to (words of TopicString as text)
		set ProjectString to (words of ProjectString as text)
		set ContextString to (words of ContextString as text)
	else if ContextInfixOffset > 1 and ProjectInfixOffset > ContextInfixOffset then
		set TopicString to text from character 1 to character (ContextString - 1) of FirstLine
		set ContextString to text from character (ContextInfixOffset + 1) to character (ProjectInfixOffset - 1) of FirstLine
		set ProjectString to text from character (ProjectInfixOffset + 1) to character -1 of FirstLine
		set TopicString to (words of TopicString as text)
		set ProjectString to (words of ProjectString as text)
		set ContextString to (words of ContextString as text)
	else if ProjectInfixOffset > 1 then
		set TopicString to text from character 1 to character (ProjectInfixOffset - 1) of FirstLine
		set ProjectString to text from character (ProjectInfixOffset + 1) to character -1 of FirstLine
		set TopicString to (words of TopicString as text)
		set ProjectString to (words of ProjectString as text)
		set ContextString to false
	else if ContextInfixOffset > 1 then
		set TopicString to text from character 1 to character (ContextInfixOffset - 1) of FirstLine
		set ContextString to text from character (ContextInfixOffset + 1) to character -1 of FirstLine
		set TopicString to (words of TopicString as text)
		set ContextString to (words of ContextString as text)
		set ProjectString to false
	else -- have only task topic
		set ShoudlResetTodoTopic to false
		set TopicString to FirstLine
		set ContextString to false
		set ProjectString to false
	end if
	set text item delimiters to OldDelims
	
	(* identify project and context, creating new project if necessary *)
	
	set ThisProject to null
	set ThisContext to null
	
	tell application "OmniFocus" to tell MyDoc
		
		if (ProjectString = false) and (SomeProject ­ "") and (SomeProject ­ missing value) then set ThisProject to SomeProject
		
		if ProjectString = NewProjectFlag then -- new project, chosen by user
			set ThisProject to (make project with properties {name:TopicString})
		else if ProjectString ­ false then -- had a possible good parsed Project
			set MyProjectArray to null
			tell MyDoc
				set MyProjectArray to complete ProjectString as project maximum matches 1
			end tell
			try
				set MyProjectID to id of first item of MyProjectArray
				set ThisProject to project id MyProjectID
			on error
				set ThisProject to (make project with properties {name:ProjectString})
			end try
		end if
		
		
		(* confirm good context, filling it out if there is no full match and only a partial match, setting to false if not even a partial *)
		-- no parsed context, try fallback
		if (ContextString = false) and (SomeContext ­ "") and (SomeContext ­ missing value) then set ThisContext to SomeContext
		
		if ContextString ­ false then -- had a possible good parsed context 
			set MyContextArray to null
			tell MyDoc
				set MyContextArray to complete ContextString as context maximum matches 1
				if ((count of MyContextArray) > 0) then
					set MyContextID to id of first item of MyContextArray
					set ThisContext to context id MyContextID
				else
					set ThisContext to (make context with properties {name:ContextString})
				end if
			end tell
		end if
	end tell
	
	set ReturnValues to {TaskTopic:TopicString, taskProject:ThisProject, TaskContext:ThisContext, ResetTodoTopic:ShoudlResetTodoTopic}
	return ReturnValues
	
end ParseIncomingTask
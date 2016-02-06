(*
Focus LaunchBar
Toggles Focus.app or let's you focus for a specific amount of time

Created by Andreas "Zettt" Zeitler on 2015-12-04
Use as you wish. Andreas Zeitler 2015.
*)
-- Changes
-- 1.0: Initial version.

(*
Turn focus on
open focus://focus

Turn focus off
open focus://unfocus

Turn focus on for 15 minutes
open focus://focus?minutes=15

Toggle focus
open focus://toggle
*)

on run
	if application "Focus" is not running then
		launch application "Focus"
	end if
	
	open location "focus://toggle"
	return
end run

on handle_string(_time)
	set _time to _time
	my focusForTime(_time)
end handle_string

on focusForTime(_time)
	if application "Focus" is not running then
		launch application "Focus"
	end if
	
	open location "focus://unfocus"
	delay 0.4
	open location "focus://focus?minutes=" & _time
end focusForTime

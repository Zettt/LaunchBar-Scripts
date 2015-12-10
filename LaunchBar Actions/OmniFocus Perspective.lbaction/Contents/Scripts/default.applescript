(*
Open OmniFocus Perspectvie
This LaunchBar Action opens an OmniFocus Perspective directly

Icon used is from Josh Hughes
https://github.com/deaghean/omnifocus-perspective-icons

Created by Andreas "Zettt" Zeitler on 2015-12-10
Mac OS X Screencasts, zCasting 3000
*)
-- Changes
-- 1.0: Initial version.

-- return list of all perspectives (with a nice fancypants icon)
on run
	set returnValue to {}
	
	tell application "OmniFocus" to set perspectiveNames to perspective names
	
	repeat with i in perspectiveNames
		set thisPerspective to i as string
		set returnValue to returnValue & [{title:thisPerspective, |url|:"omnifocus:///perspective/" & thisPerspective, icon:"OF Perspective Icon.pdf"}]
	end repeat
	
	return returnValue
end run

-- open perspective directly
-- note: this is case sensitive!
on handle_string(perspective)
	open location "omnifocus:///perspective/" & perspective
end handle_string

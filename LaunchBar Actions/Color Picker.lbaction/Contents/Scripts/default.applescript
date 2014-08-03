(*
Color Picker
Brings up the OS X color picker.

Created by Andreas "Zettt" Zeitler on 2014-08-03
With some help from here: http://lists.apple.com/archives/applescript-users/2004/Jul/msg00469.html
Mac OS X Screencasts, zCasting 3000.
*)
-- Changes
-- 1.0: Initial version.
-- 1.1: Hex conversion and string input

on run
	activate
	choose color
end run

on handle_string(_color)
	set defaultColor to hexToRGB(_color)
	
	activate
	choose color default color defaultColor
	return
	
end handle_string

on hexToRGB(_hexValue)
	if _hexValue starts with "#" then
		set hexValue to text 2 through (count of _hexValue) of _hexValue -- strip the '#"
	else
		set hexValue to _hexValue
	end if
	
	set RGBsmall to {0, 0, 0} -- range 0 -> 255, RGBsmall is here to check the result more easily
	set RGBbig to {0, 0, 0} -- range 0 -> 65535
	
	repeat with k from 1 to count of hexValue by 2
		set hex to text k through (k + 1) of hexValue
		set numX to getIndex(first character of hex)
		set numY to getIndex(second character of hex)
		
		set dec to ((numX * (16 ^ 1) + numY * (16 ^ 0)))
		
		set item ((k div 2) + 1) of RGBsmall to dec
		set item ((k div 2) + 1) of RGBbig to ((dec + 1) * 256) - 1
		
	end repeat
	
	--log RGBsmall
	--log RGBbig
	
	return RGBbig
end hexToRGB

on getIndex(val)
	set hexList to {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"}
	set indexNum to 0
	repeat with s from 1 to count of hexList
		if item s of hexList is equal to val then
			set indexNum to s - 1
			exit repeat
		end if
	end repeat
	
	return indexNum
end getIndex
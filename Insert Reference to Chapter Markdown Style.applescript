# This script requires the Satimage osax Bundle:
# http://www.satimage.fr/software/en/downloads/downloads_companion_osaxen.html
#
# It also converts rich to plain text. In case you don't need that. Comment it out.
# http://hints.macworld.com/article.php?story=2007090113115019
#
# Script to insert reference to a chapter Markdown style ([][#chapter]
#
# Description: I'm writing my Master thesis in Scrivener and often
# want to reference to other chapters quickly. This scripts aims to help with
# this by getting clipboard contents, then stripping out some characters
# and then replacing the clipboard with a Markdown style link.
# 
# Usage: Select a documents' name in Scrivener, ⌘A, ⌘C, run script, 
# go to desired location in other document, ⌘V.

set clipboardContents to the clipboard

-- make lowercase
set clipboardContents to lowercase clipboardContents

-- strip out characters
set clipboardContents to change {" ", "-", "#", "_", "\"", "/"} into {"", "", "", "", "", ""} in clipboardContents

-- put link stuff in front and back
set clipboardContents to "[][#" & clipboardContents & "]"

set the clipboard to clipboardContents

-- make plain text
try
	set the clipboard to Unicode text of (the clipboard as record)
on error errMsg
	display dialog errMsg
end try
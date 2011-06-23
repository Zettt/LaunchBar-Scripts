-- taken from this post on macosxhins.com http://www.macosxhints.com/article.php?story=20080401232826118
-- written by Zettt 30.03.2009
-- thanks fo Ice|House for help awk and such
-- this script activates fast user switching. 
-- that way you can get rid of the menubar icon for FUS

set username to "USERNAME"
set username to do shell script "/usr/bin/id -u " & username
do shell script "/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -switchToUserID " & username
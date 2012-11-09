# Installation #

	git clone git@github.com:Zettt/LaunchBar-Scripts.git
	mv Actions/* Launchbar-Scripts/
	rmdir Actions/
	mv LaunchBar-Scripts/ Actions/

# ! Newest Additions ! #

* Send to Pocket: Allows to send a URL to Pocket. Actions included for Safari and Chrome. This is even more awesome with [Keyboard Maestro](http://mosx.tumblr.com/post/34720575388).
* Keep reference to this word: A Service that allows you to put a specific looked-up word into a text file on the Desktop. *This is a normal OS X Service and also works with LaunchBar!* Put in `~/Library/Services`, LaunchBar will index it then.

# OmniFocusCLI #

OmniFocusCLI is a project by [Don](https://github.com/binaryghost/OmniFocusCLI) that enables task creation using a small shell script.  

Installation instructions:

	cd ~/Library/Application\ Support\LaunchBar\Actions
	git submodule add https://github.com/binaryghost/OmniFocusCLI.git
	git submodule init
	git submodule update
	ln -s OmniFocusCLI/OmniFocusCLI.sh OmniFocusCLI.sh
	chmod a+x OmniFocusCLI.sh

In Alfred create a new Shell shortcut:

* *Command:* '/Users/YOU/Library/Application Support/LaunchBar/Actions/OmniFocusCLI.sh' {query}
* Run silently.

# loginitems #

I've added a script that is **not** meant to be used with LaunchBar, Alfred or any other launcher. I assumed it's just a nice script to share.

loginitems description:

This script is an attempt to fasten up login times. The original idea came from [Mac OS X Hints](http://hints.macworld.com/article.php?story=20091108173250445). The idea is to "queue up" login items and launch them conscutively rather than all at once.


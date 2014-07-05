# Installation #

	git clone git@github.com:Zettt/LaunchBar-Scripts.git
	mv Actions/* Launchbar-Scripts/
	rmdir Actions/
	mv LaunchBar-Scripts/ Actions/

# Newest Changes #

- Most scripts now use Notification Center instead of Growl. "Most" means that scripts coming from third parties, especially from other projects that are merely linked to this repo as submodules, retain their own notification dependencies, i.e. OmniFocusCLI.
- Moved everything that I personally found unnecessary and added bloat to `_Archive`. Feel free to discuss with me whether the changes I made apply to "most" other folks as well and I'll change my opinion.
	- I've tried to find scripts that don't work anymore (Tweetly; Its dependency SuperTweet has ceased operation).
	- I can't remember from the top of my head what else I changed, but I tried to make this repository leaner and cleaner. I hope you appreciate.
	- Please note: *Deactivate all Actions that you don't use in the Index in LaunchBar! Especially those in `_Archive`!*

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

This script is an attempt to speed up login times. The original idea came from [Mac OS X Hints](http://hints.macworld.com/article.php?story=20091108173250445). The idea is to "queue up" login items and launch them conscutively rather than all at once.

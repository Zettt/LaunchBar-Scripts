# Installation #

	git clone git@github.com:Zettt/LaunchBar-Scripts.git
	mv Actions/* Launchbar-Scripts/
	rmdir Actions/
	mv LaunchBar-Scripts/ Actions/

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

# boxcar-growl #

boxcar-growl allows you to push messages directly to your iOS device from command line and your favorite app launcher. The original project is located [here](https://github.com/sharl/boxcar-growl).

Installation instructions:

	cd ~/Library/Application\ Support\LaunchBar\Actions
	git submodule add https://github.com/sharl/boxcar-growl.git
	git submodule init
	git submodule update
	ln -s boxcar-growl/boxcar-growl boxcar-growl.pl
	chmod a+x boxcar-growl.pl

Don't forget to add your login credentials to your .netrc. Look at subdirectory README *OR* at the page of the [original project by sharl](https://github.com/sharl/boxcar-growl).

In Alfred create a new Shell shortcut:

* *Command:* '/Users/YOU/Library/Application Support/LaunchBar/Actions/boxcar-growl.pl' {query}
* *Wrap in Quotes*: NO
* Run silently.



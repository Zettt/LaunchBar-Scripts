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
	ln OmniFocusCLI/OmniFocusCLI.sh OmniFocusCLI.sh
	chmod a+x OmniFocusCLI.sh

In Alfred create a new Shell shortcut:

* *Command:* '/Users/YOU/Library/Application Support/LaunchBar/Actions/OmniFocusCLI.sh' {query}
* Run silently.

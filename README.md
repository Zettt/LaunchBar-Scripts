# Installation #

This repo contains various scripts for launchers and script runners. To install I created separate folders for each of them. I'll provide instructions for the ones that I use, you can hopefully figure out how this works with your launcher. If it differs much from my instructions. Feel free to send me a pull request of this readme file!

## LaunchBar 6.1 ##

Drag the actions/scripts that you want to use to `~/Library/Application Support/LaunchBar/Actions/` while holding down ⌘ and ⌥. This will create aliases to the original files which will be recognized by LaunchBar. All scripts linked that way will appear in LaunchBar's index.

## Keyboard Maestro ##

With Keyboard Maestro there are two directions you can take.

1. Setup a new macro with an "Execute AppleScript" Action and tell it to execute an external script file.
2. Setup a new macro with an "Execute AppleScript" Action, but this time copy & paste the script.

The former has the advantage that you will always execute the most current version of the script, when you pull a newer version of the repo. The second is better if you don't want any extraneous files on your computer. After adding a new macro, and pasting, you can get rid of the repo and its files.

# Newest Changes #

- Most scripts now use Notification Center instead of Growl. "Most" means that scripts coming from third parties, especially from other projects that are merely linked to this repo as submodules, retain their own notification dependencies, i.e. OmniFocusCLI.
- Moved everything that I personally found unnecessary and added bloat to `_Archive`. Feel free to discuss with me whether the changes I made apply to "most" other folks as well and I'll change my opinion.
	- I've tried to find scripts that don't work anymore (Tweetly; Its dependency SuperTweet has ceased operation).
	- I can't remember from the top of my head what else I changed, but I tried to make this repository leaner and cleaner. I hope you appreciate.
	- Please note: *Deactivate all Actions that you don't use in the Index in LaunchBar! Especially those in `_Archive`!*

# loginitems #

I've added a script that is **not** meant to be used with LaunchBar, Alfred or any other launcher. I assumed it's just a nice script to share.

loginitems description:

This script is an attempt to speed up login times. The original idea came from [Mac OS X Hints](http://hints.macworld.com/article.php?story=20091108173250445). The idea is to "queue up" login items and launch them conscutively rather than all at once.


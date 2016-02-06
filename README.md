# Installation #

This repo contains various scripts for LaunchBar. To install I created separate folders for each of them. I'll provide instructions for the ones that I use, you can hopefully figure out how this works with your launcher. If it differs much from my instructions. Feel free to send me a pull request of this readme file!

## LaunchBar ##

Drag the actions/scripts that you want to use to `~/Library/Application Support/LaunchBar/Actions/` while holding down ⌘ and ⌥. This will create aliases to the original files which will be recognized by LaunchBar. All scripts linked that way will appear in LaunchBar's index.

# Newest Changes #

- The biggest change this repository has received so far: *all* LaunchBar scripts are now Actions.
- I removed all mentions of Keyboard Maestro. This was confusing even me. I intended this repository to be one scripters generally can refer to but it doesn't work out for me. I maintain some script in Keyboard Maestro and some in LaunchBar. There are still some General Scripts in here which you can experiment with.
- I also removed the loginitems script. In the era of SSD it seemed too old. Loved working on it though. Good times, good times.
- Most scripts now use Notification Center instead of Growl. "Most" means that scripts coming from third parties, especially from other projects that are merely linked to this repo as submodules, retain their own notification dependencies, i.e. OmniFocusCLI.
- Moved everything that I personally found unnecessary and added bloat to `_Archive`. Feel free to discuss with me whether the changes I made apply to "most" other folks as well and I'll change my opinion.
	- I've tried to find scripts that don't work anymore (Tweetly; Its dependency SuperTweet has ceased operation).
	- I can't remember from the top of my head what else I changed, but I tried to make this repository leaner and cleaner. I hope you appreciate.
	- Please note: *Deactivate all Actions that you don't use in the Index in LaunchBar! Especially those in `_Archive`!*

# loginitems #

I've added a script that is **not** meant to be used with LaunchBar, Alfred or any other launcher. I assumed it's just a nice script to share.

loginitems description:

This script is an attempt to speed up login times. The original idea came from [Mac OS X Hints](http://hints.macworld.com/article.php?story=20091108173250445). The idea is to "queue up" login items and launch them conscutively rather than all at once.


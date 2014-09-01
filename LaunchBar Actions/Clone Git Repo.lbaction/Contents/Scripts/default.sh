#!/bin/sh
#

cd "$HOME/Downloads/"
git clone "$@"
osascript -e 'display notification "Finished cloning of '$@'" with title "LaunchBar" subtitle "Clone Git Repo"'


#!/bin/sh
#
# Secure Delete Files
# This action uses `srm` to securely delete files passed into it.
#
# Created by Andreas Zeitler on 2016-01-01
# Derived from Open Anyway action by Objective Development Software GmbH
# zCasting 3000, Mac OS X Screencasts 2016.
#
# If you make improvements, please send them my way, so we'll all
# benefit from it.

# Clear quarantine flag on every file passed, then open it:
for f in "$@"
do
	srm -rv "$f"
done

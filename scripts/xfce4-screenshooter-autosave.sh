#!/bin/sh
#
# MAKE SURE TO ALLOW THIS SCRIPT TO RUN AS AN EXECUTABLE
#
# ----- custom xfce4-screenshooter script -----
# autosave a fullscreen screenshot w/ current date appended to the filename.
# uses -f (fullscreen) and -s (save) options, and a $(date) variable,
# bypassing the save window that asks for filename input.
#
# this is a workaround if assigning the following script to keyboard shortcut didn't work:
# >> xfce4-screenshooter -f -s "$HOME/Desktop/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
# >> from official documentation: https://docs.xfce.org/apps/xfce4-screenshooter/usage

# ---- toggle debugging ----
# can run this script in the terminal using
# ./xfce4-screenshooter-autosave
# this output errors useful for troubleshooting why this script didn't work
# un/comment this line to turn debugging on/off
set -x

# ---- get $(date) absolute path ----
# run "which date" in terminal to find $(date)'s absolute path.
# this is used to avoid PATH issues with cron/cronie (and thus empty file output). example:
# > $ which date
# > /usr/bin/date

# ----- get date and set variable -----
# date variable stores full date %F (i.e. %y%m%d), and time %T (24 hr format, i.e. %H:%M:%S)
current_date=$(/usr/bin/date +"%F_%H%M%S")

# ----- call xfce4-screenshooter -----
# use -f and -s options to save fullscreen screenshot (png format)
# designate folder (default is /home/user) and append current_date to filename
xfce4-screenshooter -f -s "$HOME/Screenshots/ss-${current_date}.png"

# ----- example output -----
# a screenshot taken on on oct 25, 2025 at 11:15:30 pm will save as:
# ss-20251025-231530.png

# ----- end -----
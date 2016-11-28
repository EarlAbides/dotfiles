#!/bin/sh
#
# ~/.xinitrc
# 
# NOTE: LightDM does not execute this file. See .xprofile
#
# Executed by startx (run your window manager from here)

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

exec dbus-launch --sh-syntax --exit-with-session openbox

#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set Dvorak keyboard
setxkbmap -layout dvorak

# set CapsLock as an addtional Control Key
setxkbmap -option ctrl:nocaps

# set the cursor
xsetroot -cursor_name left_ptr

# set the background
eval $(cat $HOME/.fehbg)

# Start redshift
redshift -m vidmode -l 32.998868:-96.772436 &

# Define Xresources
userresources=$HOME/.Xresources

#  Merge what is available
if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

# start urxvt daemon
urxvtd -q -f -o

DEFAULT_SESSION=openbox-session

case $1 in
  gnome)  exec gnome-session;;
  openbox) exec openbox-session;;
  *) exec $DEFAULT_SESSION ;;
esac

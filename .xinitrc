#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# export LANG=zh_CN.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US:zh_CN
export LC_CTYPE=zh_CN.UTF-8
# export LC_TIME=en_US.UTF-8

# for macbook: start Xorg server at DPI 220 (mbp) / 96 (LG29) / 82 (LG82) / 157dpi (samsung 3840x2160 28inch)
#xrandr --dpi 157
#xrdb -merge ~/.Xresources

# Let QT and GTK autodetect retina screen and autoadjust
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export GDK_SCALE=2
#export GDK_DPI_SCALE=0.5

# xmodmap to bindkey according to macbook keyboard
#if [ -f $HOME/.Xmodmap ]; then
#    /usr/bin/xmodmap $HOME/.Xmodmap
#fi

# xbindkeys -p

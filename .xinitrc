#!/bin/sh
export XDG_CURRENT_DESKTOP=GNOME
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

lxpolkit &

#eval $(/usr/bin/dbus-launch --sh-syntax)
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK

dbus-update-activation-environment \
	--systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

#setxkbmap \
#	-layout us,us \
#	-variant ,intl \
#	-option grp:menu_toggle \
#	-option altwin:swap_alt_win \
#	-option caps:ctrl_modifier

setxkbmap \
	-layout us,us \
	-variant ,intl \
	-option grp:menu_toggle

#~/.fehbg
nitrogen --set-auto --random ~/img/wallpapers/

xrdb ~/.Xresources
kbdd

picom &
tray

# exec i3
#exec dbus-launch --exit-with-session bspwm
exec dbus-launch --exit-with-session xmonad

#exec dbus-launch gnome-session

setxkbmap -layout us,us -variant ,intl -option grp:lctrl_lwin_toggle
xmodmap ~/.Xmodmap
dbus-launch --exit-with-session i3

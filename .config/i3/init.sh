xrandr --output DP-0 --primary --left-of HDMI-0
setxkbmap \
	-layout us,us \
	-variant ,intl \
	-option grp:menu_toggle \
	-option altwin:swap_alt_win
xmodmap ~/.Xmodmap
polybar -r example &
compton -bcC

# If I start kbdd immediatelly, it doesn't work.
( sleep 10 ; kbdd ) &

feh --bg-fill img/wallpapers/panda2.jpg img/wallpapers/panda.jpg

numlockx &
conky -d -c ~/.conky/bottom
xsetroot -cursor_name left_ptr

hsetroot -solid "#111111"
xmodmap ~/.Xmodmap
setxkbmap -option grp:switch,grp:alt_caps_toggle,grp_led:scroll us,no,latam
xscreensaver -no-splash &
gajim &
urxvtd -q -o -f

exec xmonad

#exec openbox-session

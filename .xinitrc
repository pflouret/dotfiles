numlockx &
conky -d -c ~/.conky/bottom
conky -d -c ~/.conky/desktop
xsetroot -cursor_name left_ptr

#hsetroot -solid "#111111"
setxkbmap -option grp:switch,grp:alt_caps_toggle,grp_led:scroll us,no,latam
xscreensaver -no-splash &
gajim &
urxvtd -q -o -f

nitrogen --restore
xcompmgr -c -r0 &

xmodmap ~/.Xmodmap

urxvtc -e ssh-add

exec xmonad

#exec openbox-session

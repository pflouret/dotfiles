numlockx &
conky -d -c ~/.conky/bottom
conky -d -c ~/.conky/desktop
xsetroot -cursor_name left_ptr
xset m 1 1

#hsetroot -solid "#111111"
setxkbmap -option grp:switch,grp:alt_caps_toggle,grp_led:scroll us,no,latam
xscreensaver -no-splash &
gajim &
urxvtd -q -o -f

nitrogen --restore
#xcompmgr -n -r0 &

xmodmap ~/.Xmodmap

urxvtc -e ssh-add

tilda &> /dev/null &

exec xmonad

#exec openbox-session

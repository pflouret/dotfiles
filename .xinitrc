#!/bin/bash


numlockx &
conky -d -c ~/.conky/bottom &> /dev/null
conky -d -c ~/.conky/desktop &> /dev/null
xsetroot -cursor_name left_ptr
xset m 2 1

#exec openbox-session

hsetroot -solid "#111111"
setxkbmap -option grp:switch,grp:alt_caps_toggle,grp_led:scroll us,no,latam
setxkbmap -option terminate:ctrl_alt_bksp
xscreensaver -no-splash &
#gajim &
urxvtd -q -o -f

nitrogen --restore
#xcompmgr -n -r0 &

xmodmap ~/.Xmodmap

#urxvtc -e ssh-add

tilda -c 'screen -D -R tilda' &> /dev/null &
#urxvtc -name urxvt-lijab -e screen -RD lijab &> /dev/null &
#urxvtc -name urxvt-nzb -e screen -RD nzb &> /dev/null &
#urxvtc -name urxvt-term -e screen -RD term &> /dev/null &

exec ck-launch-session xmonad
#exec openbox-session

#!/bin/bash

master=`amixer sget Master|egrep -o '\[(on|off)\]'|tr -d '[]'`
if [ $master = 'on' ]; then
  amixer sget PCM|egrep -o '\[[0-9]{2,3}%\]'|tr -dc '0-9%\n'|head -1
else
  echo mute
fi

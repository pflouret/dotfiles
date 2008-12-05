#!/bin/bash

#sensors|grep "Core 0"|cut -d " " -f 8|egrep -o "[0-9]+"|head -1
case `hostname` in
  poobar|berserk)
    echo $((`cat /sys/class/hwmon/hwmon$1/device/temp1_input` / 1000)) ;;
  *)
    echo X ;;
esac

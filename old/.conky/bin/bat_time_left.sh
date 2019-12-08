#!/bin/bash

t=`acpi|cut -d " " -f 5`

[ -z $t ] && exit 0

hour=${t:0:2}
minute=${t:3:2}

if ! `acpi|grep -qi discharging`; then
  echo -n 'AC '
fi
[ "$hour" != '00' ] && echo -n "${hour}h "
echo "${minute}m"

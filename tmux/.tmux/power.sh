#!/bin/bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk -F'( | |:)+' '{print $3}'


#!/bin/bash

# chmod u+x rars.sh
# run rars
xrandr --output eDP-1 --mode 1368x768
/usr/lib/jvm/default-java/bin/java -jar rars1_6.jar
xrandr --output eDP-1 --mode 3840x2400
xrandr --output DP-1 --mode 2560x1080
xrandr --output DP-1 --scale 2.25x2.25
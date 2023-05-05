#!/bin/bash

# run rars
cd resources
xrandr --output eDP-1 --mode 1368x768
/usr/lib/jvm/default-java/bin/java -jar rars1_6.jar
xrandr --output eDP-1 --mode 3840x2400
xrandr --output eDP-1 --scale 1.0x1.0
cd ..
#!/bin/bash

xrandr --output eDP-1 --mode 1368x768
xrandr --output eDP-1 --scale 1.50x1.50
/usr/lib/jvm/default-java/bin/java -jar rars1_6.jar
xrandr --output eDP-1 --mode 3840x2400
xrandr --output eDP-1 --scale 1.125x1.125
# sed -i 's/Xft.dpi: 96/Xft.dpi: 192/g' ~/.Xresources
# xrdb -merge ~/.Xresources && echo "Xft.dpi: 96" >> ~/.Xresources
# sed -i 's/Xft.dpi.*/Xft.dpi: 96/g' ~/.Xresources && xrdb -merge ~/.Xresources
# xrdb ~/.Xresources
# xrandr --output DP-1 --mode 2560x1080
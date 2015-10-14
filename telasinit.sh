#!/bin/bash

HDMI=$(xrandr |grep -o "HDMI1 connected")
VGA=$(xrandr |grep -o "VGA1 connected")

if [ -n "$HDMI" ]; then
    xrandr --output HDMI1 --auto
    xrandr --output LVDS1 --off
elif [ -n "$VGA" ]; then
    xrandr --output VGA1 --auto
    xrandr --output LVDS1 --off
fi

	    

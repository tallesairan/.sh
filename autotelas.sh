#!/bin/bash

HDMI=$(xrandr |grep -o "HDMI1 connected")
VGA=$(xrandr |grep -o "VGA1 connected")
monitor=""

function Main {
    
    while [ true ]; do
	Now
	ConnectCheck
	Now
	Switch
	Now
	UnconnectCheck
	Switch
    done
}

function Now {
    if [ -n "$HDMI" ]; then
	echo "HDMI ligado"
    elif [ -n "$VGA" ]; then
	echo "VGA ligado"
    else
	echo "HDMI e VGA desligados"
    fi
}

function ConnectCheck {
    while [ -z "$HDMI"  ] && [[ -z "$VGA" ]]; do
	HDMI=$(xrandr |grep -o "HDMI1 connected")
	VGA=$(xrandr |grep -o "VGA1 connected")
    done
   if [ -n "$HDMI" ]; then
       monitor=HDMI
   elif [ -n "$VGA" ]; then
       monitor=VGA
   fi
}

function UnconnectCheck {
    if [ "$monitor" == "VGA" ]; then
	while [[ -n "$VGA" ]]; do
	    VGA=$(xrandr |grep -o "VGA1 connected")
	done
	monitor=""
    elif [ "$monitor" == "HDMI" ]; then
	while [[ -n "$HDMI" ]]; do
	    HDMI=$(xrandr |grep -o "HDMI1 connected")
	done
	monitor=""
    fi
}

function Switch {
    if [ "$monitor" == "VGA" ]; then
    	xrandr --output LVDS1 --off
    	xrandr --output VGA1 --auto
    elif [ "$monitor" == "HDMI" ]; then
    	xrandr --output HDMI1 --auto
	xrandr --output LVDS1 --off 
    elif [ -z  "$monitor" ]; then
    	xrandr --output LVDS1 --auto
    	xrandr --output VGA1 --off
    	xrandr --output HDMI1 --off
    fi
}    

Main

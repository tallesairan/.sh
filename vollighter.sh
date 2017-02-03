#!/bin/bash

# Global Variables

actual_lux=$(xbacklight -get)
actual_sound=$(amixer get Master |grep Left |awk '{print $5}'|sed 's/[^0-9\%]//g')
vol=""
backlight=""

# Main

function Main() {
    OpenDialog
    ApplyChanges
}

# Functions 

function OpenDialog() {
    result=$(Xdialog --no-cancel \
		     --stdout \
		     --title Vollighter® \
		     --2rangesbox " " 100x190 \
		     volume 0 100 $actual_sound \
	             backlight 10 100 $actual_lux);
    
    vol=$(echo $result |sed 's/\/.*//')
    backlight=$(echo $result | sed 's/[^/]*\///g')

}

function ApplyChanges() {
    xbacklight -set $backlight
    amixer set Master $vol% 
}

Main

     

     



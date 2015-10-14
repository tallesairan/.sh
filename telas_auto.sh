#!/bin/bash


#variables
VGAoff=$(xrandr |grep -o "VGA1 disconnected")
HDMIoff=$(xrandr |grep -o "HDMI1 disconnected")
monitor="LVDS"

function teste {
    echo VGA connected
}

function ConnectCheck {
    while [[ $VGAoff == "VGA1 disconnected" && $HDMIoff == "HDMI1 disconnected"  ]]; do
	echo VGA e HDMI desconectados
	VGAoff=$(xrandr |grep -o "VGA1 disconnected")
	HDMIoff=$(xrandr |grep -o "HDMI1 disconnected")
	sleep 1s
    done

}
function switch {
    if [ !VGAoff ]; then
	xrandr --output LVDS1 --off
	xrandr --output VGA1 --auto
	monitor="VGA"
    elif [ !HDMIoff ]; then
	xrandr --output LVDS1 --off
	xrandr --output HDMI1 --auto
	monitor="HDMI"
    else
	xrandr --output LVDS1 --auto
	monitor="LVDS"
    fi
}

function UnconnectCheck {
    if [ monitor == "VGA" ]; then
	while [ VGAoff -neq "VGA1 uncconected" ]; do
	    VGAoff=$(xrandr |grep -o "VGA1 disconnected")
	done
    fi
} 
       
    

#main

ConnectCheck
switch
UnconnectCheck
switch


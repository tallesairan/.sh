#!/bin/bash

function Main {
    if [ "$1" == "audio" ]; then
    	audioGUI
    	audioSelector
    elif [ "$1" == "video" ]; then
	echo oi
    	 videoGUI
    	 videoSelector
    elif [ "$1" == "" ]; then
    	videoGUI
    	audioGUI
    	videoSelector
    	audioSelector
    fi
}


function videoGUI {
    video=$(zenity \
		--class="vigkk ltda" \
		--name="Telas 2.0" \
		--width=300 \
		--height=300 \
		--title="Telas 2.0" \
		--list  \
		--text "Selecione as configurações de vídeo" \
		--column "configurações" \
		"TV auto" \
		"TV 1680x1050" \
		"TV 1920x1080" \
		"Monitor auto" \
		"Monitor 1366x768" \
		"Monitor e TV iguais" \
		"Monitor e TV lado a lado" \
	 );
}

function audioGUI {
    zenity \
	--class="vigkk ltda" \
	--name="Telas 2.0" \
	--question \
	--title="Telas 2.0" \
	--text="Selecione o audio" \
	--ok-label=HDMI \
	--cancel-label=Computador
    audio=$?
}

function audioSelector {
    if [[ $audio == 0 ]] ; then
	echo hdmi
	pacmd set-card-profile 0 "output:hdmi-stereo"
    else
	echo pc
	pacmd set-card-profile 0 "output:analog-stereo+input:analog-stereo"
    fi
}

function videoSelector {
    if [ "$video" == "TV auto" ]; then
	xrandr --output HDMI1 --auto
    	xrandr --output LVDS1 --off
    elif [ "$video" == "TV 1680x1050" ]; then
	xrandr --output HDMI1 --mode 1680x1050
    	xrandr --output LVDS1 --off
    elif [ "$video" == "TV 1920x1080" ]; then
	xrandr --output HDMI1 --mode 1680x1050
    	xrandr --output LVDS1 --off
    elif [ "$video" == "Monitor auto" ]; then
	xrandr --output LVDS1 --auto
	xrandr --output HDMI1 --off
    elif [ "$video" == "Monitor e TV iguais" ]; then
	xrandr --output LVDS1 --auto
	xrandr --output HDMI1 --auto --same-as LVDS1
    elif [ "$video" == "Monitor e TV lado a lado" ]; then
	xrandr --output LVDS1 --auto --primary
	xrandr --output HDMI1 --auto --noprimary --right-of LVDS1
	
    fi
}

Main $1


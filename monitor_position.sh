#!/bin/bash

primary=$(xrandr | grep " connected" | cut -f1 -d " " | sed -n 1p)
secondary=$(xrandr | grep " connected" | cut -f1 -d " " | sed -n 2p)
position=$1
echo teste
main(){
    if [ "$position" = "" ];
    then echo "Error! Must pass arg above/below/left-og/right-of" 
    else
	echo $primary $position $secondary
	if [ "$secondary" != "" ];
	then xrandr --output $secondary --$position $primary
	fi
    fi
}


main

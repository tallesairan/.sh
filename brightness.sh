monitor=$(xrandr | grep " connected" | cut -f1 -d " " | sed -n 1p)
secondary=$(xrandr | grep " connected" | cut -f1 -d " " | sed -n 2p)
option=$1

main(){
    if [ "$option" = "decrease" ]; then decrease
    elif [ "$option" = "increase" ]; then increase
    elif [ "$option" = "get" ]; then get
    else
	echo "Error! Must pass arg increase/decrease/get"
    fi
}

decrease(){
    new_val=$(xrandr --verbose | awk '/Brightness/ { print $2 - 0.1; exit }')
    if [ "$new_val" = "0.1" ];
    then
	new_val=0.2
    fi
    # primary monitor
    xrandr --output $monitor --brightness $new_val
    if [ "$secondary" != "" ];
    then xrandr --output $secondary --brightness $new_val
    fi
    echo "Brightness level is $new_val"
}

increase(){
    new_val=$(xrandr --verbose | awk '/Brightness/ { print $2 + 0.1; exit }')
    if [ "$new_val" = "1.1" ];
    then
	new_val=1.0
    fi
    xrandr --output $monitor --brightness $new_val
    if [ "$secondary" != "" ];
    then xrandr --output $secondary --brightness $new_val
    fi

    echo "Brightness level is $new_val"
}

get(){
    echo $(xrandr --verbose | awk '/Brightness/ { print $2; exit }')
}


main

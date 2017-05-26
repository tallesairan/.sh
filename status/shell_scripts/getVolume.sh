#!/bin/bash

function Volume() {
    vol_embrapa=$(amixer get Master |grep "Mono: Playback" |awk '{print $4}'|sed 's/[^0-9\%]//g')
    # vol=$(amixer get Master |grep Left |awk '{print $5}'|sed 's/[^0-9\%]//g')
    # echo ♫: $vol_embrapa
    echo $vol_embrapa
}

Volume

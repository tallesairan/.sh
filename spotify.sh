#!/bin/bash

command=$1

function Main(){
     if [ "$command" == "" ];
    then
    	echo "error"
     elif [ "$command" == "play/pause" ];
     then
    	 dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
     elif [ "$command" == "previous" ];
     then
    	 dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
     elif [ "$command" == "next" ];
     then
    	 dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
     else
    	 echo "Use spotify.sh [command]"
    	 echo "Where [command] is"
    	 echo "play/pause"
    	 echo "previous"
    	 echo "next"
    fi
}

Main

#echo baixa -0.08 -2.50 3.12

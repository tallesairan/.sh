#!/bin/bash
func=$1

function Main {
    if [ "$func" == "" ]
    then
	~/.sh/status/bin/status.exec
    else
	echo oi
    fi
}


function Volume() {
    vol_embrapa=$(amixer get Master |grep "Mono: Playback" |awk '{print $4}'|sed 's/[^0-9\%]//g')
    # vol=$(amixer get Master |grep Left |awk '{print $5}'|sed 's/[^0-9\%]//g')
    #echo ♫: $vol_embrapa
    echo $vol_embrapa
}

function GetMusic() {

    #Spotify

    status=$(qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus)
    if [ "$status" == "Playing" ];    
    then
	artist=$(qdbus org.mpris.MediaPlayer2.spotify / org.freedesktop.MediaPlayer2.GetMetadata | sed -n -e 's/^.*artist: //p')
	music=$(qdbus org.mpris.MediaPlayer2.spotify / org.freedesktop.MediaPlayer2.GetMetadata | sed -n -e 's/^.*title: //p')
	artista=$(echo ${artist:0:20})
	musica=$(echo ${music:0:20})
	if [ "$artista" != "$artist" ];
	then
	    artista=$(echo $artista...)
	fi
	if [ "$musica" != "$music" ];
	then
	    musica=$(echo $musica... )
	fi
	echo Spotify: $artista - $musica
    else
	echo ""
    fi
}

Main




# function MainOld { 
#     i3status -c ~/.i3/i3status_top.conf | while :
#     do
#     	read line
#     	usim5=$(USIM5)
#     	weekday=$(WeekDay)
#     	month=$(Month)
#     	echo -e "$usim5 | $month | $line" || exit 1
#     done

#     # primeira linha: lê seu arquivo de status
#     # read line lê o que seu .conf mandaria para a barra
#     # usim5 recebe a informação que quero enviar para a barra
#     # echo envia usim5 e line
#     # no config:
#     # bar {
#     #    status_command i3status | path/to/this/script.sh
#     # }

# }


# function Main {
#     while true
#     do
#     	# usim5=$(stocks USIM5 4.62 400)
#     	weekday=$(WeekDay)
#     	day=$(Day)
#     	month=$(Month)
#     	time=$(Time)
#     	vol=$(Volume)
#     	year=$(Year)
#     	# music=$(GetMusic)
#     	echo -e "$weekday, $day $month - $year | $time | $usim5 | $vol | $music "

#     done
# }

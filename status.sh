#!/bin/bash


function Main { 
    i3status -c ~/.i3/i3status_top.conf | while :
    do
    	read line
    	usim5=$(USIM5)
    	weekday=$(WeekDay)
    	month=$(Month)
    	echo -e "$usim5 | $month | $line" || exit 1
    done

    # primeira linha: lê seu arquivo de status
    # read line lê o que seu .conf mandaria para a barra
    # usim5 recebe a informação que quero enviar para a barra
    # echo envia usim5 e line
    # no config:
    # bar {
    #    status_command i3status | path/to/this/script.sh
    # }
  
}

function USIM5() {
    paragraph=$(lynx -dump "http://finance.yahoo.com/q?s=USIM5.SA" |grep -A 2 "Sao Paolo");
    arr=()
    while read -r line; do
	arr+=("$line")
    done <<< "$paragraph"
    
    a=( ${arr[1]} )
    value=${a[0]}
    status=${a[1]}
    perc=${a[2]}

    gain300=$(bc -l <<< "300*($value-2.00)")
    gain200=0
    fullGain=$(bc -l <<< "$gain200 + $gain300")
    fullPer=$(bc -l <<< "scale=2; 100*($fullGain+600)/(600)-100" )
    
    echo "USIM5: $value $status $perc | i1: $gain300 ¤ t: $fullGain ($fullPer%) "
}

function WeekDay() {
    seg="понедельник"
    ter="вторник"
    qua="среда"
    qui="четверг"
    sex="пятница"
    sab="суббота"
    dom="воскресенье"

    day=$(date +%u)

    case $day in 1)
		     echo $seg
		     ;;

		  2)
		      echo $ter
		      ;;

		  3)
		      echo $qua
		      ;;

		  4)
		      echo $qui
		      ;;

		  5)
		      echo $sex
		      ;;

		  6)
		      echo $sab
		      ;;

		  7)
		      echo $dom
		      ;;

    esac
}


function Month(){
    jan="январь"
fev="февраль"
mar="март"
abr="апрель"
mai="май"
jun="июнь"
jul="июль"
ago="август"
set="сентябрь"
out="октябрь"
nov="ноябрь"
dez="декабрь"

month=$(date +%m)


case $month in 01)
     echo $jan
     ;;

02)
     echo $fev
     ;;

03)
     echo $mar
     ;;

04)
     echo $abr
     ;;

05)
     echo $mai
     ;;

06)
     echo $jun
     ;;

07)
     echo $jul
     ;;

08)
     echo $ago
     ;;

09)
     echo $set
     ;;

10)
     echo $out
     ;;

11)
     echo $nov
     ;;

12)
     echo $dez
     ;;

esac

}

function Time() {
    time=$(date +%T)
    echo $time
}

function Volume() {
    vol=$(amixer get Master |grep Left |awk '{print $5}'|sed 's/[^0-9\%]//g')
    echo ♫: $vol
}
Main




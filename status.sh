#!/bin/bash


function Main { 
    i3status -c ~/.i3/i3status_top.conf | while :
    do
	read line
	usim5=$(USIM5)
	echo -e "$usim5 | $line" || exit 1
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

    gain300=$(bc -l <<< "300*($value-1.19)")
    gain200=$(bc -l <<< "200*($value-1.46)")
    fullGain=$(bc -l <<< "$gain200 + $gain300")
    fullPer=$(bc -l <<< "scale=2; 100*($fullGain+357+292)/(357+292)-100" )
    
    echo "USIM5: $value $status $perc | i1: $gain300 ¤ i2: $gain200 ¤ t: $fullGain ($fullPer%)"
}



Main




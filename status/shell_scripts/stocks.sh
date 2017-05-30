#!/bin/bash


stock=$1
buyin=$2
qtdde=$3

function Main(){
    if [ "$stock" == "" ];
    then
	echo " "
    else
	paragraph=$(w3m -no-cookie "https://www.google.com.br/search?q=$stock.SA" |grep "Brasil ");
	
	a=( ${paragraph} )

	preco=${a[1]}
	variacao=( ${a[2]})
	porcentagem=( ${a[3]})

	echo $preco ${variacao[0]} ${variacao[1]} ${porcentagem[0]}
	# value=${a[0]}
	# status=${a[1]}
	# perct=${a[2]}

	# if [ "$buyin" == " " ] || [ "$qtdde" == " " ];
	# then
	#     echo $stock: $value $status $perct
	# else
	#     gain=$(bc -l <<< "$qtdde*($value-$buyin)")
	#     totalBuyed=$(bc -l <<< "$qtdde*$buyin")
	#     perc=$(bc -l <<< "scale=2; 100*($totalBuyed+$gain)/$totalBuyed-100")
	#     echo "$stock: $value $status $perct ¤ $gain ($perc%) "
	# fi
    fi
    
}

Main

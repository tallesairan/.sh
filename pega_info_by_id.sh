#!/bin/bash

##########################################################
## Pega informações dentro de uma div com id especifico ##
## para vários itens diferentes do BD                   ##
## no caso, o valor de cartas de magic com a lista de   ##
## nomes na entrada                                     ##
## <div class="menor-preco" id="omoMenorPreco">*</div>  ##
##  Viglioni                                      ##
##########################################################


# Global Variables
link="http://ligamagic.com.br/?view=cards%2Fsearch&card="      
flag1="omoMenorPreco"
flag2='s/<div class=\"menor-preco\" id=\"omoMenorPreco\">/\ /'
flag3='s/<\/div>/\n/'
func="curl -s"
declare -a preco
declare -a nome
tam=0
file=$1
argc=$#


# Main

function Main(){
    VerifyError
    GetPrices
    PrintTable
}

# functions

function GetPrices(){
    i=0
    while read line
    do
	nome[i]=$(echo $line |tr -d '\n\r' | tr '[:upper:]' '[:lower:]')
	preco[i]=$($func $link${nome[i]} | grep $flag1 | sed "$flag2" | sed "$flag3")
	preco[i]=$(echo ${preco[i]} |head -8)
	((i++))
    done<$file
    tam=$i
}

function PrintTable(){
    for (( i=0; i<$tam;i++))
    do
	printf "%-5s %-30s %s\n"  "$i" "${nome[i]}" "${preco[i]}"
    done
    echo " "
    echo vig©© dev ltda
    echo 2016©
}

function VerifyError(){
    clear
    echo -e '\t'Wellcome
    if [ $argc -eq 1 ]
    then
	echo " "
	echo -e '\t'"Good to go!"
	echo " "
    else
	echo " "
	echo -e '\t'"Please, call this function within a file with the cards name"
	echo -e '\t'"e.g.: "
	echo -e '\t\t'" this_function file > file_out"
	echo -e '\t'"or"
	echo -e '\t\t'" this_function file"
	echo  " "
	exit
    fi
}


# declaration

Main

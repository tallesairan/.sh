#!/bin/sh
# shell script to prepend i3status with more stuff

i3status -c ~/.i3/i3status_top.conf | while :
do
        line=$(lynx -dump "http://finance.yahoo.com/q?s=PETR3.SA" |grep -A 4 "Sao Paolo")
        echo "mystuff | $line" || exit 1
done

# i3status --config ~/.i3/i3status_top.conf| while :
# do
#   read line
#   echo $line || exit 1
# done

#lynx -dump "http://finance.yahoo.com/q?s=PETR3.SA" |grep -A 4 "Sao Paolo"




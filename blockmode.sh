#!/bin/bash

end=false

function main {
    block
    getPsswd
    while [ "$end" == "false" ]; do
	  if verifyPsswd; then
	      end=true
	  else
	      getPsswd
	  fi
    done
    unblock
}

function getPsswd {
    psswd=$(zenity \
		--title="Computador em uso :)" \
		--password \
	 );
}

function verifyPsswd {
    if [ "$psswd" == "maoe" ]; then
	return 0
    else
	return 34
    fi
}

function block {
    i3-msg bar mode invisible
    # i3-msg workspace block
    i3-msg mode block
}

function unblock {
    i3-msg mode "default"
    i3-msg workspace 666
    i3-msg bar mode dock
}

main

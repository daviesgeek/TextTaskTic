#!/bin/bash
######
#
# TextTaskTic.sh
# Matthew Davies, January 16th, 2014
#
######
source 'global.sh'

# If the settings file isn't there, assume first run
if [ ! -f "$SETTINGS" ]; then
	echo 'Initializing setup...'
	source setup.sh
fi
source "$SETTINGS"

function run {
	source 'run.sh'
}

function quit(){
	source 'quit.sh'
}

function reset(){
	source 'setup.sh'
}

function help(){
	source 'help.sh'
}

flags="${@#"${@%%[![:space:]]*}"}"

if [[ $flags == '-q' ]] || [[ $flags == '--quit' ]]; then
	quit
elif [[ $flags == '-r' ]] || [[ $flags == '--reset' ]]; then
	reset
elif [[ $flags == '-h' ]] || [[ $flags == '--help' ]] || [[ $flags == '-?' ]]; then
	help
elif [[ $flags == '-1' ]]  || [[ $flags == '--once' ]]; then
	check=0
	print=1
	run
elif [[ ! -z $flags ]]; then
	echo 'Invalid options...'
	help
else
	echo 'Running in background...'
	run </dev/null >/dev/null 2>&1 &
	disown	
fi
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
	echo "Quitting $NAME..."
	kill `ps -ef | grep TextTaskTic | grep -v grep | awk '{print $2}'`
}

function reset(){
	source 'setup.sh'
}

function help(){
	source 'help.sh'
}

if [[ $@ =~ -q ]] || [[ $@ =~ --quit ]]; then
	quit
elif [[ $@ =~ -r ]] || [[ $@ =~ --reset ]]; then
	reset
elif [[ $@ =~ -h ]] || [[ $@ =~ --help ]] || [[ $@ =~ -? ]]; then
	help
elif [[ $@ =~ -1 ]]  || [[ $@ =~ --once ]]; then
	check=0
	print=1
	run
else
	run </dev/null >/dev/null 2>&1 &
	disown	
fi
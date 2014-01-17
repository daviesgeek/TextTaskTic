#!/bin/bash
######
#
# TextTaskTic.sh
# Matthew Davies
#
######
function run {
	while true; do
		source 'global.sh'
		if [ ! -f "$SETTINGS" ]; then
			source first-run.sh
		fi

		source "$SETTINGS"

		# Quits all running instances of TextTaskTic
		quit(){
			echo 'quit function'
		}

		while getopts ":q:r:h" options; do
			case "${options}" in
		    q)
					quit
	        ;;
		    r)
	        r=${OPTARG}
	        ;;
	       h)
					usage
					;;
			esac
		done

		#sleep $((check*60))
		break
	done
}
run
#run </dev/null >/dev/null 2>&1 &
#disown

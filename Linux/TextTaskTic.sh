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
		if [ ! -f "$APATH/settings.cfg" ]; then
			source first-run.sh
		fi

		source "$APATH/settings.cfg"

		#sleep $((check*60))
		break
	done
}
run
#run </dev/null >/dev/null 2>&1 &
#disown

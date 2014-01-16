#!/bin/bash
function run {
	while true; do
		sleep 5
	done
}
#run
run </dev/null >/dev/null 2>&1 &
disown

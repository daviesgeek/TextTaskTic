while true; do
	echo "running $(date)" >> ${HOME}/Desktop/TTT.log
	sleep $((check*60))
	break
done

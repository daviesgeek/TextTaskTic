######
#
# Quit function
# Matthew Davies, January 25th, 2014
#
######

pid=`ps -ef | grep $NAME | grep -v grep | awk '{print $2}' | head -1`
if [[ ! -z $pid ]] && [[ ! $pid == $BASHPID ]]; then
	echo "Quitting $NAME..."
	kill $pid
else
	echo "$NAME is not running. Run $NAME again without flags to start it running in the background."
fi
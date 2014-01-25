######
#
# This is where all the action happens
# Matthew Davies, January 19th, 2014
#
######
while true; do

	files=( "$location"/* )
	files=( "${files[@]##*/}" )

	x=1
	for f in "${files[@]}"; do
		readarray text < $location/$f
		for l in "${text[@]}"; do
			echo $l
		done 
		x=$((x+1))
	done

	sleep $((check*60))
	break
done
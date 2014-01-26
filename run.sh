######
#
# This is where all the action happens
# Matthew Davies, January 19th, 2014
#
######
while true; do

	files=( "$location"/* )
	files=( "${files[@]##*/}" )

	for f in "${files[@]}"; do
		echo $f '=>'
		readarray text < $location/$f
		x=1
		for l in "${text[@]}"; do
			heading='^[[:space:]]?#'
			task='^[[:space:]]?-'
			note='^[[:space:]]'
			if [[ $l =~ $heading ]]; then
				echo -e "$BLUE$l $NC"
			elif [[ $l =~ $task ]]; then
				echo -e "$RED$l $NC"
			elif [[ $l =~ $note ]];then
				echo -e "$l"
			fi
			x=$((x+1))
		done
	done

	sleep $((check*60))
	break
done
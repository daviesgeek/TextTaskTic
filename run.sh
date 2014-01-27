######
#
# This is where all the action happens
# Matthew Davies, January 19th, 2014
#
######
while true; do

	files=( "$location"/* )
	files=( "${files[@]##*/}" )
	taskList=()

	for f in "${files[@]}"; do
		readarray text < $location/$f
		filekey=1
		for l in "${text[@]}"; do
			heading='^[[:space:]]?#'
			task='^[[:space:]]?-'
			note='^[[:space:]]'
			finished='@done'
			if [[ $l =~ $task ]]; then
				if [[ ! $l =~ $finished ]]; then
					datetimeregex='@\d{2,4}-\d{1,2}-\d{1,2},\d{1,2}:\d{1,2}'
					datetime=$( echo $l | grep -oP $datetimeregex)
					datesave="$datetime"

					IFS=',' read -a datetime <<< "$datetime"
					IFS='-' read -a date <<< "${datetime[0]}"
					year=${date[0]/@/}
					month=${date[1]}
					day=${date[2]}

					regex='^[0-9][0-9]$'
					if [[ $year =~ $regex ]]; then
						year="20$year"
					fi
					regex='^[0-9]$'
					if [[ $month =~ $regex ]]; then
						month="0$month"
					fi
					if [[ $day =~ $regex ]]; then
						day="0$day"
					fi
					date="$year-$month-$day"
					today=`date +%Y-%m-%d`
					date=`date --date="$date" +%s`
					today=`date --date="$today" +%s`
					if [[ $date -le $today ]]; then
						task=$(echo $l | sed "s/$datesave//g" | sed -e 's/^-//g' -e 's/[[:space:]]*$//')
						regex='#\w+((-)?\w+)+(-?)'
						tags=()
						for t in ${task[@]}; do
							if [[ $t =~ $regex ]]; then
								tags+=($t)
							fi
						done
						for tag in ${tags[@]}; do
							task=$(echo $task | sed "s/$tag//")
						done
						task=$( echo $task | sed -e 's/[[:space:]]*$//')
						taskList+=("$task | $year-$month-$day")
						# echo "$task: due on $month/$day/$year"
						# echo '--------'
					fi
				fi
			fi
			filekey=$((x+1))
		done
	done

	# Here, there's a list outstanding of tasks in $taskList
	for t in "${taskList[@]}"; do
		echo $t
	done

	sleep $((check*60))
	break
done
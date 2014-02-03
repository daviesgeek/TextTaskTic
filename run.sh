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
		IFS=$'\r\n'
		text=($(cat "$location/$f"))
		filekey=1
		for l in "${text[@]}"; do
			heading='^[[:space:]]?#'
			task='^[[:space:]]?-'
			note='^[[:space:]]'
			finished='@done'
			if [[ $l =~ $task ]]; then
				if [[ ! $l =~ $finished ]]; then
					datetimeregex='@[0-9]{2,4}-[0-9]{1,2}-[0-9]{1,2},[0-9]{1,2}:[0-9]{1,2}'
					[[ $l =~ $datetimeregex ]]
					datetime="${BASH_REMATCH[0]}"
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

	# List outstanding of tasks is in $taskList
	if [[ `uname` == 'Linux' ]]; then
		notify-send "${#taskList[@]} outstanding tasks to complete"
	elif [[ `uname` == 'Darwin' ]]; then
		for t in "${taskList[@]}"; do
			IFS='|' read -a task <<< "$t"
			echo "${t[0]} - Due ${t[1]}"
		done
	fi

	sleep $((check*60))
	break
done
#Set check time
if [[ ! $check == '' ]]; then
	checkSet='set'
	checkText="currently set to $check minutes"
else
	checkText='in minutes; default 5 minutes'
fi
echo -e "How often do you want $NAME to check ($checkText)? \n\c"
read checkRet

while true; do
	if [[ $checkRet -gt 1 ]]; then
		break
	elif [[ $checkRet == '' ]]; then
		if [[ $checSet == 'set' ]]; then
			checkRet=$check
		else
			checkRet=$DEFAULTCHECK
		fi
		break
	else
		echo -e "'$checkRet' is not a valid number. Please try again.\n\c"
		read checkRet
	fi
done

#Set folder
if [[ ! $location == '' ]]; then
	locSet='set'
	locText="currently set to $location"
else
	locText="default location: ~/Dropbox/$NAME"
fi
echo -e "Where do you want $NAME to check ($locText)? \n\c"
read locRet
eval locRet=$locRet
while true; do
	if [ -d "$locRet" ]; then
		break
	elif [[ $locRet == '' ]]; then
		if [[ $locSet == 'set' ]]; then
			locRet=$location
		else
			mkdir -p "$DEFAULTLOC"
			locRet=${DEFAULTLOC}
		fi
		break
	else
		echo -e "Directory does not exist. Please try again. \n\c"
		read locRet
		eval locRet=$locRet
	fi
done

mkdir -p ${HOME}/.$NAME
echo 'check='\"$checkRet\" >> "$SETTINGS"
echo 'location='\"$locRet\" >> "$SETTINGS"
echo "Done setting up. Please re-run $NAME without any flags to start it in the background."
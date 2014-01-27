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

#Set notification command
if [[ ! $cmd == '' ]]; then
	cmdSet='set'
	cmdText="currently set to $cmdSet"
else
	if [[ `uname` == 'Linux' ]]; then
		cmdOption='1) notify-send (default)\n2) growl (not supported yet)'
	elif [[ `uname` == 'Darwin' ]]; then
		cmdOption='1) terminal-notifier (default)\n2) growl-notify'
	fi
fi

echo -e "What notification command do you want $NAME to use?\nSee the readme for more info.\n$cmdOption\n:\c"
read cmdRet

while true; do
	if [[ `uname` == 'Linux' ]]; then
		if [[ $cmdRet == '' ]]; then
			cmdRet='notify-send'
			break
		elif [[ $cmdRet == '1' ]]; then
			cmdRet='notify-send'
			break
		elif [[ $cmdRet == '2' ]]; then
			echo "growl isn't supported yet on Linux. Please use notify-send instead (press enter)"
			read cmdRet
		else
			echo -e "'$cmdRet' is not a valid option. Please try again.\n:\c"
			read cmdRet
		fi
	elif [[ `uname` == 'Darwin' ]]; then
		if [[ $cmdRet == '' ]]; then
			cmdRet='terminal-notifier'
			break
		elif [[ $cmdRet == '1' ]]; then
			cmdRet='terminal-notifier'
			break
		elif [[ $cmdRet == '2' ]]; then
			cmdRet='growl-notify'
			break
		else
			echo -e "'$cmdRet' is not a valid option. Please try again.\n:\c"
			read cmdRet
		fi
	fi	
done

mkdir -p ${HOME}/.$NAME
echo 'check='\"$checkRet\" >> "$SETTINGS"
echo 'location='\"$locRet\" >> "$SETTINGS"
echo 'cmd='\"$cmdRet\" >> "$SETTINGS"
echo "Done setting up. Please re-run $NAME without any flags to start it in the background."
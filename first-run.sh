echo "Initializing setup..."

#Set check time
echo -e "How often do you want $NAME to check (in minutes; default 5 minutes)? \n\c"
read check

while true; do
	if [[ $check -gt 1 ]]; then
			break
	elif [[ $check == '' ]]; then
		check=$DEFAULTCHECK
		break
	else
		echo -e "'$check' is not a valid number. Please try again.\n\c"
		read check
	fi
done

#Set folder

echo -e "Where do you want $NAME to check (default location: ~/Dropbox/$Name)? \n\c"
read loc
eval loc=$loc
while true; do
	if [ -d "$loc" ]; then
		break
	elif [[ $loc == '' ]]; then
		loc=${DEFAULTLOC}
		break
	else
		echo -e "Directory does not exist. Please try again. \n\c"
		read loc
		eval loc=$loc
	fi
done

mkdir -p ${HOME}/.$NAME
echo 'check='\"$check\" >> "$SETTINGS"
echo 'location='\"$loc\" >> "$SETTINGS"
echo 'done setting up'
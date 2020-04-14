#!/bin/bash
CURRENTTIME=$(date +%s)
PASTTIME=$(cat ~/.scripts/timeupdate)
TIMEDIFF=$((CURRENTTIME-PASTTIME))
UPTIME=$(awk '{print int($1)}' /proc/uptime)

if [ "$TIMEDIFF" -gt "300" ]; then
		echo "do update"
	if  [ -x "$(command -v wget)" ]; then
		wget -q --spider http://google.com		
	fi


	if  [ -x "$(command -v git)" ]; then
		if [ $? -eq 0 ]; then
			export TEMP_DIR=$(pwd)
			cd ~/.dotfiles
			echo "we are in dotfiles"
			git remote update > /dev/null
			UPSTREAM=${1:-'@{u}'}
			LOCAL=$(git rev-parse @)
			REMOTE=$(git rev-parse "$UPSTREAM")
			BASE=$(git merge-base @ "$UPSTREAM")
		
			if [ $LOCAL = $REMOTE ]; then
				cd $TEMP_DIR
				echo "all up date!!! good"
				clear
			elif [ $LOCAL = $BASE ]; then
				echo "Need to pull"
				echo "We have updates on dotfiles. pull them? \n"
				read -p 'y/n: ' pullbool
				if [ "$pullbool" == "y" ];then
					git pull
					cd $TEMP_DIR
					clear
				fi
			elif [ $REMOTE = $BASE ]; then
				echo "Need to push"
			else
				echo "Diverged"
			fi
			cd $TEMP_DIR
		fi
	fi
	
	rm ~/.scripts/timeupdate
	date +%s >> ~/.scripts/timeupdate
fi

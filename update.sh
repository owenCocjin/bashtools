#!/bin/bash
## Author:	Owen Cocjin
## Version:	1.0
## Date:    06/12/20
## Title:   update.sh
## Description: Updates all bashTools
## Notes:
##    - Requires 'wget' program

#Change p to bashTools directory if required
p="/usr/local/bin"
btd="${p}/bashTools"

echo -e "This script will be modifying files in:\n\t${p}\n\t${btd}\nIf these are not the correct directories change 'p' in this script."
echo -en "\nAre these the correct directories (y/n)? "
read menu
echo "'${menu}'"
if [[ "$menu" != "y" ]] && [[ "$menu" != "Y" ]]; then
	echo "Please change the 'p' variable in this (and probably .sources) script!"
	exit 0
fi

#Download all raw files from github & overwrite old tools
for f in $(ls ${btd}); do
	echo -n "Downloading ${f}... "
	wget -O "${btd}/${f}" "https://raw.githubusercontent.com/owenCocjin/bashTools/master/Tools/${f}" &>/dev/null
	if [[ $? != 0 ]]; then
		echo "[X]"
	else
		echo "[V]"
	fi
done

#List updatede versions
for f in $(ls ${btd}); do
	echo -e "\n${f}:"
	echo -en "\t"
	head -n 3 ${f} | tail -n 1
done

#Source bashrc to implement updated files
. ~/.bashrc

#!/bin/bash
#
# Exit codes
#	0: ibus is on and engine match => output language name for polybar
#	1: ibus is on and engine not match => output error for polybar
#	2: ibus is off => output off label for polybar

# source config file
source $( dirname ${BASH_SOURCE[0]} )/ibus_conf.sh
IBUS_SET_VARIABLES

# current ibus engine
engine=$(ibus engine)

# if $(ibus engine) not exit 0 => ibus is off
if [[ $? != 0 ]]; then
	echo $IBUS_OFF_LABEL
	exit 2
fi

CUR_IBUS_LANG=""
CUR_IBUS_FLAG=""

for lang in ${IBUS_DATA[@]}; do
	IFS=$IBUS_DATA_DELIMETER read -ra lang_info <<< "$lang"
	if [[ ${lang_info[1]} == $engine ]]; then
		CUR_IBUS_LANG=${lang_info[0]}
		CUR_IBUS_FLAG=${lang_info[2]}
		break
	fi
done

if [[ -z $CUR_IBUS_LANG ]]; then
	echo '(Error) IBus is on, but not any engine in $IBUS_DATA match with '"$engine"
	exit 1
fi

echo $CUR_IBUS_LANG
exit 0

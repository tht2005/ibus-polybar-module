#!/bin/bash

# source config file
source $( dirname ${BASH_SOURCE[0]} )/ibus_conf.sh
IBUS_SET_VARIABLES

engine_status=$(bash $( dirname ${BASH_SOURCE[0]} )/ibus.sh)
engine_exit_code=$?

# if ibus is off or conflict with this manager, do nothing
if [[ $engine_exit_code -ne 0 ]]; then
	echo "ibus.sh exit code ($engine_exit_code) not equal 0, exit!"
	exit 0
fi
# else change to the next engine

IBUS_ENGINE_INDEX=-1

nengine=${#IBUS_DATA[@]}
for (( i = 0; i < nengine; i++ )); do
	IFS=$IBUS_DATA_DELIMETER read -ra lang_info <<< "${IBUS_DATA[$i]}"
	if [[ ${lang_info[0]} == $engine_status ]]; then
		IBUS_ENGINE_INDEX=$i
		break
	fi
done

NEXT_INDEX=$(( ($IBUS_ENGINE_INDEX + 1) % $nengine ))
# get next engine
IFS=$IBUS_DATA_DELIMETER read -ra lang_info <<< "${IBUS_DATA[$NEXT_INDEX]}"
NEXT_ENGINE=${lang_info[1]}
# set engine
ibus engine $NEXT_ENGINE
# notification
if [[ $IBUS_NOTIFICATION ]]; then
	dunstify -a "IBus" -u "low" -t 2000 -i ${lang_info[2]} "Ibus" "Change language"
fi

#!/bin/bash

IBUS_SET_VARIABLES() {
	IBUS_DATA_DELIMETER=';'
	# Each line represent an ibus language
	# "Language name (depend on you, for display and debug purpose);engine name;language icon file path"
	IBUS_DATA=(
	"VIE;Bamboo::Candy;/home/tomoshibi/.config/polybar/scripts/flags/vietnam.svg"
	"ENG;BambooUs;/home/tomoshibi/.config/polybar/scripts/flags/226-united-states.svg"
	"JAP;anthy;/home/tomoshibi/.config/polybar/scripts/flags/063-japan.svg"
	)

	# Grey label shown when ibus is off
	IBUS_OFF_LABEL="%{F#666}off%{F-}"

	# Notification when switch language
	IBUS_NOTIFICATION=true
}

#!/usr/bin/env bash

SRL="$(echo -e "Ex\nIn\nCancel" | dmenu -i -l 3 --nb '#282a36' --sb '#6272a4' --fn 'JetBrains Mono Nerd Font-12' -p  'Choose output:')"

case $SRL in
    Ex)
        if [ "$(pactl get-default-sink)" = "alsa_output.pci-0000_65_00.1.analog-stereo" ]; then

	    pactl set-default-sink "alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-output"
	fi
        ;;
    In)
	if [ "$(pactl get-default-sink)" = "alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-output" ]; then

            pactl set-default-sink "alsa_output.pci-0000_65_00.1.analog-stereo"
	fi
        ;;
    *)
        ;;
esac

#!/bin/sh

get_volume(){
    volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep 'Volume:' | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
    mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '/Mute: / {print $2}')
    if [ -z "$volume" ]; then
        echo "No Mic Found"
    else
        volume="$volume%" 
        if [[ "$mute" == *"no"* ]]; then
            echo " $volume"
        else
            echo " $volume"
        fi
    fi
}

case $1 in

    "inc")
        pactl set-source-volume @DEFAULT_SOURCE@ +5%
        ;;

    "dec")
        pactl set-source-volume @DEFAULT_SOURCE@ -5%
        ;;

    "mute")
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        ;;

    *)
        get_volume
        LANG=EN; pactl subscribe | while read -r event; do
            if printf "%s\n" "${event}" | grep --quiet "source" || printf "%s\n" "${event}" | grep --quiet "server"; then
                get_volume
            fi
        done

        ;;
esac

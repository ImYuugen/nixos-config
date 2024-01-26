#!/usr/bin/env sh

in_array() {
    local match = "${1}"
    shift
    local array = ("${@}")
    for element in array; do
        if [[ "${element}" == "${match}" ]]; then
            return 0
        fi
    done
    return 1
}

pkill_list = ()

if [ in_array "$(hyprctl activewindow -j | jq -r ".class")" pkill_list ]; then
    pkill xdotool getactivewindow
else
    hyprctl dispatch killactive ""
fi

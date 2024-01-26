#!/usr/bin/env bash

# TODO: Make it work lol

out = xrandr | grep "DP-2" > /dev/null
if $out; then
    hyprctl keyword monitor eDP-1,disable
    hyprctl keyword monitor DP-2,1920x1080@144,0x0,1
else
    hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1
fi

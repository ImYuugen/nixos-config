#!/bin/sh

sleep 1
way-displays > "/tmp/way-displays.${XDG_VTNR}.${USER}.log" 2 >&1

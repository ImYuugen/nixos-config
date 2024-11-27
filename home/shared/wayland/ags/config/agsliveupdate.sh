#!/usr/bin/env bash

trap 'echo "Killing ags" && pkill ags' SIGINT

nix-shell -p inotify-tools dart-sass --run '
  function execute() {
    clear
    echo "Config changed, relaunching ags ($1)"
    ags quit
    ags run -d $PWD &
  }

  ags quit
  ags run -d $PWD &
  inotifywait --event modify --recursive --monitor ./ \
  | while read changed; do
    execute "$changed"
  done
'

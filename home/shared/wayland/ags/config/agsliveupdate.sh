#!/usr/bin/env bash

trap 'echo "Killing ags" && pkill ags' SIGINT

nix-shell -p inotify-tools dart-sass --run '
  function execute() {
    echo "Config changed, relaunching ags"
    pkill ags
    ags --config ./config.js &
  }

  inotifywait --event modify --recursive --monitor ./ \
  | while read changed; do
    echo $changed
    execute
  done
'

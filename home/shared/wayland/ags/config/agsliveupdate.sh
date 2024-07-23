#!/usr/bin/env bash

trap 'echo "Killing ags" && pkill ags' SIGINT

nix-shell -p inotify-tools dart-sass --run '
  function execute() {
    echo "Config changed, relaunching ags"
    ags -c ./config.js -q
    ags -c ./config.js &
  }

  ags -c ./config.js &
  inotifywait --event modify --recursive --monitor ./ \
  | while read changed; do
    echo $changed
    execute
  done
'

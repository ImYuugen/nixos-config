#!/usr/bin/env bash

doas nixos-rebuild switch --flake .# -j auto --fast -L -v --log-format internal-json 2>&1 | nom --json

if [ $? -ne 0 ]; then
  echo "System rebuild failed" 1>&2
  exit 1
fi

echo "Restarting darkman"
systemctl restart --user darkman.service

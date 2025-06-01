#!/usr/bin/env bash

if [[ "$1" = "switch" ]]; then
  doas nixos-rebuild switch --flake .# -j auto --fast -L -v --log-format internal-json 2>&1 | nom --json

  if [ $? -ne 0 ]; then
    echo "System rebuild failed" 1>&2
    exit 1
  fi

  echo "Restarting darkman"
  systemctl restart --user darkman.service
elif [[ "$1" = "vm" ]]; then
  nix build .#nixosConfigurations.omen.config.system.build.vm -j auto -L -v --log-format internal-json 2>&1 | nom --json
else
  echo "You did not provide an option cuh (switch|vm)" >&2
fi

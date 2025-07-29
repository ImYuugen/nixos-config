#!/usr/bin/env bash

usage() {
  echo "Usage: ./build-os.sh [HOST] [ACTION]"
  echo "ACTION: switch | vm"
}

if [[ $# -ne 2 ]]; then
  usage
  exit 2
fi

host="$1"
shift

action="$1"
shift

superuser_cmd=""
if [ -x "$(command -v sudo)" ]; then
  superuser_cmd="sudo"
elif [ -x "$(command -v doas)" ]; then
  superuser_cmd="doas"
else
  echo "Whatever you're using for privilege escalation is not supported.." 1>&2
  exit 1
fi
echo "Using $superuser_cmd for privilege escalation"

case $action in
  switch)
    nixos-rebuild build --flake .#$host -j auto --fast -L -v --log-format internal-json 2>&1 | nom --json && \
      "$superuser_cmd" ./result/bin/switch-to-configuration switch

    if [ $? -ne 0 ]; then
      echo "System rebuild failed" 1>&2
      exit 1
    fi
    ;;
  vm)
    # Leaving the old qcow might make you pull your hair out
    rm "$host".qcow2 2> /dev/null
    nix build .#nixosConfigurations."$host".config.system.build.vm -j auto -L -v --log-format internal-json 2>&1 | nom --json
    ;;
  *)
    echo "You did not provide an option cuh (switch|vm)" 1>&2
    exit 1
    ;;
esac

#!/usr/bin/env sh

# Create the necessary simlinks to GPUs in the order iGPU:dGPU so that
# AQ_DRM_DEVICES is correctly set, without needing user intervention
#
# This only runs if no link ending with "gpu" exists, to avoid calling
# lspci unnecessarily, which takes a bit of time and we don't like that

# Just in case
if [ "$XDG_CONFIG_HOME" = "" ]; then
  XDG_CONFIG_HOME="$HOME/.config"
fi
hypr_dir="$XDG_CONFIG_HOME/hypr"

if ! ls "$hypr_dir" > /dev/null 2>&1; then
  echo "Hyprland config does not exist, exiting" >&2
  exit 1
elif ls "$hypr_dir/.aq_gpu_cache" > /dev/null 2>&1; then
  cat "$hypr_dir/.aq_gpu_cache"
  exit 0
fi

# No GPU ever will have ~ in their name
gpus=$(lspci -d ::03xx | tr '\n' '~')
aq_drm_list=""

SAVE_IFS=$IFS
IFS='~' 
for gpu in $gpus; do
  gpu_pci="$(echo "$gpu" | cut -f1 -d' ')"
  pci_path="$(find /dev/dri/by-path -name "*$gpu_pci*-card")"
  split_string=""
  if [ ! "$aq_drm_list" = "" ]; then
    split_string=":"
  fi

  # TODO: Detect dGPU wether it is nvidia or not (e.g dual AMDGPU)
  if echo "$gpu" | grep -iF "nvidia" > /dev/null; then
    link_path="$hypr_dir/dgpu";
    aq_drm_list="$(printf "%s%s%s" "$aq_drm_list" "$split_string" "$link_path")"
  else
    link_path="$hypr_dir/igpu";
    aq_drm_list="$(printf "%s%s%s" "$link_path" "$split_string" "$aq_drm_list")"
  fi
  ln -sf "$pci_path" "$link_path"
done
IFS=$SAVE_IFS

echo "$aq_drm_list" | tee "$hypr_dir/.aq_gpu_cache"

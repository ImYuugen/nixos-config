{pkgsSet, ...}: let
  pkgs = pkgsSet.stable;
in {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      advanced-scene-switcher
      input-overlay
      obs-multi-rtmp
      obs-shaderfilter
      obs-vaapi
      obs-vkcapture
      wlrobs
    ];
  };
}

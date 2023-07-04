{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisplayBoomarksToolbar = true;
        Preferences = {
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
    profiles.default = {
      #DisplayBoomarksToolbar = true;
      #Preferences = {
        #"media.ffmpeg.vaapi.enabled" = true;
      #};
    };
  };
}

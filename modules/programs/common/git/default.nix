{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Yuugen";
    userEmail = "yuugenssb@proton.me";

    aliases = {
      s = "status";
    };

    extraConfig = {
    };
  };
}

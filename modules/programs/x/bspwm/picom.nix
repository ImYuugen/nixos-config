{ config, pkgs, unstable, ... }:

{
  services.picom = {
    enable = true;
    package = unstable.picom;
    
    fade = true;
    fadeExclude = [
      "class_g ='Firefox'"
    ];
    inactiveOpacity = 0.8;
  };
}

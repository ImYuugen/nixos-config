{ config, inputs, lib, pkgs, system, user, ... }:

{
  nixpkgs = {
    inherit system;
    config.allowUnfree = true;
  };

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };

  i18n =
    let
      EN = "en_US.UTF-8/UTF-8";
      FR = "fr_FR.UTF-8/UTF-8";
      JP = "ja_JP.UTF-8/UTF-8";
    in
    {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        EN
        FR
        JP
      ];
    };

  environment = {
    shells = [ pkgs.fish pkgs.bash ];
    systemPackages = with pkgs; [
      man-pages
      man-pages-posix
      xdg-utils
      pciutils
      glibcLocales
    ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;

    sudo.enable = false;
    doas = {
      enable = true;
      extraConfig = ''
        permit nopass keepenv setenv { PATH } :wheel cmd nixos-rebuild
      '';
    };
  };

  systemd = {
    user.services.polkit-gnome-authentification-agent-1 = {
      description = "polkit-gnome-authentification-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  #**DO NOT CHANGE**
  system.stateVersion = "23.11";
}

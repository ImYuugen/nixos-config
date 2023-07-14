{ config, pkgs, lib, inputs, user, ... }:

let
  pythonpkgs = ps: with ps; [
    pandas
    numpy
    scipy
    request
  ];
in {
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "omen15";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
  };

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  security.rtkit.enable = true;

  services = {
    openssh.enable = true;
    dbus.enable = true;
  };

  environment = {
    shells = [ pkgs.fish ];
    systemPackages = with pkgs; [
      git wget xdg-utils pciutils killall pkg-config
      macchina #neofetch but in rust *\^.^/*
      bat exa tree btop gtop
      neovim sops libreoffice-qt
      gcc clang cmake cargo libcxx luajit python3Full gdb
      nodejs efibootmgr

      ffmpeg ffmpegthumbnailer mpv ani-cli

      zip unzip p7zip rar minizip-ng
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  system = {
    stateVersion = "23.11";
  };
}

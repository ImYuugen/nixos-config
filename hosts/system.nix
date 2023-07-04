{ config, pkgs, lib, inputs, user, ... }:
{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "omen15";
    networkmanager.enable = true;
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
      git wget xdg-utils pciutils killall
      macchina #neofetch but in rust *\^.^/*
      bat exa tree
      neovim sops libreoffice-qt
      gcc clang cmake cargo libcxx luajit python3Full gdb
      nodejs

      ffmpeg ffmpegthumbnailer mpv

      zip unzip p7zip rar minizip-ng
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    #package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  system = {
    #stateVersion = "23.11";
    stateVersion = "23.05";
  };
}
